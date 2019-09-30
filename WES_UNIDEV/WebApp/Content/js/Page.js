import Form from './Form';
import Search from './Search';
import Control from './Control';
import ModalPage from './ModalPage';
import ModalMessage from './ModalMessage';
import Widget from './Widget';
import Grid from './Grid';
import Calendar from './Calendar';
import AsyncProcesses from './AsyncProcesses';
import HorizontalMenu from './HorizontalMenu';
import AutoComplete from './AutoComplete';
import SourceEditor from './SourceEditor';
import Sidebar from './Sidebar';
import Development from './Development';
import ChatBot from './ChatBot';
import Searcher from './Searcher';
import ThermoStat from './ThermoStat';
import GoogleAnalytics from './GoogleAnalytics';

var Page = function () {

};

Page.processingTimeoutId = null;
Page.processing = null;
Page.progressShowed = null;
Page.webTour = null;
Page.webTourSteps = null;
Page.userName = null;
Page.userEmail = null;
Page.wesVersion = null;
Page.systemVersion = null;
Page.systemName = null;
Page.client = null;
Page.isBennerEnvironment = null;
Page.isModalPage = null;
Page.activeRole = null;
Page.isProduction = null;
Page.environmentDescription = null;
Page.developmentEnvironment = null;
Page.useGoogleAnalytics = null;
Page.canShowNPS = null;

Page.loading = function (sender, args) {

};

Page.loaded = function (sender, args) {
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    if (!prm.get_isInAsyncPostBack()) {
		Page.initWebTour();
		ThermoStat.init();
    }
};

Page.preventPostbackOnEnterKeyDown = function (event) {
    if (event.which != 13 || (event.target.type != 'text' && event.target.type != 'checkbox' && event.target.type != 'radio'))
        return false;
    event.preventDefault();
    event.stopPropagation();
    return true;
};

Page.keyDown = function (evt) {
    var forms = Form.widgets;
    for (var i = 0; i < forms.length; i++) {
        if (forms[i].formViewMode == 'Edit' || forms[i].formViewMode == 'Insert') {
            var t = evt.target.type;
            var kc = evt.which;
            if ((kc == 8) && (t != 'text' && t != 'textarea' && t != 'password' && t != 'search' && !$(evt.target).hasClass("note-editable"))) {
                evt.preventDefault();
                var confirmation = window.confirm("Seu formulário ainda não foi salvo.\n\nDeseja sair do formulário?");
                if (confirmation)
                    window.history.back();
                break;
            }
        }
    }
};

Page.openEnvironmentSummary = function () {
    if (ModalPage.isOpen()) {
        var modalBody = $('.modal.in .modal-body');
        var iframe = modalBody.find('iframe');
        if (iframe.length > 0) {
            for (var i = 0; i < iframe.length; i++) {
                if ($(iframe[i]).attr('src').indexOf('EnvironmentInfoSummary.aspx') >= 0) {
                    return;
                }
            }
        }
    }

    if (ModalPage.insideModal()) {
        window.parent.Benner.Page.openEnvironmentSummary();
        return;
    }

    var options = {
        url: Page.getApplicationPath() + 'SiteSettings/EnvironmentInfoSummary.aspx?imp=1',
        size: 'large',
        displayFooter: false,
        displayTitle: false,
        height: 580
    };
    ModalPage.show(options, null, null);
};

// PageRequestManager event handlers.
Page.initializeRequest = function (sender, args) {
};

Page.beginRequest = function (sender, args) {
    if (Page.webTour) {
        Page.webTour.end();
    }

    Page.processing = true;
    Page.processingTimeoutId = setTimeout(
        function () {
            if (Page.processing) {
                ModalMessage.show("Carregando");
                Page.progressShowed = true;
            }
        }, 500);

    try {
        Search.close();
        var ignoreAutoFocusControl = $(args._postBackElement).closest('.ignore-autofocus');
        if (ignoreAutoFocusControl && ignoreAutoFocusControl.length) {
            Control.storeCurrentFocus(null, 'ignore');
        }
        else {
            var portlet = $(args._postBackElement).closest('.portlet');
            Control.storeCurrentFocus(portlet, 'first-child');
        }
    } catch (err) {
        console.error('Erro no Page.beginRequest: ' + err.message);
    }
};

