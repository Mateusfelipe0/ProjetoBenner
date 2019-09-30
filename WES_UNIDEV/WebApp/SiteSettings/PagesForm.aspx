<%@ Page Title="Página" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.PagesFormPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wesWidget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:AjaxForm runat="server" ID="PagesForm" Title="Página" IncludeRecordInRecentItems="true" />
        <div class="col-md-12 widget">
            <div class="portlet light">
                <div class="tabbable-line">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#tabWidget" data-toggle="tab">Widgets</a>
                        </li>
                        <li>
                            <a href="#tabResources" data-toggle="tab">Recursos</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabWidget">
                            <div class="row">
                                <wesWidget:SimpleGrid runat="server" PortletLayout="None" ID="PageWidgetsGrid" DisplayRowCommand="true" Title="Widgets" FormUrl="WidgetAttributes.aspx" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tabResources">
                            <div class="row">
                                <wesWidget:SimpleGrid runat="server" PortletLayout="None" ID="PageResources" Title="Recursos" FormUrl="PageResourcesForm.aspx" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
