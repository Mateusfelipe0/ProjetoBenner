<%@ Page Title="Contadores" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>
   
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
     
      <asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <div class="row">
        <wes:HtmlPanel runat="server" ID="INFO" Title="Info" Subtitle="" PortletCssClass="" PortletLayout="None" BootstrapCols="12" FontIcon="" ShowTitle="true" ProviderWidgetUniqueId="" ChromeState="Normal" HtmlBase64="PGRpdiBjbGFzcz0ibm90ZSBub3RlLWluZm8iPgogICAgPGg0IGNsYXNzPSJibG9jayI+SW5mb3JtYcOnw6NvPC9oND4KICAgIDxwPiBVbSBjb250YWRvciDDqSB1bSByZWN1cnNvIGRvIHNpc3RlbWEgcXVlIHJldG9ybmEgbsO6bWVyb3Mgc2VxdWVuY2lhaXMuIE9zIGNvbnRhZG9yZXMgdW5pdmVyc2FpcyBtYW50w6ptIGFwZW5hcyB1bWEgc2VxdcOqbmNpYSBkZSBuw7ptZXJvcywgZW5xdWFudG8gb3MgbsOjbyB1bml2ZXJzYWlzIHBvc3N1ZW0gdW1hIHNlcXXDqm5jaWEgcGFyYSBjYWRhIGNoYXZlIGluZm9ybWFkYS4gQSBjaGF2ZSBwb2RlIHNlciwgcG9yIGV4ZW1wbG8sIG8gSEFORExFIGRlIHVtIGNsaWVudGUuIE5lc3RlIGNhc28gc2Vyw6EgZ2VyYWRvIHVtIG7Dum1lcm8gc2VxdWVuY2lhbCBwYXJhIGNhZGEgY2xpZW50ZS4gPC9wPgo8L2Rpdj4K" PageId="COUNTERGRID" Level="15" Order="50"  />
        <wes:SimpleGrid runat="server" ID="GRIDWIDGET_635841434724970563" Title="Contadores" Subtitle="" PortletCssClass="" PortletLayout="Default" BootstrapCols="12" FontIcon="" ShowTitle="true" ProviderWidgetUniqueId="" ChromeState="Normal" CanDelete="True" CanUpdate="True" CanInsert="True" EntityViewName="Z_CONTADORES.GRID" Mode="Search" UserDefinedSelectColumnVisible="False" UserDefinedPageSize="10" SystemFilterOnly="False" DisplayRowCommand="True" CompanyFilterMode="OnlyCompany" FormUrl="~/SiteSettings/Counter/Form.aspx" ShowExport="True" UserDefinedDisableRowSelection="False" PageId="COUNTERGRID" Level="15" Order="100"  />
        </div>
    
      </asp:Content>
    