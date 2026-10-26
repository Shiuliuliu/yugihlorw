/* res.js -- the H5 client's resource layer.
 *
 * The Android build packs the art into `.lcres` containers; the source tree
 * keeps those containers unpacked as directories, and the web client fetches
 * the loose files straight out of them. Nothing is converted offline:
 *
 *   .jpm      "JPM\1" + two lengths + a JPEG (colour) + a PNG (alpha mask).
 *             Composited into a canvas and cached as a cc.Texture2D.
 *   .png.sfb  the binary sprite-frame index for the atlas of the same name;
 *             turned into cc.SpriteFrames and put in cc.spriteFrameCache.
 *   .lan      the language table, handed back to ClientData.addLanguage.
 *   .bin      game data -- never read here, the tables come from the dumps.
 *
 * Loading is asynchronous, which the game already copes with: LoadingScene
 * drives the whole boot sequence off Data.Event.resource, loading the next
 * container each time one arrives. Every finished entry is reported back to
 * Lua through onEntry, which dispatches that event.
 */
(function (global) {
	'use strict';

	var R = {
		manifest: null,
		base: 'res/',
		onEntry: null,          /* lua: dispatches Data.Event.resource     */
		loaded: {},             /* container path -> true                  */
		inflight: {},           /* container path -> true                  */
		frameOwner: {},         /* sfb entry name -> texture key           */
		frameWaiters: {},       /* frame name -> callbacks while atlas loads */
		framesOf: {},           /* sfb entry name -> the frames it registered */
		frameContainer: {},     /* frame name -> the container that registers it */
	};

	/* Is this container's art actually still in the sprite-frame cache?
	 *
	 * R.loaded is set once, when a container's entries land, and until now
	 * nothing ever took it back -- so anything that drops frames without
	 * going through unloadContainer left it lying. Two of those are routine:
	 * Lua's FrameCache:removeSpriteFrames() wipes the whole cache while every
	 * container that is not in the same unload list stays "loaded", and a
	 * .sfb whose fetch fails is swallowed by its own catch, so the container
	 * is marked complete with no frames at all.
	 *
	 * A container that is only re-announced hands back a container with no
	 * art: every nine-slice built from it has no sprite frame and draws
	 * nothing, which is what turns a dialog's frame box transparent with
	 * nothing inside it. Checking costs one hash lookup per frame, only on
	 * the already-loaded path.
	 */
	R.framesMissing = function (path) {
		var entries = R.entriesOf(path) || [];
		for (var i = 0; i < entries.length; i++) {
			if (!/\.sfb$/.test(entries[i])) continue;
			var names = R.framesOf[entries[i]];
			if (!names || !names.length) return true;
			for (var j = 0; j < names.length; j++) {
				/* registered-but-undrawable counts as missing too: a frame
				 * whose texture was evicted is no more use to a node than one
				 * that was never registered, and the refetch below is what puts
				 * the texture back under it (see frameDrawable). */
				if (!frameDrawable(cc.spriteFrameCache.getSpriteFrame(names[j])))
					return true;   /* one miss is enough, and keeps the log quiet */
			}
		}
		return false;
	};

	/* ------------------------------------------------------------------ *
	 * container listing
	 * ------------------------------------------------------------------ */

	R.init = function (manifest, base) {
		R.manifest = manifest;
		if (manifest && manifest.files) {
			R.filesSet = new Set(manifest.files);
		}
		if (base) R.base = base;
	};

	/* entry name -> container path, filled in by loadContainer */
	R.containerOf = {};

	R.entriesOf = function (path) {
		var direct = R.manifest.containers[path];
		if (direct) return direct;

		/* thumbnails follow one convention: <dir>/<id>.lcres/<id>.jpg or .jpm */
		var m = /^res\/([a-z_]+)\/([0-9_]+)\.lcres$/.exec(path);
		if (m) {
			var ids = R.manifest.thumbs[m[1]];
			if (ids && ids.indexOf(m[2]) >= 0) {
				var ext = (m[1] === 'thumb_rare' || m[1] === 'thumb_monster') ? '.jpm' : '.jpg';
				return [m[2] + ext];
			}
		}
		return null;
	};

	/* ------------------------------------------------------------------ *
	 * .jpm -- JPEG colour plane + PNG alpha plane
	 * ------------------------------------------------------------------ */

	function splitJpm(buf) {
		var v = new DataView(buf);
		if (v.getUint8(0) !== 0x4a || v.getUint8(1) !== 0x50 ||
		    v.getUint8(2) !== 0x4d)
			throw new Error('not a .jpm');
		var jpegLen = v.getUint32(4, true), maskLen = v.getUint32(8, true);
		return [
			new Blob([new Uint8Array(buf, 12, jpegLen)], { type: 'image/jpeg' }),
			new Blob([new Uint8Array(buf, 12 + jpegLen, maskLen)], { type: 'image/png' }),
		];
	}

	function loadBlob(blob, timeoutMs) {
		return new Promise(function (resolve, reject) {
			var url = URL.createObjectURL(blob);
			var img = new Image();
			var settled = false;
			var timer = setTimeout(function () {
				if (settled) return;
				settled = true;
				try { URL.revokeObjectURL(url); } catch (e) {}
				reject(new Error('loadBlob timeout'));
			}, timeoutMs || 25000);
			img.onload = function () {
				if (settled) return;
				settled = true;
				clearTimeout(timer);
				try { URL.revokeObjectURL(url); } catch (e) {}
				resolve(img);
			};
			img.onerror = function (e) {
				if (settled) return;
				settled = true;
				clearTimeout(timer);
				try { URL.revokeObjectURL(url); } catch (e) {}
				reject(e || new Error('loadBlob error'));
			};
			img.src = url;
		});
	}

	var atlasSlots = 8, atlasQueue = [];
	function withAtlasSlot(task) {
		return new Promise(function (resolve, reject) {
			function run() {
				atlasSlots--;
				var done = function () {
					atlasSlots++;
					if (atlasQueue.length) atlasQueue.shift()();
				};
				Promise.resolve().then(task).then(function (v) { done(); resolve(v); },
								 function (e) { done(); reject(e); });
			}
			if (atlasSlots > 0) run(); else atlasQueue.push(run);
		});
	}

	function forget(imgs) {
		for (var i = 0; i < imgs.length; i++) {
			if (imgs[i]) { imgs[i].onload = imgs[i].onerror = null; try { imgs[i].src = ''; } catch (e) {} }
		}
	}

	/* The mask carries its coverage in luminance, not in alpha, so the two
	 * planes have to be merged per pixel. ponytail: a plain JS loop, ~15ms
	 * for a 2048x2048 atlas; move it to a GL pass if atlas loads ever show
	 * up as a hitch. */
	function composite(colour, mask) {
		var w = colour.width, h = colour.height;
		var canvas = document.createElement('canvas');
		canvas.__jdzcOwned = true;
		canvas.width = w;
		canvas.height = h;

		var ctx = canvas.getContext('2d', { willReadFrequently: true });
		ctx.drawImage(colour, 0, 0);
		var out = ctx.getImageData(0, 0, w, h);

		ctx.clearRect(0, 0, w, h);
		ctx.drawImage(mask, 0, 0, w, h);
		var alpha = ctx.getImageData(0, 0, w, h);

		var d = out.data, a = alpha.data;
		for (var i = 0, n = d.length; i < n; i += 4) {
			var alphaVal = a[i];
			if (alphaVal === 255) {
				d[i + 3] = 255;
				continue;
			}
			if (alphaVal === 0) {
				d[i] = d[i + 1] = d[i + 2] = d[i + 3] = 0;
				continue;
			}
			d[i] = ((d[i] * alphaVal) / 255) | 0;
			d[i + 1] = ((d[i + 1] * alphaVal) / 255) | 0;
			d[i + 2] = ((d[i + 2] * alphaVal) / 255) | 0;
			d[i + 3] = alphaVal;
		}

		ctx.putImageData(out, 0, 0);
		return canvas;
	}

	/* ------------------------------------------------------------------ *
	 * .sfb -- the binary sprite frame index
	 *
	 *   uint32 count, then per frame:
	 *     uint8 name length (with the NUL), name bytes,
	 *     uint16 x, y, w, h; uint8 rotated; int16 offX, offY;
	 *     uint16 originalW, originalH
	 * ------------------------------------------------------------------ */

	function parseSfb(buf) {
		var v = new DataView(buf), u8 = new Uint8Array(buf);
		var count = v.getUint32(0, true), off = 4, frames = [];
		var dec = new TextDecoder('utf-8');

		for (var i = 0; i < count; i++) {
			var n = v.getUint8(off);
			var name = dec.decode(u8.subarray(off + 1, off + n));
			off += 1 + n;
			frames.push({
				name: name,
				x: v.getUint16(off, true),
				y: v.getUint16(off + 2, true),
				w: v.getUint16(off + 4, true),
				h: v.getUint16(off + 6, true),
				rotated: v.getUint8(off + 8) !== 0,
				ox: v.getInt16(off + 9, true),
				oy: v.getInt16(off + 11, true),
				ow: v.getUint16(off + 13, true),
				oh: v.getUint16(off + 15, true),
			});
			off += 17;
		}
		return frames;
	}

	var CUSTOM_ICON_REPLACEMENTS = {
		'card_ico_12341': { path: 'res/new/thumb/card_ico_12341.png', w: 82, h: 82 },
		'card_ico_12341_3': { path: 'res/new/thumb/card_ico_12341_3.png', w: 82, h: 82 },
		'card_ico_12342': { path: 'res/new/thumb/card_ico_12342.png', w: 82, h: 82 },
		'card_ico_12342_3': { path: 'res/new/thumb/card_ico_12342_3.png', w: 82, h: 82 },
		'card_ico_12343': { path: 'res/new/thumb/card_ico_12343.png', w: 82, h: 82 },
		'card_ico_12343_3': { path: 'res/new/thumb/card_ico_12343_3.png', w: 82, h: 82 },
		'card_ico_12344': { path: 'res/new/thumb/card_ico_12344.png', w: 82, h: 82 },
		'card_ico_12344_3': { path: 'res/new/thumb/card_ico_12344_3.png', w: 82, h: 82 },
		'card_ico_30597': { path: 'res/new/thumb/card_ico_30597.png', w: 82, h: 82 },
		'card_ico_30597_3': { path: 'res/new/thumb/card_ico_30597_3.png', w: 82, h: 82 },
		'card_ico_12345': { path: 'res/new/thumb/card_ico_12345.png', w: 82, h: 82 },
		'card_ico_12345_3': { path: 'res/new/thumb/card_ico_12345_3.png', w: 82, h: 82 },
		'card_ico_12331': { path: 'res/new/thumb/card_ico_12331.png', w: 82, h: 82 },
		'card_ico_12331_3': { path: 'res/new/thumb/card_ico_12331_3.png', w: 82, h: 82 },
		'card_ico_12332': { path: 'res/new/thumb/card_ico_12332.png', w: 82, h: 82 },
		'card_ico_12332_3': { path: 'res/new/thumb/card_ico_12332_3.png', w: 82, h: 82 },
		'card_ico_12333': { path: 'res/new/thumb/card_ico_12333.png', w: 82, h: 82 },
		'card_ico_12333_3': { path: 'res/new/thumb/card_ico_12333_3.png', w: 82, h: 82 },
		'card_ico_12334': { path: 'res/new/thumb/card_ico_12334.png', w: 82, h: 82 },
		'card_ico_12334_3': { path: 'res/new/thumb/card_ico_12334_3.png', w: 82, h: 82 },
		'card_ico_12335': { path: 'res/new/thumb/card_ico_12335.png', w: 82, h: 82 },
		'card_ico_12335_3': { path: 'res/new/thumb/card_ico_12335_3.png', w: 82, h: 82 },
		'card_ico_12336': { path: 'res/new/thumb/card_ico_12336.png', w: 82, h: 82 },
		'card_ico_12336_3': { path: 'res/new/thumb/card_ico_12336_3.png', w: 82, h: 82 },
		'card_ico_12337': { path: 'res/new/thumb/card_ico_12337.png', w: 82, h: 82 },
		'card_ico_12337_3': { path: 'res/new/thumb/card_ico_12337_3.png', w: 82, h: 82 },
		'card_ico_12338': { path: 'res/new/thumb/card_ico_12338.png', w: 82, h: 82 },
		'card_ico_12338_3': { path: 'res/new/thumb/card_ico_12338_3.png', w: 82, h: 82 },
		'card_ico_21142': { path: 'res/new/thumb/card_ico_21142.png', w: 82, h: 82 },
		'card_ico_21142_3': { path: 'res/new/thumb/card_ico_21142_3.png', w: 82, h: 82 },
		'card_ico_21143': { path: 'res/new/thumb/card_ico_21143.png', w: 82, h: 82 },
		'card_ico_21143_3': { path: 'res/new/thumb/card_ico_21143_3.png', w: 82, h: 82 },
		'card_ico_21144': { path: 'res/new/thumb/card_ico_21144.png', w: 82, h: 82 },
		'card_ico_21144_3': { path: 'res/new/thumb/card_ico_21144_3.png', w: 82, h: 82 },
		'card_ico_21145': { path: 'res/new/thumb/card_ico_21145.png', w: 82, h: 82 },
		'card_ico_21145_3': { path: 'res/new/thumb/card_ico_21145_3.png', w: 82, h: 82 },
		'card_ico_21146': { path: 'res/new/thumb/card_ico_21146.png', w: 82, h: 82 },
		'card_ico_21146_3': { path: 'res/new/thumb/card_ico_21146_3.png', w: 82, h: 82 },
		'card_ico_21147': { path: 'res/new/thumb/card_ico_21147.png', w: 82, h: 82 },
		'card_ico_21147_3': { path: 'res/new/thumb/card_ico_21147_3.png', w: 82, h: 82 },
		'card_ico_30594': { path: 'res/new/thumb/card_ico_30594.png', w: 82, h: 82 },
		'card_ico_30594_3': { path: 'res/new/thumb/card_ico_30594_3.png', w: 82, h: 82 },
		'card_ico_30595': { path: 'res/new/thumb/card_ico_30595.png', w: 82, h: 82 },
		'card_ico_30595_3': { path: 'res/new/thumb/card_ico_30595_3.png', w: 82, h: 82 },
		'card_ico_40733': { path: 'res/new/thumb/card_ico_40733.png', w: 82, h: 82 },
		'card_ico_40733_3': { path: 'res/new/thumb/card_ico_40733_3.png', w: 82, h: 82 },
		'card_ico_40734': { path: 'res/new/thumb/card_ico_40734.png', w: 82, h: 82 },
		'card_ico_40734_3': { path: 'res/new/thumb/card_ico_40734_3.png', w: 82, h: 82 },
		'card_ico_40735': { path: 'res/new/thumb/card_ico_40735.png', w: 82, h: 82 },
		'card_ico_40735_3': { path: 'res/new/thumb/card_ico_40735_3.png', w: 82, h: 82 },
		'card_ico_40736': { path: 'res/new/thumb/card_ico_40736.png', w: 82, h: 82 },
		'card_ico_40736_3': { path: 'res/new/thumb/card_ico_40736_3.png', w: 82, h: 82 },
		'card_ico_40737': { path: 'res/new/thumb/card_ico_40737.png', w: 82, h: 82 },
		'card_ico_40737_3': { path: 'res/new/thumb/card_ico_40737_3.png', w: 82, h: 82 },
		'card_ico_40738': { path: 'res/new/thumb/card_ico_40738.png', w: 82, h: 82 },
		'card_ico_40738_3': { path: 'res/new/thumb/card_ico_40738_3.png', w: 82, h: 82 },
		'card_ico_40739': { path: 'res/new/thumb/card_ico_40739.png', w: 82, h: 82 },
		'card_ico_40739_3': { path: 'res/new/thumb/card_ico_40739_3.png', w: 82, h: 82 },
		'card_ico_40740': { path: 'res/new/thumb/card_ico_40740.png', w: 82, h: 82 },
		'card_ico_40740_3': { path: 'res/new/thumb/card_ico_40740_3.png', w: 82, h: 82 },
		'card_ico_40741': { path: 'res/new/thumb/card_ico_40741.png', w: 82, h: 82 },
		'card_ico_40741_3': { path: 'res/new/thumb/card_ico_40741_3.png', w: 82, h: 82 },
		'card_ico_40742': { path: 'res/new/thumb/card_ico_40742.png', w: 82, h: 82 },
		'card_ico_40742_3': { path: 'res/new/thumb/card_ico_40742_3.png', w: 82, h: 82 },
		'card_ico_40743': { path: 'res/new/thumb/card_ico_40743.png', w: 82, h: 82 },
		'card_ico_40743_3': { path: 'res/new/thumb/card_ico_40743_3.png', w: 82, h: 82 },
		'card_ico_40744': { path: 'res/new/thumb/card_ico_40744.png', w: 82, h: 82 },
		'card_ico_40744_3': { path: 'res/new/thumb/card_ico_40744_3.png', w: 82, h: 82 },
		'card_ico_40745': { path: 'res/new/thumb/card_ico_40745.png', w: 82, h: 82 },
		'card_ico_40745_3': { path: 'res/new/thumb/card_ico_40745_3.png', w: 82, h: 82 },
		'card_ico_40746': { path: 'res/new/thumb/card_ico_40746.png', w: 82, h: 82 },
		'card_ico_40746_3': { path: 'res/new/thumb/card_ico_40746_3.png', w: 82, h: 82 },
		'card_ico_40747': { path: 'res/new/thumb/card_ico_40747.png', w: 82, h: 82 },
		'card_ico_40747_3': { path: 'res/new/thumb/card_ico_40747_3.png', w: 82, h: 82 },
		'card_ico_40748': { path: 'res/new/thumb/card_ico_40748.png', w: 82, h: 82 },
		'card_ico_40748_3': { path: 'res/new/thumb/card_ico_40748_3.png', w: 82, h: 82 },
		'card_ico_12339': { path: 'res/new/thumb/card_ico_12339.png', w: 82, h: 82 },
		'card_ico_12339_3': { path: 'res/new/thumb/card_ico_12339_3.png', w: 82, h: 82 },
		'card_ico_21148': { path: 'res/new/thumb/card_ico_21148.png', w: 82, h: 82 },
		'card_ico_21148_3': { path: 'res/new/thumb/card_ico_21148_3.png', w: 82, h: 82 },
		'card_ico_30596': { path: 'res/new/thumb/card_ico_30596.png', w: 82, h: 82 },
		'card_ico_30596_3': { path: 'res/new/thumb/card_ico_30596_3.png', w: 82, h: 82 },
		'card_ico_21149': { path: 'res/new/thumb/card_ico_21149.png', w: 82, h: 82 },
		'card_ico_21149_3': { path: 'res/new/thumb/card_ico_21149_3.png', w: 82, h: 82 },
		'card_ico_12340': { path: 'res/new/thumb/card_ico_12340.png', w: 82, h: 82 },
		'card_ico_12340_3': { path: 'res/new/thumb/card_ico_12340_3.png', w: 82, h: 82 },
		'img_icon_res1_s': { path: 'res/new/linh_thach_34.png', w: 34, h: 34 },
		'res_ico_1': { path: 'res/new/linh_thach_76.png', w: 76, h: 76 },
		'img_icon_res3_s': { path: 'res/new/linh_thach_vip_36.png', w: 32, h: 36 },
		'res_ico_3': { path: 'res/new/linh_thach_vip_76.png', w: 76, h: 76 },
		'card_ico_10001': { path: 'res/new/thumb/card_ico_10001.png', w: 82, h: 82 },
		'card_ico_10001_3': { path: 'res/new/thumb/card_ico_10001_3.png', w: 82, h: 82 },
		'card_ico_10004': { path: 'res/new/thumb/card_ico_10004.png', w: 82, h: 82 },
		'card_ico_10004_3': { path: 'res/new/thumb/card_ico_10004_3.png', w: 82, h: 82 },
		'card_ico_10006': { path: 'res/new/thumb/card_ico_10006.png', w: 82, h: 82 },
		'card_ico_10006_3': { path: 'res/new/thumb/card_ico_10006_3.png', w: 82, h: 82 },
		'card_ico_10120': { path: 'res/new/thumb/card_ico_10120.png', w: 82, h: 82 },
		'card_ico_10120_3': { path: 'res/new/thumb/card_ico_10120_3.png', w: 82, h: 82 },
		'card_ico_20566': { path: 'res/new/thumb/card_ico_20566.png', w: 82, h: 82 },
		'card_ico_20566_3': { path: 'res/new/thumb/card_ico_20566_3.png', w: 82, h: 82 },
		'card_ico_21134': { path: 'res/new/thumb/card_ico_21134.png', w: 82, h: 82 },
		'card_ico_21134_3': { path: 'res/new/thumb/card_ico_21134_3.png', w: 82, h: 82 },
		'card_ico_30074': { path: 'res/new/thumb/card_ico_30074.png', w: 82, h: 82 },
		'card_ico_30074_3': { path: 'res/new/thumb/card_ico_30074_3.png', w: 82, h: 82 },
		'card_ico_30244': { path: 'res/new/thumb/card_ico_30244.png', w: 82, h: 82 },
		'card_ico_30244_3': { path: 'res/new/thumb/card_ico_30244_3.png', w: 82, h: 82 },
		'card_ico_40718': { path: 'res/new/thumb/card_ico_40718.png', w: 82, h: 82 },
		'card_ico_40718_3': { path: 'res/new/thumb/card_ico_40718_3.png', w: 82, h: 82 },
		'card_ico_40725': { path: 'res/new/thumb/card_ico_40725.png', w: 82, h: 82 },
		'card_ico_40725_3': { path: 'res/new/thumb/card_ico_40725_3.png', w: 82, h: 82 },
		'card_ico_40726': { path: 'res/new/thumb/card_ico_40726.png', w: 82, h: 82 },
		'card_ico_40726_3': { path: 'res/new/thumb/card_ico_40726_3.png', w: 82, h: 82 },
		'card_ico_12313': { path: 'res/new/thumb/card_ico_12313.png', w: 82, h: 82 },
		'card_ico_12313_3': { path: 'res/new/thumb/card_ico_12313_3.png', w: 82, h: 82 },
		'card_ico_12314': { path: 'res/new/thumb/card_ico_12314.png', w: 82, h: 82 },
		'card_ico_12314_3': { path: 'res/new/thumb/card_ico_12314_3.png', w: 82, h: 82 },
		'card_ico_12315': { path: 'res/new/thumb/card_ico_12315.png', w: 82, h: 82 },
		'card_ico_12315_3': { path: 'res/new/thumb/card_ico_12315_3.png', w: 82, h: 82 },
		'card_ico_12316': { path: 'res/new/thumb/card_ico_12316.png', w: 82, h: 82 },
		'card_ico_12316_3': { path: 'res/new/thumb/card_ico_12316_3.png', w: 82, h: 82 },
		'card_ico_21135': { path: 'res/new/thumb/card_ico_21135.png', w: 82, h: 82 },
		'card_ico_21135_3': { path: 'res/new/thumb/card_ico_21135_3.png', w: 82, h: 82 },
		'card_ico_21136': { path: 'res/new/thumb/card_ico_21136.png', w: 82, h: 82 },
		'card_ico_21136_3': { path: 'res/new/thumb/card_ico_21136_3.png', w: 82, h: 82 },
		'card_ico_21137': { path: 'res/new/thumb/card_ico_21137.png', w: 82, h: 82 },
		'card_ico_21137_3': { path: 'res/new/thumb/card_ico_21137_3.png', w: 82, h: 82 },
		'card_ico_21138': { path: 'res/new/thumb/card_ico_21138.png', w: 82, h: 82 },
		'card_ico_21138_3': { path: 'res/new/thumb/card_ico_21138_3.png', w: 82, h: 82 },
		'card_ico_21139': { path: 'res/new/thumb/card_ico_21139.png', w: 82, h: 82 },
		'card_ico_21139_3': { path: 'res/new/thumb/card_ico_21139_3.png', w: 82, h: 82 },
		'card_ico_30592': { path: 'res/new/thumb/card_ico_30592.png', w: 82, h: 82 },
		'card_ico_30592_3': { path: 'res/new/thumb/card_ico_30592_3.png', w: 82, h: 82 },
		'card_ico_12317': { path: 'res/new/thumb/card_ico_12317.png', w: 82, h: 82 },
		'card_ico_12317_3': { path: 'res/new/thumb/card_ico_12317_3.png', w: 82, h: 82 },
		'card_ico_12318': { path: 'res/new/thumb/card_ico_12318.png', w: 82, h: 82 },
		'card_ico_12318_3': { path: 'res/new/thumb/card_ico_12318_3.png', w: 82, h: 82 },
		'card_ico_12319': { path: 'res/new/thumb/card_ico_12319.png', w: 82, h: 82 },
		'card_ico_12319_3': { path: 'res/new/thumb/card_ico_12319_3.png', w: 82, h: 82 },
		'card_ico_12320': { path: 'res/new/thumb/card_ico_12320.png', w: 82, h: 82 },
		'card_ico_12320_3': { path: 'res/new/thumb/card_ico_12320_3.png', w: 82, h: 82 },
		'card_ico_12321': { path: 'res/new/thumb/card_ico_12321.png', w: 82, h: 82 },
		'card_ico_12321_3': { path: 'res/new/thumb/card_ico_12321_3.png', w: 82, h: 82 },
		'card_ico_12322': { path: 'res/new/thumb/card_ico_12322.png', w: 82, h: 82 },
		'card_ico_12322_3': { path: 'res/new/thumb/card_ico_12322_3.png', w: 82, h: 82 },
		'card_ico_12323': { path: 'res/new/thumb/card_ico_12323.png', w: 82, h: 82 },
		'card_ico_12323_3': { path: 'res/new/thumb/card_ico_12323_3.png', w: 82, h: 82 },
		'card_ico_12324': { path: 'res/new/thumb/card_ico_12324.png', w: 82, h: 82 },
		'card_ico_12324_3': { path: 'res/new/thumb/card_ico_12324_3.png', w: 82, h: 82 },
		'card_ico_12325': { path: 'res/new/thumb/card_ico_12325.png', w: 82, h: 82 },
		'card_ico_12325_3': { path: 'res/new/thumb/card_ico_12325_3.png', w: 82, h: 82 },
		'card_ico_12326': { path: 'res/new/thumb/card_ico_12326.png', w: 82, h: 82 },
		'card_ico_12326_3': { path: 'res/new/thumb/card_ico_12326_3.png', w: 82, h: 82 },
		'card_ico_12327': { path: 'res/new/thumb/card_ico_12327.png', w: 82, h: 82 },
		'card_ico_12327_3': { path: 'res/new/thumb/card_ico_12327_3.png', w: 82, h: 82 },
		'card_ico_12328': { path: 'res/new/thumb/card_ico_12328.png', w: 82, h: 82 },
		'card_ico_12328_3': { path: 'res/new/thumb/card_ico_12328_3.png', w: 82, h: 82 },
		'card_ico_21140': { path: 'res/new/thumb/card_ico_21140.png', w: 82, h: 82 },
		'card_ico_21140_3': { path: 'res/new/thumb/card_ico_21140_3.png', w: 82, h: 82 },
		'card_ico_21141': { path: 'res/new/thumb/card_ico_21141.png', w: 82, h: 82 },
		'card_ico_21141_3': { path: 'res/new/thumb/card_ico_21141_3.png', w: 82, h: 82 },
		'card_ico_30593': { path: 'res/new/thumb/card_ico_30593.png', w: 82, h: 82 },
		'card_ico_30593_3': { path: 'res/new/thumb/card_ico_30593_3.png', w: 82, h: 82 },
		'card_ico_40727': { path: 'res/new/thumb/card_ico_40727.png', w: 82, h: 82 },
		'card_ico_40727_3': { path: 'res/new/thumb/card_ico_40727_3.png', w: 82, h: 82 },
		'card_ico_40728': { path: 'res/new/thumb/card_ico_40728.png', w: 82, h: 82 },
		'card_ico_40728_3': { path: 'res/new/thumb/card_ico_40728_3.png', w: 82, h: 82 },
		'card_ico_40729': { path: 'res/new/thumb/card_ico_40729.png', w: 82, h: 82 },
		'card_ico_40729_3': { path: 'res/new/thumb/card_ico_40729_3.png', w: 82, h: 82 },
		'card_ico_40730': { path: 'res/new/thumb/card_ico_40730.png', w: 82, h: 82 },
		'card_ico_40730_3': { path: 'res/new/thumb/card_ico_40730_3.png', w: 82, h: 82 },
		'card_ico_40731': { path: 'res/new/thumb/card_ico_40731.png', w: 82, h: 82 },
		'card_ico_40731_3': { path: 'res/new/thumb/card_ico_40731_3.png', w: 82, h: 82 },
		  'card_ico_12329': { path: 'res/new/thumb/card_ico_12329.png', w: 82, h: 82 },
  'card_ico_12329_3': { path: 'res/new/thumb/card_ico_12329_3.png', w: 82, h: 82 },
		'card_ico_40732': { path: 'res/new/thumb/card_ico_40732.png', w: 82, h: 82 },
		'card_ico_40732_3': { path: 'res/new/thumb/card_ico_40732_3.png', w: 82, h: 82 },
		'card_ico_12330': { path: 'res/new/thumb/card_ico_12330.png', w: 82, h: 82 },
		'card_ico_12330_3': { path: 'res/new/thumb/card_ico_12330_3.png', w: 82, h: 82 },
		'card_nature_01': { path: 'res/cards_img_1/card_nature_01.png', w: 48, h: 50 },
		'card_nature_02': { path: 'res/cards_img_1/card_nature_02.png', w: 48, h: 50 },
		'card_nature_03': { path: 'res/cards_img_1/card_nature_03.png', w: 48, h: 50 },
		'card_nature_04': { path: 'res/cards_img_1/card_nature_04.png', w: 48, h: 50 },
		'card_nature_05': { path: 'res/cards_img_1/card_nature_05.png', w: 48, h: 50 },
		'card_nature_06': { path: 'res/cards_img_1/card_nature_06.png', w: 48, h: 50 },
		'card_nature_07': { path: 'res/cards_img_1/card_nature_07.png', w: 48, h: 50 },
		'card_nature_magic': { path: 'res/cards_img_1/card_nature_magic.png', w: 48, h: 50 },
		'card_nature_trap': { path: 'res/cards_img_1/card_nature_trap.png', w: 48, h: 50 },
		'card_frame_bottom_link': { path: 'res/cards_img_1/card_frame_bottom_link.png', w: 246, h: 68 },
		'card_frame_bottom_magic': { path: 'res/cards_img_1/card_frame_bottom_magic.png', w: 246, h: 68 },
		'card_frame_bottom_monster': { path: 'res/cards_img_1/card_frame_bottom_monster.png', w: 246, h: 68 },
		'card_frame_bottom_trap': { path: 'res/cards_img_1/card_frame_bottom_trap.png', w: 246, h: 68 },
		'img_btn_exchange1': { path: 'res/new/img_btn_exchange1.png', w: 118, h: 118 },
		'img_btn_exchange2': { path: 'res/new/img_btn_exchange1.png', w: 118, h: 118 },
		'img_btn_exchange4': { path: 'res/new/img_btn_exchange1.png', w: 118, h: 118 }
	};
	global.CUSTOM_ICON_REPLACEMENTS = CUSTOM_ICON_REPLACEMENTS;
	R.CUSTOM_ICON_REPLACEMENTS = CUSTOM_ICON_REPLACEMENTS;

	function addFrames(frames, texture, owner) {
		for (var i = 0; i < frames.length; i++) {
			var f = frames[i];
			var customIcon = CUSTOM_ICON_REPLACEMENTS[f.name];
			var frame = null;
			if (customIcon) {
				var iconTex = cc.textureCache.getTextureForKey(customIcon.path) || cc.textureCache.addImage(customIcon.path);
				if (iconTex) {
					frame = new cc.SpriteFrame(iconTex, cc.rect(0, 0, customIcon.w, customIcon.h), false, cc.p(0, 0), cc.size(customIcon.w, customIcon.h));
				}
			}
			if (!frame) {
				/* Keep the packed atlas footprint as recorded in the SFB. Cocos'
				 * WebGL sprite path uses the rotated flag to swap the UV axes; doing
				 * that here as well samples the adjacent atlas entry. Canvas' own
				 * rotated-frame path performs the same conversion when needed. */
				var rect = cc.rect(f.x, f.y, f.w, f.h);
				frame = new cc.SpriteFrame(texture, rect, f.rotated,
							       cc.p(f.ox, f.oy),
							       cc.size(f.ow, f.oh));
			}
			cc.spriteFrameCache.addSpriteFrame(frame, f.name);
			if (owner) {
				(R.framesOf[owner] || (R.framesOf[owner] = [])).push(f.name);
				/* Which container would have this frame, kept even after the
				 * container is unloaded -- see awaitFrame. */
				var belongs = R.containerOf[owner];
				if (belongs) R.frameContainer[f.name] = belongs;
			}
			R.resolveFrame(f.name, frame);
		}
	}

	/* Frames are the one resource type that cannot share the texture's
	 * asynchronous update path. A Sprite created from a frame name holds a
	 * SpriteFrame object, not the atlas texture, so replacing a temporary
	 * texture never changes that sprite. Keep the short-lived wait list here
	 * and hand each already-created node the actual frame as soon as its .sfb
	 * index is registered. */
	/* A frame is usable only once its atlas pixels are actually there.
	 *
	 * Every "is it loaded?" test here used to ask whether the frame *object*
	 * was registered, and a frame outlives its pixels: an atlas a scene evicted
	 * (unloadLCRes), a container re-loaded while its .jpm fetch failed, a
	 * masked texture whose planes never landed -- each leaves a full set of
	 * frames in cc.spriteFrameCache pointing at a texture whose isLoaded() is
	 * false. Handed one of those, ccui.Scale9Sprite takes the not-loaded branch
	 * of updateWithSprite (UIScale9Sprite.js:866): it hides itself, returns
	 * early and never sets _originalSize. The node is invisible for the rest of
	 * the session -- the dialog frame box and its grey fill that go transparent
	 * some turns in, with the content still laid out and still tappable.
	 *
	 * A frame whose pixels are gone is as good as absent, so answer the same
	 * way for both and let the caller's wait path refetch the container. */
	function frameDrawable(frame) {
		if (!frame) return false;
		if (typeof frame.isJdzcBlank === 'function' &&
		    frame.isJdzcBlank()) return false;
		var tex = frame.getTexture ? frame.getTexture() : null;
		/* not a cocos frame: nothing to check, assume present */
		if (!tex || typeof tex.isLoaded !== 'function') return true;
		return tex.isLoaded();
	}

	R.isDrawableFrame = frameDrawable;

	function isBlankFrame(frame) {
		return !frameDrawable(frame);
	}

	R.awaitFrame = function (name, callback) {
		var frame = cc.spriteFrameCache.getSpriteFrame(name);
		if (!isBlankFrame(frame)) {
			callback(frame);
			return;
		}
		(R.frameWaiters[name] || (R.frameWaiters[name] = [])).push(callback);
		/* Nothing wants this frame, but something may be lying: a container
		 * marked loaded whose frames were dropped under it. Reload whatever
		 * is, so the node waiting here fills in now instead of at the next
		 * scene that happens to ask for that container again. Cheap -- the
		 * sweep only runs on a frame that really is missing. */
		/* The sweep only sees containers still in R.loaded. One that was
		 * unloaded outright is gone from it, and Lua's own bookkeeping still
		 * says its art is there, so nobody ever asks again and the node waits
		 * for a frame no one will fetch -- a frame box with no background
		 * for the rest of the session. Go straight to the container that
		 * registers this frame. */
		var source = R.frameContainer[name];
		/* loadContainer hands back the load already in flight, so asking again
		 * costs nothing -- and gating on R.inflight here was the only thing
		 * standing between a stalled load and its waiters: a container whose
		 * fetch never settled stayed "in flight", the sweep below never saw it
		 * (R.loaded is false, so framesMissing is never consulted) and every
		 * node waiting on its frames waited for the rest of the session. */
		if (source) R.loadContainer(source);
		for (var path in R.loaded) {
			if (R.framesMissing(path)) R.loadContainer(path);
		}
	};

	R.resolveFrame = function (name, frame) {
		var waiters = R.frameWaiters[name];
		if (!waiters) return;
		delete R.frameWaiters[name];
		for (var i = 0; i < waiters.length; i++) waiters[i](frame);
	};

	/* Register a decoded image under a container-entry name.
	 *
	 * The game asks for an entry's texture in the same breath as it asks for
	 * the container, so engine.js will already have handed out an empty
	 * cc.Texture2D under this name. Fill that object rather than replace it:
	 * whoever is holding it -- a CardSprite's frame, say -- gets the pixels
	 * and the "load" event that makes it redraw. */
	function cacheUnder(key, source) {
		var tex = cc.textureCache.getTextureForKey(key);
		var element = (source instanceof cc.Texture2D)
			? source.getHtmlElementObj() : source;

		if (!tex || tex.isLoaded() || !element) {
			cc.textureCache.cacheImage(key, source);
			tex = cc.textureCache.getTextureForKey(key);
		} else {
			tex.initWithElement(element);
			tex._textureLoaded = true;
			/* webgl uploads and dispatches; canvas sees itself as loaded and
			 * returns early, so nudge the listeners either way -- dispatchEvent
			 * clears them, so the second call is a no-op */
			tex.handleLoadedTexture();
			tex.dispatchEvent('load');
		}

		R.resolvePending(key);

		/* In WebGL mode, once uploaded to GPU texture, release the 2D canvas backing store to free RAM on iOS */
		if (cc._renderType === cc.game.RENDER_TYPE_WEBGL && element instanceof HTMLCanvasElement) {
			element.width = 1;
			element.height = 1;
			if (tex) tex._htmlElementObj = null;
		}

		return tex;
	}

	/* A texture that is standing in for one still downloading.
	 *
	 * No url: the renderer treats a rect wider than its texture as an error,
	 * and an empty one is zero by zero until the pixels land. Premultiplied,
	 * because that is what initWithElement will say once they do -- a sprite
	 * picks its blend function from the texture it is given and never looks
	 * again, so a placeholder that claims otherwise leaves every late-loading
	 * sprite blending the wrong way for the rest of the session. */
	function emptyTexture(key) {
		var tex = new cc.Texture2D();
		tex._hasPremultipliedAlpha = true;
		if (key) {
			var size = R.sizeOf(key);
			if (size && size[0] && size[1]) {
				tex._contentSize.width = size[0];
				tex._contentSize.height = size[1];
				tex._pixelsWide = size[0];
				tex._pixelsHigh = size[1];
				// Do NOT set _textureLoaded = true here, because when real pixels land,
				// cc.Texture2D needs to upload to WebGL and fire 'load' event.
			}
		}
		return tex;
	}

	R.emptyTexture = emptyTexture;

	function loadImage(url, timeoutMs) {
		return new Promise(function (resolve, reject) {
			var img = new Image();
			var settled = false;
			var timer = setTimeout(function () {
				if (settled) return;
				settled = true;
				reject(new Error('loadImage timeout ' + url));
			}, timeoutMs || 25000);
			img.onload = function () {
				if (settled) return;
				settled = true;
				clearTimeout(timer);
				resolve(img);
			};
			img.onerror = function () {
				if (settled) return;
				settled = true;
				clearTimeout(timer);
				reject(new Error('404 ' + url));
			};
			img.src = url;
		});
	}

	/* A colour plane and an alpha mask kept as two files -- the .jpm split
	 * in two. The tree ships res/jpg/<n>.jpg beside <n>_mask.png, and a
	 * DragonBones atlas the same way: <n>.png is the mask for the colour in
	 * <n>_ori.jpg. Drawn without the merge the mask is a white silhouette
	 * across the screen, which is what the battle used to look like.
	 *
	 * The texture comes back straight away and empty, the way the device
	 * answered from memory; the pixels land in that same object. */
	var maskedInflight = {};

	/* Exposed so cache evictions (removeTextureForKey) can drop the stale
	 * marker -- a removed-then-re-requested key must fetch again, or it
	 * would answer an empty placeholder forever. */
	R.maskedInflight = maskedInflight;

	R.maskedTexture = function (key, colourUrl, maskUrl) {
		var tex = cc.textureCache.getTextureForKey(key);
		if (!tex) {
			tex = emptyTexture(key);
			cc.textureCache._textures[key] = tex;
		}
		if ((tex.isLoaded && tex.isLoaded() && tex._isMaskedComposited) || maskedInflight[key]) return tex;

		maskedInflight[key] = withAtlasSlot(function () {
			return Promise.all([loadImage(colourUrl), loadImage(maskUrl)])
				.then(function (imgs) {
					var canvas = composite(imgs[0], imgs[1]);
					forget(imgs);
					return canvas;
				});
		})
			.then(function (canvas) {
				delete maskedInflight[key];
				var cTex = cacheUnder(key, canvas);
				cTex._isMaskedComposited = true;
				if (tex !== cTex) tex._isMaskedComposited = true;
			})
			.catch(function () {
				/* nothing beside it: the colour plane on its own */
				return loadImage(colourUrl).then(function (img) {
					delete maskedInflight[key];
					var cTex = cacheUnder(key, img);
					cTex._isMaskedComposited = true;
					if (tex !== cTex) tex._isMaskedComposited = true;
				}).catch(function (e) {
					delete maskedInflight[key];
					cc.log('[res] ' + key + ': ' + e);
				});
			});
		return tex;
	};

	R.loadMaskedTexture = function (key, colourUrl, maskUrl) {
		var tex = cc.textureCache.getTextureForKey(key);
		if (tex && tex.isLoaded && tex.isLoaded()) return Promise.resolve(tex);
		R.maskedTexture(key, colourUrl, maskUrl);
		return maskedInflight[key] ? maskedInflight[key].then(function () {
			return cc.textureCache.getTextureForKey(key);
		}) : Promise.resolve(cc.textureCache.getTextureForKey(key));
	};

	/* ------------------------------------------------------------------ *
	 * fetching
	 * ------------------------------------------------------------------ */

	function versionedUrl(url) {
		var v = (global.JDZC_CONFIG && global.JDZC_CONFIG.version) || '20261016v1792097500';
		if (!url || typeof url !== 'string') return url;
		return url + (url.indexOf('?') >= 0 ? '&' : '?') + 'v=' + v;
	}
	R.versionedUrl = versionedUrl;

	function fetchBuffer(url) {
		return fetch(versionedUrl(url)).then(function (r) {
			if (!r.ok) throw new Error(r.status + ' ' + url);
			return r.arrayBuffer();
		});
	}

	R.loadTexture = function (path, timeoutMs) {
		/* a loose image: res/jpg/foo.jpg, res/particle/bar.png, ... */
		var cleanPath = (typeof path === 'string') ? path.split('?')[0] : path;
		var tex = cc.textureCache.getTextureForKey(cleanPath) || cc.textureCache.getTextureForKey(path);
		if (tex) return Promise.resolve(tex);
		return new Promise(function (resolve) {
			var timer = setTimeout(function () { resolve(null); }, timeoutMs || 25000);
			var t = cc.textureCache.addImage(versionedUrl(R.base + cleanPath.replace(/^res\//, '')),
						 function (t) { clearTimeout(timer); resolve(t); });
			if (!t) { clearTimeout(timer); resolve(null); }
		});
	};

	/* Load one container. Resolves once every entry is in the caches; each
	 * entry is announced to Lua as it lands, which is what drives
	 * LoadingScene's chain. */
	R.loadContainer = function (path) {
		if (R.loaded[path] && !R.framesMissing(path)) {
			/* already resident: the game still expects the events */
			var names = R.entriesOf(path) || [];
			names.forEach(function (n) { R.announce(n); });
			return Promise.resolve(names);
		}
		/* loaded but empty-handed: fall through and load it again rather than
		 * re-announce a container whose frames are gone (see framesMissing). */
		delete R.loaded[path];
		if (R.inflight[path]) return R.inflight[path];

		var entries = R.entriesOf(path);
		if (!entries) {
			cc.log('[res] unknown container ' + path);
			return Promise.resolve([]);
		}
		/* remember which container owns each entry: unloadContainer needs it
		 * to mark this path stale, or a scene that unloads its art on exit
		 * would never see it again (the next load would only re-announce). */
		for (var ei = 0; ei < entries.length; ei++) R.containerOf[entries[ei]] = path;

		var dir = R.base + path.replace(/^res\//, '') + '/';
		var atlases = {};   /* base name -> texture */

		/* atlases first: the .sfb of a container needs its texture */
		var jpms = entries.filter(function (e) { return /\.jpm$/.test(e); });
		var maskedPairs = [];
		var maskedNames = {};
		entries.forEach(function (e) {
			if (/_ori\.jpg$/.test(e)) {
				var base = e.replace(/_ori\.jpg$/, '');
				var maskName = base + '.png';
				if (entries.indexOf(maskName) >= 0) {
					maskedPairs.push({ base: base, colour: e, mask: maskName });
					maskedNames[e] = true;
					maskedNames[maskName] = true;
				}
			}
		});
		var rest = entries.filter(function (e) { return !/\.jpm$/.test(e) && !maskedNames[e]; });

		var p = Promise.all(jpms.map(function (name) {
			return withAtlasSlot(function () {
				return fetchBuffer(dir + name).then(function (buf) {
					var parts = splitJpm(buf);
					return Promise.all([loadBlob(parts[0]), loadBlob(parts[1])]);
				}).then(function (imgs) {
					var canvas = composite(imgs[0], imgs[1]);
					forget(imgs);
					atlases[name.replace(/\.jpm$/, '')] = cacheUnder(name, canvas);
					R.resolvePending(name);
					R.announce(name);
				});
			}).catch(function (e) {
				cc.log('[res] ' + name + ': ' + e);
			});
		}));

		if (maskedPairs.length > 0) {
			p = p.then(function () {
				return Promise.all(maskedPairs.map(function (pair) {
					return R.loadMaskedTexture(pair.mask, dir + pair.colour, dir + pair.mask)
						.then(function () {
							R.resolvePending(pair.mask);
							R.announce(pair.mask);
						})
						.catch(function (e) { cc.log('[res] masked pair ' + pair.base + ': ' + e); });
				}));
			});
		}

		p = p.then(function () {
			return Promise.all(rest.map(function (name) {
				if (/\.sfb$/.test(name)) {
					var base = name.replace(/\.png\.sfb$/, '')
							.replace(/\.sfb$/, '');
					return fetchBuffer(dir + name).then(function (buf) {
						var tex = atlases[base]
							|| cc.textureCache.getTextureForKey(base + '.jpm');
						if (!tex) throw new Error('no atlas for ' + name);
						R.framesOf[name] = [];   /* a reload must not stack onto the old list */
						addFrames(parseSfb(buf), tex, name);
						R.frameOwner[name] = base + '.jpm';
						R.announce(name);
					}).catch(function (e) { cc.log('[res] ' + name + ': ' + e); });
				}
				if (/\.lan$/.test(name)) {
					return fetch(versionedUrl(dir + name)).then(function (r) { return r.text(); })
						.then(function (text) {
							/* ClientData.addLanguage splits the file on LF
							 * and then walks a quoted field until it finds
							 * the closing quote. With CRLF endings the last
							 * character of such a field is the CR, so that
							 * walk never terminates and the client hangs.
							 * The tree's extend.lan is CRLF: normalise it
							 * before handing it over. */
							text = text.split('\r').join('');
							if (R.onLanguage) R.onLanguage(text);
							R.announce(name);
						}).catch(function (e) { cc.log('[res] ' + name + ': ' + e); });
				}
				if (/\.(jpg|png)$/.test(name)) {
					return new Promise(function (resolve) {
						var timer = setTimeout(function () { resolve(); }, 25000);
						var t = cc.textureCache.addImage(versionedUrl(dir + name), function (tex) {
							clearTimeout(timer);
							/* the game addresses a container's images by
							 * entry name, not by URL */
							if (tex && !(tex instanceof Error)) cacheUnder(name, tex);
							R.resolvePending(name);
							R.announce(name);
							resolve();
						});
						if (!t) { clearTimeout(timer); resolve(); }
					});
				}
				if (/\.bin$/.test(name)) {
					var binUrl = R.base + path.replace(/^res\//, '') + '/' + name;
					return fetch(versionedUrl(binUrl))
						.then(function (r) { return r.ok ? r.arrayBuffer() : null; })
						.then(function (buf) {
							if (buf && global.binCache) {
								var fullUrl = (R.base || 'res/') + path.replace(/^res\//, '') + '/' + name;
								global.binCache[fullUrl] = buf;
								global.binCache[fullUrl.split('?')[0]] = buf;
								global.binCache[binUrl] = buf;
								global.binCache[binUrl.split('?')[0]] = buf;
							}
						}).catch(function () {});
				}
				return Promise.resolve();
			}));
		});

		R.inflight[path] = p.then(function () {
			/* Effect containers carry their atlas index in *_tex.bin rather
			 * than a normal .sfb. Let the engine expose those regions to the
			 * shared FrameCache as soon as the container is resident. */
			if (/^res\/effects\/[^/]+\.lcres$/.test(path) &&
				global.jdzcRegisterEffectFrames) {
				global.jdzcRegisterEffectFrames(path);
			}
			R.loaded[path] = true;
			delete R.inflight[path];
			return entries;
		});
		return R.inflight[path];
	};

	R.unloadContainer = function (name) {
		/* name is an entry name, the way ClientData.unloadLCRes passes it */
		if (/\.sfb$/.test(name)) {
			var key = R.frameOwner[name];
			var tex = key && cc.textureCache.getTextureForKey(key);
			if (tex) cc.spriteFrameCache.removeSpriteFramesFromTexture(tex);
			if (key) cc.textureCache.removeTextureForKey(key);
			delete R.frameOwner[name];
		} else {
			cc.textureCache.removeTextureForKey(name);
		}
		/* The owning container must load again from scratch: its textures
		 * were just evicted, and a load that only re-announces would leave
		 * every sprite of the next visit on an empty placeholder. */
		var container = R.containerOf[name];
		if (container) delete R.loaded[container];
		delete maskedInflight[name];
		delete R.pending[name];
	};

	/* Bitmap fonts. cc.LabelBMFont wants the .fnt already parsed in
	 * cc.loader's cache and fails outright if it is not, and the game builds
	 * labels the moment a screen appears. There are seven of them; load them
	 * all before Lua starts, under the same paths the game names. */
	R.preloadFonts = function () {
		var fonts = R.manifest.files
			.filter(function (f) { return /\.fnt$/i.test(f); })
			.map(function (f) { return R.base + f.replace(/^res\//, ''); });

		var timeout = new Promise(function (resolve) { setTimeout(resolve, 3000); });

		var loadBMFonts = new Promise(function (resolve) {
			cc.loader.load(fonts, function () { resolve(fonts.length); });
		});

		var loadTTFFonts = (typeof document !== 'undefined' && document.fonts && document.fonts.load)
			? Promise.all([
				document.fonts.load('16px YuGiOhFont'),
				document.fonts.load('bold 16px YuGiOhFont'),
				document.fonts.load('16px "UTM Cafeta"'),
				document.fonts.load('bold 16px "UTM Cafeta"'),
				document.fonts.load('16px "Be Vietnam Pro"'),
				document.fonts.load('bold 16px "Be Vietnam Pro"'),
				document.fonts.ready
			]).catch(function (e) {
				console.warn('[Font] Preload TTF notice:', e);
			})
			: Promise.resolve();

		return Promise.all([Promise.race([loadBMFonts, timeout]), Promise.race([loadTTFFonts, timeout])]);
	};

	/* ------------------------------------------------------------------ *
	 * .pvr.ccz -- the updater's atlas
	 *
	 * RegionScene, the first screen, gets its art from res/updater: a
	 * TexturePacker plist over a .pvr.ccz. cocos2d-html5 knows neither
	 * format. The file turns out to be the easy case -- a zlib'd PVR v2
	 * holding plain RGBA8888 -- so it is decoded here and cached under the
	 * exact path the game asks for, before Lua starts, which also keeps
	 * cc.textureCache:addImage synchronous the way the game expects.
	 * ------------------------------------------------------------------ */

	/* inflate() via browser DecompressionStream, available in every modern
	 * browser since Chrome 80 / Safari 16.4 / Firefox 113 */
	function inflate(raw) {
		var stream = new Response(raw).body
			.pipeThrough(new DecompressionStream('deflate'));
		return new Response(stream).arrayBuffer();
	}

	function pvrToCanvas(raw) {
		var v = new DataView(raw);
		var headerLen = v.getUint32(0, true);
		var height = v.getUint32(4, true), width = v.getUint32(8, true);
		var bpp = v.getUint32(24, true);
		var tag = new Uint8Array(raw, 44, 4);

		if (String.fromCharCode.apply(null, tag) !== 'PVR!')
			throw new Error('not a PVR v2 container');
		if (bpp !== 32)
			throw new Error('unsupported PVR depth ' + bpp);

		var canvas = document.createElement('canvas');
		canvas.__jdzcOwned = true;
		canvas.width = width;
		canvas.height = height;

		var image = new ImageData(
			new Uint8ClampedArray(raw, headerLen, width * height * 4),
			width, height);
		canvas.getContext('2d').putImageData(image, 0, 0);
		return canvas;
	}

	R.preloadPvr = function () {
		var wanted = R.manifest.files.filter(function (f) {
			return /\.pvr\.ccz$/i.test(f);
		});

		var pvrTimeout = new Promise(function (resolve) { setTimeout(resolve, 4000); });
		var pvrPromise = Promise.all(wanted.map(function (path) {
			return fetchBuffer(R.base + path.replace(/^res\//, ''))
				.then(function (ccz) { return inflate(ccz.slice(16)); })
				.then(function (raw) {
					cacheUnder(path, pvrToCanvas(raw));
				})
				.catch(function (e) { cc.log('[res] ' + path + ': ' + e); });
		})).then(function () { return wanted.length; });

		return Promise.race([pvrPromise, pvrTimeout]);
	};

	/* ------------------------------------------------------------------ *
	 * data dumps and loose files
	 * ------------------------------------------------------------------ */

	R.setDumps = function (dumps) { R.dumps = dumps; };

	R.dump = function (name) {
		return (R.dumps && R.dumps[name]) || null;
	};

	R.exists = function (path) {
		if (!path) return false;
		if (typeof path === 'string') path = path.split('?')[0];
		if (CUSTOM_ICON_REPLACEMENTS && CUSTOM_ICON_REPLACEMENTS[path]) return true;
		if (!R.manifest) return false;
		if (!R.filesSet && R.manifest.files) {
			R.filesSet = new Set(R.manifest.files);
		}
		if (R.filesSet) {
			if (R.filesSet.has(path)) return true;
			var jpgPath = path.replace(/\.jpm$/, '.jpg');
			if (jpgPath !== path && R.filesSet.has(jpgPath)) return true;
		} else if (R.manifest.files) {
			if (R.manifest.files.indexOf(path) >= 0) return true;
			var jpgPath = path.replace(/\.jpm$/, '.jpg');
			if (jpgPath !== path && R.manifest.files.indexOf(jpgPath) >= 0) return true;
		}
		if (R.containerOf && R.containerOf[path]) return true;
		if (!R.containerEntriesSet && R.manifest.containers) {
			var set = new Set();
			for (var c in R.manifest.containers) {
				var ents = R.manifest.containers[c];
				if (ents) {
					for (var i = 0; i < ents.length; i++) set.add(ents[i]);
				}
			}
			R.containerEntriesSet = set;
		}
		if (R.containerEntriesSet && R.containerEntriesSet.has(path)) return true;
		return !!R.entriesOf(path);
	};

	R.textOf = function (path) {
		return R.texts ? (R.texts[path] || null) : null;
	};

	/* [width, height] of a loose image, known before it downloads */
	R.sizeOf = function (path) {
		if (!path) return null;
		if (typeof path === 'string') path = path.split('?')[0];
		if (R.manifest && R.manifest.sizes) {
			var norm = path.replace(/\.jpm$/, '.jpg');
			var found = R.manifest.sizes[path] || R.manifest.sizes[norm] ||
			            R.manifest.sizes[path.replace(/^res\//, '')] ||
			            R.manifest.sizes[norm.replace(/^res\//, '')] ||
			            R.manifest.sizes['res/' + path.replace(/^res\//, '')] ||
			            R.manifest.sizes['res/' + norm.replace(/^res\//, '')];
			if (found) return found;
		}
		if (/^\d+(_\d+)?\.(jpm|jpg)$/.test(path) || /thumb_(monster|magic|trap|rare)\/\d+(_\d+)?\.(jpm|jpg)$/.test(path)) {
			return [256, 256];
		}
		return null;
	};

	/* Small text resources the game reads synchronously (plists, bitmap font
	 * descriptors). There is no synchronous file IO in a browser, so they are
	 * fetched once at boot and answered from memory afterwards. */
	R.preloadTexts = function () {
		var wanted = R.manifest.files.filter(function (f) {
			return /\.(plist|fnt|csv|txt)$/i.test(f);
		});

		R.texts = {};
		return Promise.all(wanted.map(function (path) {
			return fetch(versionedUrl(R.base + path.replace(/^res\//, '')))
				.then(function (r) { return r.ok ? r.text() : null; })
				.then(function (text) {
					/* the plists ship with a BOM, which the XML parser
					 * refuses */
					if (text) R.texts[path] = text.replace(/^\uFEFF/, '');
				})
				.catch(function () { /* optional */ });
		})).then(function () { return wanted.length; });
	};

	/* The language table.
	 *
	 * main.lua calls lc.App:loadRes("res/lan.lcres") as its very first act and
	 * then builds RegionScene, which reads Str(STR.VERSION) while doing it. On
	 * the device that load is synchronous -- the table is complete before the
	 * next line runs. Here it is a 4 MB fetch, so the first screen used to be
	 * built against an empty table: Str() returned nil, the version label threw
	 * "attempt to concatenate a nil value" out of RegionScene.init, and the
	 * scene came up with no children at all -- a black screen.
	 *
	 * So fetch it before Lua starts and hand it over the moment Lua registers
	 * its parser, which reproduces the device's ordering. */
	R.preloadLanguage = function () {
		var entries = (R.manifest.containers['res/lan.lcres'] || [])
			.filter(function (e) { return /\.lan$/i.test(e); });

		R.languageTexts = [];
		return Promise.all(entries.map(function (name) {
			return fetch(versionedUrl(R.base + 'lan.lcres/' + name))
				.then(function (r) { return r.ok ? r.text() : null; })
				.then(function (text) {
					if (!text) return;
					/* addLanguage splits on LF and then walks a quoted field
					 * to its closing quote; with CRLF the last character of
					 * such a field is the CR and the walk never ends. */
					R.languageTexts.push(text.split('\r').join(''));
				})
				.catch(function () { /* optional */ });
		})).then(function () { return entries.length; });
	};

	/* Preload custom icons (Linh Thach, Linh Thach Cao Cap) and custom buttons */
	R.preloadCustomAssets = function () {
		var assets = [
			'res/jpg/city_bg_01.jpg',
			'res/updater/loading.jpg',
			'res/new/linh_thach_34.png',
			'res/new/linh_thach_76.png',
			'res/new/linh_thach_vip_36.png',
			'res/new/linh_thach_vip_76.png',
			'res/new/buttons/confirm_120x60.png',
			'res/new/buttons/confirm_140x78.png',
			'res/new/buttons/confirm_160x78.png',
			'res/new/buttons/confirm_180x78.png',
			'res/new/buttons/confirm_200x78.png',
			'res/new/buttons/confirm_220x78.png',
			'res/new/buttons/confirm_240x78.png',
			'res/new/buttons/cancel_120x60.png',
			'res/new/buttons/cancel_140x78.png',
			'res/new/buttons/cancel_160x78.png',
			'res/new/buttons/cancel_180x78.png',
			'res/new/buttons/cancel_200x78.png',
			'res/new/buttons/cancel_220x78.png',
			'res/new/buttons/cancel_240x78.png',
			'res/new/buttons/red_120x60.png',
			'res/new/buttons/red_140x78.png',
			'res/new/buttons/red_160x78.png',
			'res/new/buttons/red_180x78.png',
			'res/new/buttons/red_200x78.png',
			'res/new/buttons/red_220x78.png',
			'res/new/buttons/red_240x78.png'
		];
		Object.keys(CUSTOM_ICON_REPLACEMENTS).forEach(function (k) {
			var p = CUSTOM_ICON_REPLACEMENTS[k].path;
			if (assets.indexOf(p) < 0) assets.push(p);
		});
		var promises = assets.map(function (path) {
			return new Promise(function (resolve) {
				var timer = setTimeout(function () { resolve(null); }, 5000);
				cc.textureCache.addImage(versionedUrl(path), function (tex) {
					clearTimeout(timer);
					if (tex && !(tex instanceof Error)) {
						cc.textureCache._textures[path] = tex;
					}
					resolve(tex);
				});
			});
		});
		return Promise.all(promises).then(function () {
			Object.keys(CUSTOM_ICON_REPLACEMENTS).forEach(function (name) {
				var info = CUSTOM_ICON_REPLACEMENTS[name];
				var tex = cc.textureCache.getTextureForKey(info.path) || cc.textureCache.getTextureForKey(versionedUrl(info.path));
				if (tex) {
					var frame = new cc.SpriteFrame(tex, cc.rect(0, 0, info.w, info.h), false, cc.p(0, 0), cc.size(info.w, info.h));
					frame._textureLoaded = (typeof tex.isLoaded === 'function') ? tex.isLoaded() : true;
					cc.spriteFrameCache.addSpriteFrame(frame, name);
					R.resolveFrame(name, frame);
				}
			});
		}).catch(function(e) { console.warn('[res] preloadCustomAssets notice:', e); });
	};

	R.announce = function (name) {
		if (R.onEntry) R.onEntry(name);
	};

	/* ------------------------------------------------------------------ *
	 * sprites waiting for their art
	 *
	 * Each card thumbnail is its own container, and the game asks for the
	 * texture in the same breath as it asks for the load -- on the device
	 * that was one synchronous call. Here the sprite comes back empty and is
	 * filled in when its container lands, a moment later.
	 * ------------------------------------------------------------------ */

	R.pending = {};

	R.awaitTexture = function (key, sprite) {
		(R.pending[key] || (R.pending[key] = [])).push(sprite);
	};

	R.resolvePending = function (key) {
		var waiting = R.pending[key];
		if (!waiting) return;
		delete R.pending[key];

		var texture = cc.textureCache.getTextureForKey(key);
		if (!texture) return;

		for (var i = 0; i < waiting.length; i++) {
			global.jdzcAttachTexture(waiting[i], texture);
		}
	};

	/* called once from Lua: R.onEntry dispatches Data.Event.resource */
	R.setCallbacks = function (onEntry, onLanguage) {
		R.onEntry = onEntry;
		R.onLanguage = onLanguage;

		/* The language table was fetched before Lua existed. Give it to the
		 * parser now, in the order the device would have read it. */
		(R.languageTexts || []).forEach(function (text) { onLanguage(text); });
	};

	/* Lua asks for a container. The bytes arrive later, through onEntry,
	 * but the entry list itself is known from the manifest and some
	 * callers (main.lua's data.lcres pass) use it right away. */
	R.load = function (path) {
		var entries = R.entriesOf(path) || [];

		/* The device read a container off disk and had every texture in
		 * hand on the next line. Here the bytes are still on their way, so
		 * register an empty one per image now and let loadContainer fill
		 * it: ClientView.getCardImageName asks the cache for a card's art
		 * the moment it asks for the container, and falls back to card
		 * 10001's picture for anything the cache does not know -- which
		 * left every card in the game showing the same dragon. */
		entries.forEach(function (name) {
			if (/\.(jpg|png|jpm)$/.test(name) &&
			    !cc.textureCache.getTextureForKey(name)) {
				cc.textureCache._textures[name] = emptyTexture(name);
			}
		});

		R.loadContainer(path);
		return entries;
	};

	global.jdzcRes = R;
})(window);
