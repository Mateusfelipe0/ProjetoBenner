<%@ Page Language="C#" EnableViewState="false" EnableTheming="false" Theme="LoginRight" AutoEventWireup="true" %>

<%@ Register Src="~/uc/Login.ascx" TagName="Login" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionLogin.ascx" TagName="HeadSectionLogin" TagPrefix="wes" %>
<%@ Register Src="~/uc/ScriptsLogin.ascx" TagName="ScriptsLogin" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionApp.ascx" TagName="HeadSectionApp" TagPrefix="wes" %>

<!DOCTYPE html>
<!--[if IE 8]><html lang="pt" class="ie8 no-js"><![endif]-->
<!--[if IE 9]><html lang="pt" class="ie9 no-js"><![endif]-->
<!--[if !IE]><!-->
<html lang="pt" class="no-js">
<!--<![endif]-->
<head runat="server">
    <wes:HeadSectionLogin runat="server" />
    <wes:HeadSectionApp runat="server" />
    <title>Autenticação</title>
</head>
<body class="login">
    <%-- INICIO THEME LOGIN ALINHADO A DIREITA --%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-9 hidden-xs hidden-sm panel-logo">
                <div class="content-panel">
                    <div class="client-image"></div>
                </div>
            </div>
            <div class="col-md-3 login-right">
                <div class="content">
                    <div class="logo"></div>
                    <wes:Login ID="wesLogin" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <%-- FIM THEME LOGIN ALINHADO A DIREITA--%>
    <wes:ScriptsLogin runat="server" />
</body>
</html>
