<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FormFieldPropertiesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wesUI" %>

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            Campo
        </div>
    </div>
    <div class="portlet-body">
        <asp:Panel ID="divFields" CssClass="form-group" runat="server">
            <asp:Label ID="Label2" CssClass="control-label" runat="server" Text="Campos"></asp:Label>
            <asp:DropDownList ID="cmbFields" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnFieldsSelectedIndexChanged"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divCustomName" CssClass="form-group" runat="server">
            <asp:Label ID="Label18" CssClass="control-label" runat="server" Text="Nome"></asp:Label>
            <asp:TextBox ID="txtCustomName" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>

        <asp:Panel ID="divTitle" CssClass="form-group" runat="server">
            <asp:Label ID="Label1" CssClass="control-label" runat="server" Text="Título"></asp:Label>
            <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>

        <asp:Panel ID="divCssClass" CssClass="form-group" runat="server">
            <asp:Label ID="Label21" CssClass="control-label" runat="server" Text="Classes CSS"></asp:Label>
            <asp:TextBox ID="txtCssClass" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>
        
        <asp:Panel ID="divExtension" CssClass="form-group" runat="server">
            <asp:Label ID="Label26" CssClass="control-label" runat="server" Text="Extensão"></asp:Label>
            <asp:TextBox ID="txtExtension" placeholder=".png, .xml, .doc" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>

        <asp:Panel ID="divTooltip" CssClass="form-group" runat="server">
            <asp:Label ID="Label17" CssClass="control-label" runat="server" Text="Dica"></asp:Label>
            <asp:TextBox ID="txtTooltip" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>

        <asp:Panel ID="divExpression" CssClass="form-group" runat="server">
            <div class="form-group">
                <asp:Label ID="Label19" CssClass="control-label" runat="server" Text="Expressão SQL"></asp:Label>
                <asp:TextBox ID="txtExpression" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label23" CssClass="control-label" runat="server" Text="Tipo do resultado"></asp:Label>
                <asp:DropDownList ID="cmbSqlFieldType" CssClass="form-control" runat="server"></asp:DropDownList>
            </div>
        </asp:Panel>

        <asp:Panel ID="divTexto" CssClass="form-group" runat="server" Visible="false">
            <asp:Label ID="Label5" CssClass="control-label" runat="server" Text="Linhas"></asp:Label>
            <asp:TextBox ID="txtLines" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>

        <asp:Panel ID="divImageField" CssClass="form-group" runat="server">
            <asp:Label ID="Label9" CssClass="control-label" runat="server" Text="Tamanho"></asp:Label>
            <asp:DropDownList ID="cmbThumbnailSize" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divPathField" CssClass="form-group" runat="server">
            <asp:Label ID="Label6" CssClass="control-label" runat="server" Text="Caminho"></asp:Label>
            <div class="input-group">
                <asp:TextBox ID="txtPath" CssClass="form-control" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <button class="btn btn-default" onclick="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtPath.ClientID %>');">
                        <i class="fa fa-pencil"></i>
                    </button>
                </span>
            </div>
        </asp:Panel>

        <asp:Panel ID="divLabelField" runat="server">
            <div class="form-group">
                <asp:Label ID="Label7" CssClass="control-label" runat="server" Text="Valor"></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txtLabelValue" CssClass="form-control noresize" TextMode="MultiLine" runat="server" Rows="1"></asp:TextBox>
                    <span class="input-group-btn" style="vertical-align: top">
                        <button class="btn btn-default"
                            onclick="javascript:Benner.Apps.CustomField.show('EditCustomField.aspx','<%= txtLabelValue.ClientID %>', '<%= cmbLabelValueType.ClientID %>');">
                            <i class="fa fa-pencil"></i>
                        </button>
                    </span>
                </div>
            </div>
            <div class="form-group hide">
                <asp:Label ID="Label20" CssClass="control-label" runat="server" Text="Tipo"></asp:Label>
                <asp:DropDownList ID="cmbLabelValueType" CssClass="form-control" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="divLookup" runat="server" Visible="false">
            <div class="form-group">
                <asp:Label ID="Label10" CssClass="control-label" runat="server" Text="Visão customizada"></asp:Label>
                <asp:TextBox ID="txLookupViewName" CssClass="form-control autocomplete autocomplete-lookup-views" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="Label11" CssClass="control-label" runat="server" Text="Campos de resultado"></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txLookupResultFields" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                    <span class="input-group-btn">
                        <asp:LinkButton ID="btnLookupResultFields" CssClass="btn btn-default" runat="server" data-toggle="modal" OnClientClick="$('#lookupResultFields').modal('show');applyDragNDrop();">
                            <i class="fa fa-pencil"></i>
                        </asp:LinkButton>
                    </span>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="Label8" CssClass="control-label" runat="server" Text="Critério de seleção"></asp:Label>
                <div class="input-group">
                    <asp:TextBox ID="txtWhere" CssClass="form-control" runat="server"></asp:TextBox>
                    <span class="input-group-btn">
                        <button class="btn btn-default" onclick="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtWhere.ClientID %>');">
                            <i class="fa fa-pencil"></i>
                        </button>
                    </span>
                </div>
            </div>
            <asp:Panel ID="divAssociation" runat="server" Visible="false">
                <div class="form-group">
                    <asp:Label ID="Label12" CssClass="control-label" runat="server" Text="Página do formulário"></asp:Label>
                    <asp:TextBox ID="txtPageForm" runat="server" CssClass="form-control autocomplete autocomplete-pages"></asp:TextBox>
                    <wesUI:SearchControl ID="cmbLookupFormularios" runat="server" Visible="false"></wesUI:SearchControl>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label13" CssClass="control-label" runat="server" Text="Página de pesquisa customizada"></asp:Label>
                    <asp:TextBox ID="txtPageSearchCustom" runat="server" CssClass="form-control autocomplete autocomplete-specialized-pages"></asp:TextBox>
                    <wesUI:SearchControl ID="cmbCustomLookupPage" runat="server" Visible="false"></wesUI:SearchControl>
                </div>
                <div class="form-group">
                    <asp:CheckBox runat="server" ID="chkSearchEnter" Text="Pesquisa ao pressionar enter" />
                </div>
            </asp:Panel>
            
        </asp:Panel>

        <asp:Panel ID="divEdit" CssClass="form-group" runat="server">
            <asp:Label ID="Label3" CssClass="control-label" runat="server" Text="Edição"></asp:Label>
            <asp:DropDownList ID="cmbEdicao" CssClass="form-control" runat="server"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divLayout" CssClass="form-group" runat="server">
            <asp:Label ID="Label4" CssClass="control-label" runat="server" Text="Leiaute"></asp:Label>
            <asp:DropDownList ID="cmbLayout" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divBootstrapCols" CssClass="form-group" runat="server">
            <asp:Label ID="Label14" CssClass="control-label" runat="server" Text="Leiaute"></asp:Label>
            <asp:DropDownList ID="cmbBootstrapCols" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divGroupBootstrapCols" CssClass="form-group" runat="server">
            <asp:Label ID="Label15" CssClass="control-label" runat="server" Text="Leiaute"></asp:Label>
            <asp:DropDownList ID="cmbGroupBootstrapCols" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divTabBootstrapCols" CssClass="form-group" runat="server">
            <asp:Label ID="Label16" CssClass="control-label" runat="server" Text="Leiaute"></asp:Label>
            <asp:DropDownList ID="cmbTabBootstrapCols" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divStatesGroup" CssClass="form-group" runat="server">
            <asp:Label ID="Label22" CssClass="control-label" runat="server" Text="Estado"></asp:Label>
            <asp:DropDownList ID="cmbStatesGroup" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
        </asp:Panel>

        <asp:Panel ID="divChecks" Visible="false" runat="server">
            <asp:CheckBox runat="server" ID="chkVisible" Text="Visível" />
            <asp:CheckBox runat="server" ID="chkRequired" Text="Obrigatório" />
            <asp:CheckBox runat="server" ID="chkRenderTitle" Text="Renderizar Título" />
        </asp:Panel>
    </div>
</div>
