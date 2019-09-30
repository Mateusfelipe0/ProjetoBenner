using Benner.Tecnologia.Business;
using Swagger.Net;
using Swagger.Net.Application;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;

namespace WebApp
{
    public static class SwaggerConfig
    {
        public static void Register()
        {
            if (Benner.Tecnologia.Common.BennerConfiguration.ConfigurationRequired)
                return;
            GlobalConfiguration.Configuration
                .EnableSwagger(
                    c =>
                    {
                        var publicUrl = Benner.Tecnologia.Common.BennerConfiguration.PublicUrl;
                        if (!string.IsNullOrWhiteSpace(publicUrl))
                            c.RootUrl(req => publicUrl);

                        c.SingleApiVersion("v1",
                            "Catálogo de APIs Benner")
                            .Contact(cc => cc
                                .Name("Benner Sistemas")
                                .Url("http://www.benner.com.br"));

                        c.Schemes(new string[] { "http", "https" });

                        c.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());

                        c.DocumentFilter<ApplyDocumentVendorExtensions>();

                        c.PrettyPrint();

                        c.UseFullTypeNameInSchemaIds();

                        c.OAuth2("oauth2")
                            .Flow("password")
                            .TokenUrl("../../app_services/auth.oauth2.svc/token")
                            .Description("Autenticação pelo fluxo Resource Owner Password do OAuth2, tal como a especificação: https://oauthlib.readthedocs.io/en/stable/oauth2/grants/password.html");


                        var files = Directory.GetFiles(Path.Combine(HttpContext.Current == null || HttpContext.Current.Request == null
                                ? AppDomain.CurrentDomain.SetupInformation.ApplicationBase
                                : HttpContext.Current.Request.PhysicalApplicationPath, "bin"), "*.xml");
                        c.IncludeXmlComments(files);

                    })
                .EnableSwaggerUi(
                    c =>
                    {
                        c.SetValidatorUrl("https://online.swagger.io/validator");
                        c.EnableOAuth2Support("Swagger", "Swagger", "Swagger");
                        c.DocumentTitle("Catálogo de APIs Benner");

                        if (BennerEnvironment.IsProduction && !BennerEnvironment.IsBenner)
                        {
                            c.SupportedSubmitMethods(new string[] { });
                        }
                    });
        }
        private class ApplyDocumentVendorExtensions : IDocumentFilter
        {
            public void Apply(SwaggerDocument swaggerDoc, SchemaRegistry schemaRegistry, IApiExplorer apiExplorer)
            {
                if (swaggerDoc.security == null)
                    swaggerDoc.security = new List<IDictionary<string, IEnumerable<string>>>();

                swaggerDoc.security.Add(new Dictionary<string, IEnumerable<string>>
                {
                    { "oauth2", new string[]{ } }
                });

                GenerateOAuth2Operation(swaggerDoc, schemaRegistry, System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase);
            }

            private void GenerateOAuth2Operation(SwaggerDocument swaggerDoc, SchemaRegistry schemaRegistry, string applicationBase)
            {
                swaggerDoc.tags.Insert(0, new Tag()
                {
                    name = "Authentication",
                    description = "API para fornecer um token de autenticação compatível com o fluxo 'Resource Owner Password' do OAuth2"
                });
                swaggerDoc.paths.Add("/app_services/auth.oauth2.svc/token", new PathItem
                {
                    post = new Operation
                    {
                        tags = new string[] { "Authentication" },
                        summary = "API para fornecer um token de autenticação compatível com o fluxo 'Resource Owner Password' do OAuth2",
                        description = "O token pode ser utilizado nas demais APIs que exigem autenticação, sendo enviado através do header HTTP Authorization, cujo valor deve ter o prefixo 'Bearer '",
                        operationId = "OAuth2TokenPost",
                        consumes = new string[] { "application/x-www-form-url-encoded" },
                        produces = new string[] { "application/json" },
                        parameters = new List<Swagger.Net.Parameter>
                    {
                        new Parameter
                        {
                            name = "username",
                            @in = "formData",
                            type = "string",
                            required = true,
                            description = "o login do usuário"
                        },
                        new Parameter
                        {
                            name = "password",
                            @in = "formData",
                            type = "string",
                            required = true,
                            description = "a senha do usuário"
                        },
                        new Parameter
                        {
                            name = "grant_type",
                            @in = "formData",
                            type = "string",
                            required = true,
                            @default = "password",
                            description = "o tipo de permissão, passar fixo 'password'"
                        },
                    },
                        responses = new Dictionary<string, Response>
                    {
                        {
                            "200",
                            new Response
                            {
                                description = "Success",
                                schema = new Schema
                                {
                                    type = "object",
                                    properties = new Dictionary<string, Schema>
                                    {
                                        { "access_token", new Schema{ type = "string" } },
                                        { "token_type", new Schema{ type = "string" } },
                                        { "username", new Schema{ type = "string" } },
                                        { "expires_in", new Schema{ type = "integer" } },
                                    }
                                }
                            }
                        }
                    }
                    }
                });
            }
        }
    }
}
