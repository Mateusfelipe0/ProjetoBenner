<%@ Page Title="E-mails" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EmailGridPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <script>
        function changeTab(currentTab) {
            $('#CurrentTabHiddenField').val(currentTab);
        }
    </script>
    <div class="portlet light">
        <asp:HiddenField ID="CurrentTabHiddenField" Value="enviado" runat="server" ClientIDMode="Static" />
        <asp:UpdatePanel runat="server" ID="BadgeTabsPanel" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="tabbable-line">
                    <ul class="nav nav-tabs">
                        <li class="active" onclick="changeTab('enviado')" id="liEnviado" runat="server">
                            <a href="#tabEnviado" data-toggle="tab">Enviado
                            <asp:Label CssClass="badge badge-success" runat="server" ID="lbNumEnviado"></asp:Label></a>
                        </li>
                        <li onclick="changeTab('aguardando')" id="liAguardando" runat="server">
                            <a href="#tabAguardando" data-toggle="tab">Aguardando envio
                            <asp:Label CssClass="badge badge-info" runat="server" ID="lbNumAguardandoEnvio"></asp:Label></a>
                        </li>
                        <li onclick="changeTab('cadastrado')" id="liCadastrado" runat="server">
                            <a href="#tabCadastrado" data-toggle="tab">Cadastrado
                            <asp:Label CssClass="badge badge-default" runat="server" ID="lbNumCadastrado"></asp:Label></a>
                        </li>
                        <li onclick="changeTab('cancelado')" id="liCancelado" runat="server">
                            <a href="#tabCancelado" data-toggle="tab">Cancelado
                            <asp:Label CssClass="badge badge-warning" runat="server" ID="lbNumCancelado"></asp:Label></a>
                        </li>
                        <li onclick="changeTab('erro')" id="liErro" runat="server">
                            <a href="#tabErro" data-toggle="tab">Com erro
                            <asp:Label CssClass="badge badge-danger" runat="server" ID="lbNumComErro"></asp:Label></a>
                        </li>
                    </ul>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="tab-content">
            <div class="tab-pane active" id="tabEnviado">
                <div class="row">
                    <wes:SimpleGrid runat="server" ID="GridEnviado" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Email/Form.aspx" UserDefinedCriteriaWhereClause="A.STATUS = 4" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="False" CanDelete="True" ShowTitle="False" ChromeState="Fixed" EntityViewName="Z_EMAILS.GRID" />
                </div>
            </div>
            <div class="tab-pane" id="tabAguardando">
                <div class="row">
                    <wes:SimpleGrid runat="server" ID="GridAguardando" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Email/Form.aspx" UserDefinedCriteriaWhereClause="A.STATUS = 2" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="False" CanDelete="True" ShowTitle="False" ChromeState="Fixed" EntityViewName="Z_EMAILS.GRID" />
                </div>
            </div>
            <div class="tab-pane" id="tabCadastrado">
                <div class="row">
                    <wes:SimpleGrid runat="server" ID="GridCadastrado" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Email/Form.aspx" UserDefinedCriteriaWhereClause="A.STATUS = 1" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="False" ChromeState="Fixed" EntityViewName="Z_EMAILS.GRID" />
                </div>
            </div>
            <div class="tab-pane" id="tabCancelado">
                <div class="row">
                    <wes:SimpleGrid runat="server" ID="GridCancelado" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Email/Form.aspx" UserDefinedCriteriaWhereClause="A.STATUS = 5" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="False" CanDelete="True" ShowTitle="False" ChromeState="Fixed" EntityViewName="Z_EMAILS.GRID" />
                </div>
            </div>
            <div class="tab-pane" id="tabErro">
                <div class="row">
                    <wes:SimpleGrid runat="server" ID="GridErro" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Email/Form.aspx" UserDefinedCriteriaWhereClause="A.STATUS = 6" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="True" CanDelete="True" ShowTitle="False" ChromeState="Fixed" EntityViewName="Z_EMAILS.GRID" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
