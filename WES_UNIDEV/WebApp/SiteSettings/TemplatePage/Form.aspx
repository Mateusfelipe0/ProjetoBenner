<%@ Page Title="Template de páginas" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EditTemplatePage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp" TagPrefix="wes" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components" TagPrefix="wes" %>
<%@ Register Src="~/uc/SourceEditor.ascx" TagPrefix="wes" TagName="SourceEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wes:AjaxForm runat="server" ID="FORMWIDGET_635876997543273851" Title="Template de páginas" BootstrapCols="12" UserDefinedCommandsVisible="True" UserDefinedCriteriaWhereClause="" IncludeRecordInRecentItems="True" CanInsert="True" CanUpdate="True" CanDelete="True" ShowTitle="True" ChromeState="Fixed" EntityViewName="W_PAGINATEMPLATES.FORM" />
        <asp:UpdatePanel runat="server" ID="updateTemplate" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="col-md-12">
                    <wes:SourceEditor runat="server" ID="sourceEditorTemplate" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
