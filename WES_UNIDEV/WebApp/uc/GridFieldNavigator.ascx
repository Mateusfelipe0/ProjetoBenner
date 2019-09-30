<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.GridFieldNavigatorControl" %>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            Posicionamento
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-2">
                <asp:LinkButton ID="btnLeft" CssClass="btn default command-action predef-action" runat="server" OnClick="OnLeftClick"><i class="fa fa fa-arrow-left"></i></asp:LinkButton>
            </div>
            <div class="col-md-2"></div>
            <div class="col-md-2">
                <asp:LinkButton ID="btnRight" CssClass="btn default command-action predef-action" runat="server" OnClick="OnRightClick"><i class="fa fa fa-arrow-right"></i></asp:LinkButton>
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
</div>
