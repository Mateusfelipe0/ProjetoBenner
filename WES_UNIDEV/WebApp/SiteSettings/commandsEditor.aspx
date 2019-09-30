<%@ Page Title="Editor de comandos" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.CommandsEditorPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="cc1" %>
<%@ Register Src="~/uc/Commands.ascx" TagName="Commands" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityFunctionList.ascx" TagName="EntityFunctionList" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/CommandProperties.ascx" TagName="CommandProperties" TagPrefix="wesUserControl" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="portlet light">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Editor de comandos</span>
            </div>
            <div class="actions">
                <div class="btn-group">
                    <a href="http://wiki.benner.com.br/wiki/index.php?title=Categoria%3AComandos_-_WES" class="no-border btn btn-circle btn-default btn-sm" target="_blank">
                        <i class="fa fa-question-circle"></i>
                    </a>
                </div>
                <cc1:WidgetActionsMenu ID="developerMenu" runat="server" />
            </div>
        </div>
        <div class="portlet-body form">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="form-actions nobg no-border commands-bar fluid">
                        <asp:LinkButton ID="lnkBtnSave" CssClass="btn blue command-action predef-action" runat="server"><i class="fa fa-check btn-action"></i>Salvar</asp:LinkButton></li>
                        <asp:LinkButton ID="lnkBtnShowXml" CssClass="btn default command-action predef-action" runat="server"><i class="fa fa-code btn-action"></i>Ver XML</asp:LinkButton></li>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel ID="messageUpdatePanel" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <cc1:MessagePanel ID="messagePanel" runat="server"></cc1:MessagePanel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <wesUserControl:Commands ID="commandsControl" runat="server" />
                        </div>
                        <div class="col-md-8">
                            <wesUserControl:CommandProperties ID="commandProperties" runat="server" EnableViewState="true" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
