<%@ Page Title="E-mails" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EmailFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormEmail" Title="E-mails" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="False" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_EMAILS.FORM" />
        <wes:SimpleGrid runat="server" ID="GridAnexo" Title="Anexos" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/EmailAttached/Form.aspx" UserDefinedCriteriaWhereClause="A.EMAIL = @CAMPO(HANDLE)" UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="None" UserDefinedSelectColumnVisible="False" DefaultFilterName="" CanInsert="False" CanUpdate="False" CanDelete="False" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_EMAILANEXOS.GRID" />
    </div>
    <script runat="server">
        protected override void LoadWebPartConnections()
        {
            AddWebPartStaticConnection("FormEmailGridAnexo", "FormEmail", "GridAnexo");
        }
    </script>
</asp:Content>
