<%@ Page Title="Monitoramento do cache" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.CacheViewerPage" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Monitoramento de Cache</span>
            </div>
        </div>
        <div class="portlet-body">
            <div class="row">
                <div class="col-md-6">
                    Quantidade de objetos no cache:&nbsp;<asp:Label ID="cacheObjectCount" runat="server" Text="" /><br />
                    Percentual de memória física disponível antes da limpeza do cache:&nbsp;<asp:Label ID="effectivePercentagePhysicalMemoryLimit" runat="server" Text="" /><br />
                    Quantidade de bytes disponível para o cache:&nbsp;<asp:Label ID="effectivePrivateBytesLimit" runat="server" Text="" /><br />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="caption-subject font-green-sharp bold uppercase">Objetos no cache</span>
                            </div>
                            <div class="actions">
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Red" OnClick="clearEntities_Click"><i class="fa fa-trash-o btn-action"></i>Entidades</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Green" OnClick="clearViews_Click"><i class="fa fa-trash-o btn-action"></i>Visões</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Blue" OnClick="clearScripts_Click"><i class="fa fa-trash-o btn-action"></i>Scripts</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Magenta" OnClick="clearFilters_Click"><i class="fa fa-trash-o btn-action"></i>Filtros</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Gold" OnClick="clearMenus_Click"><i class="fa fa-trash-o btn-action"></i>Menus</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Purple" OnClick="clearPages_Click"><i class="fa fa-trash-o btn-action"></i>Paginas</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-default" ForeColor="Orange" OnClick="clearAuthorization_Click"><i class="fa fa-trash-o btn-action"></i>Autorização</asp:LinkButton>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="table-scrollable">
                                <asp:GridView ID="gridView" runat="server">
                                    <Columns>
                                        <asp:BoundField DataField="Type" ItemStyle-Width="70%" HeaderText="Type" SortExpression="Type" />
                                        <asp:BoundField DataField="Category" ItemStyle-Width="20%" HeaderText="Category" SortExpression="Category" />
                                        <asp:BoundField DataField="Count" ItemStyle-Width="10%" HeaderText="Count" SortExpression="Count" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
