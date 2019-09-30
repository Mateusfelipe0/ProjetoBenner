<%@ Page Language="C#" EnableTheming="false" StylesheetTheme="" Theme="" Inherits="Benner.Tecnologia.Wes.Components.WebApp.AdminPage" %>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.Helpers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.css") %>" rel="stylesheet" />
    <style type="text/css">
        body {
            padding: 30px;
        }

        label {
            font-weight: normal;
        }

        .navbar {
            margin-bottom: 30px;
        }

        input[type="checkbox"] {
            margin-bottom: 5px;
            vertical-align: middle;
        }

        .checkboxGroup {
            float: left;
            margin-left: 135px;
            font-size: 12px;
        }


        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

            .form-signin .form-signin-heading {
                margin-bottom: 10px;
                text-align: center;
            }
    </style>

    <title>Configuração do aplicativo</title>

    <script type="text/javascript">
        function showModal() {

            setTimeout(function () {
                $.blockUI(
                    {
                        message: $('#modalFrontSide'),
                        css: {
                            border: "0px",
                            width: null
                        }
                    });
            }, 150);
        }

        // Verifica se existe arquivos obrigatórios não informados
        function checkFieldsMandatory(arrayIdsFields) {
            var errorOccurred = "";
            for (var i = 0; i < arrayIdsFields.length; i++) {

                if (document.getElementById(arrayIdsFields[i]).value == "") {
                    document.getElementById(arrayIdsFields[i] + "Documentation").style.display = "block";
                    errorOccurred = true;
                }
            }

            return errorOccurred;
        }

        function ensureValueField(fieldId, defaultValue) {
            if (document.getElementById(fieldId).value == "")
                document.getElementById(fieldId).value = defaultValue;
        }

        function validateFields() {

            var arrayIdsFields = ["poolName", "systemName", "superServer", "anonymousUserName", "anonymousPassword"];

            var errorOccurred = checkFieldsMandatory(arrayIdsFields);
            if (errorOccurred) {
                return false;
            }

            ensureValueField("maxLoad", "2");
            ensureValueField("recycleTime", "120");
            ensureValueField("tempDirectory", "C:\\TEMP\\");
            ensureValueField("maxFileSizeInKB", "4096");

            document.getElementById("action").value = "salvar";
            showModal();

            return true;
        }

        function ensureMaxValue(element, maxValue) {
            if (element.value != "" && parseInt(element.value) > maxValue)
                element.value = maxValue;
        }
        // Valida se o caractere digitado é número caso contrário inválida
        function numbersOnly() {
            var key = (window.event) ? event.keyCode : e.which;
            if ((key > 47 && key < 58))
                return true;
            else {
                if (key == 8 || key == 0)
                    return true;
            }
            return false;
        }

        function initializeComponents() {
            $("#poolName").focus();
        }

    </script>
