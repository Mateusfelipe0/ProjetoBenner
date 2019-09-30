//Hack para o IE11
//javascript do IE 11 não suporta o método window.attachEvent
//entretanto o componente server side da Microsoft, gera um javascript utilizando a instrução não suportada (attachEvent).
var isIE11 = !!(navigator.userAgent.match(/Trident/) && !navigator.userAgent.match(/MSIE/));
if (isIE11) {
    if (typeof window.attachEvent == "undefined" || !window.attachEvent) {
        window.attachEvent = window.addEventListener;
    }
}