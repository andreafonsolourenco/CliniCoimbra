<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Clientes.aspx.cs" Inherits="Clientes" Culture="auto" UICulture="auto" %>
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
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="clientes" runat="server">
        <input type='text' class='form-control' id='search' placeholder='Pesquisa' style="height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;"/>
        <input type='button' class='form-control' id='new' value='Novo Cliente' onclick="openNovoCliente();" style="height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div id="divTable" runat="server" style="margin-top: 10px;"></div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="novoClienteDiv" runat="server" style="padding-top: 10px;">
        <div style="width: 100%; text-align: right; height: auto; cursor:pointer;" onclick="closeNovoCliente();"><i class="fa fa-times-circle" style="height: 20px; width: auto"></i></div>
        <input type='button' class='form-control' id='create' value='Guardar' onclick="createCliente();" style="height: 50px; width: 100%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 line">
            Nome
            <input type="text" class='form-control' id='nome' placeholder='Nome' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 line">
            Morada
            <input type="text" class='form-control' id='morada' placeholder='Morada' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 line">
            Nº CC
            <input type="text" class='form-control' id='cc' placeholder='Nº CC' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 line">
            NIF
            <input type="text" class='form-control' id='nif' placeholder='NIF' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 line">
            Data Nascimento
            <input type="text" class='form-control' id='data_nascimento' placeholder='Data Nascimento' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 line">
            Profissão
            <input type="text" class='form-control' id='profissao' placeholder='Profissão' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 line">
            Naturalidade
            <input type="text" class='form-control' id='naturalidade' placeholder='Naturalidade' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 line">
            Estado Civil
            <input type="text" class='form-control' id='estado_civil' placeholder='Estado Civil' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 line">
            Telefone
            <input type="text" class='form-control' id='telefone' placeholder='Telefone' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            Diagnóstico
            <textarea class='form-control' id='diagnostico' placeholder="Diagnóstico" style='width: 100%; margin: auto; height: auto;' rows='5'></textarea>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            Notas
            <textarea class='form-control' id='notas' placeholder="Notas" style='width: 100%; margin: auto; height: auto;' rows='5'></textarea>
        </div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="editCliente" runat="server" style="padding-top: 10px;">
        
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>

    <script type="text/javascript">
        var clienteID;

        $(document).ready(function () {
            loadGrid();
            $('#data_nascimento').datepicker({ format: 'dd/mm/yyyy', changeYear: true, changeMonth: true, setDate: $('#data_nascimento').val() });
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
                url: "Clientes.aspx/LoadGrid",
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

        function openNovoCliente() {
            $('#novoClienteDiv').fadeIn();
            $('#clientes').fadeOut();
        }

        function closeNovoCliente() {
            $('#novoClienteDiv').fadeOut();
            $('#clientes').fadeIn();
            loadGrid();
        }

        function openEditCliente() {
            $('#editCliente').fadeIn();
            $('#clientes').fadeOut();
        }

        function closeEditCliente() {
            $('#editCliente').fadeOut();
            $('#clientes').fadeIn();
            loadGrid();
        }

        function createCliente() {
            if ($('#nome').val().trim() == '' || $('#data_nascimento').val().trim() == '' || $('#cc').val().trim() == '' || $('#nif').val().trim() == ''
                || $('#profissao').val().trim() == '' || $('#estado_civil').val().trim() == '' || $('#naturalidade').val().trim() == ''
                || $('#morada').val().trim() == '' || $('#telefone').val().trim() == '' || $('#diagnostico').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Clientes.aspx/InsertCliente",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "nome":"' + $('#nome').val().trim() + '", "data_nascimento":"' + $('#data_nascimento').val().trim()
                    + '", "cc_nr":"' + $('#cc').val().trim() + '", "nif":"' + $('#nif').val().trim() + '", "profissao":"' + $('#profissao').val().trim() + '", "estado_civil":"' + $('#estado_civil').val().trim()
                    + '", "naturalidade":"' + $('#naturalidade').val().trim() + '", "morada":"' + $('#morada').val().trim() + '", "telefone":"' + $('#telefone').val().trim() + '", "diagnostico":"' + $('#diagnostico').val().trim()
                    + '", "notas":"' + $('#notas').val().trim() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeNovoCliente();
                                $('#nome').val('');
                                $('#data_nascimento').val('');
                                $('#cc').val('');
                                $('#nif').val('');
                                $('#profissao').val('');
                                $('#estado_civil').val('');
                                $('#naturalidade').val('');
                                $('#morada').val('');
                                $('#telefone').val('');
                                $('#diagnostico').val('');
                                $('#notas').val('');
                            }
                        }
                    }
                }
            });
        }

        function showCliente(id) {
            clienteID = id;
            
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/LoadCliente",
                data: '{"idCliente":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#editCliente').html(res.d);
                            openEditCliente();
                            $('#data_nascimentoEdit').datepicker({ format: 'dd/mm/yyyy', changeYear: true, changeMonth: true, setDate: $('#data_nascimentoEdit').val() });
                        }
                    }
                }
            });
        }

        function editCliente() {
            if ($('#nomeEdit').val().trim() == '' || $('#data_nascimentoEdit').val().trim() == '' || $('#ccEdit').val().trim() == '' || $('#nifEdit').val().trim() == ''
                || $('#profissaoEdit').val().trim() == '' || $('#estado_civilEdit').val().trim() == '' || $('#naturalidadeEdit').val().trim() == ''
                || $('#moradaEdit').val().trim() == '' || $('#telefoneEdit').val().trim() == '' || $('#diagnosticoEdit').val().trim() == '') {
                return;
            }

            $.ajax({
                type: "POST",
                url: "Clientes.aspx/EditCliente",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "nome":"' + $('#nomeEdit').val().trim() + '", "data_nascimento":"' + $('#data_nascimentoEdit').val().trim()
                    + '", "cc_nr":"' + $('#ccEdit').val().trim() + '", "nif":"' + $('#nifEdit').val().trim() + '", "profissao":"' + $('#profissaoEdit').val().trim() + '", "estado_civil":"' + $('#estado_civilEdit').val().trim()
                    + '", "naturalidade":"' + $('#naturalidadeEdit').val().trim() + '", "morada":"' + $('#moradaEdit').val().trim() + '", "telefone":"' + $('#telefoneEdit').val().trim() + '", "diagnostico":"' + $('#diagnosticoEdit').val().trim()
                    + '", "notas":"' + $('#notasEdit').val().trim() + '", "clienteID":"' + clienteID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditCliente();
                            }
                        }
                    }
                }
            });
        }

        function deleteCliente() {
            $.ajax({
                type: "POST",
                url: "Clientes.aspx/DeleteCliente",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "clienteID":"' + clienteID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                closeEditCliente();
                            }
                        }
                    }
                }
            });
        }
    </script>

  </body> 
</html>
