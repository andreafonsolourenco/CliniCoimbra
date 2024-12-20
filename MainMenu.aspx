<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainMenu.aspx.cs" Inherits="MainMenu" Culture="auto" UICulture="auto" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
	<title>CliniCoimbra - Menu</title>
	<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link href="assets/css/custom.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    
    <style>
        .variaveis {
            display: none;
        }
    </style>
</head>

<body>
    <span class="variaveis" runat="server" id="lbloperatorid"></span>
    <span class="variaveis" runat="server" id="lblsessionid"></span>

    <div id="wrapper">
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="adjust-nav">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <img src="img/logo.png" />
                </div>
            </div>
        </div>
        <!-- /. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    <li id="menuGestaoClientes" class="active-link" onclick="selectGestaoClientes();" style="cursor:pointer;">
                        <i class="fa fa-users " style="padding-left: 2px;"></i>Gestão de Clientes
                    </li>
                    <li id="menuGestaoMedicos" onclick="selectGestaoMedicos();" style="cursor:pointer;">
                        <i class="fa fa-desktop " style="padding-left: 2px;"></i>Gestão de Médicos
                    </li>
                    <li id="menuGestaoEspecialidades" onclick="selectGestaoEspecialidades();" style="cursor:pointer;">
                        <i class="fa fa-address-book " style="padding-left: 2px;"></i>Gestão de Especialidades
                    </li>
                    <li id="menuGestaoConsultas" onclick="selectGestaoConsultas();" style="cursor:pointer;">
                        <i class="fa fa-address-card " style="padding-left: 2px;"></i>Gestão de Consultas
                    </li>
                    <li id="menuFolhasKms" onclick="selectFolhaKms();" style="cursor:pointer;">
                        <i class="fa fa-table" style="padding-left: 2px;"></i>Folhas de KM's
                    </li>
                    <li id="menuSair" onclick="exit();" style="cursor:pointer;">
                        <i class="fa fa-sign-out-alt" style="padding-left: 2px;"></i>Sair
                    </li>
                </ul>
            </div>
        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper">
            <div id="page-inner">
                <div class="row" id="rowPageTitle">
                    <div class="col-lg-12">
                        <h2 id="pageTitle">Gestão de Clientes</h2>   
                    </div>
                </div>
                <iframe src="" style="width:100%; overflow-y: hidden;" frameBorder="0" id="pageSelected"></iframe>
            </div>
            <!-- /. PAGE INNER  -->
         </div>
         <!-- /. PAGE WRAPPER  -->
    </div>
    <div class="footer">
        <div class="row">
            <div class="col-lg-12" id="footerText" runat="server"></div>
        </div>
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#pageSelected').height($('#page-inner').height() - $('#rowPageTitle').height());
            $('#pageSelected').attr('src', 'Clientes.aspx?id=' + $('#lbloperatorid').html());
        });

        $(window).on('resize', function () {
            $('#pageSelected').height($('#page-inner').height() - $('#rowPageTitle').height());
        });

        $(window).scroll(function () {

        });

        $(document).keypress(function (e) {
            if (e.which == 13) {
                
            }
        });

        function exit() {
            $.ajax({
                type: "POST",
                url: "MainMenu.aspx/Logout",
                data: '{"sessionID":"' + $('#lblsessionid').html() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            window.location = "login.aspx";
                        }
                    }
                }
            });
        };

        function selectGestaoClientes() {
            $('#pageTitle').html('Gestão de Clientes');
            $('#menuFolhasKms').removeClass('active-link');
            $('#menuGestaoMedicos').removeClass('active-link');
            $('#menuGestaoEspecialidades').removeClass('active-link');
            $('#menuGestaoConsultas').removeClass('active-link');
            $('#menuGestaoClientes').addClass('active-link');
            $('#pageSelected').attr('src', 'Clientes.aspx?id=' + $('#lbloperatorid').html());
        }

        function selectFolhaKms() {
            $('#pageTitle').html('Folhas de KMS');
            $('#menuFolhasKms').addClass('active-link');
            $('#menuGestaoClientes').removeClass('active-link');
            $('#menuGestaoMedicos').removeClass('active-link');
            $('#menuGestaoEspecialidades').removeClass('active-link');
            $('#menuGestaoConsultas').removeClass('active-link');
            $('#pageSelected').attr('src', 'FolhasKms.aspx?id=' + $('#lbloperatorid').html());
        }

        function selectGestaoMedicos() {
            $('#pageTitle').html('Gestão de Médicos');
            $('#menuFolhasKms').removeClass('active-link');
            $('#menuGestaoMedicos').addClass('active-link');
            $('#menuGestaoEspecialidades').removeClass('active-link');
            $('#menuGestaoConsultas').removeClass('active-link');
            $('#menuGestaoClientes').removeClass('active-link');
            $('#pageSelected').attr('src', 'Medicos.aspx?id=' + $('#lbloperatorid').html());
        }

        function selectGestaoConsultas() {
            $('#pageTitle').html('Gestão de Consultas');
            $('#menuFolhasKms').removeClass('active-link');
            $('#menuGestaoMedicos').removeClass('active-link');
            $('#menuGestaoEspecialidades').removeClass('active-link');
            $('#menuGestaoConsultas').addClass('active-link');
            $('#menuGestaoClientes').removeClass('active-link');
            $('#pageSelected').attr('src', 'Consultas.aspx?id=' + $('#lbloperatorid').html());
        }

        function selectGestaoEspecialidades() {
            $('#pageTitle').html('Gestão de Especialidades');
            $('#menuFolhasKms').removeClass('active-link');
            $('#menuGestaoMedicos').removeClass('active-link');
            $('#menuGestaoEspecialidades').addClass('active-link');
            $('#menuGestaoConsultas').removeClass('active-link');
            $('#menuGestaoClientes').removeClass('active-link');
            $('#pageSelected').attr('src', 'Especialidades.aspx?id=' + $('#lbloperatorid').html());
        }
    </script>

  </body> 
</html>