Page.endRequest = function (sender, args) {
    Page.processing = false;
    if (Page.processingTimeoutId && Page.progressShowed) {
        clearTimeout(Page.processingTimeoutId);
        Page.processingTimeoutId = 0;
        ModalMessage.hide();
        Page.progressShowed = false;
    }

    if (args.get_error() != undefined && args.get_error().httpStatusCode == '500') {
        args.set_errorHandled(true);
        var responseData = args.get_response().get_responseData();
        var detalilMessage = responseData.substring(responseData.search("<h2> <i>") + 8, responseData.search("</i> </h2>"));
        var errorMessage = args.get_error().message.replace("Sys.WebForms.PageRequestManagerServerErrorException:", "");
        ModalMessage.alert(errorMessage, detalilMessage);
    }
    App.initAjax();
    Page.initAjax();
    Widget.init();
    Calendar.init();
    Form.init();
    Search.init();
    Control.restoreFocus();
    AsyncProcesses.initAjax();
    HorizontalMenu.fixSubMenuPositions();
    Page.initContextMenu();
    AutoComplete.init();

    if (window.self !== window.top)
        Widget.displayFooterCommandsBar(self.document);
};

//Ao realizar um scroll é verificado se algumas lista de comandos de registro está aberto
//Estando aberto é fechado
Page.closeDropdown = function () {
    var dropdown = $(".group-dropdown-menu.open");
    if (dropdown.length > 0)
        dropdown.removeClass('open');
}

// Relaliza o desbloqueio e bloqueio de widgets
Page.initBlockUI = function () {
    $(".widget-unblock").each(function () {
        App.unblockUI('#' + $(this).attr('data-block-id'));
    });

    $(".widget-block").each(function () {
        var data = $('#' + $(this).attr('data-block-id')).data();

        if ((data) && data["blockUI.isBlocked"] != 1) {
            App.blockUI({
                target: '#' + $(this).attr('data-block-id'),
                animate: true
            });
        }
    });
};

Page.hideAndShowTabs = function () {
    var widgetsList = $('.tab-content .widget-context');
    widgetsList.each(function () {
        var widgetId = $(this).parents('.widget-body').data('widget-id');

        var tab = $(".nav.nav-tabs>li[data-widget-id='" + widgetId + "']>a");
        if ($(this).hasClass('hidden')) {
            //Ambiente de desenvolvimento: concatena 'invisível' junto ao título do widget caso não esteja desta forma
            if ($(this).hasClass('developer')) {
                if (tab.data('original-text'))
                    tab.text(tab.data('original-text') + ' (invisível)');
                else {
                    var originalText = tab.text();
                    tab.attr('data-original-text', originalText);
                    tab.text(originalText + ' (invisível)');
                }
            }
            //Ambiente de Produção: esconde o tab e nav do widget
            else {
                $('.tab-content>#tab' + widgetId).addClass('hidden');
                $(".nav.nav-tabs>li[data-widget-id='" + widgetId + "']").addClass('hidden');
            }
        } else {
            //Se alguma vez o tab já foi invisível, remove o Data
            if (tab.data('original-text')) {
                tab.text(tab.data('original-text'));
                tab.removeData();
            }
            $('.tab-content>#tab' + widgetId).removeClass('hidden');
            $(".nav.nav-tabs>li[data-widget-id='" + widgetId + "']").removeClass('hidden');
        }
    });

    //Se algum active estiver escondido, seta o primeiro tab não escondido e não ativo
    //Tem chamar o evento click pois o widget pode estar minimizado
    if ($('ul.nav.nav-tabs>li.hidden.active').length && $('ul.nav.nav-tabs>li.active').length < 2)
        $('ul.nav-tabs > li:not(".hidden"):first > a').tab('show').click();

    //Se todos os widgets estão escondidos, então esconde todo o portlet
    if ($('ul.nav.nav-tabs>.hidden').length == $('ul.nav.nav-tabs').children().length)
        $('ul.nav.nav-tabs').parent().hide();
    else
        $('ul.nav.nav-tabs').parent().show();
};

