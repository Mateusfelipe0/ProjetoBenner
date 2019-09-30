<%@ Page Title="Edição do e-mail para solicitação de nova senha" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ForgotPasswordEmailConfigPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">

        <asp:HiddenField runat="server" ID="hdnTemplateEmail" />

        <div class="portlet-title">
            <div class="caption">
                <asp:Label ID="lblTitle" runat="server" CssClass="caption-subject font-green-sharp bold uppercase" />
            </div>
        </div>
        <div class="portlet-body form">

            <div class="row">
                <div class="col-md-12">
                    <div class="form-actions nobg no-border commands-bar">
                        <asp:LinkButton runat="server" ID="btnSalvar" CssClass="btn blue" OnClientClick="validationFields()" />
                    </div>

                    <asp:Panel runat="server" ID="msgErro" CssClass="alert alert-warning">
                        <button class="close" data-dismiss="alert"></button>
                        <asp:Label runat="server" ID="lblMsgUser"></asp:Label>
                    </asp:Panel>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="note note-warning">
                        <h4 class="block"><%= Benner.Tecnologia.Wes.Components.LanguageTranslator.Translate("Você pode utilizar as seguintes variáveis no texto do e-mail:") %></h4>
                        <p>
                            <%= Benner.Tecnologia.Wes.Components.LanguageTranslator.Translate("<b>@LINK</b>, retorna o link para alteração da senha.") %>
                        </p>
                        <p>
                            <%= Benner.Tecnologia.Wes.Components.LanguageTranslator.Translate("<b>@USER</b>, retorna o nome do usuário.") %>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-md-12 form-horizontal" runat="server">
                    <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2">
                            <div class="label-form">
                                <asp:Label ID="AssuntoEmailLabel" runat="server" CssClass="label-title" />                                
                            </div>
                        </label>
                        <div class="col-md-10 col-sm-10 value">
                            <asp:TextBox ID="AssuntoEmailTextBox" runat="server" class="form-control" />
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12" runat="server">
                    <div id="emailEditor" runat="server">
                        <p>Olá @USER,</p>
                        <p>Você solicitou a recuperação de sua senha, acesse o link abaixo para definir a nova senha:</p>
                        <p>@LINK</p>
                        <p>Caso não tenha solicitado a recuperação de sua senha, desconsidere este e-mail.</p>
                        <p></p>
                        <p>Att,</p>
                        <p>Benner Sistemas S.A</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        //Itens que serão habilitados
        var itensToolbars = [['style', ['style']],
        ['font', ['bold', 'italic', 'underline', 'superscript', 'subscript', 'strikethrough', 'clear']],
        ['fontname', ['fontname']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']],
        ['table', ['table']],
        ['insert', ['link', 'hr']],
        ['view', ['fullscreen']],
        ['help', ['help']]];
        //Inicializa o componente
        $('#<%= emailEditor.ClientID %>').summernote({ height: 300, lang: 'pt-BR', toolbar: itensToolbars, disableDragAndDrop: true });
        //Validação dos campos
        function validationFields() {
            debugger;
            var objEmailEditor = $('#<%= emailEditor.ClientID %>');
            var hdnEmail = $('#<%= hdnTemplateEmail.ClientID %>');
            //Inicializa o variavel do template do email
            $(hdnEmail).val("");
            //Busca o texto inserido no editor
            var textEmailEditor = $('.note-editable').text();
            //Busca o template do email definido com as tags html
            var templateEmail = $(objEmailEditor).summernote("code");
            if (textEmailEditor != "" && templateEmail != "") {
                $(hdnEmail).val(templateEmail);
            }
        }
    </script>
</asp:Content>

