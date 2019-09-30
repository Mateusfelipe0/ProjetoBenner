using System.Web.Http;
using System.Web.Routing;
using Benner.Tecnologia.Wes.Components.Rest;
using Microsoft.AspNet.WebApi.Extensions.Compression.Server;
using System.Net.Http.Extensions.Compression.Core.Compressors;
using Swagger.Net.Application;
using Newtonsoft.Json.Serialization;

namespace WebApp
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration configuration, RouteCollection routes)
        {
            routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            routes.MapHttpRoute(
                name: "Swagger UI",
                routeTemplate: "apis",
                defaults: null,
                constraints: null,
                handler: new RedirectHandler(SwaggerDocsConfig.DefaultRootUrlResolver, "swagger/ui/index")
            );

            configuration.Formatters.Remove(configuration.Formatters.XmlFormatter);
            configuration.Formatters.Add(new CustomXmlFormatter());
            ((DefaultContractResolver)configuration.Formatters.JsonFormatter.SerializerSettings.ContractResolver).IgnoreSerializableAttribute = true;
            
            configuration.MessageHandlers.Insert(0, new ServerCompressionHandler(new GZipCompressor(), new DeflateCompressor()));
        }
    }
}
