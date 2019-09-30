import Page from './Page';

var AmChartsWidget = function () {
    var charts = [];

    function verifyDataLoaderLength(chartVariable, id, state) {
        chartVariable = setExporterPath(chartVariable);

        $.ajax({
            type: "POST",
            url: Page.getApplicationPath() + 'api/datachart/',
            data: JSON.stringify(state),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (jsonRespose) {
                if ((jsonRespose.itens == null || jsonRespose.itens.length == 0) && jsonRespose.menssage != null)
                    setEmptyDataOrFailMessage(chartVariable, id, jsonRespose.menssage);
                else if (jsonRespose.error != undefined)
                    setEmptyDataOrFailMessage(chartVariable, id, jsonRespose.error);
                else
                    setData(chartVariable, jsonRespose.itens);
            },
            error: function (jqxhr, textStatus, error) {
                setEmptyDataOrFailMessage(chartVariable, id, jqxhr.responseJSON);
            },
            timeout: 5000
        });
        // redraw it
        chartVariable.validateNow();
    }

    function setExporterPath(chartVariable) {
        chartVariable.path = Page.getApplicationPath() + 'content/assets/plugins/amcharts/';
        return chartVariable;
    }

    function setEmptyDataOrFailMessage(chart, chartDiv, message) {
        chart.addLabel(0, '50%', message, 'center', 12);
        chart.chartDiv.style.opacity = 0.7;
        chart.legend.enabled = false;
    }

    function setData(chart, data) {
        chart.dataProvider = data;
        chart.validateData();
    }

    function internalHandleClick(uniqueId, data, commandName) {
        var entity = null;
        if (data.item)
            entity = data.item.dataContext;
        else
            entity = data.dataItem.dataContext;

        var alpha = entity["fill_alpha_field"]

        _.forEach(data.chart.dataProvider, function (item) {
            delete item["fill_alpha_field"];
        });

        if (!alpha || alpha == 1)
            entity["fill_alpha_field"] = 0.5;
        else {
            entity["fill_alpha_field"] = 1;
        }

        if (data.chart.type != "pie")
            data.chart.validateData();

        var entityId = (entity.id) ? entity.id : -1;
        var parameter = commandName + "$" + entityId + "$" + JSON.stringify(entity);

        __doPostBack(uniqueId, parameter);
    }

    return {
        init: function (id, objDefinition, uniqueId, commandName, state) {
            if (_.find(charts, function (chart) { return chart.id == id }) == undefined) {
                var widgetId = $('#' + id).closest('.widget').attr('id');
                charts.push({ 'id': widgetId, 'definition': JSON.stringify(objDefinition, null, '\t') });
            }

            var backgroundColor = '#FFF'
            if (objDefinition.theme) {
                if (objDefinition.theme == 'chalk' || objDefinition.theme == 'dark') {
                    backgroundColor = '#282828';
                } else if (objDefinition.theme == 'black') {
                    backgroundColor = '#222222';
                }
            }

            $('#' + id).css('background-color', backgroundColor);

            objDefinition.startDuration = 0.2;

            var chartVariable = AmCharts.makeChart(id, objDefinition);
            verifyDataLoaderLength(chartVariable, id, state);

            var handleClick = function (data) {
                internalHandleClick(uniqueId, data, commandName);
            };

            chartVariable.addListener("clickGraphItem", handleClick);
            chartVariable.addListener("clickSlice", handleClick);
        },

        getChart: function (id) {
            var chart = _.find(charts, function (chart) { return chart.id == id })
            if (chart != null)
                return JSON.parse(chart.definition);
            else
                return null;
        }
    };
}();

export default AmChartsWidget;
