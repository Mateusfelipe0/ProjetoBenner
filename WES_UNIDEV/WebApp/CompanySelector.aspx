<%@ Page Title="Informações sobre a empresa e filial" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CompanySelectorPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <asp:Label runat="server" ID="lblTitulo" CssClass="caption-subject font-green-sharp bold uppercase" Text="Trocar empresa e filial" />
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-actions nobg no-border commands-bar fluid">
                <asp:LinkButton runat="server" ID="btnChangeCompany" Text="Salvar" CssClass="btn blue command-action predef-action" OnClick="ChangeCompany" />
            </div>
            <div class="row">
                <div class="col-md-12">
                    <wes:MessagePanel ID="messagePanel" runat="server"></wes:MessagePanel>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label runat="server" ID="lblEmpresa" CssClass="control-label" Text="Empresa"></asp:Label>
                        <asp:Panel runat="server" ID="companyLookupContainer"></asp:Panel>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="lblFilial" CssClass="control-label" Text="Filial"></asp:Label>
                        <asp:Panel runat="server" ID="branchLookupContainer"></asp:Panel>
                    </div>
                    <asp:CheckBox ID="ckbSelectAllBranches" runat="server" AutoPostBack="true" Text="Todas as unidades" OnCheckedChanged="SelectAllBranches" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
