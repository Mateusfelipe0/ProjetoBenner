import Page from './Page';
import ModalPage from './ModalPage';

var AsyncProcesses = function () {
    // timeOut para o proximo setTimeOut do getAsyncProcesses
    var requestTime = 1000;
    // Se está processando um getAsyncProcesses
    var inAsyncProcesses = false;
    // Se solicitou um setTimeOut do getAsyncProcesses
    var requestAsync = false;

    var getUrl = function () {
        if (this.Url != null)
            return AsyncProcesses.resolveClientUrl(this.Url);
        else
            return "#";
    };

    var getTarget = function () {
        if (this.Url != null)
            return "_blank";
        else
            return "_self";
    };

    var getProcessClass = function () {
        switch (this.Status) {
            case 0:
                return "fa fa-exclamation-triangle process-aborted";
            case 1:
                return "fa fa-exclamation-circle process-error";
            case 2:
                return "fa fa-check process-success";
            case 3:
                return "fa fa-cog fa-spin process-running";
            case 4:
                return "fa fa-info process-info";
            default:
                return "";
        }
    };

    var getProcessBarClass = function () {

        switch (this.Status) {
            case 0:
                return "progress-bar-warning";
            case 1:
                return "progress-bar-danger";
            case 2:
                return "progress-bar-success";
            case 3:
                return "progress-bar-info";
            default:
                return "";
        }
    };

    var showErrorMessage = function (detail) {
        var html = new Sys.StringBuilder();
        html.append('<div>');
        html.append('<p><strong>Processo:</strong></p>');
        html.append('<p>' + detail.Description + '</p>');
        html.append('<p></p>');
        html.append('<p></p>');
        html.append('<p><strong>Erro:</strong></p>');
        html.append('<p>' + detail.ErrorMessage + '</p>');
        if (detail.Url != null) {
            html.append('<p></p>');
            html.append('<p></p>');
            html.append('<p>' + detail.getUrl() + '</p>');
        }
        html.append('</div>');

        ModalPage.show({ size: 'large', height: 495, customBody: html.toString(), displayFooter: true, title: 'Ocorreu um erro na execução do processo' });
    };

    return {
        init: function () {
            $('#header_task_bar').on('mouseover', function () {
                var unreadedMessages = $(this).find('a.unread-message.finished');
                for (var i = 0; i < unreadedMessages.length; i++) {
                    var id = $(unreadedMessages[i]).parent().attr('id');
                    AsyncProcesses.messageWasRead(id);
                }
                $(this).find(".dropdown-menu-list").removeAttr("data-initialized");
                App.initSlimScroll('#header_task_bar .scroller');
            });

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "positionClass": "toast-bottom-right",
                "onclick": null,
                "showDuration": "1000",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };

            if ($("#header_task_bar span.active").length) {
                this.requestAsyncProcesses(500);
            }
        },

        initAjax: function () {
            if ($("#header_task_bar span.active").length == 0) {
                this.requestAsyncProcesses(500);
            }
            this.countMessageUnread();
        },

        requestAsyncProcesses: function (timeOut) {
            requestTime = timeOut;
            if (!requestAsync) {
                setTimeout(this.getAsyncProcesses, requestTime);
                requestAsync = true;
                if (requestTime < 10000) {
                    requestTime = requestTime + 1000;
                }
            }
        },

        notifyNewProcesses: function (detail) {
            toastr.info(detail.Description, detail.Title);
            $.post(Page.getApplicationPath() + "api/AsyncProcesses/" + detail.Id, { WasRead: false, IsNew: false });
        },

        notification: function (message, title) {
            this.requestAsyncProcesses(requestTime);
            toastr.info(message, title);
        },

        resolveClientUrl: function (url) {
            return url ? url.replace(/~\x2f/g, Page.getApplicationPath()) : null;
        },

        loadAsyncProcesses: function (result) {
            var requestAgain = false;
            var headerTaskBar = $("#header_task_bar");
            var dropDownMenu = headerTaskBar.find("> .dropdown-menu");
            var dropDownMenuList = headerTaskBar.find(".dropdown-menu-list");
            var dropDownMenuHeader = dropDownMenu.find("> li").first();

            dropDownMenuList.removeAttr("data-initialized");

            dropDownMenuHeader.html(String.format('<h3><span class=\"bold\">{0}</span></h3><a href="javascript:Benner.AsyncProcesses.clearReadyProcesses();">Limpar</a>',
                result.length == 0 ? "Nenhum processo" : result.length + " processo(s)"));

            dropDownMenuList.empty();

            var detail = null;
            for (var i = result.length - 1; i >= 0; i--) {
                detail = result[i];

                detail.getUrl = getUrl;
                detail.getTarget = getTarget;
                detail.getProcessClass = getProcessClass;
                detail.getProcessBarClass = getProcessBarClass;

                if (!detail.IsReady)
                    requestAgain = true;

                var sb = new Sys.StringBuilder();
                sb.append(String.format('<li id="{0}" >', detail.Id));
                sb.append(String.format('  <a class="{0} {1}" href="{2}" target="{3}">', detail.WasRead ? "" : "unread-message", detail.IsReady ? "finished" : "", detail.getUrl(), detail.getTarget()));
                sb.append(String.format('    <span class="task">'));
                sb.append(String.format('      <span class="desc"><i class="{0}"></i> {1}</span>', detail.getProcessClass(), detail.Description));
                if (detail.Url != null)
                    sb.append(String.format('      <i class="fa fa-file-text-o faa-vertical faa-slow animated" style="float:right"></i>'));
                sb.append(String.format('    </span>'));

                if (detail.Status != 4) {
                    sb.append(String.format('    <span class="progress ">'));
                    sb.append(String.format('      <span style="width: {0}%;" class="progress-bar {1}  progress-bar-striped {2} process-progress-bar">', detail.Percent, detail.getProcessBarClass(), detail.IsReady ? "" : "active"));
                    sb.append(String.format('        <span class="percent" style="margin-left: 2px; margin-right: 2px;">{0}%</span>', detail.Percent));
                    sb.append(String.format('      </span>'));
                    sb.append(String.format('    </span>'));
                }

                sb.append(String.format('  </a>'));
                sb.append(String.format('</li>'));

                dropDownMenuList.prepend(sb.toString());
                dropDownMenuList.find("li").first().on("click", { detail: detail }, this.messageOnClick);

                if (detail.Status != 3 && !detail.ToastrDisplayed) {
                    this.notificationFinish(detail);
                } else if (detail.IsNew) {
                    this.notifyNewProcesses(detail);
                }
            }

            this.countMessageUnread();
            App.initSlimScroll('#header_task_bar .scroller');

            if (requestAgain) {
                this.requestAsyncProcesses(requestTime);
            }
        },

        notificationFinish: function (detail) {

            var message = String.format("<a>{0}</a>", detail.Description);

            var options = {
                "onclick": function () {
                    if (detail.Url != null && detail.Status != 1)
                        open(detail.getUrl(), detail.getTarget());
                    AsyncProcesses.messageWasRead(detail.Id);

                    if (detail.Status == 1) {
                        showErrorMessage(detail);
                    }
                }
            };

            $.post(Page.getApplicationPath() + "api/AsyncProcesses/" + detail.Id, { WasRead: false, ToastrDisplayed: true });

            if (detail.Status == 0) {
                toastr.warning(detail.Description, detail.Title, options);
            } else if (detail.Status == 1) {
                toastr.error(detail.Description, detail.Title, options);
            } else if (detail.Status == 4) {
                toastr.info(detail.Description, detail.Title, options);
            } else {
                toastr.success(message, detail.Title, options);
            }
        },

        clearReadyProcesses: function () {
            $('#header_task_bar').addClass("open");
            $.ajax({
                url: Page.getApplicationPath() + "api/AsyncProcesses/clear",
                type: 'POST',
                success: function (result) {
                    AsyncProcesses.requestAsyncProcesses(500);
                },
                fail: function (result) {
                    console.log("Falha na chamada de api DELETE/AsyncProcesses ");
                    console.log(msg);
                }
            });
        },

        getAsyncProcesses: function () {
            if (!inAsyncProcesses) {
                inAsyncProcesses = true;
                var request = $.get(Page.getApplicationPath() + "api/AsyncProcesses");
                request.done(function (data) {
                    inAsyncProcesses = false;
                    requestAsync = false;
                    AsyncProcesses.loadAsyncProcesses(data);
                });
                request.fail(function (msg) {
                    inAsyncProcesses = false;
                    requestAsync = false;
                    console.log("Falha na chamada de api/AsyncProcesses" + msg);
                });
            }
        },

        countMessageUnread: function () {
            var unreadMessages = $("#header_task_bar").find(".unread-message").length;
            if (unreadMessages == 0) {
                $("#header_task_bar").find("> a > span").text("");
            } else {
                $("#header_task_bar").find("> a > span").text(unreadMessages);
            }
        },

        messageWasRead: function (messageId) {
            var message = $('#' + messageId);
            if (message.find(".unread-message").length > 0) {
                message.find(".unread-message").removeClass("unread-message");
                this.countMessageUnread();
                $.post(Page.getApplicationPath() + "api/AsyncProcesses/" + messageId, { WasRead: true, ToastrDisplayed: true });
            }
        },

        messageOnClick: function (event) {
            var detail = event.data.detail;
            if (detail && detail.ErrorMessage) {
                showErrorMessage(detail);
            }
        }
    };
}();

export default AsyncProcesses;