</head>
<%  if (IsAuthenticated())
    {    %>
<body>

    <div class="container">
        <div id="modalFrontSide" style="display: none; width: 50%; position: fixed; z-index: 100001; left: 25%; top: 40%;">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Reiniciando o aplicativo
                </div>
                <div class="panel-body">
                    <h4>Você será redirecionado para a página de login do aplicativo.</h4>

                    <br />
                    <center>
                        <img id="modalSpinner" src="Content/img/progress-blue.gif" />
                    </center>
                </div>
            </div>
        </div>

        <h2 class="text-primary">Configurações do aplicativo</h2>
        <hr />

    </div>
    <div>
        <div style="margin-left: 5px; margin-top: 20px; margin-right: 5px">
            <form id="form2" name="form2" runat="server" method="post" action="admin.aspx" style="margin: 0px; padding: 0px" class="form-horizontal" role="form" autocomplete="off">

                <input runat="server" type="hidden" id="action" value="" />
                <div class="container">

                    <asp:Panel runat="server" ID="messagePanel">
                        <div class="alert alert-danger">
                            <asp:Label runat="server" ID="lbMessage"></asp:Label>
                        </div>
                    </asp:Panel>

                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:LinkButton ID="btSaveTop" runat="server" CssClass="btn btn-primary pull-right" Text="Salvar e reiniciar"
                                OnClientClick="return validateFields();" />
                        </div>
                    </div>

                    <h3>Básicas</h3>
                    <hr />

                    <div class="form-group">
                        <label for="poolName" class="col-md-3 control-label input-sm">
                            Nome do sistema
                            <label class="text-danger">*</label></label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="poolName" MaxLength="50" runat="server"></asp:TextBox>
                            <span class="help-block" style="display: none;" id="poolNameDocumentation">
                                <label class="label label-danger pull-right">Campo obrigatório</label>
                            </span>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Nome do sistema utilizado nos widgets (Ex: JURIDICO)</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">
                            Nome do sistema no Benner Server
                            <label class="text-danger">*</label></label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="systemName" MaxLength="50" runat="server"></asp:TextBox>
                            <span class="help-block" id="systemNameDocumentation" style="display: none;">
                                <label class="label label-danger pull-right">Campo obrigatório</label>
                            </span>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Nome do sistema conforme cadastrado no Benner Server (Ex: JUR_DESENV).</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">
                            Endereço do Benner Server
                            <label class="text-danger">*</label></label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="superServer" MaxLength="50" runat="server"></asp:TextBox>
                            <span class="help-block" id="superServerDocumentation" style="display: none;">
                                <label class="label label-danger pull-right">Campo obrigatório</label>
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">
                            Nome do usuário interno
                            <label class="text-danger">*</label></label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="anonymousUserName" MaxLength="50" runat="server"></asp:TextBox>
                            <span class="help-block" id="anonymousUserNameDocumentation" style="display: none;">
                                <label class="label label-danger pull-right">Campo obrigatório</label>
                            </span>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Usuário de sistema utilizado para acesso anônimo e envio de e-mail, por esse motivo deve estar configurado o servidor SMTP em sua conta.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">
                            Senha do usuário interno
                            <label class="text-danger">*</label></label>
                        <div class="col-md-4">
                            <asp:TextBox TextMode="Password" class="form-control input-sm" ID="anonymousPassword" MaxLength="50" runat="server"></asp:TextBox>
                            <span class="help-block" id="anonymousPasswordDocumentation" style="display: none;">
                                <label class="label label-danger pull-right">Campo obrigatório</label>
                            </span>
                        </div>
                    </div>

                    <div class="row"></div>
                    <h3>Avançadas</h3>
                    <hr />

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">Nº de Providers</label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="maxLoad" MaxLength="2" runat="server" onblur="ensureMaxValue(this, 50);"
                                onkeypress="return numbersOnly();"></asp:TextBox>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Número de Providers responsáveis por atender as requisições Web que executam regra de negócio. O recomendável é 2 Providers para cada núcleo incrementando caso necessário. O limite é 50.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">Tempo de vida dos Providers (min)</label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="recycleTime" MaxLength="3" runat="server" onblur="ensureMaxValue(this, 240);"
                                onkeypress="return numbersOnly();"></asp:TextBox>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Tempo em minutos que um Provider atende as requisições Web antes de ser reciclado. O recomendável é 120 minutos. O limite é 240.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">Pasta de arquivos temporários</label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="tempDirectory" MaxLength="150" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">Tamanho máximo de upload</label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="maxFileSizeInKB" MaxLength="8" runat="server" onkeypress="return numbersOnly();"></asp:TextBox>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Tamanho máximo de upload de arquivos em KB.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm">Extensões permitidas</label>
                        <div class="col-md-4">
                            <asp:TextBox class="form-control input-sm" ID="allowedFileExtensions" TextMode="MultiLine" Rows="4"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Lista de extensões de arquivos permitidas para upload neste aplicativo, separadas por vírgula (Ex.: txt, pdf, docx, xlsx). Alguns arquivos podem ser perigosos, cuidado ao liberar arquivos com as extensões bat, exe, php, asp, jsf.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm"></label>
                        <div class="col-md-4">
                            <label>
                                <asp:CheckBox ID="validateFileSignature" data-translate="false" runat="server"></asp:CheckBox>
                                Validar assinatura de arquivos
                            </label>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Indica se o aplicativo deve validar a assinatura de arquivos (magic number) em uploads.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail1" class="col-md-3 control-label input-sm"></label>
                        <div class="col-md-4">
                            <label>
                                <asp:CheckBox ID="developmentEnvironment" data-translate="false" runat="server"></asp:CheckBox>
                                Ambiente de desenvolvimento
                            </label>
                        </div>
                        <div class="col-md-5">
                            <div class="text-info">Indica se o aplicativo deve exibir botões de desenvolvimento e o papel "Desenvolvedor" na lista de papéis.</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Label class="labelHelp pull-left" runat="server" ID="lbPID"></asp:Label>
                            <asp:LinkButton ID="btSaveBottom" runat="server" CssClass="btn btn-primary pull-right" Text="Salvar e reiniciar"
                                OnClientClick="return validateFields();" />
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </div>
    <script src="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.js") %>"></script>
    <script type="text/javascript">
        $(function () {
            initializeComponents()
        });
    </script>
</body>
<%  
    }
    else
    {    %>
<body>
    <div class="container">
        <h2 class="text-primary">Configurações do aplicativo</h2>
        <hr />
        <form id="form1" name="form1" class="form-signin form-horizontal" runat="server" method="post" action="admin.aspx" role="form">
            <h3 class="form-signin-heading">Administrador do servidor</h3>
            <br />
            <div class="form-group">
                <label for="inputEmail1" class="col-md-3 control-label">Usuário</label>
                <div class="col-md-9">
                    <input name="username" type="text" id="username" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail1" class="col-md-3 control-label">Senha</label>
                <div class="col-md-9">
                    <input name="password" type="password" id="password" class="form-control" />
                </div>
            </div>
            <div class="text-center">
                <label class="text-danger"><% Response.Write(HttpUtility.HtmlEncode(AuthenticationMessage)); %></label>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Acessar</button>
        </form>
    </div>
</body>

<%  }    %>
</html>

