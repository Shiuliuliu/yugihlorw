/* sw.js -- Service Worker for YuGiH5 Web Client
 * Provides instant offline caching and sub-millisecond local loading (Arcana architecture)
 */

var CACHE_NAME = 'yugihlor-cache-20261116v050000';
var VENDOR_CACHE = 'yugihlor-vendor-cache-v2';

var STATIC_EXTENSIONS = [
	'.jpg', '.jpeg', '.png', '.jpm', '.sfb', '.lcres',
	'.woff', '.woff2', '.ttf', '.fnt', '.plist', '.wav', '.mp3', '.ogg', '.lan', '.css'
];

self.addEventListener('install', function (event) {
	self.skipWaiting();
});

self.addEventListener('activate', function (event) {
	event.waitUntil(
		caches.keys().then(function (cacheNames) {
			return Promise.all(
				cacheNames.map(function (name) {
					if (name !== CACHE_NAME && name !== VENDOR_CACHE) {
						console.log('[SW] Deleting old cache:', name);
						return caches.delete(name);
					}
				})
			);
		}).then(function () {
			return self.clients.claim();
		})
	);
});

function fetchWithRetry(req, retries) {
	return fetch(req).then(function (resp) {
		if (resp && resp.ok) return resp;
		if (retries > 0 && (!resp || resp.status >= 500)) {
			return new Promise(function (resolve) {
				setTimeout(resolve, 300);
			}).then(function () {
				return fetchWithRetry(req, retries - 1);
			});
		}
		return resp;
	}).catch(function (err) {
		if (retries > 0) {
			return new Promise(function (resolve) {
				setTimeout(resolve, 300);
			}).then(function () {
				return fetchWithRetry(req, retries - 1);
			});
		}
		return Promise.reject(err);
	});
}

self.addEventListener('fetch', function (event) {
	var req = event.request;
	if (req.method !== 'GET') return;

	var url = new URL(req.url);

	// Never intercept web sockets or dynamic backend APIs
	if (url.pathname.startsWith('/api') || url.pathname.startsWith('/ws') ||
	    url.port === '9191' || url.port === '9192' || url.port === '9193' || url.port === '8082') {
		return;
	}

	var pathname = url.pathname.toLowerCase();

	// 1. Vendor scripts (/vendor/...): Cocos2d engine framework never changes across updates.
	// Cache-First with retry ensures 0ms load and complete immunity to 502 Bad Gateway.
	if (pathname.indexOf('/vendor/') >= 0) {
		event.respondWith(
			caches.open(VENDOR_CACHE).then(function (cache) {
				return cache.match(req).then(function (cached) {
					if (cached) return cached;
					return fetchWithRetry(req, 2).then(function (netRes) {
						if (netRes && netRes.ok) {
							try { cache.put(req, netRes.clone()); } catch (e) {}
						}
						return netRes;
					});
				});
			})
		);
		return;
	}

	var isDynamicBundle = pathname.endsWith('lua_bundle.bin') ||
	                      pathname.endsWith('data_bundle.bin') ||
	                      pathname.endsWith('lua_src.json') ||
	                      pathname.endsWith('data_dumps.json') ||
	                      pathname.endsWith('res_manifest.json') ||
	                      pathname.endsWith('.js') ||
	                      pathname.endsWith('.html') ||
	                      pathname === '/';

	// 2. Code/data bundles and app scripts: Network-first with automatic fallback to cache on 5xx/error.
	if (isDynamicBundle) {
		event.respondWith(
			fetch(req, { cache: 'no-store' }).then(function (networkResponse) {
				if (networkResponse && networkResponse.ok) {
					var clone = networkResponse.clone();
					caches.open(CACHE_NAME).then(function (cache) {
						cache.put(req, clone).catch(function () {});
					});
					return networkResponse;
				}
				// If server returned 5xx / 502 / network glitch, fallback to cached copy so game boots cleanly
				if (!networkResponse || networkResponse.status >= 500) {
					return caches.match(req).then(function (cached) {
						return cached || networkResponse;
					});
				}
				return networkResponse;
			}).catch(function () {
				return caches.match(req);
			})
		);
		return;
	}

	// 3. Static game assets (images, audio, fonts, lcres, etc.): Cache-First
	var isStatic = STATIC_EXTENSIONS.some(function (ext) { return pathname.endsWith(ext); }) ||
	               pathname.indexOf('/res/') >= 0;

	if (!isStatic) return;

	event.respondWith(
		caches.open(CACHE_NAME).then(function (cache) {
			return cache.match(req).then(function (cached) {
				if (cached) {
					return cached;
				}
				return fetch(req).then(function (networkResponse) {
					if (networkResponse && networkResponse.ok) {
						try {
							var responseToCache = networkResponse.clone();
							cache.put(req, responseToCache).catch(function () {});
						} catch (e) {}
					}
					return networkResponse;
				}).catch(function (err) {
					return cached || Promise.reject(err);
				});
			});
		})
	);
});
