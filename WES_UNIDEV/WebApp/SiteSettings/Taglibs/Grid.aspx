<%@ Page Title="Taglibs" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635907774962910689" Title="Taglibs" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="W_TAGLIBS.GRID" ShowTitle="True" />
        <wes:AjaxForm runat="server" ID="WIDGETID_635907775548269266" Title="Taglibs" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="W_TAGLIBS.FORM" ShowTitle="True" />
    </div>

    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("GRIDWIDGET_635907774962910689WIDGETID_635907775548269266", "GRIDWIDGET_635907774962910689", "WIDGETID_635907775548269266");
        }
    </script>
</asp:Content>
