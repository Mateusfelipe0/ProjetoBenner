<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CommandReportControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI"
    TagPrefix="wesUI" %>

<div class="form-group">
    <label>Relatório (Código - Nome)</label>
    <wesUI:SearchControl ID="cmbReport" Width="100%" runat="server"></wesUI:SearchControl>
</div>

<div class="form-group">
    <label>Formato</label>
    <asp:DropDownList ID="ddlFormat" runat="server" CssClass="form-control" />
</div>

<div class="form-group">
    <label>Critério de seleção</label>
    <div class="input-group">
        <asp:TextBox ID="txtWhereClause" CssClass="form-control" runat="server"></asp:TextBox>
        <span class="input-group-btn">
            <a class="btn btn-default" href="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtWhereClause.ClientID %>');"><i class="fa fa-filter"></i></a>
        </span>
    </div>
</div>