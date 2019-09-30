<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EntityFunctionListControl" %>

<table style="width: 200px; border:0px solid #afd2ff;" cellpadding="0" cellspacing="0">
    <tr style="background-color: White; color:white; font-family: Tahoma; font-size: 11px; font-weight: bold; height: 21px; padding: 0px; margin: 0px;" >
        <td style="padding: 4px; border: 0px;">
            <h3>Comandos</h3>
        </td>
    </tr>
    <tr>
        <td>
            <asp:CheckBoxList style="vertical-align: middle; padding: 0px; font-family: Tahoma; font-size: 11px;" id="chkItems" runat="server" CellPadding="0" CellSpacing="0"></asp:CheckBoxList>
        </td>
    </tr>
    <tr>
        <td style="padding: 4px;">
            <asp:LinkButton ID="btnAdd" OnClick="OnAddClick" style="font-family: Tahoma; font-size: 11px;" runat="server">Adicionar</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>