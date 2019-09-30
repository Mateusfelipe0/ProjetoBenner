import ModalPage from './ModalPage';
import AsyncProcesses from './AsyncProcesses';

var Widget = function (element, rootDocument) {
    var _rootDocument = rootDocument;
    var _element = element;
    this.id = $(element).attr('id');
    this.name = this.id;
    this.widgetType = element.getAttribute("widget-type");
    this.uniqueid = element.getAttribute("widget-uniqueid");
    this.providerId = element.getAttribute("provider-widget-uniqueid");
    let jsProperties = element.getAttribute("widget-jsproperties");

    if (jsProperties) {
        Object.extend(this, JSON.parse(jsProperties));
    }
        
    this.addCommandsBarOn = function () {
        var commandsBar = $(_rootDocument).find('#' + this.id).find('.form-actions.bottom.nobg.no-border.commands-bar.fluid.footer-commands-bar');
        if (commandsBar.length > 0) {

            $(_rootDocument).find('#' + this.id).find('.command-action').each(function (j, action) {
                var $newCommand = $(action).clone(true);
                $(commandsBar).append($newCommand).append(' ');

                if ($newCommand.hasClass("btn-group")) {
                    Widget.adjustGroupCommandFooter($newCommand, commandsBar);
                    //Após copiar o comando agrupador e necessario iniciar o componente
                    $newCommand.children('a').dropdownHover();
                }
            });
        }
    };

    this.el = function () {
        return _element;
    };

    this.getId = function () {
        return this.id;
    };

    this.command = function (commandName) {
        __doPostBack(this.uniqueid, commandName);
    };

    this.refresh = function () {
        __doPostBack(this.uniqueid, 'refresh');
    };

    this.isShorterThenWindow = function () {
        var windowHeight = 0;

        if (window.self === window.top)
            windowHeight = document.documentElement.clientHeight - 46;
        else
            windowHeight = (document.documentElement.clientHeight * 0.9);// - 120;

        return $(_rootDocument).find('#' + this.id).find('.portlet-body').height() < windowHeight;
    };
    
    this.hasFooterCommandsBar = function () {
        return $(_rootDocument).find('#' + this.id).find('.footer-commands-bar').length > 0 && $(_rootDocument).find('#' + this.id).find('.footer-commands-bar').children().length > 0;
    };

    this.hideFooterCommandsBar = function () {
        if (!$(_rootDocument).find('#' + this.id).find('.footer-commands-bar').is('.footer-commands-bar.commands-bar-hide'))
            $(_rootDocument).find('#' + this.id).find('.footer-commands-bar').addClass('hide');
    };

    this.createFooterCommandsBar = function () {
        return this.addCommandsBarOn();
    };

    this.footerCommandsBarIsHidden = function () {
        return $(_rootDocument).find('#' + this.id).find('.footer-commands-bar').hasClass('hide');
    };

    this.displayFooterCommandsBar = function () {
        $(_rootDocument).find('#' + this.id).find('.footer-commands-bar').removeClass('hide');
    };

    this.getBlockId = function () {
        if ($(this.el()).find(".portlet").length)
            return '#' + this.id + ' .portlet';
        else
            return '#' + this.id + ' .widget-body';
    };

    this.block = function () {
        App.blockUI({
            target: this.getBlockId(),
            animate: true
        });
    };

    this.unblock = function () {
        App.unblockUI(this.getBlockId());
    };
};

