using System.Web.Mvc;
using System.Web.Routing;
using Benner.Tecnologia.Common;

namespace WebApp
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("Home", "", BennerConfiguration.CustomArtifacts.GetLatestArtifactName(CustomArtifactsType.DefaultPage), false);
            routes.MapPageRoute("Login", "Login", BennerConfiguration.CustomArtifacts.GetLatestArtifactName(CustomArtifactsType.LoginPage), false);

            routes.Ignore("{*pathInfo}", new { pathInfo = @"^.*(ChartImg.axd)$" });
            routes.Ignore("{resource}.axd/{*pathInfo}");
            routes.Ignore("{resource}.asmx/{*pathInfo}");
            routes.Ignore("{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{*favicon}", new { favicon = @"(.*/)?favicon(/.*)?" });

            routes.MapMvcAttributeRoutes();

            routes.MapRoute(
                "Commands",
                "commands/{viewName}/{commandName}/{id}",
                new { controller = "Commands", action = "Index", id = UrlParameter.Optional, },
                new string[] { "Benner.Tecnologia.Wes.Components.WebApp.Controllers" });

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new string[] { "Benner.Tecnologia.Wes.Components.WebApp.Controllers" });

        }
    }
}
