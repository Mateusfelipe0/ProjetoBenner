import '../../assets/plugins/select2/js/select2.full.js';
import Search from '../../js/Search.js';

describe('Teste Select2', () => {
    var html =
        `<!--DEPENDECIAS-->
        <div class="portlet-body form">
            <!--STRING-->
            <input type="text" value="Teste" maxlength="190" id="STRING" class="form-control " data-field="STRING" data-type="string" data-label="String">
            <!--INTEIRO-->
            <input type="text" value="1000" id="INTEIRO" class="form-control  auto-numeric" data-type="integer" data-m-dec="0" data-label="Inteiro" data-v-min="-550" data-field="INTEIRO" data-a-dec="," titlefieldname="INTEIRO" data-a-sep="" data-v-max="9999999">
            <!--VALOR-->
            <input type="text" value="5,90" id="VALOR" class="form-control  auto-numeric" data-type="currency" data-m-dec="2" data-label="Valor" data-v-min="-99999999.99" data-field="VALOR" data-a-dec="," titlefieldname="VALOR" data-a-sep="" data-v-max="99999999.99">
            <!--NUMERICO-->
            <input type="text" value="123,5800" id="NUMERO" class="form-control  auto-numeric" data-type="number" data-m-dec="4" data-label="Numero" data-v-min="-99999999.9999" data-field="NUMERO" data-a-dec="," titlefieldname="NUMERO" data-a-sep="" data-v-max="99999999.9999">
            <!--LOGICO-->
            <label class="boolean-control mt-checkbox mt-checkbox-outline">
                <input id="LOGICO_CHECKBOX" type="checkbox" checked="checked" data-field="LOGICO" data-type="boolean" data-label="Logico">
                <span></span>
            </label>
            <!--DATETIME-->
            <div class="input-group">
                <input type="text" value="23/02/2017" maxlength="10" id="DATA_DATE" class="form-control datepicker placeholder-no-fix " placeholder="dd/mm/aaaa" pattern="([0-9]{2})[\\\/\.\-]([0-9]{2})[\\\/\.\-]([0-9]{4})" data-date-format="dd/mm/yyyy" data-field="DATA" data-type="date" data-label="Data (Dia/Mes/Ano)">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button">
                        <i class="fa fa-calendar"></i>
                    </button>
                </span>
            </div>
            <!--HORA-->
            <div class="input-group">
                <input type="text" value="10:54:42" maxlength="8" id="HORAMINUTOSEGUNDO_TIME" class="form-control timepicker placeholder-no-fix " placeholder="hh:mm:ss" data-show-seconds="true" data-field="HORAMINUTOSEGUNDO" data-type="time" data-label="Hora :Minuto :Segundo">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button">
                        <i class="fa fa-clock-o"></i>
                    </button>
                </span>
            </div>
            <!--TABELA-->
            <div class="input-group select2-bootstrap-append ">
                <select id="tabela" class="benner-search select2-hidden-accessible" data-targetentity="DL_CARROS" data-resultfields="NOME" data-label="Lookup" data-type="association" data-inputhiddenid="tabela_VALUE" data-field="LOOKUP" data-sourceentity="DL_TESTE_CAMPOS" data-lookupviewname="DL_CARROS.LOOKUP" data-changeeventtype="callpython" data-changeeventparam="ctl00_Main_FORMDL_TESTE_CAMPOS" data-placeholder="" data-closeonselect="true" data-systeminstancename="WES_DESENVOLVIMENTO" data-url="" style="display: inline-block;" tabindex="-1" aria-hidden="true">
                    <option value="1" selected="selected">Valor Tabela</option>
                </select>
                <span class="select2 select2-container select2-container--bootstrap select2-container--focus" dir="ltr">
                    <span class="selection">
                        <span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-labelledby="tabela-container">
                            <span class="select2-selection__rendered" id="select2Test-container" title="Valor Tabela">
                                <span class="select2-selection__clear">×</span>
                                <span class="selected-item">Valor Tabela</span>
                            </span>
                            <span class="select2-selection__arrow" role="presentation">
                                <b role="presentation"></b>
                            </span>
                        </span>
                    </span>
                    <span class="dropdown-wrapper" aria-hidden="true"></span>
                </span>
                <span class="input-group-btn">
                    <a class="btn btn-default" onclick="Benner.Apps.CustomLookup.showDialog('tabela');return false;">
                        <i class="fa fa-search"></i>
                    </a>
                </span>
                <span id="ctl00_Main_FORMDL_TESTE_CAMPOS_PageControl_PAG001_PAG001_ctl58_ctl01">
                    <input type="hidden" id="tabela_VALUE" value='{"ReadOnly":false,"View":false,"SelectedItems":[{"id":1,"text":"Valor Tabela"}]}'>
                </span>
            </div>
            <!--FILTRO-->
            <div class="input-group select2-bootstrap-append ">
                <select id="filtro" class="benner-search select2-hidden-accessible" multiple="" data-targetentity="DL_CARROS" data-resultfields="NOME" data-label="Filtro" data-type="aggregation" data-inputhiddenid="FILTRO_VALUE" data-field="FILTRO" data-sourceentity="DL_TESTE_CAMPOS" data-lookupviewname="DL_CARROS.LOOKUP" data-placeholder="Nenhum" data-closeonselect="true" data-systeminstancename="WES_DESENVOLVIMENTO" data-url="" style="display: inline-block;" tabindex="-1" aria-hidden="true">
                    <option value="10" selected="selected">Corolla</option>
                    <option value="11" selected="selected">Fox</option>
                </select>
                <span class="select2 select2-container select2-container--bootstrap select2-container--focus" dir="ltr">
                    <span class="selection">
                        <span class="select2-selection select2-selection--multiple" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="-1">
                            <ul class="select2-selection__rendered">
                                <li class="select2-selection__choice" title="Corolla">
                                    <span class="select2-selection__choice__remove" role="presentation">×</span>Corolla
                                </li>
                                <li class="select2-selection__choice" title="Fox">
                                    <span class="select2-selection__choice__remove" role="presentation">×</span>Fox
                                </li>
                                <li class="select2-search select2-search--inline">
                                    <input class="select2-search__field" type="search" tabindex="0" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" role="textbox" aria-autocomplete="list" placeholder="" style="width: 0.75em;">
                                </li>
                            </ul>
                        </span>
                    </span>
                    <span class="dropdown-wrapper" aria-hidden="true"></span>
                </span>
                <span class="input-group-btn">
                    <a class="btn btn-default" onclick="Benner.Apps.CustomLookup.showDialog('filtro');return false;">
                        <i class="fa fa-search"></i>
                    </a>
                </span>
                <span id="ctl00_Main_FORMDL_TESTE_CAMPOS_PageControl_PAG003_PAG003_ctl06_ctl01">
                    <input type="hidden" id="FILTRO_VALUE" value='{"ReadOnly":false,"View":false,"SelectedItems":[{"id":10,"text":"Corolla"},{"id":11,"text":"Fox 123"}]}'>
                </span>
            </div>
            <!--LISTA-->
            <select id="LISTAselect" class="form-control " data-field="LISTA" data-type="list" data-label="Lista">
                <option value="-1">(nenhum)</option>
                <option value="1">lista 1</option>
                <option value="2" selected="selected">lista 2</option>
                <option value="3">lista 3</option>
                <option value="4">lista 4</option>
                <option value="5">lista 5</option>
            </select>
            <!--RADIO-->
            <div class="mt-radio-inline " data-field="RADIO" data-type="radio" data-label="Radio">
                <label class="mt-radio mt-radio-outline">
                    <input id="GroupRadioButton_RADIO_1" type="radio" value="1">
                    <label>radio 1-1</label>
                    <span></span>
                </label>
                <label class="mt-radio mt-radio-outline">
                    <input id="GroupRadioButton_RADIO_2" type="radio" value="2">
                    <label>radio 1-2</label>
                    <span></span>
                </label>
                <label class="mt-radio mt-radio-outline">
                    <input id="GroupRadioButton_RADIO_3" type="radio" value="3" checked="checked">
                    <label>radio 1-3</label>
                    <span></span>
                </label>
            </div>
            

            <div class="input-group select2-bootstrap-append ">
                <select id="select2Test" class="benner-search select2-hidden-accessible" data-targetentity="DL_CARROS" data-resultfields="NOME" data-label="Lookup" data-type="association" data-inputhiddenid="select2Test_VALUE" data-field="LOOKUP" data-sourceentity="DL_TESTE_CAMPOS" data-lookupviewname="DL_CARROS.LOOKUP" data-changeeventtype="callpython" data-changeeventparam="ctl00_Main_FORMDL_TESTE_CAMPOS" data-placeholder="" data-closeonselect="true" data-systeminstancename="WES_DESENVOLVIMENTO" data-url="" style="display: inline-block;" tabindex="-1" aria-hidden="true">
                    <option value="4" selected="selected">Corolla</option>
                </select>
                <span class="select2 select2-container select2-container--bootstrap select2-container--focus" dir="ltr">
                    <span class="selection">
                        <span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-labelledby="select2Test-container">
                            <span class="select2-selection__rendered" id="select2Test-container" title="Corolla">
                                <span class="select2-selection__clear">×</span>
                                <span class="selected-item">Corolla</span>
                            </span>
                            <span class="select2-selection__arrow" role="presentation">
                                <b role="presentation"></b>
                            </span>
                        </span>
                    </span>
                    <span class="dropdown-wrapper" aria-hidden="true"></span>
                </span>
                <span class="input-group-btn">
                    <a class="btn btn-default" onclick="Benner.Apps.CustomLookup.showDialog('select2Test');return false;">
                        <i class="fa fa-search"></i>
                    </a>
                </span>
                <span id="ctl00_Main_FORMDL_TESTE_CAMPOS_PageControl_PAG001_PAG001_ctl58_ctl01">
                    <input type="hidden" id="select2Test_VALUE" value="{'ReadOnly':false, 'View':false, 'SelectedItems':[{'id':4,'text':'Corolla'}]}">
                </span>
            </div>
        </div>`;

    it('Simula a ação de click no select2', () => {
        document.body.innerHTML = html;
        Search.init();

        var select2El1 = $("#select2Test");
        select2El1.trigger('select2:opening');

        let focusEl = $('body').data('last-focus');
        expect(focusEl).toBe('select2Test');
    });

    it('Atualiza o valor select2 e valida o json gerado', () => {
        document.body.innerHTML = html;

        let option = document.createElement("option");
        option.value = "1";
        option.text = "Item 1";
        option.selected = "selected";

        let select2Test = document.getElementById("select2Test");
        select2Test.remove(0);
        select2Test.add(option, 0);

        Search.updateValueSelected("select2Test", 0);

        let $select2TesteInput = Search.getInputHidden("#select2Test");
        let objValue = JSON.parse($select2TesteInput.val());

        expect(objValue.Readonly).toBeFalsy();
        expect(objValue.View).toBeFalsy();
        expect(objValue.SelectedItems[0].id).toBe("1");
        expect(objValue.SelectedItems[0].text).toBe("Item 1");

        select2Test.remove(0);
        Search.updateValueSelected("select2Test", 1);

        $select2TesteInput = Search.getInputHidden("#select2Test");
        let value = $select2TesteInput.val();
        expect(value).toBe("");
    });

    // it('Valida se consegue recuperar as dependencias dos campos - possui valor', () => {

    //     let containerControl = Search.getContainerControl("select2Test");

    //     let targetcontrol = Search.getControlByDataField("STRING", containerControl);
    //     let fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("Teste");

    //     targetcontrol = Search.getControlByDataField("INTEIRO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("1000");

    //     targetcontrol = Search.getControlByDataField("VALOR", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("5.90");

    //     targetcontrol = Search.getControlByDataField("NUMERO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("123.5800");

    //     targetcontrol = Search.getControlByDataField("LOGICO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("S");

    //     targetcontrol = Search.getControlByDataField("DATA", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("23/02/2017");

    //     targetcontrol = Search.getControlByDataField("HORAMINUTOSEGUNDO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("10:54:42");

    //     targetcontrol = Search.getControlByDataField("LOOKUP", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("1");

    //     targetcontrol = Search.getControlByDataField("FILTRO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("10, 11");

    //     targetcontrol = Search.getControlByDataField("LISTA", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("2");

    //     targetcontrol = Search.getControlByDataField("RADIO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("3");
    // });

    // it('Valida se consegue recuperar as dependencias dos campos - não possui valor', () => {

    //     Search.init();
    //     let containerControl = Search.getContainerControl("select2Test");
        
    //     document.getElementById("STRING").value = "";
    //     document.getElementById("INTEIRO").value = "";
    //     document.getElementById("VALOR").value = "";
    //     document.getElementById("NUMERO").value = "";
    //     $("#LOGICO_CHECKBOX").attr("checked", false);
    //     document.getElementById("DATA_DATE").value = "";
    //     document.getElementById("HORAMINUTOSEGUNDO_TIME").value = "";
    //     let tabela = document.getElementById("tabela");
    //     tabela.remove(0);
    //     Search.updateValueSelected("tabela", 1);
    //     let filtro = document.getElementById("filtro");
    //     filtro.remove(0);
    //     filtro.remove(0);
    //     Search.updateValueSelected("filtro", 1);
    //     document.getElementById("LISTAselect").selectedIndex = 0;
    //     $("#GroupRadioButton_RADIO_3").attr("checked", false);

    //     let targetcontrol = Search.getControlByDataField("STRING", containerControl);
    //     let fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("INTEIRO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("VALOR", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("NUMERO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("LOGICO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("N");

    //     targetcontrol = Search.getControlByDataField("DATA", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("HORAMINUTOSEGUNDO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("LOOKUP", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("FILTRO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("LISTA", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");

    //     targetcontrol = Search.getControlByDataField("RADIO", containerControl);
    //     fieldValue = Search.getFieldValue(targetcontrol);
    //     expect(fieldValue).toBe("");
    // });
});