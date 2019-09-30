<%@ Page Title="Máscaras de tabelas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.MaskGridPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:content id="Content1" contentplaceholderid="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid runat="server" ID="GridMascaraTabela" Title="Máscaras de tabelas" BootstrapCols="12" UserDefinedDisableRowSelection="False" FormUrl="~/SiteSettings/Mask/Form.aspx" UserDefinedCriteriaWhereClause="A.EMPRESA = @EMPRESA OR A.TABELA IN (SELECT HANDLE FROM Z_TABELAS WHERE POREMPRESA = 'N')" UserDefinedDataSourceParameters="" CompanyFilterMode="None" DisplayRowCommand="True" SystemFilterOnly="False" UserDefinedPageSize="10" Mode="Search" UserDefinedSelectColumnVisible="False" CanInsert="True" CanUpdate="True" CanDelete="True" ChromeState="Fixed" EntityViewName="Z_MASCARAS.GRID" ShowTitle="True" />
    </div>
</asp:content>
