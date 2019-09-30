import ModalPage from '../js/ModalPage';
import SourceEditor from '../js/SourceEditor';

var EditCustomField = function () {

};

EditCustomField.initModal = function () {
    parent.Benner.ModalPage.init();
    var valueText = parent.Benner.Apps.CustomField.getTxtLabel().val();
    switch (parent.Benner.Apps.CustomField.getCmbLabelType().val()) {
        case "0":
        case "1": // Text
            $("#sourceText").val(valueText);
            $("#rbText").click();
            break;
        case "2": // HTML
            $("#rbHTML").click();
            var aceEditor = SourceEditor.lastAceEditor();
            aceEditor.getSession().setValue(valueText);
            break;
        case "3": // MVC View
            $("#viewPath").val(valueText);
            $("#rbView").click();
            break;
        case "4": // MVC Controller 
            var obj = JSON.parse(valueText);
            $("#controllerMVC").val(obj.controller);
            $("#actionMVC").val(obj.action);
            $("#rbController").click();
            break;
    }
};

EditCustomField.OnOkClick = function () {
    if ($("#tabText").hasClass("active")) {
        parent.Benner.Apps.CustomField.getTxtLabel().val($("#sourceText").val());
        parent.Benner.Apps.CustomField.getCmbLabelType().val("1");
    } else if ($("#tabHTML").hasClass("active")) {
        var aceEditor = SourceEditor.lastAceEditor();
        var valorHTML = aceEditor.getSession().getValue();
        parent.Benner.Apps.CustomField.getTxtLabel().val(valorHTML);
        parent.Benner.Apps.CustomField.getCmbLabelType().val("2");
    } else if ($("#tabView").hasClass("active")) {
        parent.Benner.Apps.CustomField.getTxtLabel().val($("#viewPath").val());
        parent.Benner.Apps.CustomField.getCmbLabelType().val("3");
    } else if ($("#tabController").hasClass("active")) {
        var obj = {
            controller: $("#controllerMVC").val(),
            action: $("#actionMVC").val()
        };
        parent.Benner.Apps.CustomField.getTxtLabel().val(JSON.stringify(obj));
        parent.Benner.Apps.CustomField.getCmbLabelType().val("4");
    }
    parent.Benner.ModalPage.hide();
};

EditCustomField.setActiveTab = function(tabID) {
    $("#tab-field-option>div.tab-pane").removeClass("active");    
    $("#" + tabID).addClass("active");
    if ($("#tabText").hasClass("active")) {
        $("#sourceText").focus();
    } else if ($("#tabHTML").hasClass("active")) {
        SourceEditor.lastAceEditor().focus(); 
    } else if ($("#tabView").hasClass("active")) {
        $("#viewPath").focus();
    } else if ($("#tabController").hasClass("active")) {
        $("#controllerMVC").focus();
    }
}

EditCustomField.getTxtLabel = function () {
    return $("#" + EditCustomField.txtLabelId);
};

EditCustomField.getCmbLabelType = function () {
    return $("#" + EditCustomField.cmbLabelTypeId);
};

EditCustomField.txtLabelId = null;
EditCustomField.cmbLabelTypeId = null;
EditCustomField.show = function (url, labelValueId, cmbLabelTypeId) {
    EditCustomField.txtLabelId = labelValueId;
    EditCustomField.cmbLabelTypeId = cmbLabelTypeId;
    ModalPage.show({ id: labelValueId, url: url, height: 579, size: "large", displayTitle: false, generateDefaultContent: false });
};

export default EditCustomField;