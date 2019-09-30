<%@ Page Title="Editor de visão de formulário" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FormEditorPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>
<%@ Register Src="~/uc/FormFieldProperties.ascx" TagName="FormFieldProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/FormProperties.ascx" TagName="FormProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityFieldList.ascx" TagName="EntityFieldList" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/FormLayout.ascx" TagName="FormLayout" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/PageProperties.ascx" TagName="PageProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/SectionProperties.ascx" TagName="SectionProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/LookupResultFieldList.ascx" TagName="LookupResultFieldList" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="portlet light" style="margin-bottom:0;">
                <div class="portlet-title">
                    <div class="caption">
                        <span class="caption-subject font-green-sharp bold uppercase">Editor de Formulário</span>
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
                    <div id="editorCommandsBar" class="form-actions nobg no-border commands-bar fluid list-commands-bar">
                        <asp:LinkButton ID="lnkBtnSave" CssClass="btn blue command-action predef-action" runat="server"><i class="fa fa-check btn-action"></i>Salvar</asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnShowXml" CssClass="btn default command-action predef-action" runat="server" OnClick="OnShowXml"><i class="fa fa-code btn-action"></i>XML</asp:LinkButton>

                        <a id="topBtnAddField" class="btn green custom-action" onclick="openScreenAddFields()" data-toggle="modal"><i class="fa fa-plus btn-action"></i>Campos</a>
                        <asp:LinkButton ID="topBtnAddPathField" CssClass="btn green custom-action" runat="server" OnClick="OnAddPathField" ClientIDMode="Static"><i class="fa fa-plus btn-action"></i>Traduzido</asp:LinkButton>
                        <asp:LinkButton ID="topBtnAddSqlField" CssClass="btn green custom-action" runat="server" OnClick="OnAddSQLField" ClientIDMode="Static"><i class="fa fa-plus btn-action"></i>Campo SQL</asp:LinkButton>
                        <asp:LinkButton ID="topBtnAddLabel" CssClass="btn green custom-action" runat="server" OnClick="OnAddLabelField" ClientIDMode="Static"><i class="fa fa-plus btn-action"></i>Customizado</asp:LinkButton>
                        <asp:LinkButton ID="topBtnAddSection" CssClass="btn green custom-action" runat="server" OnClick="OnAddSection" ClientIDMode="Static"><i class="fa fa-plus btn-action"></i>Seção</asp:LinkButton>
                        <asp:LinkButton ID="topBtnAddPage" CssClass="btn green custom-action" runat="server" OnClick="OnAddPage" ClientIDMode="Static"><i class="fa fa-plus btn-action"></i>Guia</asp:LinkButton>

                        <div id="editorAddCommandsGroup" class="btn-group command-action nested-menu" style="display:none;">
                            <a class="btn green dropdown-toggle hover-initialized" data-toggle="dropdown" data-hover="dropdown"><i class="fa fa-plus btn-action"></i> Adicionar <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu hold-on-click break-lines" role="menu" style="width: 150px;">
                                <li id="nestedBtnAddField" style="display:none"><a id="topBtnAddFieldNested" class="green" onclick="openScreenAddFields()" data-toggle="modal">Campos</a></li>
                                <li id="nestedBtnAddPathField" style="display:none"><asp:LinkButton ID="topBtnAddPathFieldNested" CssClass="green" runat="server" OnClick="OnAddPathField">Traduzido</asp:LinkButton></li>
                                <li id="nestedBtnAddSqlField" style="display:none"><asp:LinkButton ID="topBtnAddSqlFieldNested" CssClass="green" runat="server" OnClick="OnAddSQLField">Campo SQL</asp:LinkButton></li>
                                <li id="nestedBtnAddLabel" style="display:none"><asp:LinkButton ID="topBtnAddLabelNested" CssClass="green" runat="server" OnClick="OnAddLabelField">Customizado</asp:LinkButton></li>
                                <li id="nestedBtnAddSection" style="display:none"><asp:LinkButton ID="topBtnAddSectionNested" CssClass="green" runat="server" OnClick="OnAddSection">Seção</asp:LinkButton></li>
                                <li id="nestedBtnAddPage" style="display:none"><asp:LinkButton ID="topBtnAddPageNested" CssClass="green" runat="server" OnClick="OnAddPage">Guia</asp:LinkButton></li>
                            </ul>
                        </div>

                        <div class="btn-group predef-action">
                            <asp:LinkButton ID="btnLeft" CssClass="btn btn-default form-editor-button" runat="server" OnClick="OnButtonLeftClick"><i class="fa fa-arrow-left"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnRight" CssClass="btn btn-default form-editor-button" runat="server" OnClick="OnButtonRightClick"><i class="fa fa-arrow-right"></i></asp:LinkButton>
                        </div>
                        <div class="btn-group predef-action">
                            <asp:LinkButton ID="btnUp" CssClass="btn btn-default form-editor-button" runat="server" OnClick="OnButtonUpClick"><i class="fa fa-arrow-up"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDown" runat="server" CssClass="btn btn-default form-editor-button" OnClick="OnButtonDownClick"><i class="fa fa-arrow-down"></i></asp:LinkButton>
                        </div>

                        <asp:LinkButton ID="btnDel" runat="server" CssClass="btn red predef-action" OnClick="OnButtonRemoveItemClick"><i class="fa fa-minus"></i></asp:LinkButton>

                        <asp:LinkButton ID="togglePropertiesMenu" runat="server" CssClass="btn white predef-action pull-right" OnClientClick="toggleHiddenField('formEditorPropertiesVisible')"><i class="fa fa-bars"></i></asp:LinkButton>
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
                    <div class="row form-editor-panel">
                        <div class="<%=(formEditorPropertiesVisible.Value == "0" ? "col-xs-12" : "col-md-9 col-xs-8")%> form-editor-form">
                            <wesUserControl:FormLayout ID="formLayout1" runat="server" />
                        </div>
                        <div class="col-md-3 col-xs-4 form-editor-properties <%=(formEditorPropertiesVisible.Value == "0" ? "hidden" : "")%>">
                            <asp:HiddenField ID="formEditorPropertiesVisible" ClientIDMode="Static" runat="server" Value="1" />
                            <asp:HiddenField ID="formEditorPropertiesTab" ClientIDMode="Static" runat="server" Value="0" />
                            <div class="tabContainer">
                                <ul class="nav nav-tabs">
                                    <li class="<%=GetActiveTabClass("0")%>"><a href="#fieldPropertiesTab" data-toggle="tab" onclick="Benner.Form.UpdateHiddenActiveTabPageIndex('formEditorPropertiesTab', 0);">Campo</a></li>
                                    <li class="<%=GetActiveTabClass("1")%>"><a href="#formPropertiesTab" data-toggle="tab" onclick="Benner.Form.UpdateHiddenActiveTabPageIndex('formEditorPropertiesTab', 1);">Formulário</a></li>
                                </ul>
                                <div class="tab-content allow-focus">
                                    <div id="fieldPropertiesTab" class="tab-pane <%=GetActiveTabClass("0")%>">
                                        <wesUserControl:SectionProperties ID="sectionProperties" runat="server" />
                                        <wesUserControl:FormFieldProperties ID="formFieldProperties" runat="server" EnableViewState="true" />
                                        <wesUserControl:PageProperties ID="pageProperties" runat="server" />
                                    </div>
                                    <div id="formPropertiesTab" class="tab-pane <%=GetActiveTabClass("1")%>">
                                        <wesUserControl:FormProperties ID="formProperties" Title="Campos de formulário" runat="server" EnableViewState="true" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="listFields" style="display: none;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <wesUserControl:EntityFieldList ID="fieldList" Title="Campos" EnableViewState="true" runat="server" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <script runat="server">
        public string GetActiveTabClass(string index)
        {
            if (formEditorPropertiesTab.Value == index)
                return "active";

            return string.Empty;
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (!prm.get_isInAsyncPostBack()) {
                prm.add_endRequest(applyBorderSelect);
                prm.add_endRequest(Benner.Development.formEditorInit);
                prm.add_endRequest(resetDropdownHover);
            }
            Benner.Development.formEditorInit();
        });

        function resetDropdownHover() {
            $('.dropdown-toggle.hover-initialized').dropdownHover();
        }

        function applyBorderSelect(sender, args) {
            if ($(".portlet-tab").length > 0)
                $("#tabContainer .active").addClass("active-tab");

            $(".form-section.selected").parent().addClass("group-selected");
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
</asp:Content>
