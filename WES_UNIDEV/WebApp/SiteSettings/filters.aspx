<%@ Page Title="Galeria de filtros" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.FiltersPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="cc1" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Filtros</span>
            </div>
            <div class="actions">
                <cc1:WidgetActionsMenu ID="developerMenu" runat="server" />
            </div>
        </div>
        <div class="portlet-body">
            <asp:LinkButton ID="lnkBtnNewFilter" CssClass="btn green command-action predef-action" runat="server"><i class="fa fa-plus btn-action"></i>Novo</asp:LinkButton>
            <br />
            <br />
            <asp:GridView runat="server" ID="gridFilters" EnableTheming="true" />            
        </div>
    </div>
</asp:Content>