Page.hideAndShowWidgets = function () {
    //Por ter a mesma estrutura do template de abas, esse código não deve ser executado em outro template que não seja Widgets um abaixo do outro
    if ($('.portlet.light > .tab-content').length)
        return;

    var widgetsList = $('.widget .widget-context');
    widgetsList.each(function () {

        var idWidget = $(this).parents('.widget').attr('id');
        var titleWidget = $("#" + idWidget + " .caption-subject");

        if ($(this).hasClass('hidden')) {
            //Ambiente de desenvolvimento: concatena 'invisível' junto ao título do widget caso não esteja desta forma
            if ($(this).hasClass('developer')) {

                if (!titleWidget.data('originalText')) {
                    //O data-original-text é utilizado para saber se o widget já tem o span widget invisível
                    var originalText = titleWidget.text();
                    titleWidget.attr('data-original-text', originalText);
                    titleWidget.parent().append('<span class="caption-helper">widget invisível</span>');
                }
            }
            //Ambiente de Produção: esconde o tab e nav do widget
            else
                $(this).parents('.widget').first().hide();
        } else {
            //Se alguma vez o tab já foi invisível, remove o Data e o span criado
            if (titleWidget.data('originalText')) {
                titleWidget.removeData().removeAttr('data-original-text');
                $("#" + idWidget + " .caption-helper").remove();
            }
            $(this).parents('.widget').first().show();
        }
    });
};

/**
 * This is required to fix a bug in MicrosoftAjaxWebForms.js
 * in Firefox where if window.event is not initialized, it loops stack
 * via arguments.callee.caller chain and breaks because of the
 * "use strict" mode
 *
 * Hacking window.event property is required because it is
 * not settable in Internet Explorer
 */
Page.hackEventWithinDoPostBack = function () {
    var originalEventDescriptor = Object.getOwnPropertyDescriptor(Window.prototype, "event");
    var hackEventVariable = false;
    var eventPropertyHolder;
    Object.defineProperty(window, "event", {
        configurable: true,
        get: function get() {
            var result = originalEventDescriptor ? originalEventDescriptor.get.apply(this, arguments) : eventPropertyHolder;
            if (result || !hackEventVariable)
                return result;
            return {};
        },
        set: function set(value) {
            if (originalEventDescriptor)
                originalEventDescriptor.set.apply(this, arguments);
            else
                eventPropertyHolder = value;
        }
    });

    var originalDoPostBack = window.__doPostBack;
    window.__doPostBack = function hackedDoPostBack() {
        hackEventVariable = true;
        originalDoPostBack.apply(this, arguments);
        hackEventVariable = false;
    };
};

Page.initVue = function (initialize) {
    let objectsVue = $(".vue");

    if (initialize) {
        objectsVue.each(function (index, element) {
            new window.Vue({
                el: element
            });
        });
    } else {
        objectsVue.each(function (index, element) {
            let widgetId = $(element).parents(".widget-body").data("widget-id");
            if (!widgetId)
                return;

            let hiddenWidgetWasChanged = document.getElementById(widgetId + "_widgetWasChanged");
            if (!hiddenWidgetWasChanged)
                return;

            let widgetWasChanged = (hiddenWidgetWasChanged.value === "true");

            if (widgetWasChanged) {

                hiddenWidgetWasChanged.value = false;
                new window.Vue({
                    el: element
                });
            }
        });
    }
};

Page.expandCollapsableWidgetControl = function () {
    $('body').on('click', '.portlet > .portlet-title > .caption.collapsible', function (e) {
        e.preventDefault();
        var el = $(this).closest(".portlet").children(".portlet-body");
        var tools = $(this).closest(".portlet-title").children(".tools").children("a");
        $(tools).each(function (index) {
            if (!$(this).hasClass("fullscreen")) {
                if ($(this).hasClass("collapse")) {
                    $(this).removeClass("collapse").addClass("expand");
                    el.slideUp(200);
                } else {
                    $(this).removeClass("expand").addClass("collapse");
                    el.slideDown(200);
                }
            }
        });
    });
};

Page.infoSystem = function () {
    $(document).on('keydown', function (evt) {
        if (evt.ctrlKey && evt.keyCode == 73) { // Ctrl + I
            evt.preventDefault();
            Page.openEnvironmentSummary();
        }
    });

    $(function () {
        $(".environment").hover(function () {
            $(".environment-text").stop().slideDown();
        },
            function () {
                $(".environment-text").stop().slideUp();
            });
    });
};

//Realiza uma pesquisa nos campos para apresentar apenas os necessários
Page.searchFields = function (isFieldPath, inputFieldSearch) {
    //Valor do campo de pesquisa
    var nameField = $("#" + inputFieldSearch).val().toLowerCase();
    //Lista de campos
    var fields = $(".mt-checkbox-list.editor-check-list > .mt-checkbox");

    for (var i = 0; i < fields.length; i += 1) {
        var field = $(fields[i]);
        //Valida se o texto digitado no campo de pesquisa é igual ao do nome do campo
        if (field.text().toLowerCase().indexOf(nameField) === -1) {
            field.addClass("hidden");
        } else {
            field.removeClass("hidden");
        }
    }
};

