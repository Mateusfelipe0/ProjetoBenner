<%@ Page Title="Tabelas com empresa mestre" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:EditableGrid runat="server" ID="WIDGETID_635925348881445706"  Title="Tabelas com empresa mestre" BootstrapCols="12" FormUrl="~/SiteSettings/TableMasterCompany/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_TABELASCOMEMPRESAMESTRE.GRID" ShowTitle="True" />
    </div>
</asp:Content>
   