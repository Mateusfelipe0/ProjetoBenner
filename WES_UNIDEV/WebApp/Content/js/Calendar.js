/*[ Rotinas da Classe DATE */
var BDate = function () {
    var handleDatePickers = function () {
        if (jQuery().datepicker) {
            var dateControl = $('.datepicker:not([readonly])');

            if (dateControl.length > 0) {

                dateControl.datepicker({
                    rtl: App.isRTL(),
                    orientation: "left",
                    autoclose: true,
                    language: "pt-BR",
                    todayBtn: "linked",
                    forceParse: false
                })
                    .off('focus')
                    .click(function () {
                        $(this).datepicker('show');
                    });

                // handle input group button click
                dateControl.next().children('button').on('click', function (e) {
                    e.preventDefault();
                    var datePicker = $(this).parent().parent().find('.datepicker');
                    datePicker.datepicker('show');
                    datePicker.focus();
                });

                dateControl.on('focusout', function (e) {
                    var value = $(this).val();
                    var format = $(this).attr("data-date-format");
                    if (!value || format.length == value.length)
                        return;
                    var textDate = null;
                    if (format.length === 10)
                        textDate = Date.formatDayMonthYear(value, '/');
                    else if (format.length === 7)
                        textDate = "01" + "/" + Date.formatMonthYear(value, '/');
                    else
                        textDate = "01/01/" + value;
                    var date = Date.getDateFromFormat(textDate, 'dd/MM/yyyy');
                    $(this).datepicker('setDate', date);
                });

                dateControl.on('keypress', function (e) {
                    if (e.key === 'h' || e.key === 'H' || e.charCode === 104 || e.keyCode === 72) {
                        $(this).datepicker('setDate', new Date());
                        $(this).change();
                        return;
                    } else
                        return BDate.validationKeyDate(e);
                });

                dateControl.on('keydown', function (e) {
                    $(e.currentTarget).datepicker('hide');
                });

                dateControl.on('paste', function (e) {
                    BDate.validationDatetime(this);
                });
            }
        }
    };

    var handleTimePickers = function () {

        if (jQuery().timepicker) {

            var timeControl = $('.timepicker:not([readonly])');
            if (timeControl.length > 0) {
                timeControl.timepicker({
                    autoclose: true,
                    disableFocus: false,
                    showMeridian: false,
                    minuteStep: 5,
                    defaultTime: false,
                    twoDigitsHour: true
                });

                //// handle input group button click
                timeControl.next().children('button').on('click', function (e) {
                    e.preventDefault();
                    $(this).parent().parent().find('.timepicker').timepicker('showWidget');
                });

                timeControl.on('keypress', function (e) {
                    return BDate.validationKeyTime(e);
                });

                timeControl.on('paste', function (e) {
                    BDate.validationDatetime(this);
                });
            }
        }
    };

    var handleDateLanguage = function () {

        $.fn.datepicker.dates['pt-BR'] = {
            days: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"],
            daysShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"],
            daysMin: ["Do", "Se", "Te", "Qu", "Qu", "Se", "Sa", "Do"],
            months: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
            monthsShort: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
            today: "Hoje",
            clear: "Limpar"
        };
    };

    return {
        //main function to initiate the module
        init: function () {
            handleDateLanguage();
            handleDatePickers();
            handleTimePickers();
        }
    };
}();

BDate.validationDatetime = function (control) {

    var input = $(control);
    setTimeout(function () {
        //Busca o formato do campo
        var placeholder = input.attr("placeholder");
        var regex;
        //Utiliza regex apropriada para o campo
        if (placeholder == "aaaa")
            regex = new RegExp(/\d{4}/g);
        else if (placeholder == "mm/aaaa")
            regex = new RegExp(/^(0[1-9]|1[0-2])\/\d{4}$/g);
        else if (placeholder == "dd/mm/aaaa")
            regex = new RegExp(/^(0[1-9]|1\d|2\d|3[0-1])\/(0[1-9]|1[0-2])\/\d{4}$/g);
        else if (placeholder == "hh:mm" || placeholder == "hh:mm:ss")
            regex = new RegExp(/^(?:[01]?[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])*$/g);
        //Caso o campo estaja em um formato incorreto é limpado o campo
        if (regex == !undefined && !regex.test(input.val()))
            input.val("");
    }, 200);
};

//Valida se o caracter digitado é válido para o campo data
BDate.validationKeyDate = function (event) {

    var key = (window.event) ? event.keyCode : event.which;
    if (key > 47 && key < 58)
        return true;
    else
        if (BDate.isNavigationKey(key) ||
            event.key === '/' ||
            key === 0)
            return true;
        else
            return false;
};

