<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EntityViewHeader" %>

<div class="">
    <asp:Panel runat="server" ID="panelEntity">
        <strong>Entidade:</strong>
        <asp:Label ID="lbEntityName" runat="server" />
    </asp:Panel>
    <asp:Panel runat="server" ID="panelView">
        <strong>Visão:</strong>
        <asp:Label ID="lbViewName" runat="server" />
    </asp:Panel>
    <asp:Panel runat="server" ID="panelLayer">
        <strong>Customização:</strong>
        <asp:Label ID="lbLayer" runat="server" />
    </asp:Panel>
</div>
