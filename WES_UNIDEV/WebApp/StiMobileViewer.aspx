<%@ Page Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.StiMobileViewerPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Stimulsoft.Report.Mobile" Namespace="Stimulsoft.Report.Mobile" TagPrefix="cc2" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" />
<style>
    body {
        color: transparent;
        background-color: transparent;
    }
    .stiMobileViewerReportPanel {
        overflow: visible !important;
    }
    .stiMobileViewerPage {
        border: 0px !important;
    }
    .stiMobileViewerPageShadow {
        border: 0px !important;
    }
</style>
<script type="text/javascript">
    function fireRefresh() {
        setTimeout(function () {
            location.reload(true);
        }, 500);
    }
    function fireResize(frameId) {
        document.addEventListener("DOMContentLoaded", function (event) {
            parent.Benner.Widget.resizeWidget(frameId);
        });
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <cc2:StiMobileViewer Visible="false" ID="StiMobileViewer" runat="server" FullScreen="true" />
        </div>
    </form>
</body>
</html>