Widget.adjustCommandsBar = function (commandsBar, fadeIn) {
    // descobrir a area útil
    var usefulWidth = Widget.calulateUsefulWidth(commandsBar);
    var commandButtonList = commandsBar.find('.custom-action');
    var hideNestedMenu = true;

    // para cada comando, da visão
    for (var i = 0; i < commandButtonList.length; i++) {

        // descobrir a largura
        var commandButton = $(commandButtonList[i]);
        var commandWidth = commandButton.outerWidth(true);

        // se área útil for maior ou igual que o comando
        if (usefulWidth >= commandWidth || commandWidth == 0) {
            let topMenuId = commandButton.attr('id');
            let nestedMenuId = Widget.getNestedButtonId(topMenuId);

            commandsBar.find('#' + nestedMenuId).hide();
            if (fadeIn)
                commandsBar.find('#' + topMenuId).fadeIn("slow");
            else
                commandsBar.find('#' + topMenuId).show();
        }
        // se área útil for menor que o comando
        else if (usefulWidth < commandWidth) {
            let topMenuId = commandButton.attr('id');
            let nestedMenuId = Widget.getNestedButtonId(topMenuId);

            commandsBar.find('#' + topMenuId).first().hide();

            var $commandsGroup = commandsBar.find('#' + nestedMenuId);
            Widget.adjustCommandsGroup($commandsGroup);
            $commandsGroup.show();

            hideNestedMenu = false;
        }
        usefulWidth -= commandWidth;
    }

    // esconder o botão sanduíche
    if (hideNestedMenu)
        commandsBar.find('.nested-menu').hide();
    else {
        let $nestedMenu = commandsBar.find('.nested-menu');
        if (fadeIn)
            $nestedMenu.fadeIn("slow");
        else
            $nestedMenu.show();
        
        let $nestedMenuDropdown = $nestedMenu.children(".dropdown-menu.hold-on-click");
        let $widgetDropdown = $nestedMenu.offset().left + $nestedMenuDropdown.outerWidth(true);
        if ($widgetDropdown > $(window).width()) {
            $nestedMenuDropdown.addClass("pull-right");
        }
    }
};

Widget.getNestedButtonId = function (topButtonId) {
    if (topButtonId.indexOf('top-') >= 0) {
        return topButtonId.replace('top-', 'nested-');
    } else if (topButtonId.indexOf('top') === 0) {
        return 'nested' + topButtonId.substring(3);
    } else {
        return null;
    }
};

Widget.calulateUsefulWidth = function (commandsBar) {

    var predefinedButtons = commandsBar.find('.predef-action');

    // iniciando com uma margem de 3px por botão
    var predefWidth = predefinedButtons.length * 4;

    // somando ainda a area de cada um dos predefinidos
    for (var i = 0; i < predefinedButtons.length; i++) {
        predefWidth += $(predefinedButtons[i]).outerWidth(true);
    }

    // descobrir a área útil
    var usefulWidth = commandsBar.width() - 30; /*margem de segurança*/
    usefulWidth -= predefWidth;
    usefulWidth -= commandsBar.find('.nested-menu').outerWidth(true) + 4;

    return usefulWidth;
};

Widget.adjustGroupCommandFooter = function ($groupCommand, $commandsBar) {
    var heightComponent = $groupCommand.children("ul").height() + ($commandsBar.offset().top + 34 + 10);
    if (Math.round(heightComponent) >= $(document).height()) {
        $groupCommand.addClass("dropup");
    } else {
        $groupCommand.removeClass("dropup");
    }
};

Widget.getWidgets = function (rootDocument) {
    var widgets = [];

    $(rootDocument).find('.widget').each(function (i, obj) {
        widgets.push(new Widget(obj, rootDocument));
    });

    return widgets;
};


Widget.adjustGroupCommandsFooter = function () {
    var groupCommands = $(".btn-group.command-action");
    for (var i = 0; i < groupCommands.length; i++) {
        var $groupCommand = $(groupCommands[i]);

        var heightComponent = $groupCommand.children("ul").height() + ($groupCommand.offset().top + 34 + 10);
        if (heightComponent >= $(document).height()) {
            $groupCommand.addClass("dropup");
        } else {
            $groupCommand.removeClass("dropup");
        }
    }
};


Widget.adjustCommandsBarForAllWidgets = function (fadeIn) {

    // descobrir todos CommandBars da página
    var commandsBarList = $('.form-actions');

    // disparar o ajuste para cada um
    for (var i = 0; i < commandsBarList.length; i++) {
        var commandsBar = $(commandsBarList[i]);

        // disparar apenas se a diferença com tela anterior for maior que 15px
        var lastWidth = commandsBar.data("lastWidth");
        if (!lastWidth)
            lastWidth = 0;
        var delta = lastWidth - commandsBar.width();

        if (delta < -15 || delta > 15 || lastWidth == 0) {
            Widget.adjustCommandsBar(commandsBar, fadeIn);

            commandsBar.data("lastWidth", commandsBar.width());
        }
    }
};

