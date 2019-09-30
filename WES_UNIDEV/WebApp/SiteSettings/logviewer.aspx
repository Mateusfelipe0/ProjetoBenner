<%@ Page Title="Visualização log e auditoria" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.LogViewerPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <style>
        .popover {
            max-width: 800px !important;
            width: 600px !important;
        }
    </style>

    <div class="row">
        <wes:SimpleGrid runat="server" Title="Log e auditoria" ID="gridLog" EntityViewName="Z_LOG.TEC.GRID"
            DefaultFilterName="Padrão"
            Mode="Fixed"
            UserDefinedDisableRowSelection="true" />
    </div>
</asp:Content>

