<%@ Page Title="Idiomas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.SiteSettings.TranslateFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FORMWIDGET_635839720809969550" Title="Idiomas" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_IDIOMAS.FORM" ShowTitle="True" />
        <wes:EditableGrid runat="server" ID="WIDGETID_635888129177036401" Title="Traduções" BootstrapCols="12" FormUrl="" UserDefinedCriteriaWhereClause="A.IDIOMA = @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Fixed" UserDefinedSelectColumnVisible="False" DefaultFilterName="Filtro" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_IDIOMATRADUCOES.GRID" ShowTitle="True" />
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FORMWIDGET_635839720809969550WIDGETID_635888129177036401", "FORMWIDGET_635839720809969550", "WIDGETID_635888129177036401");
        }
    </script>
</asp:Content>