//Valida se o caracter digitado é válido para o campo time
BDate.validationKeyTime = function (event) {

    var key = (window.event) ? event.keyCode : event.which;

    if (key > 47 && key < 58)
        return true;
    else
        if (BDate.isNavigationKey(key) ||
            event.key === ':' ||
            key === 0)
            return true;
        else
            return false;
};

BDate.isNavigationKey = function (keyCode) {
    return (keyCode === 13 || // enter
        keyCode === 9 || // tab
        keyCode === 8 || // backspace
        keyCode === 46 || // delete
        keyCode === 37 || // left arrow
        keyCode === 39 || // right arrow
        keyCode === 35 || // end
        keyCode === 36	 // home
    );
};

Date.isValidDate = function (day, month, year) {
    var dteDate = new Date(year, month, day, 12, 0, 0);
    return ((day == dteDate.getDate()) && (month == dteDate.getMonth()) && (year == dteDate.getFullYear()));
};

Date.toDDMMYYYY = function (date) {
    return date.getUTCDate() + "/" + (date.getUTCMonth() + 1) + "/" + date.getUTCFullYear();
};

Date.weekShortDays = ["dom", "seg", "ter", "qua", "qui", "sex", "sab"];
Date.monthNames = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

Date.prototype.addDays = function (d) {
    this.setDate(this.getDate() + d);
    return this;
};

Date.prototype.addMonths = function (mm) {
    this.setMonth(this.getMonth() + mm);
    return this;
};

Date.prototype.addYears = function (yy) {
    this.setFullYear(this.getFullYear() + yy);
    return this;
};

Date.prototype.addMilliseconds = function (ms) {
    this.setMilliseconds(this.getMilliseconds() + ms);
    return this;
};

// Funçao que formata uma string em DD/MM/YYYY
Date.formatDayMonthYear = function (text, separator) {

    // trim()
    var rsText = text.replace(" ", "");

    if (separator == null || separator == "")
        separator = "/";

    // caso seja um texto vazio, apenas retornar vazio
    if (rsText == "")
        return rsText;

    // caso seja um numero menor que 1, aborta
    if (!isNaN(rsText) && (0 + rsText) < 1)
        return rsText;

    // se for um numero e o tamanho for 1 ou 3
    if (!isNaN(rsText) && (rsText.length == 1 || rsText.length == 3))
        rsText = "0" + rsText;

    // se for um numero e o tamanho for 2
    if (!isNaN(rsText) && rsText.length == 2 && (0 + rsText) <= 31)
        rsText = rsText + separator + Date.getCurrentMonth();

    if (!isNaN(rsText) && rsText.length == 7)
        rsText = "0" + rsText;

    // se for um numero e o tamanho for 4, 6 ou 8
    if (!isNaN(rsText) && (rsText.length == 4 || rsText.length == 6 || rsText.length == 8)) {
        var month = rsText.substring(0, 2);
        if (month.charAt(1) == separator)
            month = "0" + month.charAt(0);
        rsText = month + separator + rsText.substring(2, rsText.length);
    }

    if (rsText.length > 2 && rsText.charAt(1) == separator)
        rsText = "0" + rsText;

    // se o tamanho for maior q 3
    if (rsText.length > 3 && rsText.charAt(2) == separator)
        rsText = rsText.substring(0, 3) + Date.formatMonthYear(rsText.substring(3, rsText.length), separator);

    if (separator != "/")
        rsText = rsText.replace("/", separator);

    return rsText;
};

// Funçao que formata uma string em MM/YYYY
Date.formatMonthYear = function (text, separator) {
    // trim()
    var rsText = text.replace(" ", "");

    if (separator == null || separator == "")
        separator = "/";

    // caso seja um texto vazio, apenas retornar vazio
    if (rsText == "")
        return "";

    // caso seja um numero menor que 1, aborta
    if (!isNaN(rsText) && (0 + rsText) < 1)
        return rsText;

    // se for um numero e o tamanho for 1 ou 5
    if (!isNaN(rsText) && (rsText.length == 1 || rsText.length == 5))
        rsText = "0" + rsText;

    // se for um numero e o tamanho for 2
    if (!isNaN(rsText) && rsText.length == 2)
        rsText = rsText + separator + Date.getCurrentYear();

    // se for um numero e o tamanho for 6
    if (!isNaN(rsText) && rsText.length == 6) {
        let month = rsText.substring(0, 2);
        if (month.charAt(1) == separator)
            month = "0" + month.charAt(0);
        rsText = month + separator + rsText.substring(2, rsText.length);
    }

    if (!isNaN(rsText) && rsText.length == 4)
        rsText = rsText.substring(0, 2) + separator + "20" + rsText.substring(2, rsText.length);

    // se NAO for um numero e o tamanho for 6
    if (isNaN(rsText) && rsText.length == 6)
        rsText = "0" + rsText;

    if (separator != "/")
        rsText = rsText.replace("/", separator);

    return rsText;
};

