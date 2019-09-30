import Page from '../../js/Page';

var Repository = function () {
    return {
        getDataSource: function (dataSourceIdentifier) {
            var dataSource = null;
            var url = Page.getApplicationPath() + 'api/datasource/' + dataSourceIdentifier;

            $.ajax({
                async: false,
                url: url
            }).done(function (data) {
                dataSource = data;
            });

            return dataSource;
        },

        getTables: function () {
            var tables = null;
            var url = Page.getApplicationPath() + 'api/datasource/tables';

            $.ajax({
                async: false,
                url: url
            }).done(function (data) {
                tables = data;
            });

            return tables;
        },

        getFieldsFromTable: function (table) {
            var fields = null;
            var url = Page.getApplicationPath() + 'api/datasource/tables/' + table + '/fields';

            $.ajax({
                async: false,
                url: url
            }).done(function (data) {
                fields = data;
            });

            return fields;
        },

        create: function (request) {
            var result = null;
            var url = Page.getApplicationPath() + 'api/datasource';

            $.ajax({
                async: false,
                url: url,
                type: 'POST',
                dataType: 'json',
                data: request,
                success: function (data) {
                    result = data;
                },
                error: function (error) {
                    result = error;
                }
            });

            return result;
        },

        save: function (request) {
            var result = {
                DataSource: null,
                ReturnUrl: '',
                Error: ''
            };
            var url = Page.getApplicationPath() + 'api/datasource';

            $.ajax({
                async: false,
                url: url,
                type: 'PUT',
                dataType: 'json',
                data: request,
                success: function (data) {
                    result.ReturnUrl = data.ReturnUrl;
                },
                error: function (error) {
                    result.Error = error.responseJSON;
                }
            });

            if (result.ReturnUrl !== '')
                result.DataSource = this.getDataSource(request.DataSource.Identifier);
            return result;
        },

        preview: function (dataSource) {
            var preview = null;

            $.ajax({
                async: false,
                url: Page.getApplicationPath() + 'api/datasource/preview',
                type: 'PUT',
                dataType: 'json',
                data: dataSource,
                success: function (data) {
                    preview = data;
                }
            });

            return preview;
        },

        getFieldsFromQuery: function (selectCommand) {
            var fields = null;
            var url = Page.getApplicationPath() + 'api/datasource/fields/query/';

            $.ajax({
                async: false,
                url: url,
                dataType: 'json',
                type: 'POST',
                data: {
                    selectCommand: selectCommand
                },
                success: function (data) {
                    fields = data;
                },
                error: function (error) {
                    fields = error;
                }
            });

            return fields;
        }
    };
};

export default Repository;