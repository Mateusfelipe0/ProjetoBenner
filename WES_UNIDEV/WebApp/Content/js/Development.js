import AmChartsWidget from './AmChartsWidget';
import Page from './Page';
import ModalPage from './ModalPage';
import ModalMessage from './ModalMessage';

var Development = function () {

    var currentSize = 0;
    var gridColumns = [];

    var currentWidget;
    var startX, startY, startWidth, startHeight, lastWidth;

    function discoverCurrentSize(element) {
        for (var i = 12; i > 0; i--) {
            if ($(element).hasClass('col-md-' + i))
                return i;
        }
    }

    function discoverCurrentHeight(element) {
        if (element.getAttribute('widget-type') == 'AmCharts') {
            var chart = element.querySelector('.chart');
            if (chart == null)
                return 0;
            return parseInt(chart.style.height, 10);
        }

        return parseInt(document.defaultView.getComputedStyle(element).height, 10);
    }

    function discoverGridColumnsSize(row) {
        gridColumns = [];
        for (var i = 0; i < 12; i++) {
            var column = i + 1;
            var columnSize = (column / 12) * $(row).width();
            gridColumns[i] = Math.round(columnSize);
        }
    }

    function resizeWidgetWidth(e) {
        var nextWidth = (startWidth + e.clientX - startX);
        if (nextWidth < lastWidth) {
            if (currentSize == 1)
                return;

            var nextSize = gridColumns[currentSize - 1];
            if (nextWidth <= nextSize) {
                currentSize = currentSize - 1;
                lastWidth = nextWidth;
                $(currentWidget).find('.current-column').text('col-md-' + currentSize);
            }
        } else {
            var nextSize = gridColumns[currentSize - 1];
            if (nextWidth >= nextSize) {
                if (currentSize < 12) {
                    currentSize = currentSize + 1;
                    lastWidth = nextWidth;
                    $(currentWidget).find('.current-column').text('col-md-' + currentSize);
                }
            }
        }
        currentWidget.style.width = (startWidth + e.clientX - startX) + 'px';
    }

    function resizeWidgetHeight(e) {
        var designWidget = null;
        if ($(currentWidget).attr("widget-type") === "AmCharts")
            designWidget = $(currentWidget).find('.chart')[0];
        else
            designWidget = $(currentWidget).find('.dx-widget.dx-visibility-change-handler')[0];

        var heightDiff = parseInt(document.defaultView.getComputedStyle(currentWidget).height, 10) - parseInt(document.defaultView.getComputedStyle(designWidget).height, 10);

        designWidget.style.height = (startHeight + (e.clientY - heightDiff) - startY) + 'px';
        $(currentWidget).find('.current-height').text(designWidget.style.height);
    }

    function stopResizeWidth(e) {
        document.documentElement.removeEventListener('mousemove', resizeWidgetWidth, false);
        document.documentElement.removeEventListener('mouseup', stopResizeWidth, false);

        var current = discoverCurrentSize(currentWidget);
        $(currentWidget).removeClass('col-md-' + current);
        $(currentWidget).addClass('col-md-' + currentSize).css('width', '');
        initFloatActionButtons();
    }

    function stopResizeHeight(e) {
        document.documentElement.removeEventListener('mousemove', resizeWidgetHeight, false);
        document.documentElement.removeEventListener('mouseup', stopResizeHeight, false);
        initFloatActionButtons();
    }

    var handleWidgetResize = function (widget) {
        $(widget).find('.resize-width-container').hover(function () {
            var currentWidgetSize = discoverCurrentSize(widget);
            $(this).find('.current-column').text('col-md-' + currentWidgetSize);
            $(this).find('.current-column').show();
        }, function () {
            $(this).find('.current-column').hide();
        });

        $(widget).find('.resize-height-container').hover(function () {
            var designWidget = null;
            if ($(widget).attr('widget-type') === 'AmCharts')
                designWidget = $(widget).find('.chart')[0];
            else
                designWidget = $(widget).find('.dx-widget.dx-visibility-change-handler')[0];
            $(widget).find('.current-height').text(designWidget.style.height);
            $(this).find('.current-height').show();
        }, function () {
            $(this).find('.current-height').hide();
        });

        $(widget).hover(function () {
            $(this).find('.resize-width-handle').show();
            $(this).find('.resize-height-handle').show();
        },
            function () {
                $(this).find('.resize-width-handle').hide();
                $(this).find('.resize-height-handle').hide();
            });

        $(widget).find('.resize-width-handle').on('mousedown', function (e) {
            currentWidget = widget;            
            currentSize = discoverCurrentSize(currentWidget);
            discoverGridColumnsSize($(currentWidget).closest('.row')[0]);
            startX = e.clientX;
            startWidth = lastWidth = parseInt(document.defaultView.getComputedStyle(currentWidget).width, 10);
            document.documentElement.addEventListener('mousemove', resizeWidgetWidth, false);
            document.documentElement.addEventListener('mouseup', stopResizeWidth, false);
        });

        $(widget).find('.resize-height-handle').on('mousedown', function (e) {
            currentWidget = widget;
            startY = e.clientY;
            startHeight = parseInt(document.defaultView.getComputedStyle(currentWidget).height, 10);
            document.documentElement.addEventListener('mousemove', resizeWidgetHeight, false);
            document.documentElement.addEventListener('mouseup', stopResizeHeight, false);
        });
    }

    var initWidgetResize = function () {
        var widgets = document.querySelectorAll('.widget');

        for (var i = 0; i < widgets.length; i++) {
            handleWidgetResize(widgets[i]);
        }
    };

    function getSerieIcon(graph) {
        if (graph.type == 'line' && graph.fillAlphas == 0)
            return 'fa-line-chart';
        else if (graph.type == 'line' && graph.fillAlphas > 0)
            return 'fa-area-chart';

        return 'fa-bar-chart';
    }

    function handleChart(widget) {
        var definition = AmChartsWidget.getChart(widget.id);

        if (definition != null) {

            if (definition && (definition.type !== "serial" && definition.type !== 'radar')) {
                $(widget).find('.chart-definition').remove();
                return;
            }

            var itens = '';

            for (var i = 0; i < definition.graphs.length; i++) {
                var graph = definition.graphs[i];

                if (widget.querySelector('#' + graph.id) == null) {
                    var title = '';

                    if (definition.type == 'serial')
                        title = graph.title;
                    else if (definition.type == 'radar')
                        title = graph.valueField;

                    itens += '<li id="' + graph.id + '"><a class="chart-serie" chart-type="' + definition.type + '" rotate="' + definition.rotate + '" widget-id="' + widget.id + '" category-field="' + definition.categoryField + '" serie-id="' + graph.id + '"><i class="fa ' + getSerieIcon(graph) + '"></i> ' + title + '</a></li>';
                }

            }

            if (definition.type == 'serial' || definition.type == 'radar') {
                if (widget.querySelector('.new-serie') == null) {
                    itens += '<li class="divider"></li>';
                    itens += '<li><a class="new-serie" chart-type="' + definition.type + '" widget-id="' + widget.id + '" rotate="' + definition.rotate + '"><i class="fa fa-plus"></i> Adicionar série</a></li>';
                }
            }

            if (itens != '') {
                $(widget).find('.chart-series').append(itens);
            }

            // Nova série
            $(widget).find('.new-serie').off('click').on('click', function () {
                var modal = 'serieDefinition';
                var widgetId = $(this).attr('widget-id');
                var entityViewName = $(this).closest('.widget').attr('entity-view-name');
                var categoryField = '';
                var serieId = '';
                var rotate = $(this).attr('rotate') == 'true';
                var chartType = $(this).attr('chart-type');
                var url = Page.getApplicationPath() + 'amchart/serie?widgetId=' + widgetId + '&viewName=' + entityViewName + '&categoryField=' + categoryField + '&serieId=' + serieId + '&rotate=' + rotate + '&chartType=' + chartType;
                ModalPage.show({ url: url, id: modal, height: 590, displayFooter: false, title: 'Configurações da série' });
            });

            // Edição de uma série
            $(widget).find('.chart-series .chart-serie').off('click').on('click', function () {
                var modal = 'serieDefinition';
                var widgetId = $(this).attr('widget-id');
                var chartType = $(this).attr('chart-type');
                var categoryField = $(this).attr('category-field');
                var serieId = $(this).attr('serie-id');
                var entityViewName = $(this).closest('.widget').attr('entity-view-name');
                var rotate = $(this).attr('rotate') == 'true';
                var url = Page.getApplicationPath() + 'amchart/serie?widgetId=' + widgetId + '&viewName=' + entityViewName + '&categoryField=' + categoryField + '&serieId=' + serieId + '&rotate=' + rotate + '&chartType=' + chartType;
                ModalPage.show({ url: url, id: modal, height: 590, displayFooter: false, title: 'Configurações da série' });
            });
        }
    }

    function handleNewDeveloperMenu() {
        var widgets = $(".widget[widget-type='AmCharts']");
        for (var index = 0; index < widgets.length; index++) {
            handleChart(widgets[index]);
        }

        $('.widget .remove-widget').not('.disabled').on('click', function () {
            $(this).closest('.widget').attr('removed', 'true').hide();
            initFloatActionButtons();
        });
    }

    function handleDragAndDrop() {
        $("#ContentPanel").sortable({
            connectWith: ".widget",
            items: ".widget",
            opacity: 0.8,
            handle: '.drag-handle',
            coneHelperSize: true,
            placeholder: 'portlet-sortable-placeholder',
            forcePlaceholderSize: true,
            tolerance: "pointer",
            helper: "clone",
            cancel: ".portlet-sortable-empty",
            update: function (b, c) {
                if (c.item.prev().hasClass("portlet-sortable-empty")) {
                    c.item.prev().before(c.item);
                }
                $(c.item).attr('moved', 'true');
                initFloatActionButtons();
            }
        });
    }

    function handleNewWidgetHelper() {
        var pageLayer = parseInt($('#page-layer').val());
        var pageGenerated = $('#page-generated').val() === 'true';

        if (pageGenerated === true && pageLayer.value != 0)
            $('#ContentPanel').append('<div class="row"><div class="col-md-12"><div class="new-widget-helper" id="new-page-widget"><h3 class="text-center"><i class="fa fa-plus"></i> Adicionar Widget</h3></div></div></div>');

        $('#new-page-widget').on('click', function () {
            if ($('#float-action-buttons').length > 0) {
                if (confirm("Você possui alterações visuais que ainda não foram persistidas. Deseja sair da página e perder essas alterações?"))
                    $('.create-widget-link')[0].click();
            } else {
                $('.create-widget-link')[0].click();
            }
        });
    }

    function initFloatActionButtons() {
        if ($('#float-action-buttons').length == 0) {
            var floatActionButton = '<nav class="float-action-buttons" id="float-action-buttons">' +
                '<a class="buttons" href="javascript:window.onbeforeunload=null;location.reload(true);" tooltip="Cancelar alterações visuais"></a>' +
                '<a class="buttons" id="save-page-design" tooltip="Salvar alterações visuais">' +
                '<span>' +
                '<span class="rotate"></span>' +
                '</span>' +
                '</a>' +
                '</nav>';

            $('body').append(floatActionButton);

            $('#save-page-design').on('click', function () {
                var pageWidgets = [];

                var widgets = document.querySelectorAll('.widget');

                for (var i = 0; i < widgets.length; i++) {
                    var widget = widgets[i];

                    var pageId = widget.getAttribute('page-id');

                    if (pageId == null)
                        continue;

                    var pageWidget = {};
                    pageWidget.id = widget.id;
                    pageWidget.pageId = pageId;
                    pageWidget.widgetType = widget.getAttribute('widget-type');
                    pageWidget.columnSize = discoverCurrentSize(widget);
                    pageWidget.height = discoverCurrentHeight(widget);
                    pageWidget.order = parseInt(widget.getAttribute('widget-order'))
                    var removed = widget.getAttribute('removed');
                    pageWidget.removed = removed == null ? false : removed;
                    var moved = widget.getAttribute('moved');
                    pageWidget.moved = moved == null ? false : moved;

                    pageWidgets.push(pageWidget);
                }

                var url = Page.getApplicationPath() + 'api/page/widgets';
                $.ajax({
                    type: 'PUT',
                    url: url,
                    contentType: 'application/json',
                    data: JSON.stringify(pageWidgets)
                }).done(function (data) {
                    location.hash = '#uisuccess';
                    window.onbeforeunload = null;
                    location.reload(true);
                    $('#float-action-buttons').remove();
                }).fail(function (jqXHR, data) {
                    toastr.error(jqXHR.responseJSON.ExceptionMessage, 'Erro ao persistir as alterações visuais')
                });
            });

            window.onbeforeunload = function () {
                return "Você possui alterações visuais que ainda não foram persistidas. Deseja sair da página e perder essas alterações?";
            };
        }
    }

    var initDevelopmentMode = function () {
        initWidgetResize();
        handleNewDeveloperMenu();
        handleDragAndDrop();
        handleNewWidgetHelper();

        if (location.hash == '#uisuccess') {
            toastr.success('Alterações visuais realizadas com sucesso!');
            location.hash = '';
        }
    };

    var hideDevelopmentMenu = function () {
        $('#menu-do-desenvolvedor').removeClass('open');
        $('#menu-do-desenvolvedor').children("ul").css("display", "none");
    };

    var resetDevelopmentMenu = function () {
        $('#menu-do-desenvolvedor').children("ul").css("display", "");
    };

    var cacheCleaner = function () {
        ModalMessage.show("Limpando os caches");

        hideDevelopmentMenu();

        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: Page.getApplicationPath() + 'SiteSettings/cachecleaner.aspx/cleancaches',
        }).done(function () {
            ModalMessage.hide();

            resetDevelopmentMenu();
        });
    };

    var generatePages = function () {
        ModalMessage.show("Aguarde, gerando as páginas...");

        hideDevelopmentMenu();

        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: Page.getApplicationPath() + 'SiteSettings/pageGeneration.aspx/Generate',
        }).done(function (data) {
            resetDevelopmentMenu();

            if (data.d.Success == false) {
                ModalMessage.hide();
                bootbox.alert({
                    title: "Houve um erro durante a geração das paginas",
                    message: data.d.ErrorMessage
                });
            } else {
                ModalMessage.hide();
                var instalattionProcess = $get('instalationProcess');
                if (instalattionProcess != null) {
                    bootbox.dialog({
                        title: "Instalação concluída",
                        message: "O sistema está pronto para ser utilizado",
                        buttons: {
                            main: {
                                label: "Ok",
                                className: "btn-primary",
                                callback: function () {
                                    window.location = "../";
                                }
                            }
                        }
                    });
                } else {
                    bootbox.dialog({
                        title: "As páginas foram geradas",
                        message: "O sistema está pronto para ser utilizado",
                        buttons: {
                            main: {
                                label: "Ok",
                                className: "btn-primary"
                            }
                        }
                    });
                }
            }
        });
    };

    var resizeTimeout = null;
    var setFormEditorHeights = function () {
        var formEditorElement = $('.form-editor-form');
        var docHeight = $(document).height();
        var windowHeight = $(window).innerHeight();

        var formHeight = 2000;
        if (docHeight <= windowHeight) {
            formEditorElement.css({ height: '2000px' });

            docHeight = $(document).height();
            windowHeight = $(window).innerHeight();
        } else {
            formHeight = formEditorElement.height();
        }

        var finalHeight = (formHeight - (docHeight - windowHeight) - 1) + 'px';

        formEditorElement.css({ height: finalHeight });
        $('.form-editor-properties').css({ height: finalHeight });
    };

    var scrollFormEditorToCenterSelected = function () {
        var formEditorElement = $('.form-editor-form');

        var selectedElement = formEditorElement.find('.selected');
        if (selectedElement.size() > 0) {
            var formOffset = formEditorElement.offset().top;
            var formScrollTop = formEditorElement[0].scrollTop;
            var selectedOffset = parseFloat(selectedElement.parent().offset().top);
            var selectedYOnForm = selectedOffset - formOffset + formScrollTop;

            var formHeight = formEditorElement.height();
            var selectedHeight = selectedElement.height();

            var finalScroll = selectedYOnForm - Math.round((formHeight - selectedHeight) / 2);
            formEditorElement.animate({
                scrollTop: finalScroll
            }, 400);
        }
    };

    var scrollGridEditorToCenterSelected = function () {

        var gridEditorElement = $('.form-editor-grid').find('.table-scrollable');

        var selectedElement = gridEditorElement.find('.active');
        if (selectedElement.size() > 0) {

            let positionActiveElement = selectedElement.offset().left;
            let sizeActiveElement = selectedElement.width();

            let scrollPosition = positionActiveElement + gridEditorElement.scrollLeft() + sizeActiveElement - gridEditorElement.width();
            gridEditorElement.scrollLeft(scrollPosition);
        }
    };

    var saveFormEditorScroll = function () {
        $('body').data('form-editor-scroll', $('.form-editor-form')[0].scrollTop);
    };

    var restoreFormEditorScroll = function () {
        var lastFormScroll = $('body').data('form-editor-scroll');
        if (lastFormScroll) {
            var formEditorElement = $('.form-editor-form');
            formEditorElement[0].scrollTop = lastFormScroll;
        }
    };

    return {
        cleanCaches: function () {
            cacheCleaner();
        },

        generatePages: function () {
            generatePages();
        },

        pageWidgets: function () {
            return pageWidgets;
        },

        init: function () {
            if (document.getElementById('development-environment')) {
                initDevelopmentMode();
            }
        },

        formEditorInit: function () {
            setFormEditorHeights();
            $(window).resize(function () {
                clearTimeout(resizeTimeout);
                resizeTimeout = setTimeout(setFormEditorHeights, 100);
            });

            restoreFormEditorScroll();
            $('.form-editor-form').scroll(saveFormEditorScroll);

            scrollFormEditorToCenterSelected();
        },

        gridEditorInit: function () {
            scrollGridEditorToCenterSelected();
        }
    };
}();

export default Development;
