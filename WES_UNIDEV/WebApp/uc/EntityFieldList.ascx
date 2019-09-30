<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EntityFieldListControl" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wesUI" %>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"></button>
    <h4 class="modal-title"><asp:Label ID="lblTitle" runat='server' /></h4>
</div>
<div class="modal-body">
    <div class="input-group">
        <asp:TextBox ID="txtNameField" CssClass="form-control" placeholder="Filtrar..." runat="server"></asp:TextBox>
        <span class="input-group-btn">
            <asp:LinkButton runat="server" CssClass="btn btn-default" ID="btnClearFieldSearch" Text="X">
                <i class="fa fa-rotate-left"></i>
            </asp:LinkButton>
            <button type="button" id="btnSelectAll" class="btn btn-default" onclick="Benner.Page.selectAllFields(true,'btnSelectAll','btnUnselectAll')"><i class="fa fa-check-square-o"></i></button>
            <button type="button" id="btnUnselectAll" class="btn btn-default hidden" onclick="Benner.Page.selectAllFields(false,'btnSelectAll','btnUnselectAll')"><i class="fa fa-square-o"></i></button>
        </span>
    </div>
    <div class="list-fields">
        <asp:CheckBoxList ID="chkFields" runat="server" CssClass="mt-checkbox-list editor-check-list" RepeatLayout="Flow" />
    </div>
</div>
<div class="modal-footer">
    <asp:LinkButton ID="btnAdd" CssClass="btn green" OnClientClick="$('#listFields').modal('hide')" OnClick="OnAddFieldClick" runat="server">Adicionar</asp:LinkButton>
    <button type="button" class="btn default" data-dismiss="modal">Fechar</button>
</div>
