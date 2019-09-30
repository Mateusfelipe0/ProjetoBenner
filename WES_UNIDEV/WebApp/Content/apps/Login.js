var Login = function () {
    var handleLogin = function () {
        $('.login-form').validate({
            errorElement: 'span',
            errorClass: 'help-block',
            focusInvalid: true,
            highlight: function (element) {
                $(element).closest('.form-group').addClass('has-error');
            },
            success: function (label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },
            errorPlacement: function (error, element) {
                error.insertAfter(element.closest('.input-icon'));
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
        //Adiciona as regras de validacao da tela de login
        if ($("#UserName").length > 0) {
            $("#UserName").rules("add", {
                required: {
                    depends: function () {
                        $(this).val($.trim($(this).val()));
                        return true;
                    }
                },
                messages: {
                    required: "O campo usuário é obrigatório."
                }
            });

            if ($("#Password").length > 0) {
                $("#Password").rules("add", {
                    required: true,
                    messages: {
                        required: "O campo senha é obrigatório."
                    }
                });
            }

            if ($("#CurrentPassword").length > 0) {
                $("#CurrentPassword").rules("add", {
                    required: true,
                    messages: {
                        required: "O campo senha atual é obrigatório."
                    }
                });

                $("#NewPassword").rules("add", {
                    required: true,
                    messages: {
                        required: "O campo nova senha é obrigatório."
                    }
                });

                $("#ConfirmNewPassword").rules("add", {
                    required: true,
                    equalTo: "#NewPassword",
                    messages: {
                        required: "O campo confirme a senha é obrigatório.",
                        equalTo: "Senhas informadas não conferem."
                    }
                });
            }
        }

        if ($("#txtUserName").length > 0) {
            $("#txtUserName").rules("add", {
                required: true,
                messages: {
                    required: "O campo usuário é obrigatório."
                }
            });
        }

        if ($("#txtNewPassword").length > 0) {
            $("#txtNewPassword").rules("add", {
                required: true,
                messages: {
                    required: "O campo nova senha é obrigatório."
                }
            });

            $("#txtConfirmNewPassword").rules("add", {
                required: true,
                equalTo: "#txtNewPassword",
                messages: {
                    required: "O campo confirmação de nova senha é obrigatório.",
                    equalTo: "Senhas informadas não conferem."
                }
            });
        }
        //Ao pressionar a tecla entre e validado os campos e executado postback
        $(".login-form input").keypress(function (e) {
            if (e.which == 13) {
                if ($(".login-form").validate().form()) {
					var btn = $("a#LoginButton");
                    if ($(btn).length > 0) {
                        eval($(btn).attr("href"));
                    }
                }
                return false;
            }
        });
        //Ao pressionar a space entre e validado os campos e executado postback
		$(".login-form a#LoginButton").keypress(function (e) {
            if (e.which == 32) {
                if ($('.login-form').validate().form()) {
                    eval($(this).attr("href"));
                }
                return false;
            }
        });
        //Ao pressionar sobre o botao enviar e validado os campos e executado postback
		$(".login-form a#LoginButton").click(function (e) {
            if ($('.login-form').validate().form()) {
                eval($(this).attr("href"));
            }
            return false;
        });
    };

    var appWarmup = function () {
        //fazer o warmup da aplicação
        $.get($('#Wes2008ApplicationPath').val() + 'Ping');
    };

    return {
        init: function () {
            var userName = $("#UserName");
            if ($(userName).length > 0)
                $(userName).focus();

            handleLogin();
            appWarmup();
        }
    };
}();

export default Login;