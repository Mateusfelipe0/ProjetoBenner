<%@ Page Title="Galeria de relatórios" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WebReportsPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:SimpleGrid
            ShowTitle="true"
            Title="Galeria de relatórios"
            runat="server"
            ID="GridReportWeb"
            EntityViewName="R_RELATORIOS.TEC.GRID"
            FormUrl="~/SiteSettings/EditWebReportPage.aspx"
            DisplayRowCommand="true"
            Mode="Selectable" />
    </div>
    <script>
        $(function () {
            $(".portlet-title>.actions").prepend("<div class='btn-group'><a href='http://wiki.benner.com.br/wiki/index.php?title=Categoria%3AReport' class='no-border btn btn-circle btn-default btn-sm' target='_blank'><i class='fa fa-question-circle'></i></a></div>");
        });
    </script>
</asp:Content>
