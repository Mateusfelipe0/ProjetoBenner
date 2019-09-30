<%@ Page Title="Agendamentos" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ScheduleGridPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GridSchedules" Title="Agendamentos" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Schedules/Form.aspx" UserDefinedCriteriaWhereClause="" UserDefinedDataSourceParameters="" CompanyFilterMode="None" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="100" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_AGENDAMENTOS.GRID" />
    </div>
</asp:Content>
