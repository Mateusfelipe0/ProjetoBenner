<%@ Page Title="Nova visão" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.NewViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="portlet light">
                <div class="portlet-title">
                    <div class="caption">
                        <asp:Label ID="lblTitle" CssClass="caption-subject font-green-sharp bold uppercase" runat="server" />
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:LinkButton ID="btnFinish" CssClass="btn blue" runat="server"><i class="fa fa-check"></i> Concluir</asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" CssClass="btn grey-silver" runat="server"><i class="fa fa-times"></i> Cancelar</asp:LinkButton>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Panel ID="pnlError" runat="server"></asp:Panel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label ID="lblEntidade" CssClass="control-label" Text="Definição de entidade" runat="server" />
                                <asp:Panel ID="cmbContainer" runat="server" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblNome" CssClass="control-label" Text="Nome" runat="server" />
                                <asp:TextBox ID="txbName" CssClass="form-control" runat="server" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblCamada" CssClass="control-label" Text="Camada" runat="server" />
                                <asp:DropDownList ID="cmbLayer" CssClass="form-control" runat="server" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblCopia" CssClass="control-label" Text="Cópia de" runat="server" />
                                <asp:DropDownList ID="cmbViewSource" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
