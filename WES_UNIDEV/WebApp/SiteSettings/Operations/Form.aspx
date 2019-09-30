<%@ Page Title="Operações" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.OperationFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FORMWIDGET_635839563795657264" Title="Operações" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="False" CanUpdate="False" CanDelete="False" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_OPERACOES.FORM" />
        <wes:EditableGrid runat="server" ID="WIDGETID_635851056583971512" Title="Tarefas que incluem a operação" BootstrapCols="12" FormUrl="" UserDefinedCriteriaWhereClause="A.OPERACAO = @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_TAREFAOPERACOES.GRID"/>
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FORMWIDGET_635839563795657264WIDGETID_635851056583971512", "FORMWIDGET_635839563795657264", "WIDGETID_635851056583971512");
        }
    </script>
</asp:Content>