Widget.displayFooterCommandsBar = function (rootDocument) {
    Widget.createFooterCommandsBar(rootDocument);
};


Widget.createFooterCommandsBar = function (rootDocument) {

    var widgets = Widget.getWidgets(rootDocument);

    for (var i = 0; i < widgets.length; i++) {

        var widget = widgets[i];

        if (widget.isShorterThenWindow()) {
            widget.hideFooterCommandsBar();
            continue;
        }
        else if (widget.hasFooterCommandsBar()) {
            widget.displayFooterCommandsBar();
            continue;
        }

        widget.createFooterCommandsBar();
    }
};

Widget.changeServerChromeState = function (widgetId) {
    if (!Widget.isOpeningTheWebpart(widgetId)) {
        $('#' + widgetId + " .widget").addClass("minimized");
    } else {
        $('#' + widgetId + " .widget").removeClass("minimized");
    }

    var chromeStateButton = document.getElementById(widgetId + '_ChromeStateChangeButton');
    if (chromeStateButton)
        chromeStateButton.click();
};

Widget.isOpeningTheWebpart = function (widgetId) {
    return $('#' + widgetId + " .widget").hasClass("minimized");
};

Widget.resizeWidget = function (frameId) {
    var frame = $('#' + frameId);

    if (!frame)
        return;

    if ($(frame).hasClass("widget-block")) {
        $(frame).toggleClass('widget-block widget-unblock');
        App.unblockUI('#' + $(frame).attr('data-block-id'));
    }

    var realHeight = $(frame).contents().height();
    $(frame).height(realHeight + 20);
};


Widget.openModal = function () {
    $("iframe").contents().keydown(function (e) {
        if (e.keyCode == 27) { // esc

            //ignorar esc em campo lookup e busca modal de lookup
            if ($(e.target).hasClass("select2-search__field")) {
                e.stopPropagation();
                return;
            }

            ModalPage.hide();
        }
    });
};

Widget.prepareModal = function (modalUrl, lazyPostId, sizeModal) {
    $('body').data('lazy-post-id', lazyPostId);

    //Antes de abrir o modal valida se tem alterações não salvas
    if ($('#float-action-buttons').length > 0) {
        if (!confirm("Você possui alterações visuais que ainda não foram persistidas. Deseja sair da página e perder essas alterações?")) {
            return false;
        }
    }

    if (sizeModal == undefined || sizeModal == '')
        sizeModal = "large";

    ModalPage.show(
        {
            id: 'ModalCommand',
            url: modalUrl,
            size: sizeModal.toLowerCase(),
            displayFooter: false,
            displayTitle: false,
            // ocupar 90% da altura, menos a altura do footer do modal
            height: parseInt($(window).height() * 0.9) - 70
        }, Widget.openModal, Widget.disposeModal);
    //Limpa variavel para não realizar ser apresentada a confirmação de alterações não salvas.
    window.onbeforeunload = null;
};

Widget.disposeModal = function () {

    ModalPage.hide();

    var controlId = $('body').data('lazy-post-id');
    $('body').data('lazy-post-id', '');

    //Faz um refresh no widget que disparou o modal
    if (controlId != undefined && controlId != '')
        __doPostBack(controlId, 'refresh');
    else //quando não tem widget para atualizar faz uma verifica se foi disparado algum processo async
        AsyncProcesses.initAjax();

    return false;
};

Widget.adjustCommandsGroup = function ($commandsGroup) {

    if ($commandsGroup.hasClass("dropdown-submenu")) {
        let $commands = $commandsGroup.children("ul").children();
        $commands.each(function () {

            this.id = this.firstChild.id.replace('top-', 'nested-');
            Widget.adjustCommandsGroup($(this));
        });
    }
};

Widget.init = function () {
    // atualização inicial
    Widget.createFooterCommandsBar(self.document);
    Widget.adjustCommandsBarForAllWidgets(false);
    Widget.adjustGroupCommandsFooter();

    // assinando o resize para atualizar qdo a tela mudar de tamanho
    $(window).resize(function () {
        Widget.adjustCommandsBarForAllWidgets(false);
    });

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        Widget.createFooterCommandsBar(self.document);
        Widget.adjustCommandsBarForAllWidgets(false);
    });
};

export default Widget;