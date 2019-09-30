<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.AuthorizationPageTasksPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:EditableGrid runat="server" ID="GridPageTasks" Title="Tarefas que dão acesso a página" EntityViewName="W_TAREFAPAGINAS.TEC.GRID" />
    </div>
</asp:Content>

