import Control from './Control';
import Form from './Form';
import { FormModeReadOnly, FormModeView } from './FormMode';

var Grid = function () {

};

Grid.extend = function (widget) {
    let hasFilter = $(widget.el()).find(".filter-search-form");

    return Object.extend(widget, {
        hasFilter: hasFilter,
        filterFields: function() {
            var form = $(widget.el()).find(".filter-search-form");
            return Form.getFields(form, new FormModeReadOnly());
        },
        select: function (row) {
            __doPostBack(this.uniqueid + "$SimpleGrid", 'Select$' + row);
        },
        getSelected: function () {
            var self = this;
            var result = {};
            $("#" + this.name).find("tr").each(function () {
                if ($(this).hasClass("active")) {
                    var currentHandle = $(this).attr("handle");
                    result = _.find(self.toJson(), p => {
                        return p.handle === currentHandle;
                    });
                }
            });
            return result;
        },
        filter: function (search) {
            if (search) {
                $(this.el()).find('.filter-simple-search input').val(search);
            }
            __doPostBack(this.uniqueid + '$SearchButton', '');
        },
        new: function () {
            this.command("New");
        },
        next: function () {
            __doPostBack(this.currentNodeId + '$btNextPage', '');
        },
        back: function () {
            __doPostBack(this.currentNodeId + '$btPreviousPage', '');
        },
        toJson: function () {
            var model = [];
            var result = [];
            parseGridHeader(model, this.name);
            parseGridContent(model, this.name, result);
            return result;
        }
    });
};

function parseGridHeader(model, name) {
    $("#" + name).find("thead").each(function () {
        $(this).find("th").each(function () {
            var apiField = $(this).attr("data-field");
            if (apiField !== undefined) {
                model.push(apiField);
            }
        });
    });
}

function parseGridContent(model, name, result) {
    $("#" + name).find("tr:not(.totalizer-row)").each(function () {
        var r = {};
        var i = 0;

        $(this).find("td").each(function () {
            if ($(this).attr("data-type") == "boolean") {
                r[model[i++]] = $(this).find("input").prop("checked");
            } else if ($(this).attr("data-field") !== undefined) {
                r[model[i++]] = $(this).text();
            } else {
                $(this).find("span").each(function () {
                    if ($(this).attr("data-type") === "image") {
                        $(this).find("a").each(function () {
                            var link = $(this).attr("href");
                            r[model[i++]] = window.location.origin + link;
                        });
                    }
                });
            }
        });
        if (!$.isEmptyObject(r)) {
            r["handle"] = $(this).attr("handle");
            result.push(r);
        }
    });
}

$(document).keyup(function (e) {
    if (e.keyCode == 13) { // enter
        var $currentFocus = $('input[type=text]:focus,input[type=checkbox]:focus,span:focus,input[type=search]:focus');
        if ($currentFocus.length) {
            var $filterForm = $currentFocus.closest('.filter-search-form, .filter-search-simple');
            if ($filterForm.length) {
                var $comboDropDown = $('.comboDropDown');
                if ($comboDropDown.length == 0 || ($comboDropDown.length && !$comboDropDown.is(':visible'))) {
                    var $button = $filterForm.find($('.filter-button'));
                    if ($button.length) {
                        Control.storeCurrentFocus($currentFocus, 'same');

                        // o onclick do botão filtrar é responsável por armazenar o foco no próximo campo
                        var click = $button.attr('onclick');
                        if (click && click.length)
                            eval(click);
                        // enquanto o href é responsável pelo postback
                        window.location.href = $button.attr('href');
                        return false;
                    }
                }
            }
        }
    }
});

Grid.showRecordCommands = function (listItem) {
    var dropMenu = listItem.getElementsByTagName("div");

    if (dropMenu == null || dropMenu.length == 0)
        return;


    dropMenu[0].style.left = "0px"; // Define posicionamento dos comandos logo abaixo do botão 
    dropMenu[0].style.visibility = "visible";

};

