<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Workflow.WebApp.WorkflowDocumentationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="portlet light">
        <asp:UpdatePanel ID="updatePanel" runat="server">
            <ContentTemplate>
                <asp:LinkButton CssClass="btn blue" runat="server" type="button" id="btnPrint" Text="Imprimir"  OnClientClick="javascript:this.style='display: none;';window.print();"></asp:LinkButton>
                <asp:Panel runat="server" id="Documentation" class="portlet-body form"></asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>