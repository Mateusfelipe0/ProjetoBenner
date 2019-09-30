<%@ Page Title="Grupos" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ZGroupsPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
      <asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
    <wes:AjaxForm runat="server" ID="GRUPO" Title="Grupo" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="6" FontIcon="" ShowTitle="true" ProviderWidgetUniqueId="" ChromeState="Normal" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_GRUPOS.FORM" FormMode="ReadOnly" IncludeRecordInRecentItems="True" UserDefinedCommandsVisible="True" PageId="GROUPFORM" Level="15" Order="110"  />
      <div class="col-md-6"><div class="portlet light">
    <div class="tabbable-line">
      <ul class="nav nav-tabs">
        <li onclick="Benner.Page.changeSelectedTab(this)" data-widget-id="USUARIO" class="active"><a data-toggle="tab" href="#tabUSUARIO">Usuários</a></li>
        <li onclick="Benner.Page.changeSelectedTab(this)" data-widget-id="PAPEISATRIBUIDOS"><a data-toggle="tab" href="#tabPAPEISATRIBUIDOS">Papéis atribuídos</a></li>
        <li onclick="Benner.Page.changeSelectedTab(this)" data-widget-id="GRUPOSINCLUIDOS"><a data-toggle="tab" href="#tabGRUPOSINCLUIDOS">Grupos incluídos</a></li>
        <li onclick="Benner.Page.changeSelectedTab(this)" data-widget-id="FILTRODEREGITRO"><a data-toggle="tab" href="#tabFILTRODEREGITRO">Filtro de registro</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tabUSUARIO">
                    <div class="row">
    <wes:SimpleGrid runat="server" ID="USUARIO" Title="Usuários" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="false" ProviderWidgetUniqueId="GRUPO" ChromeState="Fixed" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_GRUPOUSUARIOS.MODAL.GRID" Mode="Search" UserDefinedSelectColumnVisible="False" UserDefinedPageSize="10" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" UserDefinedCriteriaWhereClause="A.GRUPO = @CAMPO(HANDLE)" FormUrl="~/SiteSettings/GroupUsers/Form.aspx" ShowExport="True" UserDefinedDisableRowSelection="False" PageId="GROUPFORM" Level="15" Order="120"  /></div>
        </div>
        <div class="tab-pane" id="tabPAPEISATRIBUIDOS">
                    <div class="row">
    <wes:EditableGrid runat="server" ID="PAPEISATRIBUIDOS" Title="Papéis atribuídos" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="false" ProviderWidgetUniqueId="GRUPO" ChromeState="Minimized" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_PAPELATRIBUICOES.GRUPO.PAPEL.GRID" Mode="None" UserDefinedSelectColumnVisible="False" UserDefinedPageSize="10" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" UserDefinedCriteriaWhereClause="A.GRUPO = @CAMPO(HANDLE) AND A.TIPOOBJETO = 1" PageId="GROUPFORM" Level="15" Order="130"  /></div>
        </div>
        <div class="tab-pane" id="tabGRUPOSINCLUIDOS">
                    <div class="row">
    <wes:EditableGrid runat="server" ID="GRUPOSINCLUIDOS" Title="Grupos incluídos" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="false" ProviderWidgetUniqueId="GRUPO" ChromeState="Minimized" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_GRUPOGRUPOS.GRID" Mode="None" UserDefinedSelectColumnVisible="False" UserDefinedPageSize="10" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" UserDefinedCriteriaWhereClause="A.GRUPO = @CAMPO(HANDLE)" PageId="GROUPFORM" Level="15" Order="140"  /></div>
        </div>
        <div class="tab-pane" id="tabFILTRODEREGITRO">
                    <div class="row">
    <wes:SimpleGrid runat="server" ID="FILTRODEREGITRO" Title="Filtro de registro" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="false" ProviderWidgetUniqueId="GRUPO" ChromeState="Minimized" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_FILTROS.GRID" Mode="None" UserDefinedSelectColumnVisible="False" UserDefinedPageSize="10" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" UserDefinedCriteriaWhereClause="A.GRUPO = @CAMPO(HANDLE) AND A.CATEGORIA = 2" FormUrl="~/SiteSettings/RecordsFilter/Form.aspx" ShowExport="True" UserDefinedDisableRowSelection="False" PageId="GROUPFORM" Level="15" Order="150"  /></div>
        </div>
      </div>
    </div>
  </div>
</div></div>
      </asp:Content>
    