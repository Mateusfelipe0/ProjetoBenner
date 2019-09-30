<%@ Page Title="Visões" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ViewsPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDVISOES" Title="Visões" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/View.aspx" UserDefinedCriteriaWhereClause="A.CAMADA &gt; 0" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="50" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="False" CanUpdate="False" CanDelete="False" ChromeState="Fixed" EntityViewName="W_ENTIDADEVISOES.GRID" ShowTitle="True" />
    </div>
</asp:Content>
