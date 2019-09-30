<%@ Page Title="Gerador de páginas" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.PageGenerationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Gerador de páginas</span>
            </div>
        </div>
        <div class="portlet-body">
            <div class="alert alert-info">
                <strong>Informação!</strong>
                Gera as páginas (aspx) conforme as configurações de páginas e widgets do sistema. Em uma nova instalação ou quando um novo conjunto de páginas e widgets é instalado, é necessário regerar as páginas.
            </div>
            <asp:Panel ID="outdatedPagesAlert" ClientIDMode="Static" runat="server" CssClass="alert alert-warning">
                <strong>Atenção!</strong>
                As páginas estão desatualizadas, clique em Gerar páginas.
            </asp:Panel>
            <div>
                <a class="btn blue" href="javascript:Benner.Development.generatePages();">Gerar páginas</a>
            </div>
        </div>
    </div>
</asp:Content>
