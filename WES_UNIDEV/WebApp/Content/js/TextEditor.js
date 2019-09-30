import ModalPage from './ModalPage';

var TextEditor = function () {

};

TextEditor.editorId = null;

TextEditor.val = function (value) {
    var editor = $("#" + TextEditor.editorId);
    if (value != null) {
        editor.val(value);
    }

    return editor.val();
};

TextEditor.show = function (url, editorId) {
    TextEditor.editorId = editorId;
    ModalPage.show({ id: editorId, url: url, height: 380, displayTitle: false, generateDefaultContent: false });
};

export default TextEditor;