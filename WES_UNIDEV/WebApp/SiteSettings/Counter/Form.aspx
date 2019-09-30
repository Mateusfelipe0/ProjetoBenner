<%@ Page Title="Contadores" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CounterFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormContador" Title="Contador" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_CONTADORES.FORM" />
        <wes:SimpleGrid runat="server" ID="GridContadorItens" Title="Itens" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/CounterItem/Form.aspx" UserDefinedCriteriaWhereClause="A.CONTADOR= @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Normal" EntityViewName="Z_CONTADORITENS.GRID" PageWidgetHandle="2999" />
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormContadorGridItens", "FormContador", "GridContadorItens");
        }
    </script>
</asp:Content>
