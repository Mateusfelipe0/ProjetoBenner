<%@ Page Title="Editar campo customizado" Language="C#" AutoEventWireup="true"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagPrefix="wes" TagName="SourceEditor" %>
<%@ Register Src="~/uc/WesManager.ascx" TagName="WesManager" TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <title>Editar campo customizado</title>
    <wes:HeadSection ID="headSection" runat="server" />
    <style>
        .ace_editor {
            height: 416px;
        }

        .modal-header {
            height: 55px;
        }

        .modal-footer {
            border: 0px;
        }

        .environment {
            display: none;
        }

        #breadcrumbUpdatePanel > .page-bar {
            margin-bottom: 0px;
        }
    </style>
</head>
<body class="bg-white">
    <form id="formEditarJavascript" runat="server">
        <wes:WesManager runat="server">
        </wes:WesManager>

        <div class="modal-header">
            <button runat="server" id="btnClose" type="button" class="close" data-dismiss="modal" onclick="javascript:parent.Benner.ModalPage.hide();"></button>
            <h4 class="modal-title">
                <asp:Label runat="server" ID="lblTitle" CssClass="caption-subject font-green-sharp bold uppercase">Editar campo customizado</asp:Label>
            </h4>
        </div>
        <div class="modal-body" style="height: 524px;">
            <div class="modal-commands">
                <button id="btnOK" type="button" class="btn blue btn-action command-action predef-action"  accesskey="O" onclick="javascript: OnOkClick();"><i class="fa fa-check btn-action"></i>Salvar</button>
                <button id="btnCancel" type="button" class="btn grey-silver btn-cancel command-action predef-action" accesskey="C" onclick="javascript: OnCancelClick();"><i class="fa fa-times btn-action"></i>Cancelar</button>
            </div>
            <div class="mt-radio-inline" data-field="RADIO">
                <asp:RadioButton runat="server" ID="rbText" ClientIDMode="Static" GroupName="radioValor" onclick="javascript: setActiveTab('tabText');" Text="Texto" />
                <asp:RadioButton runat="server" ID="rbHTML" ClientIDMode="Static" GroupName="radioValor" onclick="javascript: setActiveTab('tabHTML');" Text="Html (Razor)" />
                <asp:RadioButton runat="server" ID="rbView" ClientIDMode="Static" GroupName="radioValor" onclick="javascript: setActiveTab('tabView');" Text="View (.cshtml)" />
                <asp:RadioButton runat="server" ID="rbController" ClientIDMode="Static" GroupName="radioValor" onclick="javascript: setActiveTab('tabController');" Text="Controller" />
            </div>
            <div class="tabbale-line">
                <div id="tab-field-option" class="tab-content">
                    <div class="tab-pane" id="tabText">
                        <textarea rows="25" class="form-control" cols="20" id="sourceText" title="Área de Texto" style="height: 416px; width: 100%;"></textarea>
                    </div>
                    <div class="tab-pane" id="tabHTML">
                        <wes:SourceEditor runat="server" ID="sourceRazor" Language="razor" style="height: 80%; width: 100%;" />
                    </div>
                    <div class="tab-pane" id="tabView">
                        <div class="form-horizontal ">
                            <label class="control-label col-md-2 col-sm-2">
                                <div class="label-form">
                                    <div class="label-title">
                                        View
                                    </div>
                                    <div class="label-title-required">
                                        <span class="required" aria-required="true">* </span>
                                    </div>
                                    <div class="label-title-help">
                                        <i class="fa fa-question-circle help-tooltip" data-original-title="Caminho relativo ao website do arquivo .cshtml"></i>
                                    </div>
                                </div>
                            </label>
                            <div class="col-md-10 col-sm-10 value">
                                <input id="viewPath" class="form-control" placeholder="Exemplo: ~/Views/Administrador/Index.cshtml" style="width: 100%;" />
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tabController">
                        <div class="form-horizontal ">
                            <label class="control-label col-md-2 col-sm-2">
                                <div class="label-form">
                                    <div class="label-title">
                                        Controller
                                    </div>
                                    <div class="label-title-required">
                                        <span class="required" aria-required="true">* </span>
                                    </div>
                                    <div class="label-title-help">
                                        <i class="fa fa-question-circle help-tooltip" data-original-title="Controller (MVC) sem o sufixo &quot;Controller&quot;"></i>
                                    </div>
                                </div>
                            </label>
                            <div class="col-md-4 col-sm-4 value">
                                <input type="text" maxlength="100" id="controllerMVC" class="form-control" data-type="string" data-label="Controller" placeholder="Exemplo: Administrador" />
                            </div>
                            <label class="control-label col-md-2 col-sm-2">
                                <div class="label-form">
                                    <div class="label-title">
                                        Action
                                    </div>
                                    <div class="label-title-required">
                                        <span class="required" aria-required="true">*</span>
                                    </div>
                                    <div class="label-title-help">
                                        <i class="fa fa-question-circle help-tooltip" data-original-title="Método do Controller MVC que retorna um ViewResult"></i>
                                    </div>
                                </div>
                            </label>
                            <div class="col-md-4 col-sm-4 value">
                                <input type="text" maxlength="100" id="actionMVC" class="form-control" data-type="string" data-label="Action" placeholder="Exemplo: Index (Padrão)" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                Benner.Apps.CustomField.initModal();
            });

            function OnOkClick() {
                Benner.Apps.CustomField.OnOkClick();
            }

            function OnCancelClick() {
                Benner.Apps.CustomField.hide();
            }

            function setActiveTab(tabID) {
                Benner.Apps.CustomField.setActiveTab(tabID);
            }
        </script>
    </form>
</body>
</html>
