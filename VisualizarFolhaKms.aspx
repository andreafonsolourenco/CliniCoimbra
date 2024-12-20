<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisualizarFolhaKms.aspx.cs" Inherits="VisualizarFolhaKms" Culture="auto" UICulture="auto" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
	<title>CliniCoimbra - Menu</title>
	<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/custom.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link href="alertifyjs/css/alertify.min.css" rel="stylesheet" type='text/css'/>
    <link href="alertifyjs/css/themes/semantic.min.css" rel="stylesheet" type='text/css'/>
    <link href="alertifyjs/css/themes/default.min.css" rel="stylesheet" type='text/css'/>
    
    <style>
        .variaveis {
            display: none;
        }

        table {
            width:100%; 
            height: auto;
        }

        table thead {
            background-color:#000; 
            color: #FFF; 
            font-size: large; 
            font-weight: bold;
        }

        table thead tr {
            height: 50px;
            -moz-border-radius: 4px !important;
            -webkit-border-radius: 4px !important;
            border-radius: 4px !important;
        }

        table thead tr th {
            padding: 5px;
        }

        table tbody {
            background-color:#FFF;
            color:#000;
            font-size: medium;
            border: 1px #000 solid; 
        }

        table tbody tr {
            height: 40px;
            -moz-border-radius: 4px !important;
            -webkit-border-radius: 4px !important;
            border-radius: 4px !important;
            cursor: pointer;
        }

        table tbody tr:hover {
            background-color: #D3D3D3;
        }

        table tbody tr td {
            padding: 5px;
            border: 1px #000 solid;
        }
    </style>
</head>

<body>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="folhaKms" runat="server" style="padding-top: 10px;">
        
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script type="text/javascript" src="alertifyjs/alertify.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            
        });

        $(window).on('resize', function () {

        });

        $(window).scroll(function () {

        });
    </script>

  </body> 
</html>
