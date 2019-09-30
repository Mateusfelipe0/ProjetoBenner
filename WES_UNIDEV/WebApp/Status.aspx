<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="Benner.Tecnologia.Bas.AppServer.WebService" %>
<%@ Import Namespace="Benner.Tecnologia.Wes.Components.WebApp" %>

<%@ Page Language="c#" AutoEventWireup="false" EnableTheming="false" Theme="" StylesheetTheme="" EnableSessionState="false" %>

<%
    try
    {
        // Garante que o warmup seja disparado (caso ainda não tenha sido)
        WarmupManager.Start();

        // Caso ainda não esteja aquecido, retorna erro
        if (!WarmupManager.CheckInitialization())
        {
            Response.StatusCode = 500;
            Response.Write(Response.Status);
            Response.Flush();
            Response.End();
            return;
        }

        string poolName = Benner.Tecnologia.Common.BennerContext.Administration.DefaultSystemInstanceName;
        var poolService = new PoolService();
        // Esta página faz dois tipos de testes:
        // 1. TESTE RÁPIDO: Apenas para ver se a pool está com problemas. Este teste sempre será executado.
        // 2. TESTE COMPLETO: Por padrão é executado a cada 30 segundos se a pool apresentou problemas. Ou forçado via ?testmode=full.

        // Observação importante:
        //   A status.aspx só irá retornar retornar erro caso algum usuário já tenha recebido algum erro antes.
        //   Isto garante velocidade no teste permitindo o uso indiscrimidado da status.aspx por WebRouters.

        // Observação importante 2:
        //  Para forçar um teste completo na pool mesmo que nenhum usuário tenha recebido algum erro 
        //  basta adicionar ?force na Request da status.aspx. Este teste é mais lento e deve ser executado
        //  por ferramentas de monitoramento com peridiocidade de no mínimo 1 minuto.     

        bool itsFullTestTime = Application["ET"] != null && ((DateTime)Application["ET"]).AddSeconds(30) <= DateTime.Now;
        bool forceFullTest = (Request["testmode"] ?? string.Empty).Equals("full", StringComparison.OrdinalIgnoreCase);

        if (itsFullTestTime || forceFullTest)
        {
            // Teste completo (incluindo ping no Provider, Banco, BServer)
            // Este teste tenta reiniciar a pool caso ela tenha problemas
            Application["ET"] = null;
            poolService.TestPool(poolName);
        }
        else
        {
            // Teste rápido para ver se a pool não está com erros.
            // Este teste não tenta reiniciar a pool.
            poolService.GetPoolInfo(poolName);
            Application["ET"] = null;
        }
    }
    catch
    {
        if (Application["ET"] == null)
            Application["ET"] = DateTime.Now;

        Response.StatusCode = 500;
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
    <title>WES Status</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="ProgId" content="VisualStudio.HTML">
    <meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
</head>
<body>
    <h1><%=Response.Status%></h1>
</body>
</html>
