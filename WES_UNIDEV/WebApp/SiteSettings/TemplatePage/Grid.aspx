<%@ Page Title="Template de páginas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635876997543273851"  Title="Template de páginas" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/TemplatePage/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="W_PAGINATEMPLATES.GRID" ShowTitle="True" />
    </div>
</asp:Content>
   