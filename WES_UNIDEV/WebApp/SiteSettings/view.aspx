<%@ Page Title="Propriedades da visão" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <asp:Label runat="server" ID="lblTitulo" CssClass="caption-subject font-green-sharp bold uppercase" Text="Propriedades da visão" />
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-actions nobg no-border commands-bar fluid">
                <asp:LinkButton ID="lnkBtnFields" CssClass="btn blue" runat="server"><i class="fa fa-pencil btn-action"></i>Campos</asp:LinkButton>
                <asp:LinkButton ID="lnkBtnCommands" CssClass="btn blue" runat="server"><i class="fa fa-pencil btn-action"></i>Comandos</asp:LinkButton>
                <asp:LinkButton ID="lnkBtnScripts" CssClass="btn blue" runat="server"><i class="fa fa-pencil btn-action"></i>Scripts</asp:LinkButton>
                <% if (lnkBtnFilters.Visible)
                   {%>
                <asp:LinkButton ID="lnkBtnFilters" CssClass="btn blue" runat="server"><i class="fa fa-pencil btn-action"></i>Filtros</asp:LinkButton>
                <%} %>
                <asp:LinkButton ID="lnkBtnDelete" CssClass="btn red" runat="server">Excluir</asp:LinkButton>
            </div>
            <div class="row static-info">
                <div class="col-md-2 name">
                    <asp:Label runat="server" ID="lblTituloSistema" Text="Sistema: " /></div>
                <div class="col-md-3 value">
                    <asp:Label ID="lbSystem" runat="server" Text="" /></div>
            </div>
            <div class="row static-info">
                <div class="col-md-2 name">
                    <asp:Label runat="server" ID="lblTituloNome" Text="Nome: " /></div>
                <div class="col-md-3 value">
                    <asp:Label ID="lbName" runat="server" Text="" /></div>
            </div>
            <div class="row static-info">
                <div class="col-md-2 name">
                    <asp:Label runat="server" ID="lblNível" Text="Nível: " /></div>
                <div class="col-md-3 value">
                    <asp:Label ID="lbLayer" runat="server" Text="" /></div>
            </div>
        </div>
    </div>
</asp:Content>
