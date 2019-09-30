<%@ Page Title="Editor de scripts" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.ScriptEditorPage" %>

<%@ Register Src="~/uc/ScriptEditor.ascx" TagName="ScriptEditor" TagPrefix="wesUserControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="cc1" %>
<%@ Register Src="~/uc/EntityViewHeader.ascx" TagName="EntityViewHeader" TagPrefix="wesUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <div class="portlet light" style="margin-bottom: 5px;">
        <div class="portlet-title">
            <div class="caption">
                <span class="caption-subject font-green-sharp bold uppercase">Editor de script</span>
            </div>
            <div class="actions">
                <div class="btn-group">
                    <a href="http://wiki.benner.com.br/wiki/index.php?title=Categoria%3AScript_-_WES" class="no-border btn btn-circle btn-default btn-sm" target="_blank">
                        <i class="fa fa-question-circle"></i>
                    </a>
                </div>
                <cc1:WidgetActionsMenu ID="developerMenu" runat="server" />
            </div>
        </div>
        <div class="portlet-body form">
            <div class="form-actions nobg no-border commands-bar fluid">
                <asp:LinkButton ID="lnkBtnSave" CssClass="btn blue command-action predef-action" runat="server"><i class="fa fa-check btn-action"></i>Salvar</asp:LinkButton>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <asp:UpdatePanel ID="messageUpdatePanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <cc1:MessagePanel ID="messagePanel" CssClass="alert alert-warning" Visible="false" runat="server"></cc1:MessagePanel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <asp:UpdatePanel ID="updatePanelEditor" runat="server">
                <ContentTemplate>
                    <wesUserControl:ScriptEditor ID="scriptControl" runat="server" EnableViewState="true" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>

