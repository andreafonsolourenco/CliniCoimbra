<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Consultas.aspx.cs" Inherits="Consultas" Culture="auto" UICulture="auto" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

    
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
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="especialidades" runat="server">
        <input type='text' class='form-control' id='search' placeholder='Pesquisa' style="height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;"/>
        <input type='button' class='form-control' id='new' value='Nova Especialidade' onclick="openNovaEspecialidade();" style="height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div id="divTable" runat="server" style="margin-top: 10px;"></div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="novaEspecialidadeDiv" runat="server" style="padding-top: 10px;">
        <div style="width: 100%; text-align: right; height: auto; cursor:pointer;" onclick="closeNovaEspecialidade();"><i class="fa fa-times-circle" style="height: 20px; width: auto"></i></div>
        <input type='button' class='form-control' id='create' value='Guardar' onclick="createEspecialidade();" style="height: 50px; width: 100%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
            Nome
            <input type='text' class='form-control' id='nome' placeholder='Nome' required='required' style='width: 100%; margin: auto;'/>
        </div>
        <div class='col-lg-4 col-md-4 col-sm-4 col-xs-12 line' id='divMedico' runat='server'></div>
        <div class='col-lg-4 col-md-4 col-sm-4 col-xs-12 line'>
            Horário
            <input type='text' class='form-control' id='horario' placeholder='Horário' required='required' style='width: 100%; margin: auto;'/>
        </div>
        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
            Notas
            <textarea class='form-control' id='notas' placeholder='Notas' style='width: 100%; margin: auto; height: auto;' rows='5'></textarea>
        </div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="editEspecialidade" runat="server" style="padding-top: 10px;">
        
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>

    <script type="text/javascript">
        var especialidadeID;

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
                url: "Especialidades.aspx/LoadGrid",
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

        function openNovaEspecialidade() {
            $('#novaEspecialidadeDiv').fadeIn();
            $('#especialidades').fadeOut();
        }

        function closeNovaEspecialidade() {
            $('#novaEspecialidadeDiv').fadeOut();
            $('#especialidades').fadeIn();
            loadGrid();
        }

        function openEditEspecialidade() {
            $('#editEspecialidade').fadeIn();
            $('#especialidades').fadeOut();
        }

        function closeEditEspecialidade() {
            $('#editEspecialidade').fadeOut();
            $('#especialidades').fadeIn();
            loadGrid();
        }

        function createEspecialidade() {
            if ($('#nome').val().trim() == '' || $('#medico').val().trim() == '' || $('#horario').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Especialidades.aspx/InsertEspecialidade",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "nome":"' + $('#nome').val().trim() + '", "medicoID":"' + $('#medico').val().trim()
                    + '", "horario":"' + $('#horario').val().trim() + '", "foto":"' + '' + '", "notas":"' + $('#notas').val().trim() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeNovaEspecialidade();
                                $('#nome').val('');
                                $('#medico').val('0');
                                $('#horario').val('');
                                $('#notas').val('');
                            }
                        }
                    }
                }
            });
        }

        function showEspecialidade(id) {
            especialidadeID = id;
            
            $.ajax({
                type: "POST",
                url: "Especialidades.aspx/LoadEspecialidade",
                data: '{"idEspecialidade":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#editEspecialidade').html(res.d);
                            loadSelectDivEditMedico();
                            openEditEspecialidade();
                        }
                    }
                }
            });
        }

        function loadSelectDivEditMedico() {
            $.ajax({
                type: "POST",
                url: "Especialidades.aspx/LoadMedicosSelectEdit",
                data: '{"idMedico":"' + $('#idMedicoEdit').html() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#divMedicoEdit').html(result);
                        }
                    }
                }
            });
        };

        function editEspecialidade() {
            if ($('#nomeEdit').val().trim() == '' || $('#medicoEdit').val().trim() == '' || $('#horarioEdit').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Especialidades.aspx/EditEspecialidade",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "nome":"' + $('#nomeEdit').val().trim() + '", "medicoID":"' + $('#medicoEdit').val().trim()
                    + '", "horario":"' + $('#horarioEdit').val().trim() + '", "foto":"' + '' + '", "notas":"' + $('#notasEdit').val().trim()
                    + '", "especialidadeID":"' + especialidadeID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditEspecialidade();
                            }
                        }
                    }
                }
            });
        }

        function deleteEspecialidade() {
            $.ajax({
                type: "POST",
                url: "Especialidades.aspx/DeleteEspecialidade",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "especialidadeID":"' + especialidadeID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditEspecialidade();
                            }
                        }
                    }
                }
            });
        }
    </script>

  </body> 
</html>
