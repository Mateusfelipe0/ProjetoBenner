import AceDiff from 'ace-diff/dist/ace-diff.min';

var ArtifactsDiff = function () {
    return {
        init: function (databaseContent, fileContent) {
            new AceDiff({
                element: '#aceDiff',
                mode: "ace/mode/xml",
                left: {
                    editable: false,
                    copyLinkEnabled: false,
                    content: databaseContent 
                },
                right: {
                    editable: false,
                    copyLinkEnabled: false,
                    content: fileContent 
                }
            });
        }
    };
}();

export default ArtifactsDiff;
