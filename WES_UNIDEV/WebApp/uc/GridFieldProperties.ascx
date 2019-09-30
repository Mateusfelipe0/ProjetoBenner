<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.GridFieldPropertiesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wesUI" %>



<div class="form-group">
    <asp:Label ID="Label2" runat="server" CssClass="control-label" Text="Campos do grid"></asp:Label>
    <asp:DropDownList ID="cmbFields" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnFieldsSelectedIndexChanged">
    </asp:DropDownList>
</div>

        <div class="form-group">
            <asp:Label ID="Label1" runat="server" CssClass="control-label" Text="Título"></asp:Label>
            <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
        </div>

         <asp:Panel ID="divCssClass" CssClass="form-group" runat="server">
            <asp:Label ID="Label21" CssClass="control-label" runat="server" Text="Classes CSS"></asp:Label>
            <asp:TextBox ID="txtCssClass" CssClass="form-control" runat="server"></asp:TextBox>
        </asp:Panel>
        
        
        <asp:Panel ID="divNamedField" runat="server" Visible="false">
            <div class="form-group">
                <asp:Label ID="Label9" runat="server" CssClass="control-label" Text="Nome"></asp:Label>
                <asp:TextBox ID="txtNameCustom" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </asp:Panel>

<asp:Panel ID="divCustomField" runat="server" Visible="false">
    <div class="form-group">
        <asp:Label ID="Label11" CssClass="control-label" runat="server" Text="Valor"></asp:Label>
        <div class="input-group">
            <asp:TextBox ID="txtValueCustom" CssClass="form-control noresize" TextMode="MultiLine" runat="server" Rows="1"></asp:TextBox>
            <span class="input-group-btn" style="vertical-align: top">
                <button class="btn btn-default"
                    onclick="javascript:Benner.Apps.CustomField.show('EditCustomField.aspx','<%= txtValueCustom.ClientID %>', '<%= cmbLabelValueType.ClientID %>');">
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

<asp:Panel ID="divEdit" runat="server" CssClass="form-group">
    <asp:Label ID="Label4" runat="server" CssClass="control-label" Text="Edição"></asp:Label>
    <asp:DropDownList ID="cmbEdicao" CssClass="form-control" runat="server">
    </asp:DropDownList>
</asp:Panel>

<asp:Panel ID="divFooterBehavior" CssClass="form-group" runat="server">
    <asp:Label ID="Label10" runat="server" CssClass="control-label" Text="Linha de totais"></asp:Label>
    <asp:DropDownList ID="cmbFooterBehavior" CssClass="form-control" runat="server">
    </asp:DropDownList>
</asp:Panel>

<asp:Panel ID="divWidth" CssClass="form-group" runat="server">
    <asp:Label ID="lbWidth" runat="server" CssClass="control-label" Text="Largura"></asp:Label>
    <asp:TextBox ID="txtWidth" CssClass="form-control" runat="server"></asp:TextBox>
</asp:Panel>

<asp:Panel ID="divLookup" runat="server" Visible="false">
    <div class="form-group">
        <asp:Label ID="Label7" runat="server" CssClass="control-label" Text="Campos de resultado"></asp:Label>
        <div class="input-group">
            <asp:TextBox ID="txLookupResultFields" CssClass="form-control" runat="server" ReadOnly="true" />
            <span class="input-group-btn">
                <asp:LinkButton ID="btnLookupResultFields" CssClass="btn btn-default" runat="server" data-toggle="modal" OnClientClick="$('#lookupResultFields').modal('show');applyDragNDrop();">
                            <i class="fa fa-pencil"></i>
                </asp:LinkButton>
            </span>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label8" runat="server" CssClass="control-label" Text="Critério de seleção" />
        <div class="input-group">
            <asp:TextBox ID="txtWhere" runat="server" CssClass="form-control"></asp:TextBox>
            <span class="input-group-btn">
                <button class="btn btn-default" onclick="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtWhere.ClientID %>');">
                    <i class="fa fa-pencil"></i>
                </button>
            </span>
        </div>
    </div>
</asp:Panel>

<asp:Panel ID="divSQLField" CssClass="form-group" runat="server" Visible="false">
    <div class="form-group">
        <asp:Label ID="Label19" CssClass="control-label" runat="server" Text="Expressão SQL"></asp:Label>
        <div class="input-group">
            <asp:TextBox ID="txtExpression" CssClass="form-control" runat="server"></asp:TextBox>
            <span class="input-group-btn">
                <button class="btn btn-default" onclick="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtExpression.ClientID %>');">
                    <i class="fa fa-pencil"></i>
                </button>
            </span>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label5" CssClass="control-label" runat="server" Text="Tipo do resultado"></asp:Label>
        <asp:DropDownList ID="cmbSqlFieldType" CssClass="form-control" runat="server"></asp:DropDownList>
    </div>
</asp:Panel>

<asp:Panel ID="divImageField" runat="server" CssClass="form-group" Visible="false">
    <asp:Label ID="Label3" runat="server" CssClass="control-label" Text="Tamanho:"></asp:Label>
    <asp:DropDownList ID="cmbThumbnailSize" CssClass="form-control" runat="server">
    </asp:DropDownList>
</asp:Panel>

<asp:Panel ID="divPathField" CssClass="form-group" runat="server">
    <asp:Label ID="Label6" runat="server" CssClass="control-label" Text="Caminho:"></asp:Label>
    <div class="input-group">
        <asp:TextBox ID="txtPath" runat="server" CssClass="form-control"></asp:TextBox>
        <span class="input-group-btn">
            <button class="btn btn-default" onclick="javascript:Benner.TextEditor.show('../TextEditor.aspx','<%= txtPath.ClientID %>');">
                <i class="fa fa-pencil"></i>
            </button>
        </span>
    </div>
</asp:Panel>

<asp:CheckBox runat="server" ID="chkVisible" Text="Visível" />
   
