<%@ Control Language="C#" ViewStateMode="Disabled" EnableViewState="false" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.TopBarMainContentUserControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<asp:UpdatePanel runat="server" ID="breadcrumbUpdatePanel" UpdateMode="Conditional" ClientIDMode="Static">
    <ContentTemplate>
        <wes:wessitemappath SiteMapProvider="WesBreadcrumbProvider" ID="ondestou" SkipLinkText="" runat="server" CssClass="page-bar">
        </wes:wessitemappath>
    </ContentTemplate>
</asp:UpdatePanel>

<asp:Panel ID="messageEnviromentOutDate" CssClass="hidden" runat="server"></asp:Panel>

<wes:WesGlobalMessagePanel id="globalMessagePanel" runat="server">
</wes:WesGlobalMessagePanel>
