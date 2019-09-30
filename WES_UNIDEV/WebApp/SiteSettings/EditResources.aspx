<%@ Page Title="Adicionar/Editar Javascript" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EditResourcesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagPrefix="wes" TagName="SourceEditor" %>
<%@ Register Src="~/uc/WesManager.ascx" TagName="WesManager" TagPrefix="wes" %>
<%@ Register Src="~/uc/TopBarMainContent.ascx" TagName="TopBarMainContent" TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <title>Editar Javascript/CSS</title>
    <wes:HeadSection ID="headSection" runat="server" />
    <style>
        .source-editor.ace_editor.ace-chrome {
            height: 465px;
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
        <wes:TopBarMainContent ID="TopBarMainContent" runat="server" Visible="false" />

        <div class="modal-header">
            <button runat="server" id="btnClose" type="button" class="close" data-dismiss="modal" onclick="javascript:parent.Benner.ModalPage.hide();"></button>
            <h4 class="modal-title">
                <asp:Label runat="server" ID="lblTitle" CssClass="caption-subject font-green-sharp bold uppercase"></asp:Label>
            </h4>
        </div>
        <div class="modal-body">
            <div class="modal-commands">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:Button runat="server" ID="btnSalvar" CssClass="btn blue" />
                        <asp:Button runat="server" ID="btnCancel" CssClass="btn default" data-dismiss="modal" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tabJavascript" data-toggle="tab">Javascript</a>
                    </li>
                    <li>
                        <a href="#tabCSS" data-toggle="tab">CSS</a>
                    </li>
                </ul>
                <wes:ExceptionMessageViewerControl ID="messagePanel" runat="server"></wes:ExceptionMessageViewerControl>
                <div class="tab-content">
                    <div class="tab-pane active" id="tabJavascript">
                        <wes:SourceEditor runat="server" ID="sourceEditorJavascript" />
                    </div>
                    <div class="tab-pane" id="tabCSS">
                        <wes:SourceEditor runat="server" ID="sourceEditorCss" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
