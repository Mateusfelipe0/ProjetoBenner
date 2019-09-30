<%@ Page Title="Consulta" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.DatasourcesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagPrefix="wes" TagName="SourceEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <link href="<%= Page.ResolveUrl("~/content/css/DataSourceEditor.css") %>" rel="stylesheet">

    <asp:HiddenField runat="server" ID="DatasourceID" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="PageWidget" ClientIDMode="Static" />
    <div class="bg-white">
        <div class="portlet light">
            <div class="portlet-title">
                <div class="caption">
                    <span class="caption-subject font-green-sharp bold uppercase">Editor de Consultas</span>
                </div>
                <div class="actions">
                    <div class="btn-group">
                        <a href="http://wiki.benner.com.br/wiki/index.php?title=Editor_de_consultas" class="no-border btn btn-circle btn-default btn-sm" target="_blank">
                            <i class="fa fa-question-circle"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="portlet-body form">
                <div class="form-actions nobg no-border commands-bar fluid">
                    <a class="btn blue" id="salvar"><i class="fa fa-check"></i>&nbsp;Salvar</a>
                    <asp:LinkButton runat="server" OnClick="Cancelar_Click" class="btn grey-silver" ID="cancelar"><i class="fa fa-close"></i>&nbsp;Cancelar</asp:LinkButton>
                </div>
                <div id="datasources-content" class="portlet widget">
                    <div class="portlet-body allow-focus">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Identificador</label>
                                    <asp:TextBox runat="server" ID="Identificacao" ClientIDMode="Static" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Nome</label>
                                    <asp:TextBox runat="server" ID="Nome" ClientIDMode="Static" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Tipo de consulta</label>
                                    <div class="mt-radio-inline">
                                        <label class="mt-radio" id="lblDataSourceType_query">
                                            <input type="radio" name="dataSourceType" id="dataSourceType_query" value="query" tabindex="-1" checked />
                                            <i class="fa fa-database"></i>
                                            Query
                                            <span></span>
                                        </label>
                                        <label class="mt-radio" id="lblDataSourceType_table">
                                            <input type="radio" name="dataSourceType" id="dataSourceType_table" value="table" />
                                            <i class="fa fa-table"></i>
                                            Tabela
                                            <span></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="queryFields" class="dataSourceType_fields">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="portlet">
                                        <div class="portlet-body">
                                            <div class="form-control" id="selectCommand"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tableFields" class="dataSourceType_fields hidden">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="control-label">Tabela</label>
                                        <select class="form-control select2me" id="tabelas" data-placeholder="Selecione..."></select>
                                    </div>
                                </div>
                                <div class="col-md-8" id="filterDiv">
                                    <div class="form-group">
                                        <label class="control-label">Critério de seleção</label>
                                        <input type="text" class="form-control" id="filter" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="portlet">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-table"></i>
                                            <span class="caption-subject">Campos</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="row">
                                            <div id="fieldsDiv" class="campo col-md-12 hidden">
                                                <div class="form-group">
                                                    <label class="control-label">Incluir</label>

                                                    <div class="input-group">
                                                        <select class="form-control select2me" data-lookuplevel="0" data-placeholder="Selecione..." id="campos"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="getColumnsDiv" class="col-md-12">
                                                <a class="btn green" id="obter-colunas"><i class="fa fa-clone"></i>&nbsp;Obter colunas</a>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="fieldPathTitle">Caminho</div>
                                                <div class="fieldAliasTitle hidden">Apelido</div>
                                                <div class="dd" id="campos-selecionados">
                                                    <ol class="dd-list" id="lista-campos-selecionados"></ol>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="portlet">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-pencil"></i>
                                            <span class="caption-subject">Propriedades</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-group">
                                            <label for="" class="control-label">Caminho:</label>
                                            <input type="text" class="form-control" id="path" readonly="">
                                        </div>
                                        <div class="form-group hidden">
                                            <label for="" class="control-label">Apelido:</label>
                                            <input type="text" class="form-control" id="alias" data-fieldid="0">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(() => {
            Benner.Apps.DataSourceEditor.init();
        })
    </script>
</asp:Content>