// Funcao que retorna o ano corrente, retorna YYYY
Date.getCurrentYear = function () {
    var d = new Date();
    return d.getFullYear();
};

// Função que pega o mes corrente, retorna MM
Date.getCurrentMonth = function () {
    var s;
    var d = new Date();
    s = "" + (d.getMonth() + 1);
    if (s.length == 1)
        s = "0" + s;
    return s;
};

// Função que formata hora e minuto
Date.formatHourMinute = function (text, separator) {
    var rsText = text.replace(" ", "");

    if (separator == null || separator == "")
        separator = ":";

    // caso seja um texto vazio, apenas retornar vazio
    if (rsText == "")
        return rsText;

    // caso seja um numero menor que 0, aborta
    if (!isNaN(rsText) && !((0 + rsText) > -1))
        return rsText;

    // se for um numero e o tamanho for 1
    if (!isNaN(rsText) && rsText.length == 1)
        rsText = "0" + rsText + separator + "00";

    // se for um numero e o tamanho for 2
    if (!isNaN(rsText) && rsText.length == 2)
        rsText = rsText + separator + "00";

    // se for um numero e o tamanho for 3, faz uns ajustes e passa adiante
    if (!isNaN(rsText) && rsText.length == 3) {
        rsText = rsText.substr(0, 2) + separator + rsText.substr(2, 1) + "0";
    }

    // se nao for um numero e tem tamanho 3
    if (isNaN(rsText) && rsText.length == 3) {
        if (rsText.charAt(1) == separator)
            rsText = "0" + rsText;

        else if (rsText.charAt(2) == separator)
            rsText = rsText + "00";

        else if (rsText.charAt(0) == separator)
            rsText = "00" + rsText;
    }

    // se tiver 4 caracteres e o segundo for :
    if (rsText.length == 4 && rsText.charAt(1) == separator)
        rsText = "0" + rsText;

    // se tiver 4 caracteres e o terceiro for :
    if (rsText.length == 4 && rsText.charAt(2) == separator)
        rsText = rsText + "0";

    // se tiver 4 caracteres e o terceiro não for :
    if (rsText.length == 4 && rsText.charAt(2) != separator)
        rsText = rsText.substr(0, 2) + separator + rsText.substr(2, 2)

    return rsText;
};

// Função que formata hora minuto e segundo
Date.formatHourMinuteSecond = function (text, separator) {
    // trim()
    var rsText = text.replace(" ", "");

    if (separator == null || separator == "")
        separator = ":";

    // caso seja um texto vazio, apenas retornar vazio
    if (rsText == "")
        return rsText;

    // caso seja um numero menor que 0, aborta
    if (!isNaN(rsText) && !((0 + rsText) > -1))
        return rsText;

    // caso tenha 1, 2 ou 4
    if (rsText.length == 1 || rsText.length == 2 || rsText.length == 4)
        rsText = Date.formatHourMinute(rsText, separator) + separator + "00";

    // caso tenha 5, faz uns ajustes e vai adiante
    if (rsText.length == 5) {
        if (rsText.charAt(2) != separator)
            rsText = rsText.substr(0, 2) + separator + rsText.substr(2, 3)
        else
            rsText = rsText + separator + "00";
    }

    // caso tenha 6, faz ajustes e vai adiante
    if (rsText.length == 6) {
        if (rsText.charAt(2) == separator)
            rsText = rsText.substr(0, 3) + Date.formatHourMinute(rsText.substr(3, 3), separator);
        else
            rsText = Date.formatHourMinute(rsText.substr(0, 4), separator) + rsText.substr(4, 2);
    }

    if (rsText.length == 7 && rsText.charAt(4) == separator)
        rsText = Date.formatHourMinute(rsText.substr(0, 4), separator) + rsText.substr(4, 3);

    if (rsText.length == 7) {
        rsText = Date.formatHourMinute(rsText.substr(0, 5), separator) + rsText.substr(5, 2);

        // caso o ajuste não bastou, faz mais uma tentativa
        if (rsText.length == 7)
            rsText = rsText.substr(0, 3) + Date.formatHourMinute(rsText.substr(3, 4), separator);
    }

    return rsText;
};

