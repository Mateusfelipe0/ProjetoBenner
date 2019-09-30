<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EditSourcePage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagPrefix="wes" TagName="SourceEditor" %>
<%@ Register Src="~/uc/WesManager.ascx" TagName="WesManager" TagPrefix="wes" %>
<%@ Register Src="~/uc/TopBarMainContent.ascx" TagName="TopBarMainContent" TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <title>Anexar arquivo</title>
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
                        <asp:Button runat="server" ID="btnCancel" Class="btn default" data-dismiss="modal" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <wes:ExceptionMessageViewerControl ID="messagePanel" runat="server"></wes:ExceptionMessageViewerControl>
            <div class="">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tabAspx" data-toggle="tab">ASPX</a>
                    </li>
                    <li id="tabCsPage">
                        <a href="#tabCs" data-toggle="tab">CS</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tabAspx">
                        <wes:SourceEditor runat="server" ID="sourceEditorAspx" />
                    </div>
                    <div class="tab-pane" id="tabCs">
                        <wes:SourceEditor runat="server" ID="sourceEditorCs" />
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            parent.Benner.ModalPage.init();
        </script>
    </form>
</body>
</html>

