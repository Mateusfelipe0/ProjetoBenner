<%@ Page AutoEventWireup="true" Language="C#" %>
<%@ Register Src="~/uc/HeadSection.ascx" TagName="HeadSection" TagPrefix="wes" %>

<!doctype html>
<html lang="pt" class="no-js">
<head runat="server">
    <title>Version</title>
    <wes:HeadSection ID="HeadSection1" runat="server" />
</head>
<body class="bg-white">
    <div>
        <form runat="server">
            <asp:HiddenField runat="server" ID="hdnToken" />
        </form>
        <asp:Label runat="server" ID="wesVersion"></asp:Label><br />
        <asp:Label runat="server" ID="dbVersion"></asp:Label><br />
        <asp:Label runat="server" ID="providerVersion"></asp:Label><br />
        <asp:Label runat="server" ID="superServerVersion"></asp:Label><br />
        <asp:Label runat="server" ID="serverName"></asp:Label><br />
        <asp:Label ID="activeSessionCount" runat="server" Text="" /><br />
    </div>
</body>
</html>

<script runat="server">
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            object value = Application.Get("activeSessionCount");
            if (value != null)
                activeSessionCount.Text = string.Format("Sessões ativas: {0}", value.ToString());
            
            GetWesVersion();
            GetServerName();
            GetProviderVersion();
            GetSuperServerVersion();
            GetDbVersion();
            Benner.Tecnologia.Wes.Components.WebApp.CsrfValidator.Validate(IsPostBack, hdnToken);
        }
        
        private void GetDbVersion()
        {
            if (dbVersion == null)
                return;
            dbVersion.Text = string.Format("Versão DB: {0}", Benner.Tecnologia.Common.BennerContext.Administration.GetDbVersion(Benner.Tecnologia.Common.BennerConfiguration.DefaultSystemInstanceName));
        }
        
        private void GetSuperServerVersion()
        {
            if (superServerVersion == null)
                return;

            superServerVersion.Text = string.Format("Versão do Super Server: {0}",
                                                 Benner.Tecnologia.Common.BennerContext.Administration.GetSuperServerVersion(Benner.Tecnologia.Common.BennerConfiguration.DefaultSystemInstanceName));
        }

        private void GetProviderVersion()
        {
            if (providerVersion == null)
                return;

            providerVersion.Text = string.Format("Versão do Provider: {0}",
                                                 Benner.Tecnologia.Common.BennerContext.Administration.GetProviderVersion(Benner.Tecnologia.Common.BennerConfiguration.DefaultSystemInstanceName));
        }
        
        private void GetServerName()
        {
            if (serverName == null)
                return;

            serverName.Text = string.Format("Servidor: {0}", Server.MachineName);
        }
        
        private void GetWesVersion()
        {
            foreach (System.Reflection.Assembly assembly in AppDomain.CurrentDomain.GetAssemblies())
            {
                if (assembly.GetName().Name.Equals("Benner.Tecnologia.Wes.Components", StringComparison.Ordinal))
                {
                    wesVersion.Text = string.Concat("Versão do WES: ", System.Diagnostics.FileVersionInfo.GetVersionInfo(assembly.Location).FileVersion);
                    break;
                }
            }
        }
</script>



