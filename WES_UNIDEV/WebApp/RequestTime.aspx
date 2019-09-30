<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    public long GetSystemsRequestTime()
    {
        System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();
        watch.Start();

        Benner.Tecnologia.Common.BennerContext.Administration.GetSystems();

        watch.Stop();
        return watch.ElapsedMilliseconds;
    }

    public long GetEntityCountAllRequestTime()
    {
        System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();
        watch.Start();

        Benner.Tecnologia.Common.Entity.CountAll(Benner.Tecnologia.Common.EntityDefinition.GetByName("Z_SISTEMA"));

        watch.Stop();
        return watch.ElapsedMilliseconds;
    }
        
    public long GetEntityGetAllRequestTime()
    {
        System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();
        watch.Start();

        Benner.Tecnologia.Common.Entity.GetAll(Benner.Tecnologia.Common.EntityDefinition.GetByName("Z_SISTEMA"));

        watch.Stop();
        return watch.ElapsedMilliseconds;
    }

    public long GetEntityGetRequestTime()
    {
        System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();
        watch.Start();

        Benner.Tecnologia.Common.Entity.Get(Benner.Tecnologia.Common.EntityDefinition.GetByName("Z_SISTEMA"), new Benner.Tecnologia.Common.Handle(1));

        watch.Stop();
        return watch.ElapsedMilliseconds;
    }    
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Tempo de resposta</title>
</head>
<body>
    <form id="form1" runat="server">
    <br />
    <br />
    <br />
    <br />
    <br />
    <div style="margin-left: 20px;">
        <h2>Tempo de resposta de serviços:</h2>
        <table class="GridViewStyle" style="width: 600px">
            <tr class="HeaderStyle">
                <td>Serviço</td>
                <td>Tempo</td>
            </tr>
            <tr class="RowStyle">
                <td>Administration.GetSystems</td>
                <td><%= GetSystemsRequestTime() %>ms</td>
            </tr>
            <tr class="RowStyle">
                <td>Entity.CountAll(Z_SISTEMA) (faz acesso ao banco via ADO.NET no AppServer)</td>
                <td><%= GetEntityCountAllRequestTime()%>ms</td>
            </tr>
            <tr class="RowStyle">
                <td>Entity.GetAll(Z_SISTEMA) (faz acesso ao banco via ADO.NET no AppServer)</td>
                <td><%= GetEntityGetAllRequestTime()%>ms</td>
            </tr>
            <tr class="RowStyle">
                <td>Entity.Get(Z_SISTEMA) (faz acesso ao banco e executa regra de negócio via provider)</td>
                <td><%= GetEntityGetRequestTime()%>ms</td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
