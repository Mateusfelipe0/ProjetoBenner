<%@ Page Title="Galeria de entidades" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EntitiesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDENTIDADES" Title="Entidades" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Entity.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="50" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="False" CanUpdate="False" CanDelete="False" ChromeState="Fixed" EntityViewName="W_ENTIDADES.GRID" ShowTitle="True" />
    </div>
</asp:Content>
