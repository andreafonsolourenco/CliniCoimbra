<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Medicos.aspx.cs" Inherits="Medicos" Culture="auto" UICulture="auto" %>
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
    <span class="variaveis" runat="server" id="lbloperatorid"></span>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="medicos" runat="server">
        <input type='text' class='form-control' id='search' placeholder='Pesquisa' style="height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;"/>
        <input type='button' class='form-control' id='new' value='Novo Médico' onclick="openNovoMedico();" style="height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div id="divTable" runat="server" style="margin-top: 10px;"></div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="novoMedicoDiv" runat="server" style="padding-top: 10px;">
        <div style="width: 100%; text-align: right; height: auto; cursor:pointer;" onclick="closeNovoMedico();"><i class="fa fa-times-circle" style="height: 20px; width: auto"></i></div>
        <input type='button' class='form-control' id='create' value='Guardar' onclick="createMedico();" style="height: 50px; width: 100%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 line">
            Nome
            <input type="text" class='form-control' id='nome' placeholder='Nome' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
            Clínica
            <input type='text' class='form-control' id='clinica' placeholder='Clínica' required='required' style='width: 100%; margin: auto;'/>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            Notas
            <textarea class='form-control' id='notas' placeholder="Notas" style='width: 100%; margin: auto; height: auto;' rows='5'></textarea>
        </div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="editMedico" runat="server" style="padding-top: 10px;">
        
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>

    <script type="text/javascript">
        var medicoID;

        $(document).ready(function () {
            loadGrid();
        });

        $(window).on('resize', function () {

        });

        $(window).scroll(function () {

        });

        $(document).keypress(function (e) {
            if (e.which == 13) {
                loadGrid();
            }
        });

        function loadGrid() {
            $.ajax({
                type: "POST",
                url: "Medicos.aspx/LoadGrid",
                data: '{"filtro":"' + $('#search').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#divTable').html(result);
                        }
                    }
                }
            });
        };

        function openNovoMedico() {
            $('#novoMedicoDiv').fadeIn();
            $('#medicos').fadeOut();
        }

        function closeNovoMedico() {
            $('#novoMedicoDiv').fadeOut();
            $('#medicos').fadeIn();
            loadGrid();
        }

        function openEditMedico() {
            $('#editMedico').fadeIn();
            $('#medicos').fadeOut();
        }

        function closeEditMedico() {
            $('#editMedico').fadeOut();
            $('#medicos').fadeIn();
            loadGrid();
        }

        function createMedico() {
            if ($('#nome').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Medicos.aspx/InsertMedico",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "nome":"' + $('#nome').val().trim() + '", "notas":"' + $('#notas').val().trim() + '", "clinica":"' + $('#clinica').val().trim() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeNovoMedico();
                                $('#nome').val('');
                                $('#notas').val('');
                                $('#clinica').val('');
                            }
                        }
                    }
                }
            });
        }

        function showMedico(id) {
            medicoID = id;
            
            $.ajax({
                type: "POST",
                url: "Medicos.aspx/LoadMedico",
                data: '{"idMedico":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#editMedico').html(res.d);
                            openEditMedico();
                        }
                    }
                }
            });
        }

        function editMedico() {
            if ($('#nomeEdit').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Medicos.aspx/EditMedico",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "medicoID":"' + medicoID + '", "nome":"' + $('#nomeEdit').val().trim() + '", "notas":"' + $('#notasEdit').val().trim()
                    + '", "clinica":"' + $('#clinicaEdit').val().trim() +'"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditMedico();
                            }
                        }
                    }
                }
            });
        }

        function deleteMedico() {
            $.ajax({
                type: "POST",
                url: "Medicos.aspx/DeleteMedico",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "medicoID":"' + medicoID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditMedico();
                            }
                        }
                    }
                }
            });
        }
    </script>

  </body> 
</html>
