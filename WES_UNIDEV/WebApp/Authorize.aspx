<%@ Page Language="C#" AutoEventWireup="true" Theme="" EnableTheming="false" Inherits="Benner.Tecnologia.Wes.Components.WebApp.AuthorizePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autenticação</title>
    <style>
        * {
			margin: 0 auto;
			padding: 0;
			border: none;
			outline: none;
			text-align: inherit;
			background-color: transparent;
			color: inherit;
			font-size: inherit;
			font-family: inherit;
			font-weight: inherit;
			line-height: 1.5em;
			text-align: inherit;
		}

		@-ms-viewport {
			width: device-width;
		}

		div,
		form,
		input,
		p,
        a {
			display: block;
			box-sizing: border-box;
		}

        a {
            text-decoration: none;
        }

        .hidden {
            display: none;
        }

		html {
			overflow-x: hidden;
			height: 100%;
		}

		body {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			position: relative;
			box-sizing: border-box;
			min-height: 100%;
			padding: 20px;
			font-size: 16px;
			font-family: 'Open Sans', sans-serif;
			font-weight: normal;
			text-align: center;
			background: #eee;
		}

        form#simpleAuth {
            width: 100%;
            max-width: 400px;
        }

        form#simpleAuth > .input {
            text-align: left;
        }

        form#simpleAuth > h2 {
            margin-bottom: 10px;
            font-size: 24px;
            text-transform: uppercase;
            color: #0076bf;
        }

        form#simpleAuth > .input > label {
            padding: 0 10px;
            font-size: 12px;
            color: #777;
        }

        form#simpleAuth > .input > input {
            width: 100%;
            padding: 10px 15px;
            margin: 5px 0;
            font-size: 16px;
            line-height: 22px;
            color: #444;
            background: white;
            box-shadow: 0 0 5px 0 rgba(0,0,0,0.4);
            transition: box-shadow 200ms linear;
        }
        form#simpleAuth > .input > input:hover {
            box-shadow: 0 0 7px 0 rgba(0,0,0,0.6);
        }

        form#simpleAuth > .btn {
            padding: 10px;
            margin-top: 20px;
            font-size: 16px;
            text-transform: uppercase;
            color: white;
            background-color: #0076bf;
            transition: opacity 200ms linear;
        }
        form#simpleAuth > .btn:hover {
            opacity: 0.7;
        }

        .alert {
            position: relative;
            padding: 15px 20px;
            margin: 20px 0;
            text-align: left;
            color: #327ad5;
            background-color: #e0ebf9;
            box-shadow: 0px 0px 4px 0px rgba(50,122,213,0.6);
        }

        .alert > .close {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 20px;
            height: 20px;
            opacity: .4;
            background: 5px 5px no-repeat url('content/assets/global/img/remove-icon-small.png');
            cursor: pointer;
            transition: opacity 200ms linear;
        }
        .alert > .close:hover {
            opacity: 0.7;
        }
    </style>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
</head>
<body>
    <form id="simpleAuth" name="simpleAuth" runat="server">
        <h2>Identifique-se</h2>
        <div class="input">
            <label for="user">Usuário</label>
            <asp:TextBox ID="BennerUser" name="user" runat="server"></asp:TextBox>
            <label for="password">Senha</label>
            <asp:TextBox ID="BennerPassword" name="password" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <div id="notification" class="alert hidden">
            <a class="close" href="javascript:closeAlert()"></a>
            <div id="notificationContent"></div>
        </div>
        <asp:LinkButton ID="Send" runat="server" CssClass="btn btn-blue" Text="Entrar" OnClick="Send_Click"></asp:LinkButton>
    </form>
    <script type="text/javascript">
        function closeAlert() {
            document.getElementById('notification').classList.add('hidden');
        }
    </script>
</body>
</html>
