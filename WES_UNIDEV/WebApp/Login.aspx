<%@ Page Language="C#" EnableViewState="false" EnableTheming="false" Theme="LoginBlur" AutoEventWireup="true" %>

<%@ Register Src="~/uc/Login.ascx" TagName="Login" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionLogin.ascx" TagName="HeadSectionLogin" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSectionApp.ascx" TagName="HeadSectionApp" TagPrefix="wes" %>
<%@ Register Src="~/uc/ScriptsLogin.ascx" TagName="ScriptsLogin" TagPrefix="wes" %>

<!DOCTYPE html>
<!--[if !IE]><!-->
<html lang="pt">
<!--<![endif]-->
<head runat="server">    
    <wes:HeadSectionLogin runat="server" />
    <wes:HeadSectionApp runat="server" />
    <title>Autenticação</title>
</head>
<body class="login">
    <%-- INICIO THEME LOGIN BLUR--%>
    <div class="background-full">
    </div>
    <div class="content">
        <div class="logo"></div>
        <wes:Login ID="wesLogin" runat="server" />
    </div>
    <div class="copyright">
	    <script type="text/javascript">
            document.write(new Date().getFullYear());
        </script> &copy; Benner Sistemas.
    </div>
    <%-- FIM THEME LOGIN BLUR--%>
    <wes:ScriptsLogin runat="server" />
</body>
</html>
