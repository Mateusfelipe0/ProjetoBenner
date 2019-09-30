import Page from "./Page";

var ThermoStat = {};

ThermoStat.init = function () {
    if (typeof thermostatio !== 'undefined' &&
        Benner.ThermoStat.isValidSystem(Page.systemName) &&
        Page.isProduction &&
        !Page.isBennerEnvironment &&
        !Page.isModalPage &&
        Page.canShowNPS &&
        Page.userEmail.toLowerCase().indexOf("@benner.com.br") == -1 &&
        !Benner.ThermoStat.ignored.includes(Page.activeRole)) {

        thermostatio.start({
            show: true,
            email: Benner.Page.userEmail,
            name: Benner.Page.userFullName,
            cid: $('#cid').val(),

            //Custom Fields
            fields: {
                usuario: Benner.Page.userName,
                versao: Benner.Page.systemVersion,
                produto: Benner.Page.systemName.toUpperCase(),
                cliente: Benner.Page.client,
                origem: 'WES',
                papel: Benner.Page.activeRole,
                versaotec: Benner.Page.wesVersion,
            },

            // When this cookie exists survey won't be shown
            hide_cookie: 'thermostatio_hide',

            // Default value set by survey configuration
            // Don't resurvey the same person again for this many days
            lockout_period: 90,

            // Default value set by survey configuration.
            // If the user manually closes the survey don't
            // attempt to survey again for this many days
            closeLockout: 15,

            // Tracks how many page views there have been
            plcookiename: 'thermostatio_pl',

            // Default value set by survey configuration.
            // Min number of page views required
            // before attempting to show survey
            minPageLoadsBeforeShowing: 1,

            // How long the pageload tracking cookie lasts
            pageLoadTrackingPeriod: 0,
        });
    }
};

ThermoStat.isValidSystem = function (systemName) {
    return ['CORPORATIVO', 'WMS', 'LOGISTICA', 'PROCESSOS', 'RH', 'AG', 'AG-CAMED', 'AG-CASSI', 'AUDITORIA', 'MG', 'PORTAL', 'PREVINNE'].indexOf(systemName.toUpperCase()) >= 0;
};
export default ThermoStat;