/* sw.js -- Service Worker for YuGiH5 Web Client
 * Provides instant offline caching and sub-millisecond local loading (Arcana architecture)
 */

var CACHE_NAME = 'yugihlor-cache-20261028v120500';

var STATIC_EXTENSIONS = [
	'.bin', '.json', '.jpg', '.jpeg', '.png', '.jpm', '.sfb', '.lcres',
	'.woff', '.woff2', '.ttf', '.fnt', '.plist', '.wav', '.mp3', '.ogg', '.lan', '.css', '.js'
];

self.addEventListener('install', function (event) {
	self.skipWaiting();
});

self.addEventListener('activate', function (event) {
	event.waitUntil(
		caches.keys().then(function (cacheNames) {
			return Promise.all(
				cacheNames.map(function (name) {
					if (name !== CACHE_NAME && name.startsWith('yugihlor-cache-')) {
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

	// Determine if this is a static game asset
	var pathname = url.pathname.toLowerCase();
	var isStatic = STATIC_EXTENSIONS.some(function (ext) { return pathname.endsWith(ext); }) ||
	               pathname.indexOf('/res/') >= 0 ||
	               pathname.endsWith('lua_bundle.bin') ||
	               pathname.endsWith('data_bundle.bin');

	if (!isStatic) return;

	event.respondWith(
		caches.match(req).then(function (cached) {
			if (cached) {
				return cached;
			}
			return fetch(req).then(function (networkResponse) {
				if (networkResponse && networkResponse.status === 200) {
					var responseToCache = networkResponse.clone();
					caches.open(CACHE_NAME).then(function (cache) {
						cache.put(req, responseToCache);
					});
				}
				return networkResponse;
			}).catch(function (err) {
				return cached || Promise.reject(err);
			});
		})
	);
});
