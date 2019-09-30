import Page from './Page';
import Control from './Control';
import ModalPage from './ModalPage';
import Grid from './Grid';
import Services from './Services';
import { FormModeReadOnly, FormModeView } from './FormMode.js';

var Search = function () {

    var PAGE_SIZE = 50;

    var handleSelect2 = function () {

        if ($().select2) {

            $('select.benner-search.select2-hidden-accessible').each(function () {

                let recordSelectedModify = false;
                $(this).on('select2:opening', function () {
                    var $body = $('body');

                    $body.data('last-focus', this.id);
                    $body.data('focus-at', 'same');

                    recordSelectedModify = false;
                });

                $(this).on('select2:select', function (details) {
                    Search.valueChanged(this, details, 0);

                    var lookup = $(this)[0];
                    var url = $(lookup).attr('postback-url');

                    if (url !== null) {
                        eval(url);
                    }

                    recordSelectedModify = true;
                    //Quando tiver python o campo não deve restaurar o foco agora, porque o evento não foi executado ainda
                    if ($(lookup).data('changeeventtype') !== "callpython")
                        Control.restoreFocus();
                });

                $(this).on('select2:unselect', function (details) {
                    Search.valueChanged(this, details, 1);

                    recordSelectedModify = true;

                    if ($($(this)[0]).data('changeeventtype') !== "callpython") {
                        // Precisa do setTimeout ou o foco não funciona. Isso é confusão do select2.
                        setTimeout(function () { Control.restoreFocus(); }, 1);
                    }
                });

                $(this).on('select2:close', function (event) {
                    if (event.params.originalSelect2Event === undefined) {
                        $(this).addClass("select2-event-close"); 
                        
                        if (!recordSelectedModify && $(this).data('unselecting')) {
                            $(this).removeData('unselecting');
                        } else {
                            Control.restoreFocus();
                        }
                    }
                });

                // Hack que remove o comportamento padrão do Select2 de abrir a caixa de busca
                // quando um item é removido pelo x no componente.
                // Link para a discussão com o hack https://github.com/select2/select2/issues/3320
                $(this).on('select2:unselecting', function (e) {
                    $(this).data('unselecting', true);
                }).on('select2:open', function (e) {
                    if ($(this).data('unselecting')) {
                        $(this).select2('close');
                    }
                });

                // opções de inicialização do select2
                var options = {};
                var self = $(this);
                options.placeHolder = $(this).data('placeholder');
                options.closeOnSelect = $(this).data('closeonselect');

                var fieldName = $("#" + $(this).data("inputhiddenid")).data("field");
                //Ao recriar o select2 no firefox o display era atribuido "inline"
                //Assim tornando o layout do incorreto
                $(this).css("display", "inline-block");
                // both
                options.formatAjaxError = formatAjaxError;
                options.id = buildSelectionId(self.attr('id'));
                options.searchOnEnter = $(this).data('searchonenter');
                options.allowClear = !$(this).prop('multiple');
                options.width = "off";
                options.theme = "bootstrap";
                options.language = "pt-BR";
                options.ajax = {
                    type: 'POST',
                    url: Page.getApplicationPath() + "api/search",
                    idSelect2: self.attr('id'),
                    dataType: 'json',
                    quietMillis: 200,
                    data: function (params) {
                        try {
                            if (params.term === undefined)
                                params.term = "";
                            params.page = params.page || 1;

                            var fields = "";
                            var changeEventType = $(this).data('changeeventtype');
                            if (changeEventType === "callpython" || changeEventType === "callscriptui") {
                                fields = Search.getFieldsToJson($(this));
                            }

                            return {
                                query: params.term,
                                targetEntity: $(this).data('targetentity'),
                                targetView: $(this).data('lookupviewname') ? $(this).data('lookupviewname') : '',
                                resultFields: $(this).data('resultfields'),
                                serverStateKey: $(this).attr('id'),
                                dependValueList: Search.recoverDependValueList($(this)),
                                sourceEntity: $(this).data('sourceentity') ? $(this).data('sourceentity') : '',
                                selectAnyStructuredLevel: $(this).data('selectanylevel') === 'True',
                                formDefinitionName: $(this).data('formdefinitionname') ? $(this).data('formdefinitionname') : '',
                                entitySessionKey: $(this).data('entitykey') ? $(this).data('entitykey') : '',
                                fieldName: fieldName,
                                maxRows: PAGE_SIZE,
                                startRow: (PAGE_SIZE * (params.page - 1)),
                                fieldsJson: fields
                            };
                        }
                        catch (err) {
                            $(this).select2("close");
                            throw err;
                        }
                    },
                    processResults: function (data, params) {
                        return {
                            results: data,
                            pagination: {
                                more: data.length == PAGE_SIZE
                            }
                        };
                    },
                    error: function (jqXHR, status, error) {
                        if (jqXHR.status === 401 || jqXHR.status === 302) {
                            $(self).select2({ data: [{ id: -1, text: 'A sua sessão expirou.' }] });
                            $(self).select2("open");
                        }
                    }
                };

                if (!$(this).prop('multiple'))
                    options.templateSelection = templateSelectionItem;

                $(this).select2(options);
            });
        }
    };

    var templateSelectionItem = function (item) {
        if (!item.id) {
            return item.text;
        }

        var $item = $('<span class="selected-item">' + item.text + '</span>');
        return $item;
    };

    // both
    var buildSelectionId = function (e) {
        return JSON.stringify(e);
    };

    // both
    var formatAjaxError = function (jqXHR, textStatus, errorThrown) {
        //Os browsers retornavam mensagens de erros diferentes quando a sessão expira
        if (jqXHR.status === 401)
            return jqXHR.statusText;

        if (jqXHR.responseJSON === undefined)
            return errorThrown;

        if (!jqXHR.responseJSON.ExceptionMessage || !jqXHR.responseJSON.ExceptionMessage.length) {
            if (!jqXHR.responseJSON.Message || !jqXHR.responseJSON.Message.length)
                return errorThrown;

            return jqXHR.responseJSON.Message;
        }
        return jqXHR.responseJSON.ExceptionMessage;
    };

    return {
        init: function () {
            handleSelect2();
        }
    };
}();