//Realiza a limpeza do campo de pesquisa e volta a listar todos os campos da visão
Page.clearFieldSearch = function (isFieldPath, inputFieldSearch) {
    //Verifica se possui alguma informação para ser limpa
    if ($("#" + inputFieldSearch).val() != "") {
        //Limpa o campo de pesquisa
        $("#" + inputFieldSearch).val("");
        //Lista de campos
        var fields = $(".mt-checkbox-list.editor-check-list > .mt-checkbox");
        //Transformas campos em visiveis
        fields.removeClass("hidden");
    }
};

Page.selectAllFields = function (checked, nameFieldChecked, nameFieldNotChecked) {
    //Lista de campos
    var fields = $(".mt-checkbox-list.editor-check-list").children(":not(.hidden)").find("input");

    for (var i = 0; i < fields.length; i += 1) {
        var field = $(fields[i]);

        if (field.is(":checked") != checked)
            field.click();
    }

    if (checked) {
        $("#" + nameFieldChecked).addClass("hidden");
        $("#" + nameFieldNotChecked).removeClass("hidden");
    }
    else {
        $("#" + nameFieldChecked).removeClass("hidden");
        $("#" + nameFieldNotChecked).addClass("hidden");
    }

};

Page.isMobile = function () {
    var apple_phone = /iPhone/i,
        apple_ipod = /iPod/i,
        apple_tablet = /iPad/i,
        android_phone = /(?=.*\bAndroid\b)(?=.*\bMobile\b)/i, // Match 'Android' AND 'Mobile'
        android_tablet = /Android/i,
        amazon_phone = /(?=.*\bAndroid\b)(?=.*\bSD4930UR\b)/i,
        amazon_tablet = /(?=.*\bAndroid\b)(?=.*\b(?:KFOT|KFTT|KFJWI|KFJWA|KFSOWI|KFTHWI|KFTHWA|KFAPWI|KFAPWA|KFARWI|KFASWI|KFSAWI|KFSAWA)\b)/i,
        windows_phone = /IEMobile/i,
        windows_tablet = /(?=.*\bWindows\b)(?=.*\bARM\b)/i, // Match 'Windows' AND 'ARM'
        other_blackberry = /BlackBerry/i,
        other_blackberry_10 = /BB10/i,
        other_opera = /Opera Mini/i,
        other_chrome = /(CriOS|Chrome)(?=.*\bMobile\b)/i,
        other_firefox = /(?=.*\bFirefox\b)(?=.*\bMobile\b)/i, // Match 'Firefox' AND 'Mobile'
        seven_inch = new RegExp(
            '(?:' +         // Non-capturing group
            'Nexus 7' +     // Nexus 7
            '|' +           // OR
            'BNTV250' +     // B&N Nook Tablet 7 inch
            '|' +           // OR
            'Kindle Fire' + // Kindle Fire
            '|' +           // OR
            'Silk' +        // Kindle Fire, Silk Accelerated
            '|' +           // OR
            'GT-P1000' +    // Galaxy Tab 7 inch
            ')',            // End non-capturing group
            'i');           // Case-insensitive matching

    var match = function (regex, userAgent) {
        return regex.test(userAgent);
    };

    var IsMobileClass = function (userAgent) {
        var ua = userAgent || navigator.userAgent;
        // Facebook mobile app's integrated browser adds a bunch of strings that
        // match everything. Strip it out if it exists.
        var tmp = ua.split('[FBAN');
        if (typeof tmp[1] !== 'undefined') {
            ua = tmp[0];
        }

        this.apple = {
            phone: match(apple_phone, ua),
            ipod: match(apple_ipod, ua),
            tablet: !match(apple_phone, ua) && match(apple_tablet, ua),
            device: match(apple_phone, ua) || match(apple_ipod, ua) || match(apple_tablet, ua)
        };
        this.amazon = {
            phone: match(amazon_phone, ua),
            tablet: !match(amazon_phone, ua) && match(amazon_tablet, ua),
            device: match(amazon_phone, ua) || match(amazon_tablet, ua)
        };
        this.android = {
            phone: match(amazon_phone, ua) || match(android_phone, ua),
            tablet: !match(amazon_phone, ua) && !match(android_phone, ua) && (match(amazon_tablet, ua) || match(android_tablet, ua)),
            device: match(amazon_phone, ua) || match(amazon_tablet, ua) || match(android_phone, ua) || match(android_tablet, ua)
        };
        this.windows = {
            phone: match(windows_phone, ua),
            tablet: match(windows_tablet, ua),
            device: match(windows_phone, ua) || match(windows_tablet, ua)
        };
        this.other = {
            blackberry: match(other_blackberry, ua),
            blackberry10: match(other_blackberry_10, ua),
            opera: match(other_opera, ua),
            firefox: match(other_firefox, ua),
            chrome: match(other_chrome, ua),
            device: match(other_blackberry, ua) || match(other_blackberry_10, ua) || match(other_opera, ua) || match(other_firefox, ua) || match(other_chrome, ua)
        };
        this.seven_inch = match(seven_inch, ua);
        this.any = this.apple.device || this.android.device || this.windows.device || this.other.device || this.seven_inch;
        // excludes 'other' devices and ipods, targeting touchscreen phones
        this.phone = this.apple.phone || this.android.phone || this.windows.phone;
        // excludes 7 inch devices, classifying as phone or tablet is left to the user
        this.tablet = this.apple.tablet || this.android.tablet || this.windows.tablet;

        if (typeof window === 'undefined') {
            return this;
        }
    };

    var instantiate = function () {
        var IM = new IsMobileClass();
        IM.Class = IsMobileClass;
        return IM;
    };

    if (typeof module != 'undefined' && module.exports && typeof window === 'undefined') {
        //node
        module.exports = IsMobileClass;
    } else if (typeof module != 'undefined' && module.exports && typeof window !== 'undefined') {
        //browserify
        module.exports = instantiate();
    } else if (typeof define === 'function' && define.amd) {
        //AMD
        Page.isMobile = instantiate();
        define('isMobile', [], Page.isMobile);
    } else {
        Page.isMobile = instantiate();
    }

};

