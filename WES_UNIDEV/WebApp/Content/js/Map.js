import 'ladda/dist/ladda.min.css';
import 'leaflet/dist/leaflet.css';
import 'leaflet.awesome-markers/dist/leaflet.awesome-markers.css';

import 'ladda/dist/spin.min.js';
import Ladda from 'ladda/dist/ladda.min.js';
import L from 'leaflet/dist/leaflet.js';
import 'leaflet.awesome-markers/dist/leaflet.awesome-markers.js';
import async from 'async';
import Page from './Page';

var Map = function () {
    return {
        init: function (mapDefinition) {
            mapDefinition = renderMap(mapDefinition);
            loadPoints(mapDefinition);
        }
    };

    //renderiza o mapa
    function renderMap(mapDefinition) {

        mapDefinition._mapElement = $('.' + mapDefinition.ClassDiv);
        if (mapDefinition._mapElement.length > 0) {
            mapDefinition._mapElement = mapDefinition._mapElement[0];
            var coordenadaInicial = [-15.0, -55];
            var zoomInicial = 4;
            mapDefinition._mapInstance = L.map(mapDefinition._mapElement, { scrollWheelZoom: mapDefinition.MouseZoom, dragging: mapDefinition.Dragging }).setView(coordenadaInicial, zoomInicial);
            mapDefinition._featureGroup = L.featureGroup().addTo(mapDefinition._mapInstance);
            addLayer(mapDefinition);
            return mapDefinition;
        }
    }

    //adciona a layer ao mapa
    function addLayer(mapDefinition) {

        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
            attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
            id: 'mapbox.streets',
            accessToken: 'pk.eyJ1IjoiY2VzYXJhbGJ1cXVlcnF1ZSIsImEiOiJjamQwM2R1MmsxaW8yMnFvMWU0d3B2aTg4In0.qGnX64Wwn1Yo9nB0bGNf9g'
        }).addTo(mapDefinition._mapInstance);
    }

    //carrega da visão os pontos a serem mostrados
    function loadPoints(mapDefinition) {

        if (mapDefinition.PointDefinition != null) {
            $.ajax({
                type: 'POST',
                contentType: 'application/json',
                url: Page.getApplicationPath() + "api/map",
                data: JSON.stringify(mapDefinition.PointDefinition),
                async: true,
            }).success(function (points) {
                mapDefinition._pointsArray = points;
                renderPoints(mapDefinition);
            }).fail(function (jqXHR, data) {
                console.log(jqXHR.responseJSON.ExceptionMessage);
            });
        }
	}

    //renderiza os pontos no mapa
    function renderPoints(mapDefinition) {

        if (!mapDefinition._pointsArray.length) {
            flyToBounds(mapDefinition);
            return;
        }
        else {
            startLoading(mapDefinition);
            async.each(mapDefinition._pointsArray, function (point, callback) {
                var errorMessage = false;
                try {
                    getLatitudeLongitude(mapDefinition, point)
                } catch (e) {
                    errorMessage = 'Erro ao processar o ponto de endereço ' + point.FullAdress;
                } finally {
                    callback(errorMessage);
                }
            }, function (error) {
                if (error)
                    console.log(error);
            });
        }
    }

    //adiciona o marcador ao mapa
    function addMarkerOnMap(mapDefinition, marker, latitudeLongitude) {        

        var markerInstance = createMarker(latitudeLongitude);
        if (markerInstance != null) {
            markerInstance.options.icon = settingMarker(marker.PinFontIcon, marker.PinFontColor, marker.MarkerColor, marker.PinExtraClass);

            if (mapDefinition.UniqueID != null && marker.Id != null && marker.EntityViewName != null)
                markerInstance.on('click', function (e) {
                    __doPostBack(mapDefinition.UniqueID, '{id:' + marker.Id + '}');
                });

            markerInstance.addTo(mapDefinition._featureGroup);
            addPopup(markerInstance, marker.PopupHtmlContent, marker.PopupWidth);
        }

        loadingStatus(mapDefinition);
    }

    //retorna a latitude e logitude do marcador
    function getLatitudeLongitude(mapDefinition, marker) {

        if (marker.Latitude != null && marker.Longitude != null && !isNaN(marker.Latitude) && !isNaN(marker.Longitude)) {
            addMarkerOnMap(mapDefinition, marker, latlongArray(marker.Latitude, marker.Longitude));
        } else if (marker.FullAdress != null)
            findCoordinateByAdress(mapDefinition, marker);
		else
			loadingStatus(mapDefinition);
    }

    //transforma a latitude e logitude em um array coeso
    function latlongArray(lat, long) {

        var latlong = [];
        latlong.push(lat);
        latlong.push(long);
        return latlong;
    }

    //pesquisa a coordenada pelo endereço
    //padrão rua, número, município, estado, pais
    function findCoordinateByAdress(mapDefinition, marker) {

        $.ajax
            ({
                type: "GET",
                url: Page.getApplicationPath() + "api/map/" + marker.FullAdress,
                async: true,
                contentType: 'application/json'
            }).success(function (data) {
                if (data) {
                    var latitudeLongitude = latlongArray(data.Latitude, data.Longitude)
                    addMarkerOnMap(mapDefinition, marker, latitudeLongitude);
                } else {
                    loadingStatus(mapDefinition);
                }
            }).fail(function (jqXHR, data) {
                console.log(jqXHR.responseJSON.ExceptionMessage);
            });
    }

    //cria marcação conforme a coordenada latitude e longitude
    function createMarker(latitudeLongitude) {

        if (latitudeLongitude == null || !Array.isArray(latitudeLongitude) || latitudeLongitude.length != 2) 
            return null;
        
        return L.marker(latitudeLongitude);
    }

    //configura estilo do marcador
    function settingMarker(pinFontIcon, pinFontColor, markerColor, extraClass) {

        var fontIcon = [];
        if (pinFontIcon != null)
            fontIcon = pinFontIcon.split(' ');
        return L.AwesomeMarkers.icon({ icon: fontIcon[1], prefix: fontIcon[0], markerColor: markerColor, extraClasses: extraClass + ' font-' + pinFontColor });
    }

    //adiciona popup ao marcador
    function addPopup(markerInstance, popupHtmlContent, popupWidth) {

        if (popupHtmlContent == null)
            return;
        if (popupWidth == null)
            popupWidth = 150;
        markerInstance.bindPopup(popupHtmlContent, { minWidth: popupWidth });
        markerInstance.on('mouseover', function () {
            markerInstance.openPopup();
        });
        //o popup irá desaparecer após 2500 milissegundos
        markerInstance.on('mouseout', function () {
            setTimeout(function () {
                markerInstance.closePopup()
            }, 2500);
        });
    }

    //voa sobre os pontos afim de uma melhor apresentação
    function flyToBounds(mapDefinition) {

        if (Object.keys(mapDefinition._featureGroup.getBounds()).length > 0)
            mapDefinition._mapInstance.flyToBounds(mapDefinition._featureGroup.getBounds(), { duration: 1.2 });
        else {
            mapDefinition._mapInstance.zoomControl.disable();
            mapDefinition._mapInstance.scrollWheelZoom.disable();
            mapDefinition._mapInstance.dragging.disable();
            $(mapDefinition._mapElement).append('<div class="no-content-map"><h2><strong>Nenhum registro encontrado.</strong></h2></div>');
            $(mapDefinition._mapElement).find('.leaflet-pane').addClass('blur-map');
        }
    }

    //apresenta o loading de pontos no mapa
    function startLoading(mapDefinition) {

        mapDefinition._percentagePerPoint = ((100 / mapDefinition._pointsArray.length) / 100);
        mapDefinition._currentPercentage = 0.0;

        var loadingElement = '<button type="button" data-loading-text="Pontos carregados" class="btn btn-primary mt-ladda-btn ladda-button loading-points" data-style="expand-left" data-size="xs">\
	<span class="ladda-label"> Carregando</span>\
	<span class="ladda-spinner"></span>\
	<div class="ladda-progress" style="width:115px;"></div>\
</button>';
        $(mapDefinition._mapElement).append(loadingElement);

        mapDefinition._loadingProgress = Ladda.create(document.querySelector('.loading-points'));
        mapDefinition._loadingProgress.start();
        mapDefinition._loadingProgress.setProgress(mapDefinition._currentPercentage);
    }

    //atualiza a barra de progresso 
    function loadingStatus(mapDefinition) {

        mapDefinition._currentPercentage = mapDefinition._currentPercentage + mapDefinition._percentagePerPoint;
        mapDefinition._loadingProgress.setProgress(mapDefinition._currentPercentage);

        if (mapDefinition._currentPercentage >= 1) {
            flyToBounds(mapDefinition);
            $('.ladda-label').text('Carregado');
            $('.loading-points').toggle('slow');
        }
    }
}();

export default Map;