// ------------------------------------------------------------------
// getDateFromFormat( date_string , format_string )
//
// This function takes a date string and a format string. It matches
// If the date string matches the format string, it returns the
// getTime() of the date. If it does not match, it returns 0.
// ------------------------------------------------------------------
Date.getDateFromFormat = function (val, format) {
    function _getInt(str, i, minlength, maxlength) {
        for (var x = maxlength; x >= minlength; x--) {
            var token = str.substring(i, i + x);
            if (token.length < minlength) { return null; }
            if (_isInteger(token)) { return token; }
        }
        return null;
    }

    function _isInteger(val) {
        var digits = "1234567890";
        for (var i = 0; i < val.length; i++) {
            if (digits.indexOf(val.charAt(i)) == -1) { return false; }
        }
        return true;
    }

    val = val + "";
    format = format + "";
    var i_val = 0;
    var i_format = 0;
    var c = "";
    var token = "";
    var x, y;
    var now = new Date();
    var year = now.getYear();
    var month = now.getMonth() + 1;
    var date = 1;
    var hh = now.getHours();
    var mm = now.getMinutes();
    var ss = now.getSeconds();
    var ampm = "";

    while (i_format < format.length) {
        // Get next token from format string
        c = format.charAt(i_format);
        token = "";
        while ((format.charAt(i_format) == c) && (i_format < format.length)) {
            token += format.charAt(i_format++);
        }
        // Extract contents of value based on format token
        if (token == "yyyy" || token == "yy" || token == "y") {
            if (token == "yyyy") {
                x = 4;
                y = 4;
            }
            if (token == "yy") {
                x = 2;
                y = 2;
            }
            if (token == "y") {
                x = 2;
                y = 4;
            }
            year = _getInt(val, i_val, x, y);
            if (year == null) { return 0; }
            i_val += year.length;
            if (year.length == 2) {
                if (year > 70) { year = 1900 + (year - 0); }
                else { year = 2000 + (year - 0); }
            }
        }
        else if (token == "MMM" || token == "NNN") {
            month = 0;
            for (let i = 0; i < MONTH_NAMES.length; i++) {
                var month_name = MONTH_NAMES[i];
                if (val.substring(i_val, i_val + month_name.length).toLowerCase() == month_name.toLowerCase()) {
                    if (token == "MMM" || (token == "NNN" && i > 11)) {
                        month = i + 1;
                        if (month > 12) { month -= 12; }
                        i_val += month_name.length;
                        break;
                    }
                }
            }
            if ((month < 1) || (month > 12)) { return 0; }
        }
        else if (token == "EE" || token == "E") {
            for (let i = 0; i < DAY_NAMES.length; i++) {
                var day_name = DAY_NAMES[i];
                if (val.substring(i_val, i_val + day_name.length).toLowerCase() == day_name.toLowerCase()) {
                    i_val += day_name.length;
                    break;
                }
            }
        }
        else if (token == "MM" || token == "M") {
            month = _getInt(val, i_val, token.length, 2);
            if (month == null || (month < 1) || (month > 12)) { return 0; }
            i_val += month.length;
        }
        else if (token == "dd" || token == "d") {
            date = _getInt(val, i_val, token.length, 2);
            if (date == null || (date < 1) || (date > 31)) { return 0; }
            i_val += date.length;
        }
        else if (token == "hh" || token == "h") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 1) || (hh > 12)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "HH" || token == "H") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 0) || (hh > 23)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "KK" || token == "K") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 0) || (hh > 11)) { return 0; }
            i_val += hh.length;
        }
        else if (token == "kk" || token == "k") {
            hh = _getInt(val, i_val, token.length, 2);
            if (hh == null || (hh < 1) || (hh > 24)) { return 0; }
            i_val += hh.length; hh--;
        }
        else if (token == "mm" || token == "m") {
            mm = _getInt(val, i_val, token.length, 2);
            if (mm == null || (mm < 0) || (mm > 59)) { return 0; }
            i_val += mm.length;
        }
        else if (token == "ss" || token == "s") {
            ss = _getInt(val, i_val, token.length, 2);
            if (ss == null || (ss < 0) || (ss > 59)) { return 0; }
            i_val += ss.length;
        }
        else if (token == "a") {
            if (val.substring(i_val, i_val + 2).toLowerCase() == "am") { ampm = "AM"; }
            else if (val.substring(i_val, i_val + 2).toLowerCase() == "pm") { ampm = "PM"; }
            else { return 0; }
            i_val += 2;
        }
        else {
            if (val.substring(i_val, i_val + token.length) != token) { return 0; }
            else { i_val += token.length; }
        }
    }
    // If there are any trailing characters left in the value, it doesn't match
    if (i_val != val.length) { return 0; }
    // Is date valid for month?
    if (month == 2) {
        // Check for leap year
        if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { // leap year
            if (date > 29) { return 0; }
        }
        else { if (date > 28) { return 0; } }
    }
    if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
        if (date > 30) { return 0; }
    }
    // Correct hours value
    if (hh < 12 && ampm == "PM") { hh = hh - 0 + 12; }
    else if (hh > 11 && ampm == "AM") { hh -= 12; }
    return new Date(year, month - 1, date, hh, mm, ss);
};

/*]*/

export default BDate;