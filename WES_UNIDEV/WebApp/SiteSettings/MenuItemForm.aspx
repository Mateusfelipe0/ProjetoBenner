<%@ Page Title="Item de menu" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.MenuItemFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wesWidget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:AjaxForm runat="server" ID="MenuItemForm" Title="Item de menu" IncludeRecordInRecentItems="true" />
        <wesWidget:SimpleGrid runat="server" ID="MenuItensGrid" FormUrl="MenuItemForm.aspx" Title="Subitens" />
    </div>
</asp:Content>
