<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.SiteSettings.AuthorizationEntityTasksPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel runat="server" ID="updatePanel" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="hdnTaskInclude" />
            <asp:HiddenField runat="server" ID="hdnTaskChanged" />

            <div class="portlet">
                <div class="portlet-title">
                    <div class="caption">
                        <asp:Label runat="server" ID="lblTitle" CssClass="caption-subject font-green-sharp bold uppercase"></asp:Label>
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-actions top nobg no-border commands-bar fluid">
                        <asp:LinkButton runat="server" ID="btnSave" CssClass="btn blue command-action predef-action" Text="<i class='fa fa-check btn-action'></i> Salvar"></asp:LinkButton>
                    </div>

                    <div style="display:-webkit-box">
                        <wes:MultipleSearchControl Width="60%" ID="searchControlTask" runat="server" />
                        <asp:LinkButton runat="server" ID="btnAdd" CssClass="btn green command-action predef-action" Text="<i class='fa fa-plus btn-action'></i> Adicionar"></asp:LinkButton>
                    </div>

                    <div class="table-responsive table-scrollable">
                        <wes:BennerGridView runat="server" ID="gridView"></wes:BennerGridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

