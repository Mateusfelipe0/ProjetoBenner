<%@ Page Title="Processos" Language="C#" AutoEventWireup="true"
    Inherits="Benner.Tecnologia.Workflow.WebApp.WorkflowProcessPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:SimpleGrid runat="server" ID="gridProcesses" Title="Processos" EntityViewName="Z_WFPROCESSOS.GRID" />
        <wesWidget:SimpleGrid runat="server" ID="gridMeusProcessos" Title="Processos iniciados por mim"
            UserDefinedDisableRowSelection="True" FormUrl="~/wfl/a/t/instancia.aspx" UserDefinedCriteriaWhereClause="A.SOLICITADOPOR = @USUARIO"
            UserDefinedDataSourceParameters="" CompanyFilterMode="OnlyCompany" DisplayRowCommand="False"
            UserDefinedPageSize="10" Mode="Selectable" UserDefinedSelectColumnVisible="False"
            DefaultFilterName="" ChromeState="Fixed" EntityViewName="Z_WFMODELOINSTANCIAS.MY.GRID"
            CanInsert="False" CanUpdate="False" CanDelete="False"
            ShowTitle="True" />
    </div>
</asp:Content>
