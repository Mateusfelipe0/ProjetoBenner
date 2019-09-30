<%@ Page Title="Informações de versão do WES" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.VersionInfoPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase"><asp:Label runat="server" ID="lblWESVersionInfo" Text="Informações de versão do WES" /></span>
                <span class="caption-helper"><asp:Label ID="lblWesVersion" runat="server" /></span>
            </div>
        </div>
        <div class="portlet-body form">
            <div class="row">
                <div class="col-md-12">
                    <asp:GridView ID="gridVersion" runat="server">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

