<%@ Page Language="C#" EnableSessionState="true" EnableViewState="false" EnableTheming="false"%>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.Helpers" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inicializando aplicativo</title>
</head>
<body class="warmup">
    <link href="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%= ResolveUrl("~/content/css/warmup.css")%>" rel="stylesheet" type="text/css" />
    <div id="warmuppage">
        <div id="warmupcontent">
            <img src="<%= ResolveUrl("~/content/img/logo-benner-vermelha-azul.png")%>" alt="Logo Benner">

            <i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
            <h1>Aguarde um momento</h1>
            <h2>O aplicativo está inicializando</h2>
        </div>
    </div>
    <script type="text/javascript">
        function wakeUp() {
            location.reload();
        };
		<% 
            var redisValidator = new Benner.Tecnologia.Wes.Components.WebApp.SessionServerValidator();
            redisValidator.CheckAvailability();
        %>
		document.addEventListener("DOMContentLoaded", function(){
			setInterval(wakeUp, 1000);
        });
    </script>
</body>
</html>
