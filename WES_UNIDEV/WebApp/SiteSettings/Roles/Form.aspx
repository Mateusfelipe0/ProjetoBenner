<%@ Page Title="Papéis" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ZRolesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormRoles" Title="Papéis" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_PAPEIS.FORM" />
        <div class="col-md-12 widget">
            <div class="tabbable-line">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tabTarefas" data-toggle="tab">Tarefas</a>
                    </li>
                    <li>
                        <a href="#tabGrupos" data-toggle="tab">Grupos</a>
                    </li>
                    <li>
                        <a href="#tabUsuarios" data-toggle="tab">Usuários</a>
                    </li>
                    <li>
                        <a href="#tabPapeis" data-toggle="tab">Papéis incluídos</a>
                    </li>
                    <li>
                        <a href="#tabPapeisQueIncluem" data-toggle="tab">Papéis que incluem este papel</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tabTarefas">
                        <div class="row">
                            <wes:EditableGrid runat="server" ID="GridTaskAssigned" ShowTitle="false" Mode="Search" Title="Tarefas atribuídas" EntityViewName="Z_PAPELTAREFAS.GRID"
                                UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE)" />
                        </div>
                    </div>
                    <div class="tab-pane" id="tabGrupos">
                        <div class="row">
                            <wes:EditableGrid runat="server" Mode="Search" ID="GridGroup" ShowTitle="false" Title="Papéis atribuídos" EntityViewName="Z_PAPELATRIBUICOES.GRUPO.GRID"
                                UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE) AND TIPOOBJETO = 1" />
                        </div>
                    </div>
                    <div class="tab-pane" id="tabUsuarios">
                        <div class="row">
                            <wes:EditableGrid runat="server" ID="GridUser" Mode="Search" ShowTitle="false" Title="Usuarios" BootstrapCols="12" EntityViewName="Z_PAPELATRIBUICOES.USUARIO.GRID"
                                UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE) AND TIPOOBJETO = 2" />
                        </div>
                    </div>
                    <div class="tab-pane" id="tabPapeis">
                        <div class="row">
                            <wes:EditableGrid runat="server" ID="GridRolesAssigned" ShowTitle="false" Title="Papéis incluídos" EntityViewName="Z_PAPELPAPEIS.GRID"
                                UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE)" />
                        </div>
                    </div>
                    <div class="tab-pane" id="tabPapeisQueIncluem">
                        <div class="row">
                            <wes:SimpleGrid runat="server" ID="GridRolesAssignedRoles" ShowTitle="false" Title="Papéis que incluem este papel" EntityViewName="Z_PAPELPAPEIS.PAPEL.GRID" UserDefinedCriteriaWhereClause="A.PAPELINCLUIDO = @CAMPO(HANDLE)" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormRolesGridTaskAssigned", "FormRoles", "GridTaskAssigned");
            AddWebPartStaticConnection("FormRolesGridRolesAssigned", "FormRoles", "GridRolesAssigned");
            AddWebPartStaticConnection("GridRolesUsers", "FormRoles", "GridUser");
            AddWebPartStaticConnection("GridRolesGroup", "FormRoles", "GridGroup");
            AddWebPartStaticConnection("GridRolesGridRolesAssignedRoles", "FormRoles", "GridRolesAssignedRoles");
        }
    </script>
</asp:Content>
