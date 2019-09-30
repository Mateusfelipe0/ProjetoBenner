<%@ Page Title="Pesquisar" Language="C#" Inherits="Benner.Tecnologia.Workflow.WebApp.WorkflowCompareRelevantDataPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Register Src="~/uc/WesManager.ascx" TagName="WesManager" TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <wes:HeadSection runat="server" />
    <title>Lookup</title>
    <style>
        .environment {
            display: none;
        }
    </style>
</head>
<body class="bg-white">
    <div class="col-md-12 col-sm-12">
        <form id="formMain" runat="server">
            <wes:WesManager ID="WesManager1" runat="server">
                <Scripts>
                </Scripts>
            </wes:WesManager>
        </form>
        
        <asp:Panel ID="Resultados" runat="Server">
               
        </asp:Panel>
        
    </div>
    
</body>
</html>
