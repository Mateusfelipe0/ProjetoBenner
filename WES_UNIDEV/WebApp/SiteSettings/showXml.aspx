<%@ Page Title="Conteúdo serializado em formato XML" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ShowXmlPage" %>

<%@ Register Src="~/uc/SourceEditor.ascx" TagName="SourceEditor" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <wesUserControl:SourceEditor runat="server" ID="sourceEditor" />
    <style media="all">
        div#ContentPanel {
            width: 100%;
            height: 100%;
            padding: 0 !important;
        }
        .source-editor.ace_editor {
            height: 100vh

        }
    </style>
</asp:Content>