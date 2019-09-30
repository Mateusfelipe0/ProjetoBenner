<%@ Page Title="Entrada de Dados Padrão" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<asp:content id="Content1" contentplaceholderid="Main" runat="Server" >
    <div class="row">
        <wesWidget:AjaxForm runat="server" ID="DefaultDataInputForm" Title="" UserDefinedCommandsVisible="True"
            UserDefinedCriteriaWhereClause=""  />
    </div>
</asp:content>
