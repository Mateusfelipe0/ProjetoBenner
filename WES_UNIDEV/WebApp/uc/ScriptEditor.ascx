<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ScriptEditorControl" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagName="SourceEditor" TagPrefix="wesUserControl" %>

<table style="width: 100%" cellspacing="5px">
    <tr>
        <td style="width: 50%">
            <asp:Label ID="Label4" runat="server" Text="Objeto"></asp:Label>
        </td>
        <td style="width: 50%">
            <asp:Label ID="Label3" runat="server" Text="Evento"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:DropDownList CssClass="form-control" ID="cmbObjects" runat="server" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedObjectChanged"></asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ID="cmbFunctions" CssClass="form-control" runat="server" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedFunctionChanged"></asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <wesUserControl:SourceEditor runat="server" ID="sourceEditor" />
        </td>
    </tr>
</table>