Page.initFancybox = function () {
    $(".fancybox").fancybox({ 'type': 'image', margin: [70, 20, 20, 20] });
};

Page.initEasyPieChart = function () {
    $('.easy-pie-chart .number').each(function () {
        $(this).easyPieChart(
            {
                animate: 1e3,
                size: 75,
                lineWidth: 3,
                barColor: $(this).data("color")
            });
    });
};

Page.validSessionExpired = function (iframe) {
    if ($(iframe).contents().find("body").hasClass("login"))
        parent.window.location.href = "~/Login";
};

Page.initContextMenu = function () {

    if ($(".ignore-context-menu").length > 0)
        return;

    $("#ContentPanel").contextmenu({
        'target': '#menu-do-desenvolvedor-context',
        onItem: function (context, e) {
            e.currentTarget.click();
        },
        before: function (e) {
            if (!e.shiftKey && !e.ctrlKey) {
                return $(e.target).parents(".dx-widget").length === 0;
            }
            return false;
        }
    });
};

Page.initWidgetFilterBox = function () {
    jQuery.expr[':'].containsi = function (a, i, m) {
        return jQuery(a).text().removeAccents().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
    };
    $("input[id$='_menuFilter']").first().focus();
    $("input[id$='_menuFilter']").keyup(function () {
        var menuList = $("div[data-widget-id='" + $(this).data("parentWidgetId") + "'] .list-unstyled")
        menuList.find("li a").css("display", "");
        menuList.prev("h3").css("display", "");

        var titles = $("div[data-widget-id='" + $(this).data("parentWidgetId") + "'] h3:not(:containsi('" + this.value.removeAccents() + "'))").next()
        menuList = menuList.filter(titles);

        if (this.value != null && this.value != "")
            menuList.find("li a:not(:containsi('" + this.value.removeAccents() + "'))[href]").css("display", "none");

        for (var i = 0; i < menuList.length; i++) {
            if ($(menuList[i]).find("li a:visible[href]").length == 0) {
                $(menuList[i]).prev("h3").css("display", "none");
                $(menuList[i]).prev("a:not([href])").css("display", "none");
            }
        }

    });
};

//Ao realizar o ping está sendo garantido qua sessão não irá expirar
Page.ping = function (timePing, timeout) {
    var endTime = new Date();
    endTime.setMinutes(endTime.getMinutes() + timePing);
    //Realiza o request até o tempo final
    Page.requestPing(endTime, timeout);
};

