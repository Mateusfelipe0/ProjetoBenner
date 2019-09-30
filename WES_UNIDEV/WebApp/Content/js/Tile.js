import Page from './Page';

var Tile = function () {
    var initTile = function (tileDefinition) {
        App.blockUI({ target: $("#" + tileDefinition.Id + " .widget-body"), animate: true });
        $.ajax({
            type: 'POST',
            contentType: 'application/json',
            url: Page.getApplicationPath() + "api/tile",
            data: JSON.stringify(tileDefinition),
            async: true
        }).success(function (data) {
            renderTile(data);
        }).fail(function (jqXHR, data) {
            var tile = $('#' + tileDefinition.Id);
            tile.find('.tilevalue').text("ERRO");
            tile.find('.tiledescription').text("mais detalhes no console");
            console.log(jqXHR.responseJSON.ExceptionMessage);
        }).complete(function () { App.unblockUI($("#" + tileDefinition.Id + " .widget-body")); });
    };

    var renderTile = function (data) {
        var tile = $('#' + data.Id);

        tile.find('.tilevalue').append(data.Value);
        tile.find('.tiledescription').append(data.Description);

        if (data.TileType == 1) {
            var colorField = tile.find('.tilecolor[data-tilecolor]');
            var colorFieldOldValue = colorField.data('tilecolor');
            colorField.removeClass(colorFieldOldValue).addClass(data.Color);
            tile.find('.tileicon').removeClass().addClass(data.Icon);
        }
        else if (data.TileType == 2) {
            var colorField = tile.find('.tilecolor[data-tilecolor]');
            var colorFieldOldValue = colorField.data('tilecolor');
            colorField.removeClass('font-' + colorFieldOldValue).addClass('font-' + data.Color);
            tile.find('.tileicon').removeClass().addClass(data.Icon);
            if (data.Progress == null)
                data.Progress = "";
            else
                data.Progress = data.Progress + '%';
            tile.find('.tileprogress.tilecolor').width(data.Progress).removeClass(colorFieldOldValue).addClass(data.Color);
            tile.find('.tileprogress:not(.tilecolor)').append(data.Progress);
            if (data.Status == null)
                data.Status = " ";
            tile.find('.tilestatus').append(data.Status);
        }
        else if (data.TileType == 3) {
            var colorIconField = tile.find('.tilecolor.tileicon');
            var colorFieldOldValue = colorIconField.data('tilecolor');
            colorIconField.removeClass('bg-' + colorIconField.data('tilecolor')).removeClass(colorIconField.data('tileicon')).addClass('bg-' + data.Color).addClass(data.Icon);
            tile.find('.tileprefix').append(data.Prefix);
        }
    };
    return {
        init: function (tile, stateId) {
            initTile(tile);
        },
        render: function (tile) {
            renderTile(tile);
        }
    };
}();

export default Tile;