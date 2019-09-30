<%@ Page Title="Jargão" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.JargaoGridPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:EditableGrid runat="server" ID="GridJargao" Title="Jargão" BootstrapCols="12" FormUrl="" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Fixed" UserDefinedSelectColumnVisible="False" DefaultFilterName="Filtro" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_EMPRESATRADUCOES.GRID" ShowTitle="True" />
    </div>
</asp:Content>
