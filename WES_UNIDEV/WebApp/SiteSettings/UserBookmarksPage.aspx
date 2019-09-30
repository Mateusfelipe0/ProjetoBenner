<%@ Page Title="Favoritos" Language="C#" AutoEventWireup="true"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>

<%@ Register Assembly="Benner.Tecnologia.Wes.Components.WebApp" Namespace="Benner.Tecnologia.Wes.Components.WebApp"
    TagPrefix="wesControl" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components"
    TagPrefix="wesWidget" %>
<script runat="server">
    protected void BookmarksSaveExecuted(object sender, EventArgs e)
    {
        BookmarksProvider.ClearCache();
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <wesWidget:EditableGrid Title="Favoritos" OnSaveCommandExecute="BookmarksSaveExecuted" UserDefinedCriteriaWhereClause="A.USUARIO = @USUARIO" UserDefinedSelectColumnVisible="true" CanInsert="true" EntityViewName="W_FAVORITOS.GRID" ID="userBookmarksGrid" ShowTitle="true" runat="server" />
    </div>
</asp:Content>
