<%@ Page Title="Acesso Negado" Language="C#" Inherits="Benner.Tecnologia.Wes.Components.WebApp.WesPage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div class="row">
        <div class="col-md-12 page-401">
            <div class=" number font-red"><i class="fa fa-lock"></i></div>
            <div class=" details">
                <h3>Oops! Acesso negado.</h3>
                <p>
                    Você não tem permissão para acessar essa página.
                    <br>
                </p>
                <p>
                    <%if (!Page.ClientQueryString.Contains("imp=1"))
                        { %>
                    <a href="<%= Page.ResolveUrl("~/") %>" class="btn red btn-outline home-redirect">Página inicial </a>
                    <%} %>
                    <br>
                </p>
            </div>
        </div>
    </div>
    <style>
        .page-401 {
            text-align: center;
            margin-top: 50px;
        }

            .page-401 .number {
                letter-spacing: -10px;
                line-height: 128px;
                font-size: 110px;
                font-weight: 300;
            }

            .page-401 .number {
                display: inline-block;
                color: #ec8c8c;
                text-align: right;
            }

            .page-401 .details {
                text-align: left;
            }

            .page-401 .details {
                margin-left: 40px;
                display: inline-block;
            }
    </style>
</asp:Content>

