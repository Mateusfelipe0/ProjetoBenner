<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.GridPropertiesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wes" %>

<div class="form-group">
    <asp:Label ID="Label1" CssClass="control-label" runat="server" Text="Título"></asp:Label>
    <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
</div>
<asp:Panel runat="server" ID="divVisionSubstitute" CssClass="form-group">
    <asp:Label ID="lblVisionSubstitute" CssClass="control-label" runat="server"></asp:Label>
    <wes:SearchControl EnableTheming="true" ID="cmbVisionSubstitute" runat="server"></wes:SearchControl>
</asp:Panel>
<asp:Panel runat="server" ID="divBtnEditVisionSubstitute" CssClass="form-group">
    <asp:HyperLink runat="server" ID="btnEditVisionSubstitute" CssClass="btn blue"><i class="fa fa-pencil"></i> Editar Visão</asp:HyperLink>
</asp:Panel>
<div>
    <asp:CheckBox ID="chkBehaveAsUnstructuredGrid" runat="server" Text="Exibir grid não estruturado" Visible="false"></asp:CheckBox>
</div>

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            Ordenação
        </div>
        <div class="actions">
            <asp:LinkButton ID="btnAddSortField" CssClass="btn green" runat="server" OnClick="OnAddSortFieldClick"><i class="fa fa-plus"></i></asp:LinkButton>
            <asp:LinkButton ID="btnDelSortField" CssClass="btn red" runat="server" OnClick="OnDeleteSortFieldClick"><i class="fa fa-minus"></i></asp:LinkButton>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <div class="col-md-8" style="padding-right: 0px">
                <asp:DropDownList ID="cmbFields" CssClass="form-control" runat="server">
                </asp:DropDownList>
            </div>
            <div class="col-md-4" style="padding-left: 0px">
                <asp:DropDownList CssClass="form-control" ID="cmbOrder" runat="server">
                    <asp:ListItem Value="0">ASC</asp:ListItem>
                    <asp:ListItem Value="1">DESC</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <asp:ListBox ID="lstSortFields" CssClass="form-control" runat="server"></asp:ListBox>
            </div>
        </div>
    </div>
</div>
