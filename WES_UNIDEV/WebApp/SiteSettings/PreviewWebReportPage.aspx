<%@ Page Title="Prever" Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.PreviewWebReportPage" %>

<%@ Register Assembly="Stimulsoft.Report.Mobile" Namespace="Stimulsoft.Report.Mobile" TagPrefix="Stimulsoft" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:HiddenField ID="taskId" runat="server" />
    <asp:HiddenField ID="nameReport" runat="server" />
    <wes:MessagePanel ID="messagePanel" runat="server"></wes:MessagePanel>
    <div class="ignore-context-menu"></div>
    <Stimulsoft:StiMobileViewer ID="mobileViewer" ShowDesignButton="false" runat="server" Visible="false" Theme="Office2013WhiteBlue" GlobalizationFile=".\SiteSettings\Localization\pt-BR.xml" />
    
    <script type="text/javascript">
        <% if (Request["done"] == null) { %>

            App.setAssetsPath("../content/assets/");
            Benner.ModalMessage.show("Aguarde, gerando o relatório <%= HttpUtility.JavaScriptStringEncode(nameReport.Value) %>...");
            
            function getAsyncReport() {
                //Realiza a chamado do serviço de tempos e tempos para verificar se o relatório terminou
                setTimeout(validReportIsTerminated(), 1000);
            }
            
            function validReportIsTerminated() {
                //Verifica se o relatorio ja terminou
                $.ajax({
                    type: "GET",
                    contentType: "application/json; charset=utf-8",
                    url: Benner.Page.getApplicationPath() + 'SiteSettings/PreviewWebReportPage.aspx/IsTerminated',
                    data: { idTask: <%= Convert.ToInt64(taskId.Value) %> },
                }).done(function (data) {
                    if (data.d) {
                        window.location.replace("<%= Request.RawUrl + "&done=0" %>");
                    } else {
                        getAsyncReport();
                    }
                });
            }

            getAsyncReport();

        <% } else { %>

            function setSizeReportStimulsoft() {
                var $stimulsoft = $(".stiMobileViewerMainPanel > .stiMobileViewerReportPanel > .stiMobileViewerPageShadow");
                var $pageContent = $(".page-content");
            
                if ($stimulsoft.width() > $pageContent.width()) {
                    $stimulsoft.addClass("preview-stimulsoft");
                }
            }

            setSizeReportStimulsoft();

        <% } %>
    </script>
</asp:Content>
