<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FormPropertiesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wes" %>

<div class="form-group">
    <asp:Label ID="Label1" CssClass="control-label" runat="server" Text="Título"></asp:Label>
    <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
</div>
<asp:Panel runat="server" ID="divLegendForm" CssClass="form-group">
    <asp:Label ID="lblLegendForm" CssClass="control-label" runat="server"></asp:Label>
    <asp:DropDownList ID="cmbLegendForm" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnUpdateLayoutCaptionIndexChanged"></asp:DropDownList>
</asp:Panel>
<asp:Panel runat="server" ID="divColumn" CssClass="form-group">
    <asp:Label ID="lblColumn" CssClass="control-label" runat="server"></asp:Label>
    <asp:DropDownList ID="cmbColumn" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
</asp:Panel>
<asp:Panel runat="server" ID="divVisionSubstitute" CssClass="form-group">
    <asp:Label ID="lblVisionSubstitute" CssClass="control-label" runat="server"></asp:Label>
    <wes:SearchControl EnableTheming="true" ID="cmbVisionSubstitute" runat="server"></wes:SearchControl>
</asp:Panel>
<asp:Panel runat="server" ID="divBtnEditVisionSubstitute" CssClass="form-group">
    <asp:HyperLink runat="server" ID="btnEditVisionSubstitute" CssClass="btn blue"><i class="fa fa-pencil"></i> Editar Visão</asp:HyperLink>
</asp:Panel>
