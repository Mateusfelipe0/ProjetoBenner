import 'babel-polyfill';
var ace = require('brace');
require('brace/mode/html');
require('brace/mode/xml');
require('brace/mode/razor');
require('brace/mode/sql');
require('brace/mode/json');
require('brace/mode/text');
require('brace/mode/python');
require('brace/mode/javascript');
require('brace/mode/css');
require('brace/snippets/razor');
require('brace/snippets/xml');
require('brace/snippets/sql');
require('brace/snippets/text');
require('brace/snippets/html');
require('brace/snippets/json');
require('brace/snippets/javascript');
require('brace/snippets/python');
require('brace/snippets/css');
require('brace/theme/chrome');
require("brace/ext/language_tools");

var SourceEditor = function () {
    this.config;
    this.code;
    this.sourceEditor;
    this.editor;
};

SourceEditor.items = Array();

SourceEditor.add = function (idConfig, idCode, idSourceEditor) {
    var aceEditor = new SourceEditor();
    aceEditor.config = idConfig;
    aceEditor.code = idCode;
    aceEditor.sourceEditor = idSourceEditor;
    aceEditor.editor = ace.edit(idSourceEditor);

    SourceEditor.items[SourceEditor.items.length] = aceEditor;

    return aceEditor;
};

SourceEditor.lastAceEditor = function () {
    return SourceEditor.items[SourceEditor.items.length - 1].editor;
};

SourceEditor.AceEditor = function (index) {
    return SourceEditor.items[index].editor;
};

SourceEditor.load = function (idConfig, idCode, idSourceEditor) {
    var aceEditor = SourceEditor.add(idConfig, idCode, idSourceEditor);
    aceEditor.editor.setTheme("ace/theme/chrome");
    aceEditor.editor.setPrintMarginColumn(-1);
    aceEditor.editor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: true
    });
    var config = JSON.parse($("#" + idConfig).val());

    aceEditor.editor.setReadOnly(config.ReadOnly);

    var session = aceEditor.editor.getSession();
    session.setMode("ace/mode/" + config.Language);
    session.setUseWrapMode(true);
    session.setValue($("#" + idCode).val());

    $("#" + idSourceEditor).keyup(function (e) {
        if (e.keyCode == 27) // esc
            e.stopPropagation();
    });

    aceEditor.editor.focus();
};

SourceEditor.save = function () {
    for (var i = 0; i < SourceEditor.items.length; i++) {
        var objAceEditor = SourceEditor.items[i];
        var hidden = $("#" + objAceEditor.code);
        hidden.val(objAceEditor.editor.getSession().getValue());
    }
};

SourceEditor.addEventChange = function ($field, editorSession) {
    $field.hide();
    editorSession.on('change', function () {
        $field.val(editorSession.getValue());
    });
    editorSession.setValue($field.val());
}

SourceEditor.init = function () {
    $('div.source-editor').each(function () {
        var div = $(this);
        var mode = div.data('mode');
        var loaded = div.data('loaded');

        if (!mode || loaded)
            return;

        var editor = ace.edit(div[0]);
        editor.setTheme("ace/theme/chrome");
        editor.setPrintMarginColumn(-1);
        let session = editor.getSession();
        session.setMode("ace/mode/" + mode);
        session.setUseWrapMode(true);
        editor.setOptions({
            enableBasicAutocompletion: true,
            enableSnippets: true,
            enableLiveAutocompletion: true
        });

        div.data('loaded', true);
        editor.focus();

        let fieldName = div.data('bind-field');
        if (!fieldName)
            return;

        let $field = $(".widget-body *[data-field=" + fieldName + "]");
        if ($field.length > 0) {

            let $inputField = $field.children("input");
            if ($inputField.length > 0) {
                SourceEditor.addEventChange($inputField, session);
                return;
            }

            let $textAreaField = $field.children("textarea");
            if ($textAreaField.length > 0) {
                SourceEditor.addEventChange($textAreaField, session);
                return;
            }
        }
    });
};

export default SourceEditor;