<%@ Page Title="Criar widget" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CreateWidgetPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wesWidget" %>

<asp:Content ContentPlaceHolderID="Head" runat="server">
    <style>
        .form-body {
            padding: 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:UpdatePanel ID="UPStep" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="CurrentStep" Value="1" ClientIDMode="Static" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="portlet" id="form_wizard">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Adicionar widget</span>
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-wizard">
                <div class="form-body">
                    <ul class="nav nav-pills nav-justified steps">
                        <li><a data-toggle="tab" class="step" href="#tab1"><span class="number">1</span><span class="desc"><i class="fa fa-check"></i>Tipo</span></a></li>
                        <li><a data-toggle="tab" class="step" href="#tab2"><span class="number">2</span><span class="desc"><i class="fa fa-check"></i>Origem dos dados</span></a></li>
                        <li><a data-toggle="tab" class="step" href="#tab3"><span class="number">3</span><span class="desc"><i class="fa fa-check"></i>Atributos</span></a></li>
                    </ul>
                    <div id="bar" class="progress progress-striped" role="progressbar">
                        <div class="progress-bar progress-bar-success"></div>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab1">
                            <div class="row">
                                <wesWidget:AjaxForm runat="server" HideDeveloperCommands="true" EntityViewName="W_CRIARWIDGET.FORM" ShowTitle="false" ID="WidgetForm" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tab2">
                            <div class="row">
                                <wesWidget:AjaxForm runat="server" HideDeveloperCommands="true" FormMode="Insert" EntityViewName="W_CRIARFONTEDADOS.FORM" ShowTitle="false" ID="DataSourceForm" />
                            </div>
                        </div>
                        <div class="tab-pane" id="tab3">
                            <div class="row">
                                <wesWidget:AjaxForm runat="server" HideDeveloperCommands="true" FormMode="Insert" EntityViewName="W_WIDGETGRIDSIMPLES.FORM" ShowTitle="false" ID="AttributesForm" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
                
        $(function () {
            // default form wizard
            $('#form_wizard').bootstrapWizard({
                onTabClick: function (tab, navigation, index, clickedIndex) {
                    return false;
                },
                onNext: function (tab, navigation, index) {
                },
                onPrevious: function (tab, navigation, index) {
                },
                onTabShow: function (tab, navigation, index) {
                    Benner.SourceEditor.init();     
                    var total = navigation.find('li').length;
                    var current = index + 1;
                    var $percent = (current / total) * 100;
                    $('#form_wizard').find('.progress-bar').css({
                        width: $percent + '%'
                    });
                }
            });

            selectCurrentStep = function () {
                  Benner.SourceEditor.init(); 
                var currentStep = $("#CurrentStep").val();
                $('[href="#tab' + currentStep + '"]').tab('show');
                Benner.Control.restoreFocus();
            };

            changeCommandsOrder = function () {           
                $(".tab-pane.active .custom-action").each(function (index) {
                    let save = $(".tab-pane.active .btn-save").eq(index);
                    $(save).before(this);
                    $(this).after("&nbsp;");
                });
            };

            // Application event handlers for component developers.
            var prm = Sys.WebForms.PageRequestManager.getInstance(); 
            if (!prm.get_isInAsyncPostBack()) {
                prm.add_endRequest(function (sender, args) {
                    selectCurrentStep();
                    changeCommandsOrder(0);
                    changeCommandsOrder(1);
                });
            }
        });
    </script>
</asp:Content>
