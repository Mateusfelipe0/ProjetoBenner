import Page from './Page';

var Services = function () {

};

Services.getPathFieldResultValues = function (entityViewName, associationFieldName, associationFieldValue, pathFields, onSucess) {
    var applicationPath = Page.getApplicationPath();
    var servicePath = "PathField.asmx";
    if (applicationPath != null) {
        servicePath = applicationPath + servicePath;
    }

    Sys.Net.WebServiceProxy.invoke(servicePath,
        "GetResultValues",
        false,
        {
            entityViewName: entityViewName,
            associationFieldName: associationFieldName,
            associationFieldValue: associationFieldValue,
            pathFields: pathFields
        },
        onSucess,
        Services.onFail,
        null);
};

Services.onFail = function (err, response, context) {
    alert(err._message);
};

export default Services;