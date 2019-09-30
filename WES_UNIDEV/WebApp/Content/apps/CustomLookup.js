import ModalPage from '../js/ModalPage';
import Page from '../js/Page';
import Search from '../js/Search';
import Control from '../js/Control';

var CustomLookup = function () {
};

CustomLookup.init = function () {
    $("iframe").contents().keyup(function (e) {
        if (e.keyCode == 27) // esc
        {
            if (parent != null)
                parent.Benner.ModalPage.hide();
            else
                ModalPage.hide();
        }
        if (e.keyCode == 13) // enter
        {
            var $textBox = $(this).find("#searchTextBox");
            if ($textBox.length && $textBox.is(':focus')) {
                var $button = $("iframe").contents().find('#searchButton');
                if ($button.length) {
                    $button.trigger("click");
                    $textBox.focus();
                }
            }
        }
    });
};

CustomLookup.showDialog = function (senderControlId) {
    var sender = $('#' + senderControlId);

    var targetEntity = $(sender).data('targetentity');
    var resultFields = $(sender).data('resultfields');
    var associationField = $("#" + $(sender).data('inputhiddenid')).data("field");
    var whereGuid = senderControlId;
    var dependencyValues = Search.recoverDependValueList($(sender));
    var customPageUrl = $(sender).data("popupurl");
    var selectAnyLevel = $(sender).data("selectanylevel");
    var lookupViewName = $(sender).data("lookupviewname");
    var sourceEntity = $(sender).data("sourceentity");
    var entityKey = $(sender).data("entitykey") ? $(sender).data('entitykey') : '';
    var formDefinitionName = $(sender).data('formdefinitionname') ? $(sender).data('formdefinitionname') : '';
    var fields = "";
    if ($(sender).data('changeeventtype') === "callpython") {
        fields = Search.getFieldsToJson($(sender));
    }

    var queryString =
        "?targetEntityName=" + targetEntity +
        "&resultFieldNames=" + resultFields +
        "&associationFieldName=" + associationField +
        "&whereGuid=" + whereGuid +
        "&dependencyValues=" + dependencyValues +
        "&sourceEntity=" + sourceEntity + 
        "&entityKey=" + entityKey +
        "&formDefinitionName=" + formDefinitionName;

    if (lookupViewName != null && lookupViewName.length > 0)
        queryString += "&lookupViewName=" + lookupViewName;

    if (selectAnyLevel != null && selectAnyLevel)
        queryString += "&selectAnyLevel=1";

    if (customPageUrl == null || customPageUrl.length == 0)
        customPageUrl = Page.getApplicationPath() + "DefaultLookupSearch.aspx";

    Control.storeCurrentFocus("#" + senderControlId, 'same');

    $('body').data('searchControlId', senderControlId);
    $('body').data('scroll-pos', { x: $(window).scrollLeft(), y: $(window).scrollTop() });

    ModalPage.show({ id: senderControlId, size: 'large', height: 495, displayFooter: false, url: customPageUrl + queryString, title: '', executePost: true, fields: fields });
};

CustomLookup.applySelectionAndHideDialog = function (sender) {
    var handle = $(sender).attr("handle");
    var text = $(sender).attr("text");

    ModalPage.hide();

    var searchControlId = $('body').data('searchControlId');
    $('body').data('searchControlId', '');
    var targetcontrol = $('#' + searchControlId);

    if (targetcontrol != null) {

        var selectedItem = { id: parseInt(handle) };

        var selectedData = $(targetcontrol).select2("data");
        if (!selectedData || !selectedData.length)
            selectedData = [];

        var foundItem = _.find(selectedData, { id: selectedItem.id.toString() });

        // caso já esteja selecionado, não faz nada
        if (foundItem !== undefined) {
            Control.restoreFocus();
            return;
        }

        // senão, atualiza a lista, e atualiza a lista no componente
        if ($(targetcontrol).data('multiple') === 'True')
            selectedData.push(selectedItem);
        else
            selectedData = selectedItem;

        $(targetcontrol).append("<option value=" + handle + " selected=\"selected\">" + text + "</option>");
        $(targetcontrol).trigger("select2:select");
    }
};

export default CustomLookup;