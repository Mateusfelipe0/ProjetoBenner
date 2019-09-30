<%@ Page Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ErrorPage" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.Helpers" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <wes:HeadSection ID="HeadSection1" runat="server" />
</head>
<body class="bg-white">
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnToken" />

        <div class="container">
            <div class="row" style="margin-left: auto; margin-right: auto; margin-top: 50px; width: 80%;">
                <div class="errorTitlePanel">
                    <p class="emoticon">:(</p>
                    <div style="padding-top: 20px; padding-bottom: 40px;">
                        <asp:Label runat="server" Text="Ops, ocorreu um problema" Font-Size="X-Large" ID="lblProblem" />
                        <div class="errorCmds" style="margin-top: 10px;">
                            <div>
                                <div style="float: left">
                                </div>
                                <asp:PlaceHolder ID="errorCmdsContainer" runat="server"></asp:PlaceHolder>
                            </div>
                        </div>
                    </div>
                    <div>
                        <asp:Label ID="lblErrorMessage" runat="server" Font-Size="1.5em"></asp:Label>
                    </div>
                </div>
                <div>
                    <div class="errorGuidPanel">
                        <asp:Label ID="lblGuid" runat="server"></asp:Label>
                    </div>
                    <div style="margin-top: 10px;">
                        <a href="#" style="text-decoration: underline;" onclick="showHide('pnlDetalhes');">
                            <asp:Label ID="lblDetalhes" runat="server" Text="Detalhes" />
                        </a>
                        <div id="pnlDetalhes" style="display: none;">
                            <asp:PlaceHolder ID="phContainer" runat="server"></asp:PlaceHolder>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
    <script src="<%= Page.ResolveUrl("~/scripts/WebForms/MsAjax/MicrosoftAjax.js")%>" type="text/javascript"></script>
    <script src="<%= Page.ResolveUrl("~/scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js")%>" type="text/javascript"></script>
    <script src="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.js") %>"></script>
    <script type="text/javascript">

        $(function() {
            $("body").keyup(function(e) {
                if (e.keyCode == 27) // esc
                {
                    if (parent != null)
                        parent.Benner.ModalPage.hide();
                    else
                        Benner.ModalPage.hide();

                    return false;
                }
            });
        });

        function showHide(id) {
            elem = document.getElementById(id);
            if (!elem)
                return;

            elem.style.display = (elem.style.display == 'none') ? 'block' : 'none';
        }
    </script>
</body>
</html>