Grid.selectAllRows = function (widgetId, gridClientId, isSimpleGrid) {
    var value = false;
    if ($("#" + gridClientId).find("th.multi-select-column input:checked").length > 0)
        value = true;

    var checkboxlist = $("#" + gridClientId).find("td.multi-select-column label > input");
    for (var i = 0; i < checkboxlist.length; i++) {
        if ($(checkboxlist[i]).prop("checked") !== value)
            $(checkboxlist[i]).prop("checked", value);
        
        if (value)
            $(checkboxlist[i]).parents("tr").addClass("active");
        else
            $(checkboxlist[i]).parents("tr").removeClass("active");
    }

    Grid.updateTotalizersAll(gridClientId, value, isSimpleGrid);
    if (Grid[widgetId] && Grid[widgetId].refreshOnSelectRows)
        Grid[widgetId].refresh();
};

Grid.stopPropagation = function (evt) {
    var event = evt || window.event;

    if (event.stopPropagation)
        event.stopPropagation();
    else
        event.cancelBubble = true;
};

var AggregateOperationOption = { Count: "Count", Sum: "Sum", Average: "Average", Max: "Max", Min: "Min" };

Grid.initializeTotalizers = function (idWidget, isSimpleGrid) {
    let $selectedRows = $("#" + idWidget + " tbody .multi-select-column input:checked");
    for (let i = 0; i < $selectedRows.length; i++) {
        Grid.updateTotalizerRow(idWidget,$selectedRows[i].id, isSimpleGrid);
    }
};

Grid.getTotalizers = function (columnTotalizers) {
    let array = new Array();

    for (let i = 0; i < columnTotalizers.length; i++) {
        let columnTotalizer = columnTotalizers[i];

        let value = 0;
        if (columnTotalizer.dataset.totalizer === AggregateOperationOption.Max) {
            value = Number.MIN_SAFE_INTEGER;
        } else if (columnTotalizer.dataset.totalizer === AggregateOperationOption.Min) {
            value = Number.MAX_SAFE_INTEGER;
        }

        array.push({
            aggregateOperation: columnTotalizer.dataset.totalizer,
            count: 0,
            decimal: columnTotalizer.dataset.mDec,
            name: columnTotalizer.dataset.field,
            type: columnTotalizer.dataset.type,
            value: value
        });
    }

    return array;
};

Grid.loadDataTotalizers = function (idWidget, totalizers, isSimpleGrid) {

    let rows = document.querySelectorAll("#" + idWidget + " tbody > tr.active");
    for (let i = 0; i < rows.length; i++) {
        let columns = rows[i].querySelectorAll("td.item-totalizer");
        for (let j = 0; j < columns.length; j++) {
            let value = Grid.getFieldValue(columns[j], isSimpleGrid);
            Grid.applyTotalizer(totalizers[j], value);
        }
    }
};

Grid.updateTotalizer = function (columnTotalizers, totalizers) {
    for (let i = 0; i < columnTotalizers.length; i++) {
        let columnTotalizer = columnTotalizers[i];
        let totalizerValue = totalizers[i];
        if (totalizerValue.aggregateOperation == AggregateOperationOption.Average && totalizerValue.value > 0) {
            totalizerValue.value = totalizerValue.value / totalizerValue.count;
        }
        columnTotalizer.textContent = Grid.getFormatValue(totalizerValue.value, totalizerValue.type, totalizerValue.decimal);
    }

        columnTotalizers[0].parentNode.classList.add("active");
}

Grid.updateTotalizersAll = function (idWidget, selectChecked, isSimpleGrid) {
    let columnTotalizers = document.querySelectorAll("#" + idWidget + " .totalizer-row > .totalizer-cell");

    if (selectChecked) {
        let totalizers = Grid.getTotalizers(columnTotalizers);

        Grid.loadDataTotalizers(idWidget, totalizers, isSimpleGrid);
        if (document.querySelectorAll("#" + idWidget + " .totalizer-row").length > 0) {
            Grid.updateTotalizer(columnTotalizers, totalizers);
        }

    } else {
        for (let i = 0; i < columnTotalizers.length; i++) {
            let columnTotalizer = columnTotalizers[i];
            columnTotalizer.textContent = columnTotalizer.dataset.valueDb;
        }
        if (columnTotalizers.length > 0) {
            columnTotalizers[0].parentNode.classList.remove("active");
        }
    }
};

