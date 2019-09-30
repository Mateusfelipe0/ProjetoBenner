<%@ Page Title="Classificações" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ReportClassifyPage" %>
    
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
      
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GridClassificacao"  Title="Lista de Classificações" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="R_CLASSIFICACOES.GRID" />
        <wes:AjaxForm runat="server" ID="FormClassificacao"  Title="Detalhes" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="R_CLASSIFICACOES.FORM" />
    </div>    
    <script runat="server">
      protected override void LoadWebPartConnections()
      {
          AddWebPartStaticConnection("ClassificacaoLigacao", "GridClassificacao", "FormClassificacao");
      }
    </script>
</asp:Content>
    