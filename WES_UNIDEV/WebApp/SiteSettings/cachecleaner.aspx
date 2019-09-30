<%@ Page Title="Limpar o cache do WES" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CacheCleanerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase"><asp:Label runat="server" ID="lblClearWesCache" Text="Limpar o cache do WES" /></span>
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-actions nobg no-border commands-bar fluid">
                <asp:LinkButton CssClass="btn blue" ToolTip="Atualiza o cache dos servidores de apresentação e de aplicativo" ID="lnkBtnCleanCache" runat="server" Text="Limpar"></asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>

