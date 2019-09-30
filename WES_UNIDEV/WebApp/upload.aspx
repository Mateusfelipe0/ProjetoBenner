<%@ Page Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.UploadPage" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.Helpers" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <title>Anexar arquivo</title>
    <wes:HeadSection ID="HeadSection1" runat="server" />
</head>
<body class="bg-white">
    <form id="form1" runat="server" enctype='multipart/form-data'>
        <asp:HiddenField runat="server" ID="hdnToken" />

        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" onclick="javascript:parent.Benner.ModalPage.hide();"></button>
            <h4 class="modal-title"><asp:Label runat="server" ID="lblAttachFile" Text="Anexar Arquivo" /></h4>
        </div>
        <div class="modal-body">
            <asp:Panel ID="msgError" CssClass="alert alert-warning alert-modal" runat="server">
                <asp:Label ID="lblMsg" runat="server" />
            </asp:Panel>
            <input id="file" type="file" size="50" runat="server" />
        </div>
        <div class="modal-footer">
            <input id="btnUploadTheFile" class="btn blue" type="button" value="Enviar" onserverclick="OnUploadClick" runat="server" />
            <asp:Button runat="server" ID="btnCancel" Class="btn default" data-dismiss="modal" Text="Cancelar" />
        </div>
    </form>
    <script src="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.js") %>"></script>
    <script type="text/javascript">
        parent.Benner.ModalPage.init();
    </script>
</body>
</html>
