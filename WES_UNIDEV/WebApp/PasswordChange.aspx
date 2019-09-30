<%@ Page Title="Alteração de senha" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.PasswordChangePage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="Benner" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel ID="updateSenha" runat="server">
        <ContentTemplate>
            <div class="portlet light">
                <div class="portlet-title">
                    <div class="caption">
                        <asp:Label runat="server" ID="lblTitulo" Text="Alteração da senha de acesso" CssClass="caption-subject font-green-sharp bold uppercase" />
                    </div>
                </div>
                <Benner:MessagePanel runat="server" ID="allowDivMessage"></Benner:MessagePanel>
                <div id="divChangePassword" runat="server" class="portlet-body form">
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:Button runat="server" ID="btnChangePassword" Text="Alterar" CssClass="btn blue" OnClick="ChangePassword" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <Benner:MessagePanel runat="server" ID="responseMessage"></Benner:MessagePanel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label" ID="lblSenhaAtual" Text="Senha atual" />
                                <asp:TextBox TextMode="Password" CssClass="form-control" runat="server" ID="txtCurrentPassword" MaxLength="255" size="47"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label" ID="lblNovaSenha" Text="Nova senha" />
                                <asp:TextBox TextMode="Password" CssClass="form-control" runat="server" ID="txtNewPassword" MaxLength="255" size="47"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label" ID="lblConfirmacaoSenha" Text="Confirmação de senha" />
                                <asp:TextBox TextMode="Password" CssClass="form-control" runat="server" ID="txtConfirmPassword" MaxLength="255" size="47"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

