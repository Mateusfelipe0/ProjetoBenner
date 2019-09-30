<%@ Page Language="C#" EnableViewState="false" EnableTheming="false" Theme="Login" AutoEventWireup="true" %>

<%@ Register Src="~/uc/Login.ascx" TagName="Login" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionLogin.ascx" TagName="HeadSectionLogin" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionApp.ascx" TagName="HeadSectionApp" TagPrefix="wes" %>
<%@ Register Src="~/uc/ScriptsLogin.ascx" TagName="ScriptsLogin" TagPrefix="wes" %>

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
    <%-- INICIO THEME LOGIN PADRÃO --%>
    <div class="content" style="margin-top: 100px;">
        <div class="logo"></div>
        <wes:Login runat="server" />
    </div>
    <div class="copyright">
	    <script type="text/javascript">
            document.write(new Date().getFullYear());
        </script> &copy; Benner Sistemas.
    </div>
    <%-- FIM THEME LOGIN PADRÃO --%>
    <wes:ScriptsLogin runat="server" />
</body>
</html>
