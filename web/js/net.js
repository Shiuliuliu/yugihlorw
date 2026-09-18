/* net.js -- the game's TCP transport, over a WebSocket.
 *
 * Socket_pb speaks a raw stream: a 4-byte big-endian length, then an
 * LCCrypt-scrambled, CRC16-checked protobuf SglMsg. All of that framing is
 * pure Lua and untouched here -- only the pipe underneath changes, because a
 * browser cannot open a TCP socket.
 *
 * The server side is a WebSocket endpoint in front of the existing Netty
 * pipeline (jdzc-java, WsBridgeHandler): one WebSocket connection is one TCP
 * session, and binary frames are handed to the same decoder chain. Frame
 * boundaries carry no meaning -- Lua reassembles the stream itself -- so a
 * frame may hold part of a message or several.
 */
(function (global) {
	'use strict';

	var config = global.JDZC_CONFIG || {};

	/* The game hands over the region's own host:port, which is how the
	 * device reaches the server. A browser reaches it through whatever host
	 * served the page, so that is the default; JDZC_CONFIG.wsUrl overrides
	 * it outright. */
	function url(host, port) {
		if (config.wsUrl) return config.wsUrl;
		var isHttps = global.location.protocol === 'https:';
		var scheme = isHttps ? 'wss://' : 'ws://';
		var h = config.wsHost || global.location.hostname;
		var p = '';
		if (isHttps) {
			p = global.location.port ? (':' + global.location.port) : '';
		} else {
			p = ':' + (config.wsPort || global.location.port || port || 8080);
		}
		return scheme + h + p + '/ws';
	}

	function Socket(host, port, onEvent) {
		var self = this;
		this.onEvent = onEvent;
		this.closed = false;

		var ws = new WebSocket(url(host, port));
		ws.binaryType = 'arraybuffer';
		this.ws = ws;

		ws.onopen = function () { self.emit('open', null); };
		ws.onmessage = function (e) {
			self.emit('data', new Uint8Array(e.data));
		};
		ws.onclose = function () {
			if (!self.closed) { self.closed = true; self.emit('close', null); }
		};
		ws.onerror = function () {
			if (!self.closed) { self.closed = true; self.emit('error', 'websocket'); }
		};
	}

	Socket.prototype.emit = function (what, payload) {
		try {
			this.onEvent(what, payload);
		} catch (e) {
			cc.log('[net] ' + what + ': ' + (e && e.stack ? e.stack : e));
		}
	};

	Socket.prototype.send = function (bytes) {
		if (this.ws.readyState === WebSocket.OPEN) this.ws.send(bytes);
	};

	Socket.prototype.close = function () {
		this.closed = true;
		try { this.ws.close(); } catch (e) { /* already gone */ }
	};

	global.jdzcNet = {
		open: function (host, port, onEvent) {
			return new Socket(host, port, onEvent);
		},
	};
})(window);
