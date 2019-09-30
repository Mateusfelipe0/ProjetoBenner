<%@ Page Title="Agendamentos" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormAgendamento" Title="Agendamento" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_AGENDAMENTOS.FORM" />
        <wes:SimpleGrid runat="server" ID="GridLogs" Title="Logs" EntityViewName="Z_AGENDAMENTOLOG.GRID" DefaultFilterName="Filtro padrão" Mode="Selectable" UserDefinedCriteriaWhereClause="A.AGENDAMENTO = @CAMPO(HANDLE)" CanDelete="false" CanInsert="false" CanUpdate="false" FormUrl="~/SiteSettings/Schedules/Logs.aspx" />
    </div>

    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("AgendamentoLos", "FormAgendamento", "GridLogs");
        }
    </script>

    <script>
        $(function () {
            var removeTabTipo = function () {
                $('*[data-field="TIPO"]').find('h4.radio-list').first().hide();
            }

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (!prm.get_isInAsyncPostBack(0)) {
                prm.add_endRequest(removeTabTipo);

            }
            removeTabTipo();
        });

    </script>
</asp:Content>
