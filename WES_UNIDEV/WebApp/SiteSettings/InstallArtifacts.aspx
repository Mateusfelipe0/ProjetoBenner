<%@ Page Title="Instalação de artefatos" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.InstallArtifactsPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <style>
        th {
            border-top: none !important;
        }

        tr td:first-child,
        tr th:first-child {
            width: 1px;
            text-align: center;
        }

        .boolean-control.mt-checkbox.mt-checkbox-outline {
            margin-top: 0px;
        }
        .list-commands-bar > label {
            margin-left:50px;
            margin-right:5px;
        }
        .tooltip.fade.top {
            z-index:9999;
        }

    </style>
    <asp:UpdatePanel runat="server" ID="upInstaller" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Timer runat="server" ID="refreshTimer" Enabled="false" Interval="1000"></asp:Timer>
            <div class="portlet light">
                <div class="portlet-title">
                    <div class="caption">
                        <span class="caption-subject font-green-sharp bold uppercase">
                            <asp:Label runat="server" ID="lblArtifactsInstall" Text="Instalação de artefatos" /></span>
                    </div>
                </div>
                <div class="portlet-body form">
                    <asp:Panel runat="server" ID="commandsPanel" class="form-actions top nobg no-border commands-bar fluid list-commands-bar row">
                        <asp:LinkButton runat="server" ID="btnInstall" CssClass="btn blue" ClientIDMode="Static" OnClientClick="installArtifacts();"><i class="fa fa-bolt btn-action"></i> Instalar todos</asp:LinkButton>
                        <asp:CheckBox runat="server" ID="ckbInstallCustomerArtifacts" Checked="false" OnCheckedChanged="CkbInstallCustomerArtifacts_Changed" AutoPostBack="true" ClientIDMode="Static" Text="Instalar artefatos de camada cliente" /><i class="fa fa-question-circle help-tooltip" data-original-title="Você só deve ativar esta opção se estiver instalando artefatos de camada cliente gerados em outro ambiente. Atenção! Se foram feitas customizações diretamente neste ambiente elas serão sobrescritas."></i>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-12">
                            <wes:ExceptionMessageViewerControl TruncateMessage="false" runat="server" ID="exceptionViewer"></wes:ExceptionMessageViewerControl>
                        </div>
                    </div>
                    <asp:Panel runat="server" ID="stepsPanel" class="mt-element-step">
                        <div class="row step-line">
                            <div class="col-md-4 mt-step-col first <%= GetStepClass(1) %>">
                                <div class="mt-step-number bg-white">1</div>
                                <div class="mt-step-title uppercase font-grey-cascade">Atualização <%= GetStepIcon(1) %></div>
                                <div class="mt-step-content font-grey-cascade"><%= LanguageTranslator.Translate(GetStepDescription(1)) %></div>
                            </div>
                            <div class="col-md-4 mt-step-col <%= GetStepClass(2) %>">
                                <div class="mt-step-number bg-white">2</div>
                                <div class="mt-step-title uppercase font-grey-cascade">Exclusão <%= GetStepIcon(2) %></div>
                                <div class="mt-step-content font-grey-cascade"><%= LanguageTranslator.Translate(GetStepDescription(2)) %></div>
                            </div>
                            <div class="col-md-4 mt-step-col last <%= GetStepClass(3) %>">
                                <div class="mt-step-number bg-white">3</div>
                                <div class="mt-step-title uppercase font-grey-cascade">Geração de páginas <%= GetStepIcon(3) %></div>
                                <div class="mt-step-content font-grey-cascade"><%= LanguageTranslator.Translate(GetStepDescription(3)) %></div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="gridsPanel" class="row">
                        <div class="col-md-12">
                            <div class="filter-search-form note note-info note-bordered">
                                <asp:DropDownList CssClass="form-control" runat="server" ID="ddlFilterLevel" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <br />
                        </div>
                        <div class="col-md-12">
                            <div class="tabbable">
                                <ul class="nav nav-tabs" id="guias">
                                    <li class="dropdown pull-right tabdrop"></li>
                                    <li class="active"><a href="#tabWidgets" data-toggle="tab">Widgets</a></li>
                                    <li><a href="#tabTemplates" data-toggle="tab">Templates</a></li>
                                    <li><a href="#tabPages" data-toggle="tab">Páginas</a></li>
                                    <li><a href="#tabMenus" data-toggle="tab">Menus</a></li>
                                    <li><a href="#tabTasks" data-toggle="tab">Tarefas</a></li>
                                    <li><a href="#tabRoles" data-toggle="tab">Papéis</a></li>
                                    <li><a href="#tabViews" data-toggle="tab">Visões</a></li>
                                    <li><a href="#tabScripts" data-toggle="tab">Scripts</a></li>
                                    <li><a href="#tabFilters" data-toggle="tab">Filtros</a></li>
                                    <li><a href="#tabDataSources" data-toggle="tab">Consultas</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tabWidgets">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridWidgets" data-type="6">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabTemplates">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridTemplates" data-type="5">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabPages">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridPages" data-type="3">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabMenus">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridMenus" data-type="1">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabTasks">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridTasks" data-type="7">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabRoles">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridRoles" data-type="8">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabViews">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridViews" data-type="4">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabScripts">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridScripts" data-type="9">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabFilters">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridFilters" data-type="10">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                    <div class="tab-pane" id="tabDataSources">
                                        <asp:GridView runat="server" ClientIDMode="Static" ID="gridDataSources" data-type="11">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" CssClass="chk-all" runat="server" onclick="checkboxAll(this)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkInstall" CssClass="chk-install" runat="server" onclick="checkboxClicked(this)" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderStyle-CssClass="column-action" ItemStyle-CssClass="column-action" HeaderText="Ações" />
                                                <asp:BoundField DataField="Status" HeaderText="Comparação" />
                                                <asp:BoundField DataField="Camada" HeaderText="Camada" />
                                                <asp:BoundField DataField="ArtifactName" HeaderText="Identificador" />
                                                <asp:BoundField DataField="InstallMessage" HeaderText="Status" />
                                            </Columns>
                                            <FooterStyle />
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        function initializeTabs() {
            var hasCheckedArtifats = $('.chk-install:checked').length > 0;
            $("#guias > li > a").each(function () {
                var tabPaneId = $(this).attr("href");

                if ($(tabPaneId).length == 0)
                    return;

                var gridViewId = tabPaneId.replace("#tab", "#grid");
                var badgetValue = $(gridViewId).data("badge");
                $(this).find(".badge").remove();

                var checkedArtifacts = $(tabPaneId + " .chk-install:checked").length;

                //atualiza o número de itens selecionados
                if (checkedArtifacts > 0)
                    $(this).append(' <span class="badge badge-info">' + checkedArtifacts + '</span>');
                else if (!hasCheckedArtifats && badgetValue > 0)
                    $(this).append(' <span class="badge badge-default">' + badgetValue + '</span>');

            });
            $('.nav-pills, .nav-tabs').tabdrop({ text: 'Mais' });

            updateInstallButton();
        };

        function installArtifacts() {
            App.blockUI({
                target: 'body',
                animate: true
            });
        }

        function viewDifference(control) {
            var type = $(control).data('type');
            var name = $(control).data('name');
            var layer = $(control).data('layer');
            Benner.ModalPage.show(
                {
                    id: 'compare_artifact',
                    title: name + " (Base de dados < Arquivo local)",
                    displayTitle: true,
                    url: Benner.Page.getApplicationPath() + 'SiteSettings/compareartifact.aspx?imp=1&type=' + type + '&name=' + name + '&layer=' + layer,
                    size: 'fullpage',
                    displayFooter: false,
                    height: parseInt($(window).height() * 0.8) - 25,
                    generateDefaultContent: true,
                });
        };

        var selectCurrentStep = function () {
            var currentStep = localStorage.getItem("CurrentInstallTab");
            $(".nav-tabs a[href$=\"" + currentStep + "\"]").tab("show");
        };

        $(function () {
            $('.nav-tabs a').click(function (e) {
                localStorage.setItem("CurrentInstallTab", this.hash);
            });

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (!prm.get_isInAsyncPostBack()) {
                prm.add_endRequest(function (sender, args) {
                    selectCurrentStep();
                    initializeTabs();
                });
            }

            selectCurrentStep();
            initializeTabs();
        });

        function checkboxAll(element) {
            var tab = $(element).closest("div.tab-pane");
            tab.find('.chk-install').prop('checked', $(element).is(':checked'));

            initializeTabs();
        }

        function updateInstallButton() {
            //atualiza o label do botão de instalar
            if ($(".chk-install:checked").length == 0) {
                $("#btnInstall").html('<i class="fa fa-bolt btn-action"></i> Instalar todos');
            }
            else {
                $("#btnInstall").html('<i class="fa fa-bolt btn-action"></i> Instalar selecionado(s)');
            }
        }

        function checkboxClicked(element) {
            //troca a cor
            $(element).parents("tr").toggleClass("active");

            initializeTabs();
        }
        function getArtifactType(id) {
            switch (id) {
                case (1): return "Menu"; break;
                case (3): return "Página"; break;
                case (4): return "Visão"; break;
                case (5): return "Template"; break;
                case (6): return "Widget"; break;
                case (7): return "Tarefa"; break;
                case (8): return "Papel"; break;
                case (9): return "Script"; break;
                case (10): return "Filtro"; break;
                case (11): return "Consulta"; break;
            }
        }
    </script>
</asp:Content>
