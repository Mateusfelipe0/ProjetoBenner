import Page from './Page';

var Searcher = (function () {

    var _lastFind = "";
    var _scheduledRequest;
    var _responseCount = 0;
    var _autoNavigate = false;
    var _installed = false;

    function getItem(item) {
        var i = document.createElement('i');
        $(i).addClass(item.Fonticon);

        var caption = document.createElement("span");
        var a = document.createElement("a");

        if (item.Url)
            $(a).attr("href", item.Url);

        $(a).addClass("list-group-item searcher-list-group-item")
            .append(i).append(caption);

        if (item.Text == 'zzz_there_are_more_items') {
            item.Text = "Existem mais itens, refine sua pesquisa";
            $(a).addClass('searcher-more-itens');
        }

        $(caption).addClass("searcher-caption").text(" " + item.Text);

        if (item.Commands != null && item.Commands.length > 0)
            $(a).append(Searcher.getCommandsHtml(item.Commands));

        return a;
    };

    function addItemsGrouped(data, root) {
        data.sort(
            function (a, b) {
                if (a.Group + a.Text < b.Group + b.Text) return -1;
                if (a.Group + a.Text > b.Group + b.Text) return 1;
                return 0;
            }
        );

        var lastGroup = '';
        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            if (item.Group !== undefined && lastGroup !== item.Group) {
                var group = item.Group;
                var li = document.createElement("li");
                $(li).text(group.toUpperCase()).addClass("list-group-item searcher-list-header bold");
                $(root).append(li);
                lastGroup = item.Group;
            }
            $(root).append(getItem(item));
        }
    };

    return {
        init: function () {
            $('.searcher-icon').on('click', '', function () {
                var searcherModal = $("#searcher-modal");
                if (!searcherModal.is(":visible")) {
                    Searcher.install();
                    searcherModal.modal('show');
                }
                else
                    searcherModal.modal('hide');
            });
            //Tooltip do searcher
            $('#searcher').tooltip(
                {
                    placement: 'bottom'
                }
            );
        },

        install: function () {
            if (!_installed) {
                $(document).ready(function () {
                    $('body').on('keyup', '.searcher-criteria', Searcher.processKey);
                });

                var searcherModal = $("#searcher-modal");

                searcherModal.on('shown.bs.modal', function () {
                    $('.searcher-criteria').focus();
                });

                searcherModal.find(".dropdown-menu li a").click(function () {
                    var button = searcherModal.find(".btn:first-child");
                    button.contents().first()[0].textContent = $(this).text();
                    button.data("group", $(this).text().trim());
                    searcherModal.find(".input-group-btn:first-child").removeClass('open');
                    $('.searcher-criteria').focus();
                    $('.searcher-criteria').select();
                    Searcher.search();
                });

                _installed = true;
            }
        },

        processResponse: function (data, resultId) {
            _responseCount++;
            $(".searcher-result-caption").hide();
            var text = $('.searcher-criteria').val();
            var listGroup = document.createElement('div');
            $(listGroup).addClass('list-group');

            if (data && (data.length > 0)) {
                addItemsGrouped(data, listGroup);
                $("#" + resultId).empty().append(listGroup);
                $("#" + resultId).slideDown(200);
            }

            if (text.trim() != "" && _responseCount == 2 && $(".searcher-results-panel .list-group").length == 0) {
                $(".searcher-result-caption").show();
                $(".searcher-result-caption").html('Nenhum registro encontrado');
            }

            if (_responseCount == 2)
                Searcher.unBlockUI();
        },

        processError: function (data, resultid) {
            Searcher.unBlockUI();
            _autoNavigate = false;
            if (data.status == 401 || ((data.responseText.indexOf('wesLogin_titlePage') > 0) && (data.responseText.indexOf('"login"') > 0)))
                Searcher.processResponse([{
                    'Url': 'javascript:location.reload();',
                    'Group': 'Informação',
                    'Text': 'Sua sessão expirou. Efetue o login novamente.'
                }], resultid);
            else {
                var message = '';

                var exception = data.responseJSON;
                while (exception != null) {
                    if (message != '' && !message.endsWith('.'))
                        message += '.';
                    message += ' ' + exception.ExceptionMessage;

                    exception = exception.InnerException;
                }

                Searcher.processResponse([{
                    'Url': '',
                    'Group': 'Erro',
                    'Text': message
                }], resultid);
            }
        },

        blockUI: function () {
            $('.searcher-btn-search').removeClass('fa-search');
            $('.searcher-btn-search').addClass('fa-spin fa-refresh');
        },

        unBlockUI: function () {
            $('.searcher-btn-search').removeClass('fa-spin');
            $('.searcher-btn-search').removeClass('fa-refresh');
            $('.searcher-btn-search').addClass('fa-search');
        },

        search: function () {
            _responseCount = 0;
            var text = $('.searcher-criteria').val();
            var group = $('#searcher-btn-group').data("group");

            if (group.toUpperCase() === 'TODOS')
                group = '';

            if ((text == _lastFind || (text.length > 0 && text.length < 3)) && (!_autoNavigate))
                return;

            try {
                Searcher.blockUI();

                Searcher.searchItems(text, group);
                setTimeout(function () { Searcher.searchEntities(text, group); }, 1);

                _lastFind = text;

            }
            catch (e) {
                Searcher.unBlockUI();
            }
        },

        searchItems: function (text, group) {
            $("#searcher-results-items").empty().hide();

            $.ajax({
                url: Page.getApplicationPath() + "api/searcher",
                data: { text: text, group: group, category: "items" },
                dataType: "json",
                success: function (data) {
                    Searcher.processResponse(data, 'searcher-results-items');
                },
                error: function (data) {
                    Searcher.processError(data, 'searcher-results-items');
                }
            });

        },
        searchEntities: function (text, group) {
            $("#searcher-results-entities").empty().hide();
            $.ajax({
                url: Page.getApplicationPath() + "api/searcher",
                data: { text: text, group: group, category: "entities" },
                dataType: "json",
                success: function (data) {
                    Searcher.processResponse(data, 'searcher-results-entities');
                },
                error: function (data) {
                    Searcher.processError(data, 'searcher-results-entities');
                }
            });
        },
        clear: function () {
            _lastFind = '';
            $('.searcher-criteria').val('');
            $(".searcher-results").empty();
            $(".searcher-result-caption").hide();
            $('.searcher-criteria').focus();
        },

        processKey: function (e) {
            _autoNavigate = false;
            var code = (e.keyCode ? e.keyCode : e.which);
            if (code == 13) {
                Searcher.clearSchedule();
                _autoNavigate = true;
                Searcher.search();
            } else {
                Searcher.clearSchedule();
                _scheduledRequest = setTimeout(Searcher.search, 800);
            }
        },

        clearSchedule: function () {
            if (_scheduledRequest)
                clearTimeout(_scheduledRequest);
        },

        getCommandsHtml: function (commands) {
            if (!commands || commands.length == 0)
                return;

            var span = document.createElement('span');
            $(span).addClass('searcher-commads-list');
            for (var i = 0; i < commands.length; i++) {
                var command = commands[i];

                var a = document.createElement('a');
                $(a).attr('href', command.Url);
                $(a).addClass('btn btn-xs');
                if (command.Color != null)
                    $(a).addClass(command.Color);
                else
                    $(a).addClass('default');
                if (command.Fonticon != null) {
                    var icon = document.createElement('i');
                    $(icon).addClass(command.Fonticon);

                    $(a).append(icon);
                }
                $(a).append(" " + command.Text);
                $(span).append(a);
            }

            return span;
        },
    };

})();

export default Searcher;