<%@ Page Title="Iniciar processo" Language="C#" AutoEventWireup="true"
    Inherits="Benner.Tecnologia.Workflow.WebApp.WorkflowDashboardPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:Panel runat="server" ID="Tiles">
        <h3 class="page-title">
            <asp:Label runat="server" ID="Label1" Text="Estatísticas" />
            <small>
                <asp:Label runat="server" ID="Label2" Text="atualizadas a cada" />
                <span id="cache-expiration"><%= CacheExpiration %></span>
                <asp:Label runat="server" ID="Label3" Text="minutos" /></small>
        </h3>
        <div class="row" id="tiles">
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="wfl-total-instancias">
                <div class="dashboard-stat blue" id="wfl-total-instancias-estatisticas">
                    <div class="visual">
                        <i class="fa fa-bar-chart-o"></i>
                    </div>
                    <div class="details">
                        <div class="number">
                            <span class="value"></span>
                            <i class="fa fa-spinner fa-pulse loading hide"></i>
                        </div>
                        <div class="desc">
                            <asp:Label runat="server" ID="lblInstancesTotal" Text="Total de instâncias" />
                        </div>
                    </div>
                    <a runat="server" id="instances" onserverclick="instances_OnServerClick" class="more">
                        <asp:Label runat="server" ID="lblMore" Text="Ver mais" />
                        <i class="m-icon-swapright m-icon-white"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="wfl-instancias-abertas">
                <div class="dashboard-stat green">
                    <div class="visual">
                        <i class="fa fa-sitemap"></i>
                    </div>
                    <div class="details">
                        <div class="number">
                            <span class="value"></span>
                            <i class="fa fa-spinner fa-pulse loading hide"></i>
                        </div>
                        <div class="desc">
                            <asp:Label runat="server" ID="lblExecuting" Text="Em execução" />
                        </div>
                    </div>
                    <a class="more" runat="server" id="InstancesInProgress" onserverclick="InstancesInProgress_OnServerClick">
                        <asp:Label runat="server" ID="lblMore2" Text="Ver mais" />
                        <i class="m-icon-swapright m-icon-white"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="wfl-instancias-atrasadas">
                <div class="dashboard-stat yellow">
                    <div class="visual">
                        <i class="fa fa-clock-o"></i>
                    </div>
                    <div class="details">
                        <div class="number">
                            <span class="value"></span>
                            <i class="fa fa-spinner fa-pulse loading hide"></i>
                        </div>
                        <div class="desc">
                            <asp:Label runat="server" ID="lblDelayed" Text="Atrasadas" />
                        </div>
                    </div>
                    <a class="more" runat="server" id="DelayedInstances" onserverclick="DelayedInstances_OnServerClick">
                        <asp:Label runat="server" ID="lblMore3" Text="Ver mais" />
                        <i class="m-icon-swapright m-icon-white"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="wfl-instancias-erro">
                <div class="dashboard-stat red">
                    <div class="visual">
                        <i class="fa fa-exclamation-triangle"></i>
                    </div>
                    <div class="details">
                        <div class="number">
                            <span class="value"></span>
                            <i class="fa fa-spinner fa-pulse loading hide"></i>
                        </div>
                        <div class="desc">
                            <asp:Label runat="server" ID="lblError" Text="Com erro" />
                        </div>
                    </div>
                    <a class="more" runat="server" id="InstancesWithError" onserverclick="InstancesWithError_OnServerClick">
                        <asp:Label runat="server" ID="lblMore4" Text="Ver mais" />
                        <i class="m-icon-swapright m-icon-white"></i></a>
                </div>
            </div>
        </div>
    </asp:Panel>

    <wesWidget:MenuWidget runat="server" ID="MENU" Title="Menu" MenuID="WORKFLOW" CanInsert="True" CanUpdate="True" CanDelete="True"
        ShowTitle="False" ChromeState="Fixed" EntityViewName="" />

    <asp:Panel runat="server" ID="Chart">
        <div class="portlet light">
            <div class="portlet-title">
                <div class="caption">
                    <span class="caption-subject font-green-sharp bold uppercase">
                        <asp:Label runat="server" ID="lblDashboard" Text="Acompanhamento" />
                    </span><small>
                        <asp:Label runat="server" ID="lblAverageExecutionTime" Text="Tempo médio de execução dos processos" /></small> <i id="loading-chart" class="fa fa-spinner fa-pulse loading hide"></i>
                </div>
                <div class="actions">
                    Unidade 
                    <asp:DropDownList ClientIDMode="Static" ID="unidade" runat="server">
                        <asp:ListItem id="lsiHours" Value="0" Text="Horas" />
                        <asp:ListItem id="lsiMinutes" Value="1" Text="Minutos" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="portlet-body form">
                <div id="tempoprocessos" style="width: 100%; height: 460px;"></div>
            </div>
        </div>
    </asp:Panel>

    <script>

        var HOURS = 0;
        var MINUTES = 1;
        var chart;

        var api = Benner.Page.getApplicationPath() + 'App_Services/WorkflowMonitoringService.svc/api/';

        function renderTileResult(tile, data) {
            $('#' + tile + ' .number .loading').addClass('hide');
            $('#' + tile + ' .number .value').empty().text(data)
        };

        function renderChartResult(element, data) {

            var unit = $('#unidade').val();



            var chartData = [];

            for (var i = 0; i <= data.Processes.length - 1; i++) {

                chartData.push({
                    'Process': data.Processes[i].Process,
                    'ExecutionTime': unit == HOURS ? (data.Processes[i].ExecutionTime / 60).toFixed(2) : data.Processes[i].ExecutionTime
                });
            };


            chart = new AmCharts.AmSerialChart();
            chart.dataProvider = chartData;
            chart.categoryField = "Process";
            chart.theme = "light"
            chart.rotate = true;

            var categoryAxis = chart.categoryAxis;
            categoryAxis.gridPosition = "start";
            categoryAxis.axisColor = "#DADADA";
            categoryAxis.fillAlpha = 1;
            categoryAxis.gridAlpha = 0;
            categoryAxis.fillColor = "#FAFAFA";

            var valueAxis = new AmCharts.ValueAxis();
            valueAxis.axisColor = "#DADADA";
            valueAxis.title = "Tempo médio de execucao das instancias";
            valueAxis.gridAlpha = 0.1;
            chart.addValueAxis(valueAxis);

            var graph = new AmCharts.AmGraph();
            graph.title = "Income";
            graph.valueField = "ExecutionTime";
            graph.type = "column";
            graph.balloonText = "[[category]]:[[value]] ";
            graph.lineAlpha = 0;
            graph.fillColors = "#5b9bd1";
            graph.fillAlphas = 1;
            chart.addGraph(graph);

            chart.creditsPosition = "top-right";

            chart.write(element);

            $('#loading-chart').addClass('hide');
        }

        function callService(operation, data, callback) {
            $.ajax({
                type: 'POST',
                url: api + operation,
                contentType: 'application/json',
                dataType: 'json',
                data: data,
            }).done(function (data) {
                callback(data);
            });
        }

        function renderTileCallback(tileId) {
            var tile = tileId;

            function render(data) {
                renderTileResult(tile, data);
            }

            return render;
        }

        function renderChartCallback(chartId) {
            var chart = chartId;

            function render(data) {
                renderChartResult(chart, data);
            }

            return render;
        }

        function callAllServices() {

            $('.loading').removeClass('hide');
            $('.value').empty();

            callService('startedinstances', {}, renderTileCallback('wfl-total-instancias'));
            callService('instancesinprogress', {}, renderTileCallback('wfl-instancias-abertas'));
            callService('delayedinstances', {}, renderTileCallback('wfl-instancias-atrasadas'));
            callService('instanceswitherror', {}, renderTileCallback('wfl-instancias-erro'));
            callService('averageprocessexecutiontime', {}, renderChartCallback('tempoprocessos'));
        }

        $(function () {

            if ($('#tiles').length) {

                var unit = localStorage.getItem('wfl-process-execution-time-unit');

                if (unit != null)
                    $('#unidade').val(unit);

                callAllServices();
                var timer = $('#cache-expiration').text();
                setInterval(callAllServices, timer * 60000);

                $('#unidade').on('change', function () {
                    chart.clear();
                    $('#loading-chart').removeClass('hide');
                    localStorage.setItem('wfl-process-execution-time-unit', $(this).val());
                    callService('averageprocessexecutiontime', {}, renderChartCallback('tempoprocessos'));

                });

            }


        })
    </script>
</asp:Content>
