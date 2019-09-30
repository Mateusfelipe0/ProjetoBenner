<%@ Page Title="Manipulação de dados" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPageModal" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" 
    Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" 
    Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>

<%@ Register Src="~/uc/HeadSection.ascx" 
    TagName="HeadSection" 
    TagPrefix="wes" %>

<%@ Register Src="~/uc/WesManager.ascx" 
    TagName="WesManager" 
    TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head id="Head1" runat="server">
    <wes:HeadSection ID="HeadSection1" runat="server" />
    <title>Lookup</title>
    <style>
        .environment, .portlet-title {
            display: none;
        }
    </style>
</head>
    <body class="lookup-search bg-white">
    <div class="col-md-12">
        <form id="formMain" runat="server">
        </form>
    </div>
    <script type="text/javascript">
        parent.Benner.ModalPage.hide();
    </script>
</body>
</html>