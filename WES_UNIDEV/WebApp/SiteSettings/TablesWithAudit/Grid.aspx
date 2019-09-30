<%@ Page Title="Tabelas com auditoria" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
    
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
      
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635838845846085458"  Title="Tabelas com auditoria" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/TablesWithAudit/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_TABELASCOMAUDITORIA.GRID" />
    </div>
</asp:Content>
    