<%@ Control Language="C#" AutoEventWireup="true" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CommandPropertiesControl" %>
<%@ Register Src="~/uc/UrlLinkDefinition.ascx" TagName="UrlLinkDef" TagPrefix="SiteSettings" %>
<%@ Register Src="~/uc/GridLinkDefinition.ascx" TagName="GridLinkDef" TagPrefix="SiteSettings" %>
<%@ Register Src="~/uc/FormLinkDefinition.ascx" TagName="FormLinkDef" TagPrefix="SiteSettings" %>
<%@ Register Src="~/uc/CommandFunction.ascx" TagName="CmdFunctionDef" TagPrefix="SiteSettings" %>
<%@ Register Src="~/uc/CommandContext.ascx" TagName="CmbContextDef" TagPrefix="SiteSettings" %>
<%@ Register Src="~/uc/CommandReport.ascx" TagName="CmdReportDef" TagPrefix="SiteSettings" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.UI" TagPrefix="cc1" %>

<div class="col-md-6">
    <div class="commands-editor-properties">
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    Propriedades
                </div>
            </div>
            <div class="portlet-body form">
                <div class="row">
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="">
                            <asp:Panel ID="divName" runat="server" CssClass="form-group">
                                <label>Nome</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="divTitle" runat="server" CssClass="form-group">
                                <label>Título</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="divImage" runat="server" CssClass="form-group">
                                <label>Font-icon</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtNameImage" CssClass="form-control autocomplete autocomplete-fonticons" runat="server"></asp:TextBox>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="divBackgroundColor" runat="server" CssClass="form-group">
                                <label>Classe CSS</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtBackgroundColor" CssClass="form-control  autocomplete autocomplete-color" runat="server"></asp:TextBox>
                                </div>
                            </asp:Panel>
                            <label>Contexto</label>
                            <SiteSettings:CmbContextDef ID="functionContextCtrl" runat="server"/>
                            
                            <asp:CheckBox ID="chkVisible" runat="server" AutoPostBack="True" Text="Visível" OnCheckedChanged="chkVisible_OnCheckedChanged" />

                            <div class="form-group">
                                <asp:CheckBox ID="chkShowModal" runat="server" AutoPostBack="True" Text="Exibir em modal" OnCheckedChanged="chkShowModal_CheckedChanged" />
                            </div>

                            <asp:Panel ID="divStruturedTableCommands" runat="server" CssClass="form-group">
                                <asp:CheckBox ID="chkShowInAllLevelsStructuredTable" runat="server" Text="Exibir em todos os níveis" />
                            </asp:Panel>

                            <asp:Panel ID="divSizeModal" runat="server" CssClass="form-group">
                                <label>Tamanho do modal</label>
                                <div class="input-group">
                                    <asp:DropDownList ID="cmbSizeModal" runat="server" AutoPostBack="true" CssClass="form-control">
                                        <asp:ListItem Value="0" Text="Default" />
                                        <asp:ListItem Value="1" Text="Full" />
                                        <asp:ListItem Value="2" Text="Large" />
                                        <asp:ListItem Value="3" Text="Small" />
                                    </asp:DropDownList>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="col-md-6">
    <div class="commands-editor-properties">
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    Entrada de dados
                </div>
            </div>
            <div class="portlet-body form">
                <div class="row">
                    <asp:Panel ID="divInput" runat="server" CssClass="col-md-12">
                        <div class="form-group">
                            <asp:DropDownList ID="cmbInputType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnInputTypeChanged" CssClass="form-control">
                                <asp:ListItem Value="NULL" Text="Sem entrada de dados" Selected="True" />
                                <asp:ListItem Value="TABELAVIRTUAL" Text="Tabela virtual" />
                            </asp:DropDownList>
                        </div>
                        <SiteSettings:FormLinkDef ID="formLinkDefCtrlDataInput" runat="server" Visible="False" />
                    </asp:Panel>
                </div>
            </div>
        </div>

        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    Processamento
                </div>
            </div>
            <div class="portlet-body form">
                <div class="row">
                    <asp:Panel ID="divProcess" runat="server" CssClass="col-md-12">
                        <div class="form-group">
                            <asp:DropDownList ID="cmbProcessType" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="OnProcessTypeChanged" CssClass="form-control">
                                <asp:ListItem Value="NULL" Text="Sem processamento" Selected="True" />
                                <asp:ListItem Value="SAVE" Text="Execução do Save" />
                                <asp:ListItem Value="FUNCTION" Text="Execução de função" />
                                <asp:ListItem Value="REPORT" Text="Emissão de Relatório" />
                            </asp:DropDownList>
                        </div>
                        <SiteSettings:CmdFunctionDef ID="functionDefCtrl" runat="server" Visible="False" />
                        <SiteSettings:CmdReportDef ID="functionReportCtrl" runat="server" Visible="False" />
                    </asp:Panel>
                </div>
            </div>
        </div>

        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    Destino
                </div>
            </div>
            <div class="portlet-body form">
                <div class="row">
                    <asp:Panel ID="divOutput" runat="server" CssClass="col-md-12">
                        <div class="form-group">
                            <asp:DropDownList ID="cmbOutputType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnOutputTypeChanged" CssClass="form-control">
                                <asp:ListItem Value="LOCAL" Text="Fica no local de disparo" Selected="True" />
                                <asp:ListItem Value="URL" Text="Vai para uma url" />
                                <asp:ListItem Value="GRID" Text="Vai para um grid" />
                                <asp:ListItem Value="FORM" Text="Vai para um formulário" />
                                <asp:ListItem Value="HIST" Text="Volta para a página anterior / Fecha modal" />
                            </asp:DropDownList>
                        </div>
                        <SiteSettings:UrlLinkDef ID="urlLinkDefCtrl" runat="server" Visible="False" />
                        <SiteSettings:GridLinkDef ID="gridLinkDefCtrl" runat="server" Visible="False" />
                        <SiteSettings:FormLinkDef ID="formLinkDefCtrl" runat="server" Visible="False" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</div>
