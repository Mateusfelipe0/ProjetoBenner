<%@ Assembly Name="Benner.Tecnologia.Wes.Components.WebApp" %>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.FilterControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="wes" %>
<asp:UpdatePanel ID="updatePanelFilter" UpdateMode="Always" runat="server">
    <ContentTemplate>
        <asp:MultiView ID="multiViewFilter" ActiveViewIndex="0" runat="server">
            <asp:View runat="server" ID="viewConditions">
                <div class="portlet light ignore-autofocus">
                    <div class="portlet-title">
                        <div class="caption">
                            <asp:Label runat="server" ID="lblConditions" CssClass="caption-subject font-green-sharp bold uppercase" Text="Condições" />
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <asp:LinkButton ID="addConditionButton" CssClass="btn default command-action predef-action" OnClick="AddConditionButton_Click" runat="server"><i class="fa fa-plus btn-action"></i>Adicionar condição</asp:LinkButton>
                        <asp:LinkButton ID="addWhereConditionButton" CssClass="btn default command-action predef-action" OnClick="addWhereConditionButton_Click" runat="server"><i class="fa fa-plus btn-action"></i>Adicionar condição definida manualmente</asp:LinkButton>
                        <div class="table-responsive table-scroll filter-control">
                            <asp:Table ID="table" runat="server" CssClass="filter-conditions" />
                        </div>
                        <asp:Panel ID="erros" CssClass="alert alert-danger" runat="server" Visible="false">
                            <asp:Label ID="lbErrorMessage" CssClass="" runat="server" Text=""></asp:Label>
                        </asp:Panel>
                    </div>
                </div>

                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption">
                            <asp:Label runat="server" ID="lblLogicalOperators" CssClass="caption-subject font-green-sharp bold uppercase" Text="Operadores Lógicos" />
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="advancedConditionTextBox" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>
            <asp:View runat="server" ID="viewVirtualTable">
                <div class="portlet light ignore-autofocus">
                    <div class="portlet-title">
                        <div class="caption">
                            <asp:Label runat="server" ID="lblVirtualTable" CssClass="caption-subject font-green-sharp bold uppercase" Text="Tabela virtual" />
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblFormView" CssClass="control-label" runat="server" Text="Visão de formulário"></asp:Label>
                                    <wes:SearchControl EnableTheming="true" ID="cmbVirtualTableFormView" runat="server"></wes:SearchControl>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <br />
                                <asp:HyperLink ID="linkVirtualTableViewEditor" CssClass="btn default" runat="server" Text="Editar campos"></asp:HyperLink>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblSelectCriteria" CssClass="control-label" runat="server" Text="Critério de seleção"></asp:Label>
                                    <asp:TextBox ID="txtVirtualTableWhereClause" TextMode="MultiLine" Rows="6" CssClass="form-control" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
    </ContentTemplate>
</asp:UpdatePanel>







