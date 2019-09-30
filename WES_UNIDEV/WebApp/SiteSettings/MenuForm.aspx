<%@ Page Title="Menu" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.MenuFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wesWidget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:AjaxForm runat="server" ID="MenuForm" Title="Menu" />
        <wesWidget:SimpleGrid runat="server" UserDefinedPageSize="100" ID="MenuItensGrid" Mode="Search" FormUrl="~/SiteSettings/MenuItemForm.aspx" Title="Itens do menu" />
    </div>
</asp:Content>
