<%@ Page Title="Galeria de páginas" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.PagesGridPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:SimpleGrid runat="server" ID="PagesGrid" CanInsert="true" Title="Páginas" FormUrl="~/SiteSettings/PagesForm.aspx" Mode="Search" />
    </div>
</asp:Content>
