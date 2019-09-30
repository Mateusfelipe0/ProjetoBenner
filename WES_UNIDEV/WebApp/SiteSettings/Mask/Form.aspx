<%@ Page Title="Máscaras de tabelas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.MaskFormPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormMascaraTabelas"  Title="Máscaras de tabelas" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_MASCARAS.FORM" ShowTitle="True" />
        <wes:EditableGrid runat="server" ID="GridMascaraGrupo"  Title="Grupos" BootstrapCols="12" FormUrl="" UserDefinedCriteriaWhereClause="A.MASCARA = @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_MASCARAGRUPOS.GRID" ShowTitle="True" />
    </div>   
    <script runat="server">
     protected override void LoadWebPartConnections()
     {
       AddWebPartStaticConnection("FormMascaraTabelasGridMascaraGrupo", "FormMascaraTabelas", "GridMascaraGrupo");
     }
    </script>
</asp:Content>
   