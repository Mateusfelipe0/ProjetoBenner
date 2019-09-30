GoogleAnalytics = function () {
    console.log('GoogleAnalytics');
};

GoogleAnalytics.init = function () {

    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }

    gtag('js', new Date());

    gtag('config', 'UA-126321264-1', {
        'custom_map': {
            'dimension1': 'sistema',
            'dimension2': 'versao',
            'dimension3': 'cliente',
            'dimension4': 'versaoTec',
            'dimension5': 'ambiente',
            'dimension6': 'mododesenv'
        }
    });

    gtag('event', 'page_view', {
        'sistema': Benner.Page.systemName,
        'versao': Benner.Page.systemVersion,
        'cliente': Benner.Page.client,
        'versaoTec': Benner.Page.wesVersion,
        'ambiente': Benner.Page.environmentDescription,
        'mododesenv': Benner.Page.developmentEnvironment
    });
}

module.exports = GoogleAnalytics;