<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.Helpers" %>

<!DOCTYPE html>
<html lang="pt" class="no-js">
<head id="Head1" runat="server">
    <wes:HeadSection ID="HeadSection" runat="server" />
    <style>
        .effectImg {
            opacity: 0.6;
            width:217px;
            height:129px;
            border:1px solid black;
        }

        .effectImg:hover {
            opacity: 1;
        }

        .bg-white .modal-header {
            padding: 8px 15px 8px 15px;
        }

        .modal-body .form-group {
            margin-bottom: 0px;
        }

        @media (max-width: 992px) {
            .col-sm-6{
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body class="bg-white">
    <form id="form1" runat="server">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" onclick="javascript:parent.Benner.ModalPage.hide();"></button>
            <h4 class="modal-title">Opções de templates</h4>
        </div>
        <div class="modal-body form-horizontal text-center">
            <div class="form-group">
                <div class="col-sm-6">
                    <a onclick="javascript:selectTemplate('inheritance');">
                        <img id="loginAtual" class="effectImg" src="../Content/img/LoginAtual.png" />
                    </a>
                </div>
                <div class="col-sm-6">
                    <a onclick="javascript:selectTemplate('right');">
                        <img id="loginRight" class="effectImg" src="../Content/img/LoginRight.png" />
                    </a>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-6">
                    <a onclick="javascript:selectTemplate('blur');">
                        <img id="loginBlur" class="effectImg" src="../Content/img/LoginBlur.png" />
                    </a>
                </div>
                <div class="col-sm-6">
                    <a onclick="javascript:selectTemplate('default');">
                        <img id="loginDefault" class="effectImg" src="../Content/img/LoginDefault.png" />
                    </a>
                </div>
            </div>
        </div>
    </form>
    <link href="../content/dist/benner.min.css" rel="stylesheet">
    <script src="<%= UrlResolverHelper.ResolveUrl("~/content/dist/benner.min.js") %>"></script>
    <script type="text/javascript">
        function selectTemplate(template) {
            parent.document.getElementById("hdnTemplateLogin").value = template;
            parent.Benner.ModalPage.hide();
        }
    </script>
</body>
</html>
