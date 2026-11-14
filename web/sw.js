/* sw.js -- Service Worker for YuGiH5 Web Client
 * Provides instant offline caching and sub-millisecond local loading (Arcana architecture)
 */

var CACHE_NAME = 'yugihlor-cache-20261115v050500';

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
					if (name !== CACHE_NAME) {
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
	var isBundle = pathname.endsWith('lua_bundle.bin') ||
	               pathname.endsWith('data_bundle.bin') ||
	               pathname.endsWith('lua_src.json') ||
	               pathname.endsWith('data_dumps.json') ||
	               pathname.endsWith('res_manifest.json') ||
	               pathname.endsWith('.js') ||
	               pathname.endsWith('.html') ||
	               pathname === '/';

	// Network-first for code/data bundles and scripts so APK & Web always stay 100% in sync
	if (isBundle) {
		event.respondWith(
			fetch(req, { cache: 'no-store' }).then(function (networkResponse) {
				if (networkResponse && networkResponse.status === 200) {
					var clone = networkResponse.clone();
					caches.open(CACHE_NAME).then(function (cache) {
						cache.put(req, clone).catch(function () {});
					});
				}
				return networkResponse;
			}).catch(function () {
				return caches.match(req);
			})
		);
		return;
	}

	// Determine if this is a static game asset
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
					if (networkResponse && networkResponse.status === 200) {
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
