<%@ Control Language="C#" AutoEventWireup="true"  Inherits="Benner.Tecnologia.Wes.Components.WebApp.AddOperationsTaskPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<style>
    .operation-task .mt-checkbox-inline {
        padding: 0px;
    }

    .operation-task .mt-checkbox-inline > .mt-checkbox.mt-checkbox-outline {
        margin-bottom: 0px;
    }
</style>

<asp:Panel ID="msgError" CssClass="alert alert-warning alert-modal" runat="server" Visible="false">
    <asp:Label ID="lblMsg" runat="server" />
</asp:Panel>

<asp:Panel runat="server" ID="divComponents">
    <div class="form-actions top nobg no-border commands-bar fluid footer-commands-bar commands-bar-hide">
        <asp:LinkButton runat="server" ID="btnSave" CssClass="btn blue command-action predef-action" Text="<i class='fa fa-check btn-action'></i> Salvar"></asp:LinkButton>
    </div>
    <div class="row">
        <div class="col-md-6">
            <wes:MultipleSearchControl ID="searchControlEntities" runat="server" />
        </div>
        <div class="col-md-6">
            <asp:LinkButton runat="server" ID="btnAdd" CssClass="btn green command-action predef-action" Text="<i class='fa fa-plus btn-action'></i> Adicionar"></asp:LinkButton>
        </div>
    </div>
</asp:Panel>

<asp:HiddenField runat="server" ID="hdnEntityChanged" />
<asp:HiddenField runat="server" ID="hdnTaskHandle" />
<asp:HiddenField runat="server" ID="hdnEntityInclude" />

<asp:Panel runat="server" ID="divGridOperations" CssClass="table-responsive table-scrollable">
    <wes:BennerGridView runat="server" ID="gridView"></wes:BennerGridView>
</asp:Panel>