Page.requestPing = function (endTime, timeout) {
    var currentTime = new Date();
    //Valida se não ultrapassou o tempo limite
    if ((endTime - currentTime) > 0) {
        //Request é realizado para uma página padrão
        $.ajax({
            cache: false,
            type: "GET",
            url: Page.getApplicationPath() + "Ping"
        }).done(function (data) {
            setTimeout(function () {
                Page.requestPing(endTime, timeout);
            }, timeout);
        });
    }
};

Page.initHotkeys = function () {
    $(document).keydown(function (e) {
        if (e.ctrlKey && e.keyCode == 13 ||/*Ctrl+Enter: Salvar*/
            e.ctrlKey && e.keyCode == 45 ||/*Ctrl+Insert: Novo*/
            e.ctrlKey && e.keyCode == 32 ||/*Ctrl+Espaço: Searcher*/
            e.keyCode == 27/*Esc: Cancelar*/
            /*h: Adiciona a data de hoje para o componente de data (a implementação do mesmo está no Date.js*/
        ) {

            if (e.keyCode == 27 && $('body').hasClass('modal-page')) {
                return;
            }

            let select2Focused = Search.getFocusedSelect2();
            if (select2Focused && e.keyCode === 27)
                return;

            var field = $(":focus");

            var focusedWidget = field.parents(".widget");

            var button = {};

            if (field.parents(".note-editor").size() > 0)
                return;

            switch (e.keyCode) {
                case 13:
                    {
                        button.context = "widget";
                        if (e.shiftKey)
                            button.path = ".btn-savenew";
                        else
                            button.path = ".btn-save";
                        break;
                    }
                case 27:
                    button.path = ".btn-cancel";
                    button.context = "widget";
                    break;
                case 45:
                    button.path = ".btn-new";
                    button.context = "widget";
                    break;
                case 32:
                    button.path = "#searcher";
                    button.context = "global";
                    break;
            }
            $(button.path).first().focus();

            if (button.context == "global") {
                $(button.path).first().click();
                return;
            }

            if (focusedWidget != null && focusedWidget.length > 0)
                $(focusedWidget).find(button.path).first().click();
            else if ($(button.path).parents(".widget").size() == 1)
                $(button.path).first().click();
        }
    });

};

Page.changeSelectedTab = function (tabItem) {
    var widgetId = $(tabItem).data("widget-id");
    var widgetClientId = $("#" + widgetId).parent().attr("id");

    if (Widget.isOpeningTheWebpart(widgetClientId)) {
        Widget.changeServerChromeState(widgetClientId);
    }
};

Page.GridNavigation = function (key) {
    var current = $("tr.active");
    if (current.size() == 0)
        var target = $("#FixedWebPartZoneMain [widget-type='SimpleGrid'] tr")[1];
    else {
        var target = "";
        if (key == 38)
            target = current.prev();
        else if (key == 40)
            target = current.next();
    }
    if (target.size == 0)
        return;

    $(target).find("td[onclick]").first().click();
    $(window).scrollTop(target.position());
};

Page.handleDropdownHover = function () {
    $('.btn.dropdown-toggle').not('.hover-initialized').not('.dropdown-click,.note-btn').each(function () {
        $(this).dropdownHover();
        $(this).addClass('hover-initialized');
    });
};

Page.helpDocumentation = function () {
    var search = $(".widget .portlet-title .caption > span").first().text();
    if (search === "")
        search = document.title;

    $.ajax({
        url: Page.getApplicationPath() + "api/helpdocumentation",
        data: { search: search },
        dataType: "json",
        async: false,
        success: function (data) {
            window.open(data);
        },
        error: function (data) {
            alert("Falha ao ser redirecionado para a documentação.");
        }
    });
};

Page.addWebTourSteps = function (steps) {

    if (Page.webTourSteps === null)
        Page.webTourSteps = [];

    Page.webTourSteps = Page.webTourSteps.concat(steps);
};

Page.initWebTour = function (forceStart) {

    if (Page.webTourSteps == null)
        return;

    $('#help-documentation-dropdown').removeClass('hidden');
    $('#help-documentation-icon').show();

    Page.initEventsWebTour(Page.webTourSteps);

    var webTour = new WebTour();

    webTour
        .addSteps(Page.webTourSteps)
        .start(forceStart);

    Page.webTour = webTour;
};

