<%@ Page Title="Galeria de menus" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.MenusPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wesWidget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:SimpleGrid runat="server" UserDefinedPageSize="100" Mode="Search" BootstrapCols="4" ID="MenusGrid" FormUrl="~/SiteSettings/MenuForm.aspx" Title="Menus" />
        <wesWidget:SimpleGrid runat="server" UserDefinedPageSize="100" Mode="Search" BootstrapCols="4" ID="MenuItensGrid" FormUrl="~/SiteSettings/MenuItemForm.aspx" Title="Itens" />
        <wesWidget:SimpleGrid runat="server" UserDefinedPageSize="100" Mode="Search" BootstrapCols="4" ID="MenuSubItensGrid" FormUrl="~/SiteSettings/MenuItemForm.aspx" Title="Subitens" />
    </div>
</asp:Content>

