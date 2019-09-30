<%@ Page Title="Visualização cubo desktop" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ZCubeVisualizationPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
      <asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:PivotTable runat="server" ID="VISUALIZACAOCUBO" Title="Visualização cubo" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="true" ProviderWidgetUniqueId="" ChromeState="Fixed" CanDelete="True" CanUpdate="True" CanInsert="True" ShowFieldsPanel="False" PivotTableHeight="550" PageId="SITESETTINGS_DESKTOPCUBE_VISUALIZATION" Level="15" Order="10"  />
        </div>
    
      </asp:Content>
    