Page.initWidgets = function () {
    Page.widgets = [];
    Form.widgets = [];
    Grid.widgets = [];

    _.forEach(Widget.getWidgets(window.document), (p, k) => {
        var widgetType = p.el().getAttribute("widget-type");
        if (widgetType === "AjaxForm") {
            let widget = Form.extend(p);
            Page.widgets.push(widget);
            Form.widgets.push(widget);
            Form[widget.id] = widget;
        }
        else if (widgetType === "SimpleGrid") {
            let widget = Grid.extend(p);
            Page.widgets.push(widget);
            Grid.widgets.push(widget);
            Grid[widget.id] = widget;
        }
        else
            Page.widgets.push(p);

        Page[p.id] = p;
    });
};

Page.initEventsWebTour = function (steps) {
    var index = 1;
    steps.forEach(function (step) {

        if (steps.length !== index) {
            step.onNext = function (tour) {
                WebTour.nextSteps(tour);
            };
        }

        step.onShow = function (tour) {
            WebTour.displayCommandContainer(tour);
        };

        step.onHide = function (tour) {
            WebTour.hideCommandContainer(tour);
        };

        step.onPrev = function (tour) {
            WebTour.prevSteps(tour);
        };

        index++;
    });
};

Page.getApplicationPath = function () {
    return $('#Wes2008ApplicationPath').val();
};

Page.getQueryParameter = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
};

function summernoteInitialize() {
    var itensToolbars = [['style', ['style']],
    ['font', ['bold', 'italic', 'underline', 'superscript', 'subscript', 'strikethrough', 'clear']],
    ['fontname', ['fontname']],
    ['color', ['color']],
    ['para', ['ul', 'ol', 'paragraph']],
    ['height', ['height']],
    ['table', ['table']],
    ['insert', ['link', 'picture', 'codeview', 'hr']],
    ['view', ['fullscreen']],
    ['help', ['help']]];
    //Inicializa o componente
    $(".html-control").summernote({
        height: 160,
        lang: 'pt-BR',
        toolbar: itensToolbars,
        disableDragAndDrop: true,
        callbacks: {
            onBlur: function () {
                //Verifica que foi alterado a informação antes disparar o script python
                var $hidden = $("#" + this.id + "_HIDDEN");
                var $summerNote = $(this).html().trim();
                if ($summerNote != $hidden.val())
                    $(this).change();
            },
            onChange: function (contents) {
                //Adiciona o valor digitado no editor de html no campo hidden
                var $hidden = $("#" + this.id + "_HIDDEN");
                if ($hidden != null) {
                    $hidden.val(contents.trim());
                }
            }
        }
    });
}

function fixedGridRecordCommand() {
    $(document).on('show.bs.dropdown', '.dropdown-toggle.dropdown-command-record[data-hover="dropdown"]', function () {
        var offset = $(this).offset();
        offset.top += $(this).outerHeight();
        var dropdownMenu = $(this).next();
        // Tamanho do menu na nova posição
        var dropdownMenuHeight = offset.top + dropdownMenu.height();
        // Tamanho do documento
        var currentDocumentHeight = $(document).height();
        if (currentDocumentHeight < dropdownMenuHeight) {
            $(this).parent().addClass("drop-up");
            //Acerta a posição para ficar acima do componente
            dropdownMenuHeight = dropdownMenu.outerHeight();
            offset.top -= (dropdownMenuHeight + $(this).outerHeight() + 5);
        }
        dropdownMenu.css("position", "fixed");
        dropdownMenu.offset({ left: offset.left, top: offset.top + 3 });
    });
    // Ao clicar sobre uma lista de comandos de registro
    // Adiciona a position fixed e seta a posição do mesmo
    // Para não ficar sendo escondido pelo grid
    $(document).on('click.bs.dropdown.data-api', ".dropdown-toggle.dropdown-command-record", function () {
        var $this = $(this), $parent = $this.parent();
        var offset = $this.offset();
        offset.top += $this.outerHeight();
        var dropdownMenu = $parent.find(".dropdown-menu.dropdown-menu-command-record");
        // Tamanho do menu na nova posição
        var dropdownMenuHeight = offset.top + dropdownMenu.height();
        // Tamanho do documento
        var currentDocumentHeight = $(document).height();
        if (currentDocumentHeight < dropdownMenuHeight) {
            $(this).parent().addClass("drop-up");
            //Acerta a posição para ficar acima do componente
            dropdownMenuHeight = dropdownMenu.outerHeight();
            offset.top -= (dropdownMenuHeight + $(this).outerHeight() + 5);
        }
        dropdownMenu = dropdownMenu.first();
        $(dropdownMenu).css("position", "fixed");
        $(dropdownMenu).offset({ left: offset.left, top: offset.top + 3 });
    });
}

