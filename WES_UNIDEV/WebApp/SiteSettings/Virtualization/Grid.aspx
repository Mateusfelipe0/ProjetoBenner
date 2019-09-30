<%@ Page Title="Virtualização" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
       <wes:SimpleGrid runat="server" ID="WIDGETID_635925364707046866"  Title="Virtualização" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Virtualization/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="True" CanDelete="False" ChromeState="Fixed" EntityViewName="Z_VIRTUALIZACAODBPROVEDORES.GRID" ShowTitle="True" />
    </div>
</asp:Content>
   