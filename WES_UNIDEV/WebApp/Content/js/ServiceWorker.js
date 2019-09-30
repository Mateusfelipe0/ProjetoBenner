// Service worker

const PRECACHE = 'precache-v2';
const RUNTIME = 'runtime';

const PRECACHE_URLS = [
  '../../Default.aspx',
  '../../Login',
  '../../',
  '../dist/benner.min.css',
  '../dist/benner.min.js',
  '../dist/benner.min.js.map'
];

self.addEventListener('install', event => {
	event.waitUntil(
		caches.open(PRECACHE)
		.then(cache => cache.addAll(PRECACHE_URLS))
		.then(self.skipWaiting())
	);
});

self.addEventListener('activate', event => {
	const currentCaches = [PRECACHE, RUNTIME];
	event.waitUntil(
		caches.keys().then(cacheNames => {
			return cacheNames.filter(cacheName => !currentCaches.includes(cacheName));
		}).then(cachesToDelete => {
			return Promise.all(cachesToDelete.map(cacheToDelete => {
				return caches.delete(cacheToDelete);
			}));
		}).then(() => self.clients.claim())
	);
});