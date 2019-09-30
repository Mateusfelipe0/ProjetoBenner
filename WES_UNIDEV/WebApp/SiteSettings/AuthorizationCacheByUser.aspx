<%@ Page Title="Monitoramento do cache" Language="C#"
    Inherits="Benner.Tecnologia.Wes.Components.WebApp.AuthorizationCacheByUserPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <style>
    .box{
        border: lightgray;
        border-style: solid;
        padding: 15px;
        border-width: 1px;
    }
</style>
    <asp:Label ID="errorMessageLabel" runat="server" Text="Label" Visible="False" CssClass="msgusr" Width="100%"></asp:Label>
    <br />
    <br />

    <div class="box">
        <br />
        <asp:Label ID="Label1" runat="server" Text="Nome do usuário:"></asp:Label>
        <asp:TextBox ID="userNameTextBox" runat="server"></asp:TextBox>
        <asp:Button ID="loadUserData" runat="server" Text="Listar o que está em cache" OnClick="loadUserData_Click" />
        <br />
        <br />
        <table width="100%">
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="Grupos para o usuário "></asp:Label>
                    <asp:Label ID="groupsLabel" runat="server" Text="??"></asp:Label>
                    <br />
                    <asp:ListBox ID="userGroupsListBox" runat="server" Height="110px" Width="251px"></asp:ListBox>
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Papéis concedidos ao usuário "></asp:Label>
                    <asp:Label ID="assignedLabel" runat="server" Text="??"></asp:Label>
                    <br />
                    <asp:ListBox ID="assignedRolesListBox" runat="server" Height="110px" Width="251px"></asp:ListBox>
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Papéis negados ao usuário "></asp:Label>
                    <asp:Label ID="unassignedLabel" runat="server" Text="??"></asp:Label>
                    <br />
                    <asp:ListBox ID="unassignedRolesListBox" runat="server" Height="110px" Width="251px"></asp:ListBox>
                </td>
            </tr>
        </table>
        <br />
        <asp:Label ID="activeRoleLabel" runat="server" Text="Papel ativo é ??"></asp:Label>
        <br />
        <br />
    </div>
    
    <div class="box">
        <br />
        <asp:Label ID="Label5" runat="server" Text="O usuário "></asp:Label>
        <asp:TextBox ID="testUserName" runat="server"></asp:TextBox>
        <asp:Label ID="Label6" runat="server" Text=" pode executar a ação "></asp:Label>
        <asp:TextBox ID="testAction" runat="server"></asp:TextBox>
        <asp:Label ID="Label7" runat="server" Text=" sobre a entidade "></asp:Label>
        <asp:TextBox ID="testEntity" runat="server"></asp:TextBox>
        <asp:Label ID="Label8" runat="server" Text="?  "></asp:Label>
        <br />
        <br />
        <asp:Button ID="testButton" runat="server" Text="Com papéis concedidos ->" />
        <asp:Label ID="testResultLabel" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Button ID="testButtonActiveRole" runat="server" Text="Apenas com papel ativo ->" />
        <asp:Label ID="testActiveRoleResultLabel" runat="server"></asp:Label>
        <br />
    </div>

    <div class="box">
        <br />
        <asp:Label ID="Label9" runat="server" Text="URL:"></asp:Label>
        <asp:TextBox ID="URLTextBox" runat="server" Width="435px" style="width:435px;font-family: arial;" >~/exemplo.aspx</asp:TextBox>
        <asp:Button ID="loadURLData" runat="server" Text="Listar tarefas vinculadas (em cache)" />
        <br />
        <br />
        <table width="100%">
            <tr>
                <td>
                    <asp:Label ID="Label10" runat="server" Text="Tarefas vinculadas à URL "></asp:Label>
                    <br />
                    <asp:ListBox ID="urlTaskListBox" runat="server" Height="110px" Width="251px"></asp:ListBox>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>

    <div class="box">
        <br />
        <asp:Label ID="Label11" runat="server" Text="Papel:"></asp:Label>
        <asp:TextBox ID="RoleName" runat="server" Width="211px" style="font-family: arial;" ></asp:TextBox>
        <asp:Button ID="loadRoleData" runat="server" Text="Listar tarefas vinculadas (em cache)" />
        <br />
        <br />
        <asp:Label ID="Label12" runat="server" Text="Tarefas vinculadas ao papel "></asp:Label>
        <br />
        <asp:ListBox ID="roleTaskListBox" runat="server" Height="110px" Width="251px"></asp:ListBox>
        <br />
        <br />
    </div>


    <br />
    <br />
    <br />
    

</asp:Content>