Search.dependValueList = "";

Search.getFieldsToJson = function ($search) {
    let uniqueId = $search.parents("[widget-uniqueid]").attr("id");

    if (Benner.Form[uniqueId] == null) {
        if (Benner.Grid[uniqueId] != null && Benner.Grid[uniqueId].hasFilter) {
            return JSON.stringify(Benner.Grid[uniqueId].filterFields());    
        }
    } else {
        return JSON.stringify(Benner.Form[uniqueId].toJson());
    }
}

Search.addDependValueList = function (dataField, details) {
    //Adiciona na lista de campo dependentes o campo pai
    if (details.params !== undefined) {
        if (details.params === null) {
            //Adiciona na lista de campo dependentes os campos que depende
            Search.dependValueList = "|" + dataField + Search.dependValueList;
            return true;

        } else if (details.params.data.id !== -1) {
            //Adiciona na lista de campo dependentes o campo pai
            Search.dependValueList = dataField + Search.dependValueList;
        }
    } else {
        Search.dependValueList = dataField;
    }
    return false;
};

Search.callScriptPython = function (searchControl, changeEventParam) {
    Control.storeCurrentFocus(searchControl, "same");
    Control.callFieldEventScript(changeEventParam, Search.dependValueList);

    Search.dependValueList = "";
};

Search.getEventParam = function () {
    //Garante que não existe '|' no inicio da linha
    if (Search.dependValueList.charAt(0) == "|")
        Search.dependValueList = Search.dependValueList.substring(1, Search.dependValueList.length);
    //Recupera o primeiro item da lista
    var dataField = Search.dependValueList.substring(0, Search.dependValueList.indexOf("|"));
    return $("[data-field='" + dataField + "']").data('changeeventparam');
};

Search.updateValueSelected = function (idSearchControl, typeOperation) {
    var selectedVal;

    let control = $("#" + idSearchControl);
    if (control.attr("multiple") === "multiple") {
        var itemsSelected = [];
        var itemsSelectedData = control.select2("data");
        for (var i = 0; i < itemsSelectedData.length; i++) {
            itemsSelected.push({ id: itemsSelectedData[i].id, text: itemsSelectedData[i].text });
        }
        selectedVal = JSON.stringify({ Readonly: false, View: false, SelectedItems: itemsSelected });
    } else {
        if (typeOperation === 1) {
            selectedVal = "";
        } else {
            selectedVal = JSON.stringify({
                Readonly: false,
                View: false,
                SelectedItems: [{ id: control.val(), text: control.find(":selected").text() }]
            });
        }
    }

    let $inputHidden = Search.getInputHidden(control);
    $inputHidden.val(selectedVal);
};

Search.setValue = function (id, value) {
    var objValue = JSON.parse(value);

    parent.$("#" + id).append("<option value=" + objValue.ID + " selected=\"selected\">" + objValue.Value + "</option>");
    parent.$("#" + id).trigger("select2:select");

    parent.Benner.ModalPage.hide();

    parent.$("#" + id).trigger("focus");
};

//Verifica se o usuário possui permissão para visualizar o botão para realizar cadastro no lookup
Search.validationPermissionButtonRegister = function (searchControl, typeOperation) {
    if (typeOperation === 0 && $(searchControl).data("canupdate") === "False")
        return false;
    else if (typeOperation === 1 && $(searchControl).data("caninsert") === "False")
        return false;

    return true;
};

