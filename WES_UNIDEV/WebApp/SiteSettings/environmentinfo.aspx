<%@ Page Title="Informação do ambiente" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.EnvironmentInfoPage" %>
<%@ Register Assembly="Benner.Tecnologia.Wes.Components" Namespace="Benner.Tecnologia.Wes.Components.WebControls" TagPrefix="wes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <div id="ctl00_VersionInfo">
            <div class="col-md-4 widget">
                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption collapsible" onclick="Benner.Widget.changeServerChromeState('ctl00_VersionInfo');">
                            <span class="caption-subject font-green-sharp bold uppercase">Informações da versão</span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse" onclick="Benner.Widget.changeServerChromeState('ctl00_VersionInfo');"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="wesVersion"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="providerVersion"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="superServerVersion"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="ctl01_EnvironmentInfo">
            <div class="col-md-4 widget">
                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption collapsible" onclick="Benner.Widget.changeServerChromeState('ctl01_EnvironmentInfo');">
                            <span class="caption-subject font-green-sharp bold uppercase">Informações do ambiente</span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse" onclick="Benner.Widget.changeServerChromeState('ctl01_EnvironmentInfo');"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-group">
                            <asp:Label runat="server" ID="poolName"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="serverName"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="serverPort"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="serverSoftware"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="activeSessionCount" runat="server"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="usingCOMFree" runat="server"></asp:Label>
                        </div>
                        <div class="form-group">
                            <wes:MessagePanel ID="desktopHeapMessagePanel" runat="server"></wes:MessagePanel>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="sessionMode" runat="server"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="loggingMode" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="ctl02_SystemInfo">
            <div class="col-md-4 widget">
                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption collapsible" onclick="Benner.Widget.changeServerChromeState('ctl02_SystemInfo');">
                            <span class="caption-subject font-green-sharp bold uppercase">Informações do Sistema</span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse" onclick="Benner.Widget.changeServerChromeState('ctl02_SystemInfo');"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-group">
                            Última alteração: <asp:Label runat="server" ID="lastChange"></asp:Label>
                        </div>
                        <div class="form-group">
                            Última correção: <asp:Label runat="server" ID="lastCorrection"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="bserverHostName"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="bserverSystemName"></asp:Label>
                        </div>
                        <div class="form-group">
                            Versão DB: <asp:Label runat="server" ID="dbVersion"></asp:Label>
                        </div>
                        <div class="form-group">
                            Nome do sistema: <asp:Label runat="server" ID="systemName"></asp:Label>
                        </div>
                        <div class="form-group">
                            Versão do sistema: <asp:Label runat="server" ID="systemVersion"></asp:Label>
                        </div>
                        <div class="form-group">
                            Sistema é específico: <asp:Label runat="server" ID="isCustomSystem"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="lastSpecific"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div id="ctl03_LoggedInUsers">
            <div class="col-md-12 widget">
                <div class="portlet light">
                    <div class="portlet-title">
                        <div class="caption collapsible" onclick="Benner.Widget.changeServerChromeState('ctl03_LoggedInUsers');">
                            <span class="caption-subject font-red bold uppercase">Usuários ativos</span>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse" onclick="Benner.Widget.changeServerChromeState('ctl03_LoggedInUsers');"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <asp:UpdatePanel runat="server" ID="gridUsersUpdate">
                            <ContentTemplate>
                                <asp:Timer ID="timerUpdateGridUsers" runat="server"></asp:Timer>
                                <asp:GridView runat="server" ID="gridUsers">
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

