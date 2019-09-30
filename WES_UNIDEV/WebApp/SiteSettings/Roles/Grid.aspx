<%@ Page Title="Papéis" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GridRoles" Title="Papéis" BootstrapCols="5" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Roles/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="100" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_PAPEIS.GRID" />
        <div class="col-md-7 widget">
            <div class="portlet light">
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
                                <wes:SimpleGrid runat="server" ShowTitle="false" ID="GridTaskAssigned" Mode="Search" Title="Tarefas atribuídas" FormUrl="~/SiteSettings/RoleTask/Form.aspx" EntityViewName="Z_PAPELTAREFAS.GRID"
                                    UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE)" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabGrupos">
                            <div class="row">
                                <wes:EditableGrid runat="server" Mode="Search" ID="GridGroup" Title="Papéis atribuídos" EntityViewName="Z_PAPELATRIBUICOES.GRUPO.GRID"
                                    UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE) AND A.TIPOOBJETO = 1" ShowTitle="False" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabUsuarios">
                            <div class="row">
                                <wes:EditableGrid runat="server" Mode="Search" ID="GridUser" Title="Usuarios" BootstrapCols="12" EntityViewName="Z_PAPELATRIBUICOES.USUARIO.GRID"
                                    UserDefinedCriteriaWhereClause="A.PAPEL = @CAMPO(HANDLE) AND A.TIPOOBJETO = 2" ShowTitle="False" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabPapeis">
                            <div class="row">
                                <wes:EditableGrid runat="server" ShowTitle="false" ID="GridRolesAssigned" Title="Papéis incluídos" EntityViewName="Z_PAPELPAPEIS.GRID"
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
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormRolesGridTaskAssigned", "GridRoles", "GridTaskAssigned");
            AddWebPartStaticConnection("FormRolesGridRolesAssigned", "GridRoles", "GridRolesAssigned");
            AddWebPartStaticConnection("GridRolesUsers", "GridRoles", "GridUser");
            AddWebPartStaticConnection("GridRolesGroup", "GridRoles", "GridGroup");
            AddWebPartStaticConnection("GridRolesGridRolesAssignedRoles", "GridRoles", "GridRolesAssignedRoles");
        }
    </script>

</asp:Content>
