<%@ Page Title="Relatório" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EditWebReportPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm
            ShowTitle="true"
            Title="Relatório"
            IncludeRecordInRecentItems="true"
            runat="server"
            ID="FormReportWeb"
            EntityViewName="R_RELATORIOS.TEC.FORM" />

        <wes:EditableGrid runat="server" ID="GridReportTask" Title="Tarefas que dão acesso ao Relatório" BootstrapCols="12" FormUrl=""
            UserDefinedCriteriaWhereClause="A.RELATORIO = @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany"
            DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False"
            DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="true" ChromeState="Fixed"
            EntityViewName="R_TAREFARELATORIOS.RELATORIO.GRID" />
    </div>
    <script>
        $(function () {
            $($(".portlet-title>.actions")[0]).prepend("<div class='btn-group'><a href='http://wiki.benner.com.br/wiki/index.php?title=Categoria%3AReport' class='no-border btn btn-circle btn-default btn-sm' target='_blank'><i class='fa fa-question-circle'></i></a></div>");
        });
    </script>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormReportWebGridReportTask", "FormReportWeb", "GridReportTask");
        }
    </script>
</asp:Content>
