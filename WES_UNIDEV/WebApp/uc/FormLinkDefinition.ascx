<%@ Control Language="C#" EnableTheming="true" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FormLinkDefinitionControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI"
    TagPrefix="wesUI" %>

<div class="form-group">
    <label class="control-label name column-nowrap">
        <div class="label-form">
            <div class="label-title">
                Url
            </div>
            <div class="label-title-help">
                <i class="fa fa-question-circle help-tooltip" data-original-title="Na url é possível definir parametros na QueryString referênciando um campo, ex: ~/Pages/Default.aspx?handle=@CAMPO(HANDLE)"></i>
            </div>
        </div>
    </label>
    <div class="input-group">
        <asp:TextBox ID="txtUrl" CssClass="form-control autocomplete autocomplete-pages" runat="server"></asp:TextBox>
    </div>
</div>

<div class="form-group">
    <asp:Label ID="lbResource" runat="server" Text="Entidade">
            <div class="label-title">
                Entidade
            </div>
            <div class="label-title-help">
                <i class="fa fa-question-circle help-tooltip" data-original-title="Nome da entidade do widget que receberá os parâmetros na página de destino"></i>
            </div>
    </asp:Label>
    <div class="input-group" style="width: 100%">
        <wesUI:SearchControl ID="cmbEnt" Width="100%" runat="server"></wesUI:SearchControl>
    </div>
</div>

<div class="form-group">
    <label>Modo</label>
    <div class="input-group">
        <asp:DropDownList ID="cmbFormMode" CssClass="form-control" runat="server">
            <asp:ListItem Value="0" Text="Visualização" Selected="True" />
            <asp:ListItem Value="1" Text="Edição" />
            <asp:ListItem Value="2" Text="Inserção" />
            <asp:ListItem Value="3" Text="Visualização, senão inserção" />
            <asp:ListItem Value="4" Text="Edição, senão inserção" />
        </asp:DropDownList>
    </div>
</div>

<div class="form-group">
    <label>Critério de seleção</label>
    <div class="form-group">
        <div class="input-group">
            <asp:TextBox ID="txtWhereClause" CssClass="form-control" runat="server"></asp:TextBox>
            <span class="input-group-btn">
                <asp:LinkButton id="btnWhereClauseEditor" runat="server" CssClass="btn btn-default"><i class="fa fa-filter"></i></asp:LinkButton>
            </span>
        </div>

    </div>
</div>