<%@ Page Title="Pesquisar" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.DefaultLookupSearch" %>

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
        .environment, .portlet-title {
            display: none;
        }
    </style>
</head>
<body class="lookup-search bg-white allow-focus">
    <div class="col-md-12">
        <form id="formMain" runat="server">
            <wes:WesManager ID="WesManager1" runat="server">
                <Scripts>
                </Scripts>
            </wes:WesManager>
			<asp:HiddenField runat="server" ClientIDMode="Static" ID="hidden_lookup_json"/>
            <div class="search-panel">
                <wes:LookupSearchGrid
                    runat="server"
                    ID="Resultado"
                    Title="Pesquisa"
                    ShowExport="false"
                    UserDefinedDisableRowSelection="True"
                    FormUrl=""
                    UserDefinedCriteriaWhereClause=""
                    UserDefinedDataSourceParameters=""
                    DisplayRowCommand="False"
                    SystemFilterOnly="False"
                    UserDefinedPageSize="9"
                    Mode="Search"
                    UserDefinedSelectColumnVisible="False"
                    DefaultFilterName=""
                    ShowTitle="False"
                    EntityViewName=""
                    PortletLayout="None"
                    HideDeveloperCommands="true" />
            </div>
        </form>
    </div>
    <script type="text/javascript">
        $(function () {
            parent.Benner.Apps.CustomLookup.init();
        });
    </script>
</body>
</html>
