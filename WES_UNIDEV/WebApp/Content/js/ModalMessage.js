var ModalMessage = function () {

};

ModalMessage.show = function (message) {
    App.blockUI({ textOnly: false, boxed: true, message: message });
};

ModalMessage.hide = function (elmentId) {
    App.unblockUI();
};

ModalMessage.alert = function (title, message, callback) {
    var options = {
        title: title,
        message: message
    };

    if (callback != null) {
        options.buttons = {
            main: {
                label: "Ok",
                className: "btn-primary",
                callback: function () {
                    callback();
                }
            }
        };
    }

    bootbox.dialog(options);
};

ModalMessage.confirm = function (title, message, callback, cancelCallback) {
    return bootbox.dialog({
        title: title,
        message: message,
        onEscape: function () {
            bootbox.hideAll();
            if (typeof cancelCallback != 'undefined')
                cancelCallback();
        },
        buttons: {
            success: {
                label: 'Sim',
                className: 'blue btn-primary',
                callback: function () {
                    callback();
                }
            },
            main: {
                label: 'Não',
                className: 'default',
                callback: function () {
                    if (typeof cancelCallback != 'undefined')
                        cancelCallback();
                }
            }
        }
    });
};

export default ModalMessage;