Grid.selectRow = function (idWidget, idGrid, idCheckbox, isSimpleGrid) {
    Grid.updateTotalizerRow(idGrid, idCheckbox, isSimpleGrid);
    if (Grid[idWidget] && Grid[idWidget].refreshOnSelectRows)
        Grid[idWidget].refresh();
};

Grid.updateTotalizerRow = function (idWidget, idCheckbox, isSimpleGrid) {
    let $checkbox = $("#" + idCheckbox);
    if ($checkbox.is(":checked"))
        $checkbox.parents("tr").addClass("active");
    else
        $checkbox.parents("tr").removeClass("active");

    let columnTotalizers = document.querySelectorAll("#" + idWidget + " .totalizer-row > .totalizer-cell");

    let rows = document.querySelectorAll("#" + idWidget + " tbody > tr.active:not(.totalizer-row)");
    if (rows.length > 0) {
        let totalizers = Grid.getTotalizers(columnTotalizers);

        Grid.loadDataTotalizers(idWidget, totalizers, isSimpleGrid);
        if (document.querySelectorAll("#" + idWidget + " .totalizer-row").length > 0) {
            Grid.updateTotalizer(columnTotalizers, totalizers);
        }
    } else {
        for (let i = 0; i < columnTotalizers.length; i++) {
            let columnTotalizer = columnTotalizers[i];
            columnTotalizer.textContent = columnTotalizer.dataset.valueDb;
        }
        if (columnTotalizers.length > 0) {
            columnTotalizers[0].parentNode.classList.remove("active");
        }
    }
};

Grid.applyTotalizer = function (fieldTotalizer, newItem) {
    if (newItem === null || newItem.trim() === "")
        return fieldTotalizer.value;

    fieldTotalizer.count++;
    newItem = parseFloat(newItem.replace("R$", "").replaceAll(".", "").replace(",", "."));
    switch (fieldTotalizer.aggregateOperation) {
        case AggregateOperationOption.Count:
            fieldTotalizer.value++;
            break;
        case AggregateOperationOption.Average:
        case AggregateOperationOption.Sum:
            fieldTotalizer.value = fieldTotalizer.value + newItem;
            break;
        case AggregateOperationOption.Max:
            if (fieldTotalizer.value < newItem)
                fieldTotalizer.value = newItem;
            break;
        case AggregateOperationOption.Min:
            if (fieldTotalizer.value > newItem)
                fieldTotalizer.value = newItem;
            break;
    }
};

Grid.getFieldValue = function (field, isSimpleGrid) {

    if (isSimpleGrid) {
        return field.children[0].text;
    } else {
        let $selectField = $(field).find("select");
        if ($selectField.length > 0) {
            return $selectField.val();
        }

        let $inputField = $(field).find("input");
        if ($inputField.length > 0) {
            return $inputField.val();
        }
    }
};

Grid.getFormatValue = function (value, typeField, decimalValue) {
    if (typeField === "currency") {
        value = value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', minimumFractionDigits: 2, maximumFractionDigits: 2 });
    } else if (typeField === "number") {
        value = value.toLocaleString('pt-BR', { minimumFractionDigits: decimalValue, maximumFractionDigits: decimalValue });
    } else if (typeField === "integer" && value.toString().indexOf(".") !== -1) {
        value = value.toString().substr(0, value.toString().indexOf("."));
    }
    return value;
};

Grid.rowChanged = function (idChangeRecord, gridClientId, handle) {
    var hiddenField = document.getElementById(gridClientId);
    if (hiddenField) {
        hiddenField.value = hiddenField.value + handle + '|';
    }
    //Atualiza o label que indica se o registro foi alterado
    if (idChangeRecord != null && idChangeRecord != "") {
        $("#" + idChangeRecord).addClass("bg-red");
    }
};

export default Grid;