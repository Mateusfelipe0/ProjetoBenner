<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" EnableTheming="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<html lang="pt" class="no-js">
<head runat="server">
    <title>WES: Problema de conexão com Redis</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <style>
        .bg-white {
            background-color: #fff !important;
            font-family: sans-serif;
        }

        .container {
            margin-right: auto;
            margin-left: auto;
            padding-left: 15px;
            padding-right: 15px; 
        }
            
        .container:before, .container:after {
            content: " ";
            display: table; 
        }
        .container:after {
            clear: both; 
        }
        
        @media (min-width: 768px) {
            .container {
                width: 750px; 
            } 
        }
        
        @media (min-width: 992px) {
            .container {
                width: 970px; 
            } 
        }
        @media (min-width: 1200px) {
            .container {
                width: 1170px; 
            } 
        }

        .emoticon {
            font-size: 72px;
            vertical-align: top;
            float: left;
            padding-right: 50px;
        }

        p {
            margin: 20px 0;
        }

        .error-back {
            color: #333;
            text-decoration: underline;
        }
    </style>

    <link rel="shortcut icon" href="favicon">
</head>
<body class="bg-white">
    <div class="container">
        <div class="row" style="margin-left: auto; margin-right: auto; margin-top: 50px; width: 80%;">
            <div style="color: #e7505a">
                <p class="emoticon">:(</p>
                <div style="padding-top: 20px; padding-bottom: 40px;">
                    <span style="font-size:X-Large;">Problema ao realizar a conexão com o Redis. Favor entrar em contato com o administador do sistema.</span>
                    <div class="errorCmds" style="margin-top: 10px;">
                        <div>
                            <div style="float: left"></div>
                            <div style="padding-bottom: 10px;">
                                <a href="Login" class="error-back">Voltar</a>
                            </div>
                            <div><%= Microsoft.Web.Redis.RedisSessionStateProvider.LastException.Message %></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>