<%@ Page Title="Comparação de artefatos" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.CompareArtifactPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <asp:HiddenField runat="server" ID="DatabaseContent" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="FileContent" ClientIDMode="Static" />
    <div id="aceDiff">
    </div>
    <script>
        $(document).ready(function () {
            Benner.Apps.ArtifactsDiff.init($("#DatabaseContent").val(), $("#FileContent").val());
        });
    </script>
</asp:Content>