Search.createButtonToRegister = function (searchControl, typeOperation) {
    if ($(searchControl).data("url") !== "" && $(searchControl).data("canurl") === "True") {

        var btnKeepRecord = $(searchControl).parent().find(".input-group-btn.keep-record");
        if (!Search.validationPermissionButtonRegister(searchControl, typeOperation))
            btnKeepRecord.hide();
        else
            btnKeepRecord.show();

        if (typeOperation === 0) {
            btnKeepRecord.children().attr("class", "btn blue");
            btnKeepRecord.children().children().attr("class", "fa fa-pencil");
        } else {
            btnKeepRecord.children().attr("class", "btn green");
            btnKeepRecord.children().children().attr("class", "fa fa-plus");
        }
    }
};

Search.valueChanged = function (searchControl, details, typeOperation) {

    if (searchControl == null)
        return;

    var containerControl = Search.getContainerControl($(searchControl).attr("id"));

    var dataField = Search.getField(searchControl);

    Search.updateValueSelected($(searchControl).attr("id"), typeOperation);
    Search.createButtonToRegister(searchControl, typeOperation);

    // Deve limpar os dependidos caso seja um lookup normal ou caso seja um filtro, neste caso o 'removed' será um array e não um objeto. 
    // Ainda, caso seja um array ele deverá ter ao menos 1 elemento.
    Search.clearDepends(dataField, containerControl);

    var changeEventType = $(searchControl).data('changeeventtype');
    if ((!changeEventType || !changeEventType.length) && (details.added !== undefined && details.added.id === -1)) {
        return;
    }

    var changeEventParam = $(searchControl).data('changeeventparam');

    switch (changeEventType) {
        case "callpython":
            if (Search.addDependValueList(dataField, details))
                return;
            Search.callScriptPython(searchControl, changeEventParam);

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_endRequest(function endRequest(sender, args) {
                Search.updatePathFields(searchControl, containerControl);
                Sys.WebForms.PageRequestManager.getInstance().remove_endRequest(endRequest);
            });
            break;
        case "rowchanged":
            Grid.rowChanged(changeEventParam.lblchangerecord, changeEventParam.grid + "_DataChangedCollecion", changeEventParam.handle);
            Search.updatePathFields(searchControl, containerControl);
            Control.storeCurrentFocus(searchControl, "same");
            break;
        default:
            // Caso seja vazio recupera o primeiro eventparam da lista de camps dependente
            if (changeEventParam == undefined || changeEventParam === "")
                changeEventParam = Search.getEventParam();

            Search.updatePathFields(searchControl, containerControl);
            Search.callScriptPython(searchControl, changeEventParam);

            break;
    }
};

Search.getContainerControl = function (idSearchControl) {

    var identifierSearchControl = "#" + idSearchControl;
    // verifica se está em uma linha do grid editável
    var gridRow = $(identifierSearchControl).closest("tr[handle!=''][handle]");
    if (gridRow && gridRow.length)
        return gridRow;


    // verifica se está em um filtro de grid
    var filter = $(identifierSearchControl).closest("div.filter-form");
    if (filter && filter.length)
        return filter;


    // verifica se está em um formulário
    var form = $(identifierSearchControl).closest("div.portlet-body.form");
    if (form && form.length)
        return form;


    // verifica se está dentro de um widget qualquer, customizado por exemplo
    var portlet = $(identifierSearchControl).closest("div.portlet");
    if (portlet && portlet.length)
        return portlet;

    // senão encontrou nenhuma das opções, manda o form mesmo
    return $(identifierSearchControl).closest("form");
};

Search.clearDepends = function (sourceFieldName, containerControl) {
    if (!sourceFieldName || !sourceFieldName.length)
        return;

    $(containerControl)
        .find("select[data-dependlist*='$" + sourceFieldName + "$']")
        .each(function () {
            var inputHidden = Search.getInputHidden(this);
            switch ($(inputHidden).data("type")) {
                case "association": {
                    if ($(this).val() !== null) {
                        var evt = $.Event('select2:unselect', {
                            params: null
                        });
                        $(this).val(null).change();
                        $(this).trigger(evt);
                    }
                    break;
                }
                case "aggregation": {
                    $(this).val(null).trigger("select2:unselect");
                    break;
                }
            }
        });
};

