/* boot.js -- brings up the web client.
 *
 * cocos2d-html5 loads this last (see project.json), calls cc.game.run(), and
 * hands control to onStart. From there:
 *
 *   1. fetch the resource manifest, the Lua sources and the data dumps
 *   2. start the wasm Lua 5.1 VM and wire the JS bridge to it
 *   3. write the game's modules into the VM's filesystem
 *   4. run lua/h5_boot.lua, which requires the game's own main.lua
 *
 * Nothing about the game's Lua is modified on the way in: the sources are the
 * same files the Android build packs.
 */
(function (global) {
	'use strict';

	var isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) || (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1);
	/* The native client uses FIXED_HEIGHT with a 768px design height.  The
	 * authored scene coordinates (including FindClashArea's field at y=244)
	 * are in this logical surface; the browser viewport supplies only the
	 * scale and aspect-ratio-derived width. */
	var DESIGN_H = 768;
	var viewportW = Math.max(1, global.innerWidth || 1024);
	var viewportH = Math.max(1, global.innerHeight || 768);
	/* Replaced in onStart by what the view actually resolved to. */
	var DESIGN_W = Math.round(DESIGN_H * viewportW / viewportH);
	/* The bar's scale is the game's own. main.lua's boot chain announces its
	 * milestones as INIT_PROGRESS_40/50/60/80/100, and 100 lands immediately
	 * before it replaces the scene with RegionScene -- so the browser-side
	 * fetches fill only 0..40 and the game's numbers carry the rest. The
	 * overlay comes down on 100, which makes "bar full" and "game up" the
	 * same moment instead of leaving the player on a full bar. */
	var JS_PHASE = 0.4;
	var Boot = {
		lua: null,
		loaded: 0,
		total: 1,
		shown: 0,
		/* monotonic: a milestone never drags the bar backwards */
		progress: function (value) {
			if (!isFinite(value)) return;
			value = Math.max(0, Math.min(1, value));
			if (value <= Boot.shown) return;
			Boot.shown = value;
			var el = document.getElementById('bootProgress');
			if (el) el.value = value;
			if (global.__setBootProgress) global.__setBootProgress(value);
		},
		/* the fetch phase is only a fraction of the whole boot */
		fetchProgress: function (value) { Boot.progress(value * JS_PHASE); },
		takeOverlayDown: function () {
			if (Boot.done) return;
			Boot.done = true;
			status('running');
			var el = document.getElementById('bootOverlay');
			if (el) el.style.display = 'none';
		},
	};

	function fetchJson(url) {
		var bustUrl = url + (url.indexOf('?') >= 0 ? '&' : '?') + '_t=' + Date.now();
		return fetch(bustUrl, { cache: 'no-store' }).then(function (r) {
			if (!r.ok) throw new Error(r.status + ' ' + url);
			var len = Number(r.headers.get('content-length')) || 0;
			if (!r.body || !len) return r.json();
			var reader = r.body.getReader(), chunks = [], received = 0;
			function read() { return reader.read().then(function (part) {
				if (part.done) { var all = new Uint8Array(received), p = 0;
					chunks.forEach(function (c) { all.set(c, p); p += c.length; });
					return JSON.parse(new TextDecoder().decode(all)); }
				chunks.push(part.value); received += part.value.length;
			Boot.fetchProgress((Boot.loaded + received / Math.max(1, len)) / Math.max(1, Boot.total));
				return read();
			}); }
			return read();
		});
	}

	function status(text) {
		var el = document.getElementById('bootStatus');
		if (el) el.textContent = text;
		if (global.__setBootProgress) global.__setBootProgress(undefined, text);
		cc.log('[boot] ' + text);
	}

	Boot.start = function () {
		var config = global.JDZC_CONFIG;

		status('Đang tải dữ liệu cấu hình...');

		/* Four bootstrap resources plus each configured preload are real work
		 * units.  The bar advances only when a fetch/decoder promise resolves;
		 * there is no timer-based fake progress. */
		Boot.loaded = 0;
		Boot.total = 9 + ((global.JDZC_CONFIG && global.JDZC_CONFIG.preload) || []).length;
		Boot.progress(0);
		function done(p) { return p.then(function (v) { Boot.loaded++; Boot.fetchProgress(Boot.loaded / Boot.total); return v; }); }
		var ver = (global.JDZC_CONFIG && global.JDZC_CONFIG.version) || '20260924v1';
		return Promise.all([
			done(fetchJson('res_manifest.json?v=' + ver)),
			done(fetchJson('lua_src.json?v=' + ver)),
			done(fetchJson('data_dumps.json?v=' + ver)),
			done(global.LuaVM()),
		]).then(function (all) {
			var manifest = all[0], sources = all[1], dumps = all[2],
			    Module = all[3];

			jdzcRes.init(manifest, config.resBase);
			jdzcRes.setDumps(dumps);

			/* RegionScene, the first screen, builds its UI the moment it is
			 * created and cannot wait for a container to arrive, so the few
			 * it needs are resident before Lua starts. Everything after it
			 * goes through LoadingScene, which is event-driven and happy to
			 * wait.
			 *
			 * The language table is in the same class of problem, only worse:
			 * main.lua loads it and then reads Str() from it on the next
			 * line, which is safe on the device because loadRes is
			 * synchronous there. It is fetched first here so the parser can
			 * be handed a complete table before Lua runs. */
			status('Đang tải tài nguyên hình ảnh...');
			var preloadList = config.preload || [];
			function safe(tag, p, timeoutMs) {
				if (!p || typeof p.then !== 'function') return Promise.resolve(p);
				var limit = timeoutMs || (isIOS ? 30000 : 25000);
				var timer = new Promise(function (resolve) {
					setTimeout(function () {
						console.warn('[boot] ' + tag + ' timed out (' + limit + 'ms), proceeding to prevent freeze');
						resolve(null);
					}, limit);
				});
				return Promise.race([p, timer]).catch(function (err) {
					console.warn('[boot] ' + tag + ' notice:', err);
					return null;
				});
			}
			return Promise.all([
				done(safe('Language', jdzcRes.preloadLanguage())),
				done(safe('Texts', jdzcRes.preloadTexts())),
				done(safe('Pvr', jdzcRes.preloadPvr())),
				done(safe('Fonts', jdzcRes.preloadFonts())),
				done(safe('jindutiao', jdzcRes.loadTexture('res/particle/jindutiao.png'))),
				done(safe('CustomAssets', jdzcRes.preloadCustomAssets ? jdzcRes.preloadCustomAssets() : Promise.resolve())),
				done(safe('Shaders', global.jdzcPreloadShaders ? global.jdzcPreloadShaders() : Promise.resolve())),
			]).then(function () {
				/* Load containers with controlled concurrency (2 on iOS to avoid canvas memory exhaustion, 4 on desktop) */
				var index = 0;
				var concurrency = isIOS ? 2 : 4;
				function loadNext() {
					if (index >= preloadList.length) return Promise.resolve();
					var path = preloadList[index++];
					return done(safe('Container ' + path, jdzcRes.loadContainer(path), 35000)).then(loadNext);
				}
				var workers = [];
				for (var w = 0; w < Math.min(concurrency, preloadList.length); w++) {
					workers.push(loadNext());
				}
				return Promise.all(workers);
			}).then(function () {
				return [sources, dumps, Module];
			});
		}).then(function (all) {
			var sources = all[0], Module = all[2];

			status('Đang khởi động engine game...');

			var lua = new global.JdzcLua(Module);
			Boot.lua = lua;
			global.jdzcLua = lua;

			/* the game's modules, flat: basenames are unique tree-wide */
			Module.FS.mkdir('/src');
			Module.FS.mkdir('/save');
			Object.keys(sources).forEach(function (name) {
				Module.FS.writeFile('/src/' + name + '.lua', sources[name]);
			});

			lua.run(sources.bridge, 'bridge.lua');
			lua.newproxyRef = lua.getGlobalRef('__jsb_newproxy');

			lua.run('package.path = "/src/?.lua"', 'package.path');

			/* the fork registers these as native constants, and the game
			 * does arithmetic on them while modules are still loading */
			lua.setGlobal('JDZC_TRACE', !!config.trace);
			lua.setGlobal('JDZC_VERSION', config.version || '1.0.0.1089');
			lua.setGlobal('JDZC_REGION', config.region || null);
			lua.setGlobal('SCR_W', DESIGN_W);
			lua.setGlobal('SCR_H', DESIGN_H);

			global.jdzcOnLuaError = function (msg) {
				console.error('[lua error] ' + msg);
			};

			/* main.lua reports where its boot chain is through
			 * Data.Event.application ("event_application", Data.lua), one
			 * INIT_PROGRESS_<n> event per milestone. Left registered on
			 * purpose: ClientData listens on the same event, and removing a
			 * listener from inside its own dispatch splices the vector being
			 * iterated. `Boot.done` makes it a no-op after boot. */
			cc.eventManager.addCustomListener('event_application', function (e) {
				if (Boot.done) return;
				var m = /^INIT_PROGRESS_(\d+)$/.exec(e.getUserString() || '');
				if (!m) return;
				var pct = parseInt(m[1], 10);
				Boot.progress(pct / 100);
				if (pct >= 100) Boot.takeOverlayDown();
			});

			status('Đang vào thế giới Yu-Gi-Oh!...');
			lua.run('require("h5_boot")', 'h5_boot');

			/* Safety net: a boot chain that dies before 100 would leave the
			 * player on a bar that never finishes. */
			setTimeout(Boot.takeOverlayDown, 60000);
		});
	};

	global.JdzcBoot = Boot;

	/* Fullscreen is the difference between a phone game and a web page, and
	 * the browser only grants it from a gesture -- so it rides the first tap,
	 * which the player makes anyway. The orientation is left alone on purpose:
	 * locking landscape would flip the page under a player still holding the
	 * phone upright, and #rotateHint already asks them to turn it. */

		function enterFullscreen() {
		var el = document.documentElement;
		if (document.fullscreenElement || !el.requestFullscreen) return;
		var req = el.requestFullscreen({ navigationUI: 'hide' });
		if (req && req.catch) req.catch(function () {});
	}

	cc.game.onStart = function () {
		cc.view.adjustViewPort(true);
		/* The phone hands cocos CSS pixels and cocos only turns retina on for
		 * iOS/mac, so on Android the whole game rendered at ~400x860 and the
		 * panel upscaled it -- soft art, soft text. This makes the canvas
		 * backing store the real screen, capped at 2x: past that it is fill
		 * rate for nothing. Has to come first, because the design size reads
		 * it when it sizes the canvas. */
		cc.view.enableRetina(true);
		/* Match the native Director: a fixed logical height with the width
		 * expanded to the browser aspect ratio. Fixed height in portrait too
		 * -- SHOW_ALL would frame a 1024-wide surface and leave black bars
		 * beside it for good once the player rotates into landscape. */
		cc.view.setDesignResolutionSize(DESIGN_W, DESIGN_H, cc.ResolutionPolicy.FIXED_HEIGHT);
		cc.view.resizeWithBrowserSize(true);
		/* what fixed-height actually handed us, rather than the aspect guessed
		 * from window.inner* above -- they agree, but only one is the truth */
		DESIGN_W = Math.round(cc.view.getVisibleSize().width);

		/* Entering fullscreen and rotating both change the frame, and mobile
		 * browsers report the old one for a beat -- so re-run the resize once
		 * it has settled. cocos binds its own handler to the same events. */
		function triggerLuaResize() {
			if (window.jdzcLua && window.jdzcLua.run) {
				try {
					window.jdzcLua.run('pcall(function() if ClientView and ClientView.updateScreenSize then ClientView.updateScreenSize() end end)');
				} catch (e) {}
			}
		}
		window.triggerLuaResize = triggerLuaResize;

		['fullscreenchange', 'webkitfullscreenchange', 'orientationchange'].forEach(function (name) {
			document.addEventListener(name, function () {
				setTimeout(function () {
					cc.view._resizeEvent();
					triggerLuaResize();
				}, 300);
			});
		});
		window.addEventListener('resize', function () {
			setTimeout(function () {
				triggerLuaResize();
			}, 300);
		});
		document.addEventListener('touchend', function onFirstTap() {
			document.removeEventListener('touchend', onFirstTap);
			enterFullscreen();
			setTimeout(triggerLuaResize, 400);
		}, { passive: true });

		/* the game's boot chain schedules its first step on the running
		 * scene, so one has to exist before main.lua runs */
		cc.director.runScene(new cc.Scene());

		Boot.start().catch(function (e) {
			status('boot failed: ' + (e && e.stack ? e.stack : e));
			cc.error(e);
		});
	};

	cc.game.run();
})(window);
