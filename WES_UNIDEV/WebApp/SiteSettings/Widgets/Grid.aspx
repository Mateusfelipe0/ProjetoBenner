<%@ Page Title="Widgets" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635907193146401467" Title="Widgets" BootstrapCols="12" EntityViewName="W_WIDGETS.GRID" ChromeState="Normal" ShowTitle="True" CanDelete="True" CanUpdate="True" CanInsert="True" UserDefinedSelectColumnVisible="False" Mode="None" UserDefinedPageSize="20" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" UserDefinedDisableRowSelection="False" PageWidgetHandle="3978" />
        <wes:AjaxForm runat="server" ID="WIDGETID_635907199528758889" Title="Widgets" BootstrapCols="12" ProviderWidgetUniqueId="GRIDWIDGET_635907193146401467" EntityViewName="W_WIDGETS.FORM" ChromeState="Normal" ShowTitle="True" CanDelete="True" CanUpdate="True" CanInsert="True" IncludeRecordInRecentItems="True" UserDefinedCommandsVisible="True" PageWidgetHandle="3979" />
    </div>
</asp:Content>
