<%@ Page Title="Definição de entidade" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EntityPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="portlet light">
                <div class="portlet-title">
                    <div class="caption">
                        <asp:Label runat="server" ID="lblTitulo" CssClass="caption-subject font-green-sharp bold uppercase" Text="Definição de entidade" />
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:LinkButton ID="lnkBtnEntityDefinitionGenerate" runat="server" CssClass="btn blue" Text="Regerar definição"></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnViewsGenerate" runat="server" CssClass="btn blue" Text="Gerar visões builder"></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnShowXml" runat="server" CssClass="btn grey" Text="Ver XML"></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnDelete" runat="server" CssClass="btn red" Text="Excluir"></asp:LinkButton>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <wes:messagepanel id="messagePanel" runat="server"></wes:messagepanel>
                            <wes:ExceptionMessageViewerControl id="exceptionMessage" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label>Selecione os tipos de visões para geração da camada builder:</label><br />
                            <div class="checkbox-list-item"><asp:CheckBox ID="chkForm" Text="Formulário" runat="server" /></div>
                            <div class="checkbox-list-item"><asp:CheckBox ID="chkGrid" Text="Grid" runat="server" /></div>
                            <div class="checkbox-list-item"><asp:CheckBox ID="chkLookup" Text="Lookup" runat="server" /></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <h4>Visões da entidade</h4>
                            <asp:GridView runat="server" ID="gridViews" EnableTheming="true" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

