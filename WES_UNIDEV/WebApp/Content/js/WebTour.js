import HorizontalMenu from './HorizontalMenu';

var WebTour = function () {
    var _tour;
    var _tourConfig = {
        name: document.location.pathname.replaceAll('/', '').replaceAll('.', ''),
        keyboard: true,
        storage: false
    };

    this.end = function () {
        if (_tour) {
            _tour.end();
            _tour = null;
        }
    };

    this.reset = function () {
        WebTour.currentSteps = -1;
    };

    this.addSteps = function (steps) {
        _tourConfig.steps = steps;
        return this;
    };

    this.start = function (forceStart) {

        if (forceStart == null || forceStart == false) {
            var webTourValue = localStorage.getItem(WebTour.getStorageKey());

            if (webTourValue) {

                var stepsHash = JSON.stringify(_tourConfig.steps).hashCode();

                if (stepsHash == webTourValue)
                    return;
            }

            _tourConfig.onEnd = function (tour) {
                var stepsHash = JSON.stringify(_tourConfig.steps).hashCode();
                localStorage.setItem(WebTour.getStorageKey(), stepsHash);
                WebTour.currentSteps = -1;
            };
        }
        else
            _tourConfig.onEnd = this.reset;

        if (WebTour.currentSteps >= 0)
            return;

        WebTour.currentSteps = 0;

        _tourConfig.template = this.getWebTourTemplate();
        _tourConfig.onHide = this.reset;

        _tour = new Tour(_tourConfig);
        _tour.init();
        _tour.start();
    };
};

WebTour.prototype.getWebTourTemplate = function () {
    var template = '<div class="popover tour">' +
        '<div class="arrow"></div>' +
        '<h3 class="popover-title"></h3>' +
        '<div class="popover-content"></div>' +
        '<div class="popover-navigation">' +
        '<div class="btn-group">' +
        '<button class="btn default" data-role="prev">Voltar</button>' +
        '<button class="btn blue" data-role="next">Avançar</button>' +
        '</div>' +
        '<button class="btn default" data-role="end">Finalizar</button>' +
        '</div>' +
        '</div>';

    return template;
};

WebTour.getStorageKey = function () {
    return 'webtour' + ($('#username').val() + document.location.pathname).hashCode();
};

WebTour.currentSteps = -1;

WebTour.displayCommandContainer = function (tour) {
    let currentCommand = tour._options.steps[WebTour.currentSteps].element;
    if ($(currentCommand).hasClass('command-action'))
        return;
    //Habilitando comandos no agrupador 'Mais'
    WebTour.displayGroupMore(currentCommand, 'block');
    //Habilitar agrupadores
    WebTour.displayGroupCommand(currentCommand, 'block');
};

WebTour.hideCommandContainer = function (tour) {
    let currentCommand = tour._options.steps[WebTour.currentSteps].element;
    if ($(currentCommand).hasClass("command-action"))
        return;
    //Desabilitar comandos no agrupador 'Mais'
    WebTour.displayGroupMore(currentCommand, '');
    //Desabilitar agrupadores
    WebTour.displayGroupCommand(currentCommand, '');
};

WebTour.nextSteps = function (tour) {
    WebTour.currentSteps++;
};

WebTour.prevSteps = function (tour) {
    WebTour.currentSteps--;
};

WebTour.getCommandSelector = function (commandId) {

    if (document.querySelector('.more-menu-item').style.display !== "none") {
        var nestedCommand = document.querySelector('.more-menu-item #nested-' + commandId);
        if (nestedCommand !== null && nestedCommand.style.display !== 'none')
            return '#nested-' + commandId;
    }

    var command = document.querySelector('.commands-bar #top-' + commandId);
    if (command !== null && command.style.display !== 'none')
        return '#top-' + commandId;

    var gridRowCommand = document.querySelector('#' + commandId + '_record');
    if (gridRowCommand !== null)
        return gridRowCommand;

    var gridRowGroupedCommand = document.querySelector('.dropdown-menu-command-record #' + commandId);
    if (gridRowGroupedCommand !== null)
        return gridRowGroupedCommand;
};

WebTour.displayGroupCommand = function (command, valueDisplay) {
    let groupCommands = $(command).parents('.dropdown-menu');
    if (groupCommands.length > 0) {
        for (let i = groupCommands.length - 1; i >= 0; i--) {

            let currentGroupCommand = groupCommands[i];
            if ($(currentGroupCommand).parent().hasClass('dropdown-submenu')) {
                HorizontalMenu.positionSubMenu($(currentGroupCommand).parent());
            }
            $(currentGroupCommand).css('display', valueDisplay);
        }
    }
};

WebTour.displayGroupMore = function (command, valueDisplay) {

    let $currentGroupMore = $(command).parents('.more-menu-item');
    if ($currentGroupMore.length > 0) {
        $currentGroupMore.children('ul').css('display', valueDisplay);
    }
};

export default WebTour;