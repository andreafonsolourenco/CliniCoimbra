<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" Culture="auto" UICulture="auto" %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <title>CliniCoimbra - Login</title>

    <script type="text/javascript">
        $(window).resize(function () {

        });

        $(document).ready(function () {
            $('#username').focus();
        });

        function login() {
            $.ajax({
                type: "POST",
                url: "login.aspx/Login",
                data: '{"user":"' + $('#username').val() + '", "pass":"' + $('#password').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(result) > 0) {
                                encryptSessionID(result);
                                $('#register-link').fadeOut();
                            }
                            else
                                $('#register-link').fadeIn();
                        }
                    }
                }
            });
        };

        function encryptSessionID(str) {
            $.ajax({
                type: "POST",
                url: "login.aspx/Encrypt",
                data: '{"str":"' + str + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            window.location = "MainMenu.aspx?id=" + result;
                            //registaLog(result, 'LOGIN', 'Login efetuado com o user ' + $('#txtLogin').val());
                        }
                    }
                }
            });
        };

        $(document).keypress(function (e) {
            if (e.which == 13) {
                login();
            }
        });

    </script>


    <style>
        body {
            background-image: linear-gradient(to left top, #009900, #006600);
            height: 100vh;
        }
        #login .container #login-row #login-column .login-box {
            margin-top: 120px;
            max-width: 600px;
            height: auto;
            /*border: 1px solid #9C9C9C;*/
            background-image: linear-gradient(to bottom, #aec1c3, #a9b5b7, #bcc5c6, #cfd5d5, #e3e5e5);
        }
        #login .container #login-row #login-column .login-box #login-form {
            padding: 20px;
        }
        #login .container #login-row #login-column .login-box #login-form #register-link {
            margin-top: -85px;
        }
    </style>

</head>


<body>
    <div id="login">
        <h3 class="text-center text-white pt-5"></h3>
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div class="login-box col-md-12">
                        <h3 class="text-center text-info"><img src="img/logo.png" style="height: 100px; width: auto; margin: auto" /></h3>
                        <div class="form-group">
                            <label for="username" class="text-info" style="color: #000 !important;">Username:</label><br>
                            <input type="text" name="username" id="username" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="password" class="text-info" style="color: #000 !important;">Password:</label><br>
                            <input type="password" name="password" id="password" class="form-control">
                        </div>
                        <div class="form-group">
                            <%--<label for="remember-me" class="text-info"><span>Remember me</span> <span><input id="remember-me" name="remember-me" type="checkbox"></span></label>--%><br>
                            <input type="button" class="btn btn-info btn-lg" style="width: 100% !important; margin-bottom: 50px; background-color: #006600; border: 0 !important;" value="Entrar" onclick="login();">
                        </div>
                        <div id="register-link" style="display:none; text-align: center">
                            Utilizador Não Encontrado!
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