Search.updatePathFields = function (sourceControl, containerControl) {
    if (sourceControl == null)
        return;

    var sourceFieldName = Search.getField(sourceControl);
    if (!sourceFieldName || !sourceFieldName.length)
        return;

    var pathFields = [];
    var sourceViewName;

    $(containerControl).find("span[data-type='path'] > input[type='text'][data-dependlist*='$" + sourceFieldName + "$']")
        .each(function () {
            $(this).val('');
            pathFields.push($(this).parent().data('field'));
            if (!sourceViewName || !sourceViewName.length)
                sourceViewName = $(this).data('entityview');
        });
    
    if (!pathFields || !pathFields.length)
        return;
    
    let formMode = new FormModeReadOnly();
    let inputHidden = Search.getInputHidden(sourceControl);
    var sourceFieldValue = formMode.getAssociationFieldValue(inputHidden);
	if (sourceFieldValue === "" || sourceFieldValue == null)
        return;

    Services.getPathFieldResultValues(
        sourceViewName,
        sourceFieldName,
        sourceFieldValue.id,
        pathFields,
        Search.changePathValuesOnSucess(pathFields, containerControl));
};

Search.changePathValuesOnSucess = function (pathFields, containerControl) {
    return function (data) {
        for (var i = 0; i < pathFields.length; i++) {
            var control = Control.getControlByDataField(pathFields[i], containerControl);
            if (control != null) {
                $(control).find("input").val(data[pathFields[i]]);
            }
        }
    };
};

Search.TryRecoverDependValueList = function (searchControl) {
    try {
        Search.recoverDependValueList($("#" + searchControl));
        return true;
    }
    catch (err) {
        return false;
    }
};

Search.recoverDependValueList = function (searchControl) {

    var dependNames = $(searchControl).data('dependlist');
    var containerControl = Search.getContainerControl($(searchControl).attr("id"));

    var result = "";
    if (!dependNames || !dependNames.length)
        return result;

    let formMode = new FormModeReadOnly();
    var dependNameList = $.unique(dependNames.split(",")); //jquery >= 3.0 deve ser usado uniqueSort
    for (var i = 0; i < dependNameList.length; i++) {

        var fieldName = dependNameList[i].replace("~", "");
        fieldName = fieldName.replace(/\$/g, ''); //replaceAll do char '$'
        var fieldValue = "";
        var fieldTitle = fieldName;

        var targetcontrol = Control.getControlByDataField(fieldName, containerControl);
        if (targetcontrol !== null) {
            fieldValue = formMode.getFieldValue(targetcontrol);
            fieldValue = Search.getFieldValue(targetcontrol.getAttribute("data-type"), fieldValue);

            fieldTitle = Search.getFieldLabel(targetcontrol);
        }

        var message = "";
        if (!fieldValue || !fieldValue.length) {
            if (dependNameList[i].indexOf('~') === -1) {
                message = "Falta preencher campo '" + (typeof (fieldTitle) == "undefined" ? fieldName : fieldTitle) + "'.";
                alert(message);
                throw message;
            } else if (targetcontrol == null) {
                fieldValue = -1;
            } else {
                fieldValue = Search.getDefaultValue(targetcontrol);
            }
        }

        if ((!fieldValue || !fieldValue.length) && dependNameList[i].indexOf('~') === -1) {
            message = "Falta preencher campo '" + fieldTitle + "'.";
            alert(message);
            throw message;
        }


        if (result.length > 0)
            result += "|";

        result += fieldName + "=" + fieldValue;
    }

    return result;
};

Search.getFieldValue = function(fieldType, fieldValue) {
    if (!fieldValue)
        return "";

    let value = fieldValue;
    switch (fieldType) {
        case "aggregation":
        case "bit" : {
            let ids = [];
            $(fieldValue).each(function () {
                ids.push(this.id);
            });

            value = ids.join(", ");
            break;
        }
        case "association":
        case "list":
        case "radio":
        case "tab": {
            value = fieldValue.id.toString();
            break;
        };
    }

    return value;
}

Search.getDefaultValue = function (control) {
    switch ($(control).data("type")) {

        case "date":
        case "time": return "@DATA(30/12/1899)";

        case "aggregation":
        case "association":
        case "currency":
        case "number":
        case "integer": return "-1";

        case "list":
        case "boolean":
        case "tab":
        case "radio":
        case "string":
        default: return "";
    }
};

Search.getFieldLabel = function (control) {
    return $(control).data("label");
};

Search.getField = function (control) {
    var inputHidden = Search.getInputHidden(control);
    return $(inputHidden).data("field");
};

Search.getInputHidden = function (control) {
    let $inputId = $(control).data("inputhiddenid");
    let $inputHidden = $("#" + $inputId);

    if ($inputHidden == null) {
        throw new Error('InputHidden não encontrado do lookup: ' + $(control).attr('id'));
    }

    return $inputHidden;
};

Search.close = function () {
    $('select.select2-hidden-accessible').each(function () {
        $(this).select2('close');
    });
};

Search.getFocusedSelect2 = function () {
    var $select2 = $(".benner-search.select2-event-close");
    if ($select2.length > 0) {
        $select2.removeClass("select2-event-close");
        return true;
    }
    return false;
};

export default Search;