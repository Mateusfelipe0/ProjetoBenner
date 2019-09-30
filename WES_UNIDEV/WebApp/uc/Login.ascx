<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.LoginControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<form runat="server" id="formLogin" class="login-form form">
    <h4 runat="server" id="titlePage" class="form-title">Autenticação</h4>
    <wes:MessagePanel ID="messagePanel" runat="server"></wes:MessagePanel>
    <asp:Login ID="loginWes" runat="server" RenderOuterTable="false">
        <LayoutTemplate>
            <div class="form-group">
                <label class="control-label visible-ie9">Usuário</label>
                <div class="input-icon">
                    <i class="fa fa-user"></i>
                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control placeholder-no-fix" autocomplete="off" 
                        placeholder="Usuário" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie9">Senha</label>
                <div class="input-icon">
                    <i class="fa fa-lock"></i>
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control placeholder-no-fix" 
                        autocomplete="off" placeholder="Senha" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-actions">
                <asp:LinkButton runat="server" CssClass="btn blue pull-right" CommandName="Login" ID="LoginButton" ClientIDMode="Static">
                    Acessar <i class='m-icon-swapright m-icon-white'></i></asp:LinkButton>
            </div>
            <asp:Panel runat="server" ID="divForgotPassword" CssClass="forget-password">
                <h4>
                    <asp:HyperLink runat="server" ID="ForgotPassword" NavigateUrl="~/Login?forgotPassword=1">Esqueceu sua senha?</asp:HyperLink>
                </h4>
            </asp:Panel>
        </LayoutTemplate>
    </asp:Login>
            
    <asp:ChangePassword ID="changePassword" runat="server" RenderOuterTable="false" DisplayUserName="true">
        <ChangePasswordTemplate>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie9">Usuário</label>
                <div class="input-icon">
                    <i class="fa fa-user"></i>
                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control placeholder-no-fix" autocomplete="off" 
                        placeholder="Usuário" ClientIDMode="Static" ReadOnly="true" ></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie9">Usuário</label>
                <div class="input-icon">
                    <i class="fa fa-lock"></i>
                    <asp:TextBox runat="server" ID="CurrentPassword" CssClass="form-control placeholder-no-fix" autocomplete="off" 
                        placeholder="Senha atual" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie9">Usuário</label>
                <div class="input-icon">
                    <i class="fa fa-lock"></i>
                    <asp:TextBox runat="server" ID="NewPassword" CssClass="form-control placeholder-no-fix" autocomplete="off" 
                        placeholder="Nova senha" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie9">Usuário</label>
                <div class="input-icon">
                    <i class="fa fa-check"></i>
                    <asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="form-control placeholder-no-fix" autocomplete="off" 
                        placeholder="Confirme a senha" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <a ID="ChangePasswordPushButton" class="btn default" href="./Login"><i class='m-icon-swapleft'></i> Voltar</a>
                <asp:LinkButton runat="server" CommandName="ChangePassword" ID="CancelPushButton" CssClass="btn blue pull-right" ClientIDMode="Static">
                    Alterar <i class='m-icon-swapright m-icon-white'></i></asp:LinkButton>
            </div>
        </ChangePasswordTemplate>
        <SuccessTemplate>
            <p>Sua senha foi alterada.</p>
            <div class="form-actions right">
                <asp:LinkButton runat="server" CommandName="Continue" CssClass="btn green pull-right" ID="ContinuePushButton" ClientIDMode="Static">
                    Continuar <i class='m-icon-swapright m-icon-white'></i></asp:LinkButton>
            </div>
        </SuccessTemplate>
    </asp:ChangePassword>

    <asp:Panel runat="server" ID="recoveryPassword">
        <asp:Panel runat="server" ID="recoveryPasswordInput" class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie9">Digite seu nome de usuário</label>
			<div class="input-icon">
				<i class="fa fa-user"></i>
                <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control placeholder-no-fix" 
                    placeholder="Digite seu usuário" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
			</div>
        </asp:Panel>
        <div class="form-group">
            <a ID="btCancelPasswordRecovery" class="btn default" href="./Login"><i class='m-icon-swapleft'></i> Voltar</a>
            <asp:LinkButton runat="server" ID="btPasswordRecovery" CssClass="btn blue pull-right" ClientIDMode="Static">Enviar <i class='m-icon-swapright m-icon-white'></i></asp:LinkButton>
		</div>
    </asp:Panel>

    <asp:Panel runat="server" ID="recoveryChangePassword">
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie9">Novo usuário</label>
            <div class="input-icon">
                <i class="fa fa-lock"></i>
                <asp:TextBox runat="server" ID="txtNewPassword" CssClass="form-control placeholder-no-fix" autocomplete="off"  
                    placeholder="Nova Senha" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie9">Confirme novo usuário</label>
            <div class="input-icon">
                <i class="fa fa-check"></i>
                <asp:TextBox runat="server" ID="txtConfirmNewPassword" CssClass="form-control placeholder-no-fix" 
                    placeholder="Confirmação de nova senha" autocomplete="off" TextMode="Password" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>
        <div class="form-group form-group-right">
            <asp:LinkButton runat="server" ID="btSendNewPassword" CssClass="btn blue" ClientIDMode="Static">Enviar <i class='m-icon-swapright m-icon-white'></i></asp:LinkButton>
        </div>
    </asp:Panel>
</form>