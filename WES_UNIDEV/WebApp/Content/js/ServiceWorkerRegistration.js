document.addEventListener("DOMContentLoaded", function (event) {
	// Registra um service-worker para se comportar como Progressive Web App
	if ('serviceWorker' in navigator) {
		navigator.serviceWorker.register(Benner.Page.getApplicationPath() + "content/js/ServiceWorker.js")
			.then(function (reg) {

			}).catch(function (err) {
                console.log("Não foi possível registrar o service worker. Mensagem:", err);
			});
	}
});
