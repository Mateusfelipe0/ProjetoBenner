<%@ Page Title="Componentes negócios" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
    
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
      
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FormTaskComponentBusiness"  Title="Componentes negócios" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="Z_TAREFACOMPONENTESNEGOCIO.FORM" />
    </div>
</asp:Content>
    