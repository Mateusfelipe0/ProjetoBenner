<%@ Page Title="Relatórios" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:content id="Content1" contentplaceholderid="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635838874621812082"  Title="Relatórios" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="" UserDefinedCriteriaWhereClause="((A.USUARIO = @USUARIO) OR (A.PRIVADO = 'N'))" UserDefinedDataSourceParameters="" CompanyFilterMode="None" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="R_RELATORIOIMPRESSOES.GRID" />
    </div>
</asp:content>