Page.initApplication = function () {
    // Hook up Application event handlers.
    Sys.Application.add_load((sender, args) => {
        if (!args.get_isPartialLoad()) {
            //  add our handler to the document's
            //  keydown event
            $(document).keydown(function (event) {
                var cancelKeyPress = Page.preventPostbackOnEnterKeyDown(event);
                if (!cancelKeyPress)
                    Page.keyDown(event);
            });
        }
    });

    Sys.Application.add_init((sender) => {
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (!prm.get_isInAsyncPostBack()) {
            prm.add_pageLoading(Page.loading);
            prm.add_pageLoaded(Page.loaded);
            prm.add_initializeRequest(Page.initializeRequest);
            prm.add_beginRequest(Page.beginRequest);
            prm.add_endRequest(Page.endRequest);
        }
    });
};

Page.initEnvironmentVariables = function () {
    Page.userName = $('#username').val();
    Page.userEmail = $('#useremail').val();
    Page.userFullName = $('#userFullName').val();
    Page.wesVersion = $('#WesVersion').val().substr(0, 2) + "." + $('#WesVersion').val().substr(2, 1);
    Page.systemVersion = $('#systemVersion').val();
    Page.client = $('#client').val();
    Page.systemName = $('#product').val();
    Page.isModalPage = $('#isModalPage').val().toLowerCase() === "true";
    Page.isBennerEnvironment = $('#isBennerEnvironment').val().toLowerCase() === "true";
    Page.activeRole = $('#activeRole').val();
    Page.isProduction = $('#isProduction').val().toLowerCase() === "true";
    Page.canShowNPS = $('#canShowNPS').val().toLowerCase() === "true";
    Page.developmentEnvironment = $('#development-environment').val();
    Page.useGoogleAnalytics = $('#useGoogleAnalytics').val();
}

Page.initAjax = function () {
    Page.initBlockUI();
    Page.initEasyPieChart();
    Page.hideAndShowTabs();
    Page.hideAndShowWidgets();
    Page.initEnvironmentVariables();
    SourceEditor.init();
    Page.initWidgets();

    $(".form-actions a:not(.btn-del)").click(function () {
        //não permitir pressionar mais de uma vez os comandos
        var command = $(this).attr("href");
        $(this).removeAttr("href");
        eval(command);
    });

    // Ao passar o mouse sobre sobre uma lista de comandos de registro
    // Adiciona a position fixed e seta a posição do mesmo
    // Para não ficar sendo escondido pelo grid
    fixedGridRecordCommand();

    $(".table-responsive.table-scrollable").scroll(Page.closeDropdown);
    $(window).scroll(Page.closeDropdown);

    //Itens que serão habilitados
    summernoteInitialize();

    $('body').on('click', function (e) {
        $('[data-toggle="popover"]').each(function () {
            //the 'is' for buttons that trigger popups
            //the 'has' for icons within a button that triggers a popup
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                $(this).popover('hide');
            }
        });
    });

    Page.handleDropdownHover();
    Page.initVue(false);
    for (let func of Page.initFunctions) func();
};


Page.initFunctions = [];

Page.init = function (initFunction) {
    if (initFunction) {
        Page.initFunctions.push(initFunction);
        return;
    }

    Page.hackEventWithinDoPostBack();
    Page.initAjax();
    App.setAssetsPath(Page.getApplicationPath() ? Page.getApplicationPath() + 'content/assets/' : '../../assets/');
    HorizontalMenu.init(window);
    Page.isMobile();
    Calendar.init();
    Form.init();
    Search.init();
    AsyncProcesses.init();
    Control.restoreFocus();
    Sidebar.init();
    Widget.init();
    Page.initFancybox();
    Page.initContextMenu();
    Page.initWidgetFilterBox();
    Page.initHotkeys();
    Development.init();
    AutoComplete.init();
    ChatBot.init();
    Searcher.init();
    Page.expandCollapsableWidgetControl();
    Page.infoSystem();
    Page.initVue(true);

    if (Page.useGoogleAnalytics == "True") {
        GoogleAnalytics.init();
    }
};

export default Page;

