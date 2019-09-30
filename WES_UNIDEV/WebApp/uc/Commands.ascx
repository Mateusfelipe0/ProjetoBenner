<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CommandsControl" %>

<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            Comandos
        </div>
        <div class="actions">
            <div class="btn-group">
                <button class="btn btn-sm green" type="button" data-toggle="dropdown"><i class="fa fa-plus"></i></button>
                <ul class="dropdown-menu" role="menu">
                    <li>
                        <asp:LinkButton ID="btnAddCommand" runat="server" OnClick="OnAddCommandClick">Comando</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="btnAddGroup" runat="server" OnClick="OnAddGroupClick">Agrupador</asp:LinkButton>
                    </li>
                </ul>
            </div>
            <asp:LinkButton ID="btnCommandDelete" OnClick="OnCommandDeleteClick" runat="server" CssClass="btn btn-sm red"><i class="fa fa-minus"></i></asp:LinkButton>
            <div class="btn-group">
                <asp:LinkButton ID="btnCommandUp" OnClick="OnCommandUpClick" runat="server" CssClass="btn btn-sm btn-default "><i class="fa fa-arrow-up"></i></asp:LinkButton>
                <asp:LinkButton ID="btnCommandDown" OnClick="OnCommandDownClick" runat="server" CssClass="btn btn-sm btn-default"><i class="fa fa-arrow-down"></i></asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <div class="col-md-12">
                <asp:TreeView ID="treeView" NodeStyle-NodeSpacing="3px" runat="server" ImageSet="Arrows" SkipLinkText="" ForeColor="Black" ShowLines="False" ViewStateMode="Enabled" Font-Underline="False">
                    <RootNodeStyle Font-Bold="False" Font-Size="12pt" Font-Underline="False" />
                    <ParentNodeStyle Font-Bold="False" Font-Underline="False" />
                    <HoverNodeStyle Font-Underline="False" />
                    <SelectedNodeStyle Font-Underline="False" Font-Bold="true" />
                    <NodeStyle Font-Size="11pt" Font-Underline="false" />
                </asp:TreeView>
            </div>
        </div>
    </div>
</div>