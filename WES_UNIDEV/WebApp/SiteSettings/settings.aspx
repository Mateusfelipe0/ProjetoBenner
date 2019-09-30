<%@ Page Title="Definições do site" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wesWidget:MenuWidget ShowTitle="true" Title="Configurações" MenuID="SITESETTINGS" runat="server" ID="configurationsMenu" />
    </div>
</asp:Content>

<script runat="server">

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        if (Benner.Tecnologia.Common.BennerConfiguration.CanNotChangePassword)
            configurationsMenu.PreRenderMenuItem += configurationsMenu_RenderedItem;
    }

    void configurationsMenu_RenderedItem(object sender, Benner.Tecnologia.Wes.Components.RenderMenuItemEventArgs e)
    {
        
        if (e.MenuItem.Target.Equals("ALTERAODESENHADEACESSO"))
            e.MenuItem.Enabled = false;
    }

</script>