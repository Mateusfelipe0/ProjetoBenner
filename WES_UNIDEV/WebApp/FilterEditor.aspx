<%@ Page Title="Editor de filtro" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FilterEditor" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="cc1" %>
<%@ Register Src="~/uc/FilterControl.ascx" TagName="filterControl" TagPrefix="wesUserControls" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <style>
        .portlet {
            margin-bottom: 0px !important;
        }
    </style>
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <asp:Label runat="server" ID="lblTituloEditorDeFiltro" CssClass="caption-subject font-green-sharp bold uppercase" Text="Editor de filtro" />
            </div>
            <div class="actions">
                <cc1:WidgetActionsMenu ID="developerMenu" runat="server" />
            </div>
        </div>
        <div class="portlet-body form">
            <asp:UpdatePanel ID="filterEditorUpdatePanel" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:LinkButton ID="lnkBtnSave" OnClick="ButtonSave_Click" CssClass="btn blue command-action predef-action" runat="server"><i class="fa fa-check btn-action"></i>Salvar</asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnDelete" OnClick="ButtonDelete_Click" Enabled="false" CssClass="btn red command-action predef-action" runat="server"><i class="fa fa-minus btn-action"></i>Excluir</asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnCancel" OnClick="ButtonCancel_Click" CssClass="btn grey-silver command-action predef-action" runat="server"><i class="fa fa-times btn-action"></i>Cancelar</asp:LinkButton>
                    </div>
                    <cc1:MessagePanel ID="messagePanel" runat="server">
                    </cc1:MessagePanel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblTituloNomeFiltro" CssClass="control-label" Text="Nome do filtro" />
                                <asp:TextBox ID="txFilterName" class="form-control" CausesValidation="true" runat="server" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <asp:Label runat="server" ID="lpFilterType" CssClass="control-label" Text="Tipo" />
                                <asp:DropDownList runat="server" class="form-control" ID="ddlFilterType" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterType_SelectedIndexChanged">
                                    <asp:ListItem Value="1" Text="Condições"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Tabela virtual"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <asp:CheckBox ID="cbEmptyResults" runat="server" Text="Não trazer resultados até filtrar" />
                        </div>
                        <div class="col-md-4">
                            <asp:CheckBox ID="cbFilterVisibility" Checked="true" Text="Vis&#237;vel" runat="server" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <wesUserControls:filterControl ID="filterControl" runat="server" />
</asp:Content>
