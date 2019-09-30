<%@ Page Title="Tarefas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.TaskFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormTask" Title="Tarefa" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_TAREFAS.FORM" />
        <div class="col-md-12 widget">
            <div class="portlet light">
                <div class="tabbable-line">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#tabOperacoes" data-toggle="tab">Operações</a>
                        </li>
                        <li>
                            <a href="#tabPaginas" data-toggle="tab">Páginas</a>
                        </li>
                        <li>
                            <a href="#tabRelatorios" data-toggle="tab">Relatórios</a>
                        </li>
                        <li>
                            <a href="#tabComponenteNegocios" data-toggle="tab">Componentes</a>
                        </li>
                        <li>
                            <a href="#tabProcessosServidor" data-toggle="tab">BTL</a>
                        </li>
                        <li>
                            <a href="#tabTarefasIncluidas" data-toggle="tab">Tarefas incluídas</a>
                        </li>
                        <li>
                            <a href="#tabPapeisTarefa" data-toggle="tab">Papéis com esta tarefa</a>
                        </li>
                        <li>
                            <a href="#tabTarefasQueIncluem" data-toggle="tab">Tarefas que incluem esta tarefa</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabOperacoes">
                            <div class="row">
                                <wes:CustomUserControl runat="server" ID="GridTaskOperations" Title="Operações" BootstrapCols="12" UserControlName="~/SiteSettings/Task/AddOperationsTask.ascx" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="false" ChromeState="Fixed" EntityViewName="" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabPaginas">
                            <div class="row">
                                <wes:EditableGrid runat="server" ID="GridTaskPages" EntityViewName="W_TAREFAPAGINAS.GRID" ShowTitle="false" Title="Lista de páginas"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabRelatorios">
                            <div class="row">
                                <wes:EditableGrid runat="server" ID="GridTaskReports" EntityViewName="R_TAREFARELATORIOS.GRID" ShowTitle="false" Title="Lista de relatórios"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabComponenteNegocios">
                            <div class="row">
                                <wes:SimpleGrid runat="server" ID="GridTaskComponentBusiness" EntityViewName="Z_TAREFACOMPONENTESNEGOCIO.GRID" ShowTitle="false" Title="Lista de componentes de negócio"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" FormUrl="~/SiteSettings/TaskComponentsBusiness/Form.aspx" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabProcessosServidor">
                            <div class="row">
                                <wes:SimpleGrid runat="server" ID="GridTaskProcess" EntityViewName="Z_TAREFAPROCESSOS.GRID" ShowTitle="false" Title="Lista de processos de servidor (BTL)"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" FormUrl="~/SiteSettings/TaskProcess/Form.aspx" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabTarefasIncluidas">
                            <div class="row">
                                <wes:EditableGrid runat="server" ID="GridTaskIncluded" ShowTitle="false" EntityViewName="Z_TAREFATAREFAS.GRID"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabPapeisTarefa">
                            <div class="row">
                                <wes:SimpleGrid runat="server" ID="GridRoles" ShowTitle="false" EntityViewName="Z_PAPELTAREFAS.PAPEL.GRID"
                                    UserDefinedCriteriaWhereClause="A.TAREFA = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabTarefasQueIncluem">
                            <div class="row">
                                <wes:SimpleGrid runat="server" ID="GridTaskIncludedTask" ShowTitle="false" EntityViewName="Z_TAREFATAREFAS.TAREFA.GRID"
                                    UserDefinedCriteriaWhereClause="A.TAREFAINCLUIDA = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormTaskGridTaskOperations", "FormTask", "GridTaskOperations");
            AddWebPartStaticConnection("FormTaskGridTaskPages", "FormTask", "GridTaskPages");
            AddWebPartStaticConnection("FormTaskGridTaskReports", "FormTask", "GridTaskReports");
            AddWebPartStaticConnection("FormTaskGridTaskComponentBusiness", "FormTask", "GridTaskComponentBusiness");
            AddWebPartStaticConnection("FormTaskGridTaskProcess", "FormTask", "GridTaskProcess");
            AddWebPartStaticConnection("FormTaskGridTaskIncluded", "FormTask", "GridTaskIncluded");
            AddWebPartStaticConnection("FormTasGridRoles", "FormTask", "GridRoles");
            AddWebPartStaticConnection("FormTasGridTaskIncludedTask", "FormTask", "GridTaskIncludedTask");
        }
    </script>
</asp:Content>
