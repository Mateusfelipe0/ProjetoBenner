<%@ Page Title="Iniciar processo" Language="C#" AutoEventWireup="true"
    Inherits="Benner.Tecnologia.Workflow.WebApp.WorkflowProcessStartPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:AjaxForm runat="server" ID="form" Title="Dados de entrada" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" ChromeState="Fixed" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" />
    </div>
</asp:Content>
