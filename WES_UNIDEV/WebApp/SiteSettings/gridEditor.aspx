<%@ Page Title="Editor de visão de grid" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.GridEditorPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>
<%@ Register Src="~/uc/EntityFieldList.ascx" TagName="EntityFieldList" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/GridProperties.ascx" TagName="GridProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/GridFieldNavigator.ascx" TagName="GridFieldNavigator" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/GridFieldProperties.ascx" TagName="GridFieldProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/LookupResultFieldList.ascx" TagName="LookupResultFieldList" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="portlet light">
                <div class="portlet-title">
                    <div class="caption">
                        <span class="caption-subject font-green-sharp bold uppercase">Editor de grid</span>
                    </div>
                    <div class="actions">
                        <div class="btn-group">
                            <a href="http://wiki.benner.com.br/wiki/index.php?title=Categoria%3AVis%C3%B5es_-_WES" class="no-border btn btn-circle btn-default btn-sm" target="_blank">
                                <i class="fa fa-question-circle"></i>
                            </a>
                        </div>
                        <wes:WidgetActionsMenu ID="developerMenu" runat="server" />
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:LinkButton ID="lnkBtnSave" CssClass="btn blue command-action predef-action" runat="server"><i class="fa fa-check btn-action"></i>Salvar</asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnShowXml" CssClass="btn default command-action predef-action" runat="server" OnClick="OnShowXml"><i class="fa fa-code btn-action"></i>XML</asp:LinkButton>

                        <div class="btn-group command-action custom-action hidden-lg" id="addGroup" style="display:inline-block;">
                            <a class="btn green dropdown-toggle hover-initialized" data-toggle="dropdown" data-hover="dropdown"><i class="fa fa-plus btn-action"></i>Adicionar <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu break-lines" role="menu" style="width: 150px;">
                                <li><a id="btnAddField" class="green" onclick="openScreenAddFields()" data-toggle="modal">Campos</a></li>
                                <li><asp:LinkButton ID="btnAddPathField" CssClass="green" runat="server" OnClick="OnAddPathField">Traduzido</asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAddSqlField" CssClass="green" runat="server" OnClick="OnAddSQLField">SQL</asp:LinkButton></li>
                                <li><asp:LinkButton ID="btnAddLabel" CssClass="green" runat="server" OnClick="OnAddLabelField">Customizado</asp:LinkButton></li>
                            </ul>
                        </div>

                        <div class="predef-action hidden-md hidden-sm hidden-xs" style="display:inline-block;vertical-align:middle;">
                            <a id="btnAddFieldWide" class="btn green" onclick="openScreenAddFields()" data-toggle="modal"><i class="fa fa-plus btn-action"></i>Campos</a>
                            <asp:LinkButton ID="btnAddPathFieldWide" CssClass="btn green" runat="server" OnClick="OnAddPathField"><i class="fa fa-plus btn-action"></i>Traduzido</asp:LinkButton>
                            <asp:LinkButton ID="btnAddSqlFieldWide" CssClass="btn green" runat="server" OnClick="OnAddSQLField"><i class="fa fa-plus btn-action"></i>Campo SQL</asp:LinkButton>
                            <asp:LinkButton ID="btnAddLabelWide" CssClass="btn green" runat="server" OnClick="OnAddLabelField"><i class="fa fa-plus btn-action"></i>Customizado</asp:LinkButton>
                        </div>

                        <div class="btn-group predef-action">
                            <asp:LinkButton ID="btnLeft" CssClass="btn btn-default" runat="server" OnClick="OnLeftClick"><i class="fa fa fa-arrow-left"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnRight" CssClass="btn btn-default" runat="server" OnClick="OnRightClick"><i class="fa fa fa-arrow-right"></i></asp:LinkButton>
                        </div>

                        <asp:LinkButton ID="btnDel" runat="server" CssClass="btn red predef-action" OnClick="OnDeleteClick"><i class="fa fa-minus"></i></asp:LinkButton>

                        <asp:LinkButton ID="togglePropertiesMenu" runat="server" CssClass="btn white predef-action pull-right" OnClientClick="toggleHiddenField('gridEditorPropertiesVisible')"><i class="fa fa-bars"></i></asp:LinkButton>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel ID="messageUpdatePanel" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <wes:MessagePanel ID="messagePanel" runat="server"></wes:MessagePanel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <div class="row grid-editor-panel">
                        <div class="<%=(gridEditorPropertiesVisible.Value == "0" ? "col-xs-12" : "col-md-9 col-xs-8")%> form-editor-grid">
                            <div class="portlet">
                                <div class="portlet-body">
                                    <div class="table-scrollable">
                                        <asp:GridView ID="grid" runat="server" AutoGenerateColumns="false" AllowSorting="true">
                                            <HeaderStyle />
                                            <RowStyle />
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-xs-4 grid-editor-properties <%=(gridEditorPropertiesVisible.Value == "0" ? "hidden" : "")%>">
                            <asp:HiddenField ID="gridEditorPropertiesVisible" ClientIDMode="Static" runat="server" Value="1" />
                            <asp:HiddenField ID="gridEditorPropertiesTab" ClientIDMode="Static" runat="server" Value="0" />
                            <div class="tabContainer">
                                <ul class="nav nav-tabs">
                                    <li class="<%=GetClass("0")%>"><a href="#fieldPropertiesTab" data-toggle="tab" onclick="Benner.Form.UpdateHiddenActiveTabPageIndex('gridEditorPropertiesTab', 0);">Campo</a></li>
                                    <li class="<%=GetClass("1")%>"><a href="#gridPropertiesTab" data-toggle="tab" onclick="Benner.Form.UpdateHiddenActiveTabPageIndex('gridEditorPropertiesTab', 1);">Grid</a></li>
                                </ul>
                                <div>
                                    <div class="tab-content allow-focus">
                                        <div id="fieldPropertiesTab" class="tab-pane <%=GetClass("0")%>">
                                            <wesUserControl:GridFieldProperties ID="GridDefFields1" runat="server" EnableViewState="true" />
                                        </div>
                                        <div id="gridPropertiesTab" class="tab-pane <%=GetClass("1")%>">
                                            <wesUserControl:GridProperties ID="GridDefProp1" runat="server" EnableViewState="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="listFields" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <wesUserControl:EntityFieldList ID="gridListFields1" Title="Campos" runat="server" />
                    </div>
                </div>
            </div>
            <div class="modal fade" id="lookupResultFields" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <wesUserControl:LookupResultFieldList ID="lookupResultFieldList" Title="Campos de resultado" EnableViewState="true" runat="server" />
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    if (!prm.get_isInAsyncPostBack()) {
                        prm.add_endRequest(Benner.Development.gridEditorInit);
                        prm.add_endRequest(resetDropdownHover)
                    }
                    Benner.Development.gridEditorInit();
                });

                function resetDropdownHover() {
                    $('.dropdown-toggle.hover-initialized').dropdownHover();
                }

                function openScreenAddFields() {
                    $('#listFields').modal('show');
                }

                function toggleHiddenField(fieldName) {
                    var currValue = parseInt($('#' + fieldName).val());
                    if (currValue > 0)
                        Benner.Form.UpdateHiddenActiveTabPageIndex(fieldName, 0);
                    else
                        Benner.Form.UpdateHiddenActiveTabPageIndex(fieldName, 1);
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script runat="server">
        public string GetClass(string index)
        {
            if (gridEditorPropertiesTab.Value == index)
                return "active";

            return string.Empty;
        }
    </script>
</asp:Content>
