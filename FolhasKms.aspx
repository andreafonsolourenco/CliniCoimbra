<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FolhasKms.aspx.cs" Inherits="FolhasKms" Culture="auto" UICulture="auto" %>
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
    <span class="variaveis" runat="server" id="lbloperatorid"></span>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="folhasKMS" runat="server">
        <input type='text' class='form-control' id='search' placeholder='Pesquisa' style="height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;"/>
        <input type='button' class='form-control' id='new' value='Nova' onclick="openNovaFolha();" style="height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div id="divTable" runat="server" style="margin-top: 10px;"></div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="novaFolha" runat="server" style="padding-top: 10px;">
        <div style="width: 100%; text-align: right; height: auto; cursor:pointer;" onclick="closeNovaFolha();"><i class="fa fa-times-circle" style="height: 20px; width: auto"></i></div>
        <input type='button' class='form-control' id='create' value='Guardar' onclick="createFolhaKms();" style="height: 50px; width: 100%; margin: auto; float: right; margin-bottom: 10px;"/>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            Nome do Beneficiário
            <input type="text" class='form-control' id='nomeBeneficiario' placeholder='Nome do Beneficiário' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            NIF do Beneficiário
            <input type="text" class='form-control' id='nifBeneficiario' placeholder='NIF do Beneficiário' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            Matrícula
            <input type="text" class='form-control' id='matricula' placeholder='Matrícula' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            Proprietário
            <input type="text" class='form-control' id='proprietario' placeholder='Proprietário' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 line">
            Preço p/ KM
            <input type="number" class='form-control' id='precokm' placeholder='Preço p/ KM' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 line">
            Mês
            <select class="form-control" id="mes" style="width: 100%; margin: auto;">
                <option value="1">Janeiro</option>
                <option value="2">Fevereiro</option>
                <option value="3">Março</option>
                <option value="4">Abril</option>
                <option value="5">Maio</option>
                <option value="6">Junho</option>
                <option value="7">Julho</option>
                <option value="8">Agosto</option>
                <option value="9">Setembro</option>
                <option value="10">Outubro</option>
                <option value="11">Novembro</option>
                <option value="12">Dezembro</option>
            </select>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 line">
            Ano
            <input type="number" class='form-control' id='ano' placeholder='Ano' required="required" style="width: 100%; margin: auto;"/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            Total KM's
            <input type="number" class='form-control' id='totalKms' placeholder='Total KMS' required="required" style="width: 100%; margin: auto;" readonly/>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 line">
            Valor Total
            <input type="number" class='form-control' id='valorTotal' placeholder='Valor Total' required="required" style="width: 100%; margin: auto;" readonly/>
        </div>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="linhasFolhaKms"></div>
    </div>

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 variaveis" id="editFolha" runat="server" style="padding-top: 10px;">
        
    </div>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script type="text/javascript" src="alertifyjs/alertify.min.js"></script>
    <script type="text/javascript" src="js/jquery.btechco.excelexport.js"></script>
    <script type="text/javascript" src="js/jquery.base64.js"></script>

    <script type="text/javascript">
        var folhaKmsID;
        var intro;
        var body;

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
                url: "FolhasKms.aspx/LoadGrid",
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

        function openNovaFolha() {
            $('#novaFolha').fadeIn();
            $('#folhasKMS').fadeOut();
            fillLines();
            $('#totalKms').val('0.00');
            $('#valorTotal').val('0.00');
            $('#precokm').val('0.36');

            $('#nomeBeneficiario').val('Alberto Miguel Silva Sousa Rio');
            $('#nifBeneficiario').val('171988450');
            $('#matricula').val('39-73-JP');
            $('#proprietario').val('Alberto Miguel Silva Sousa Rio');
            $('#ano').val(new Date().getFullYear());
        }

        function closeNovaFolha() {
            $('#novaFolha').fadeOut();
            $('#folhasKMS').fadeIn();
            loadGrid();
        }

        function openEditFolha() {
            $('#editFolha').fadeIn();
            $('#folhasKMS').fadeOut();
        }

        function closeEditFolha() {
            $('#editFolha').fadeOut();
            $('#folhasKMS').fadeIn();
            loadGrid();
        }

        function fillLines() {
            var lns = "";

            lns += "<table id='tableLinhasFolhaKms'>";
            lns += "<thead style='font-size: small;'>";
            lns += "<tr><th style='width:10%'>Dia</th><th style='width:10%'>Hora Partida</th><th style='width:10%'>Hora Chegada</th>";
            lns += "<th style='width:15%'>Origem</th><th style='width:15%'>Destino</th><th style='width:15%'>KMS</th><th style='width:10%'>Valor</th><th style='width:15%'>Notas</th></tr>";
            lns += "</thead><tbody style='font-size: small;'>";

            for (i = 0; i < 500; i++) {
                
                lns += "<tr>";
                lns += "<td><input type='number' class='form-control' id='dia" + i + "' placeholder='Dia' required='required' style='width: 100%; margin: auto;' /></td>";
                lns += "<td><input type='time' class='form-control' id='horaPartida" + i + "' placeholder='Partida' required='required' style='width: 100%; margin: auto;' /></td>";
                lns += "<td><input type='time' class='form-control' id='horaChegada" + i + "' placeholder='Chegada' required='required' style='width: 100%; margin: auto;' /></td>";
                lns += "<td><input type='text' class='form-control' id='origem" + i + "' placeholder='Origem' required='required' style='width: 100%; margin: auto;' /></td>";
                lns += "<td><input type='text' class='form-control' id='destino" + i + "' placeholder='Destino' required='required' style='width: 100%; margin: auto;' /></td>";
                lns += "<td><input type='number' class='form-control' id='kms" + i + "' placeholder='KMS' required='required' style='width: 100%; margin: auto;' onfocusout='calculateValue(" + i + ");' /></td>";
                lns += "<td><input type='number' class='form-control' id='valor" + i + "' placeholder='Valor' required='required' style='width: 100%; margin: auto;' value='0.00' readonly/></td>";
                lns += "<td><input type='text' class='form-control' id='notas" + i + "' placeholder='Notas' style='width: 100%; margin: auto;' /></td>";
                lns += "</tr>";
                
            }

            lns += "</tbody></table>";

            $('#linhasFolhaKms').html(lns);
        }

        function calculateValue(x) {
            if (!isNaN($('#kms' + x).val().trim())) {
                var res = parseFloat(parseFloat($('#kms' + x).val().trim()) * parseFloat($('#precokm').val().trim())).toFixed(2);
                $('#valor' + x).val(res.toString());
            }
            else {
                $('#valor' + x).val('0.00');
            }
            
            calculateHeaderValues();
        }

        function calculateHeaderValues() {
            var kms = 0.00;
            var val = 0.00;

            for (i = 0; i < 500; i++) {
                if (!isNaN($('#kms' + i).val().trim()) && $('#kms' + i).val().trim() != '') {
                    kms += parseFloat($('#kms' + i).val().trim());
                    val += parseFloat($('#valor' + i).val().trim());
                }                
            }

            $('#totalKms').val(kms.toString());
            $('#valorTotal').val(val.toFixed(2).toString());
        }

        function createFolhaKms() {
            var xml = createXML();

            $.ajax({
                type: "POST",
                url: "FolhasKms.aspx/InsertFolhaKms",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "xml":"' + xml + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0)
                                closeNovaFolha();
                        }
                    }
                }
            });
        }

        function createXML() {
            var xml = '<FOLHA><BENEFICIARIO_NOME>' + $('#nomeBeneficiario').val().trim() + '</BENEFICIARIO_NOME>';
            xml += '<BENEFICIARIO_NIF>' + $('#nifBeneficiario').val().trim() + '</BENEFICIARIO_NIF>';
            xml += '<VIATURA_MATRICULA>' + $('#matricula').val().trim() + '</VIATURA_MATRICULA>';
            xml += '<VIATURA_PROPRIETARIO>' + $('#proprietario').val().trim() + '</VIATURA_PROPRIETARIO>';
            xml += '<PRECO_KM>' + $('#precokm').val().trim() + '</PRECO_KM>';
            xml += '<MES>' + $('#mes').val().trim() + '</MES>';
            xml += '<ANO>' + $('#ano').val().trim() + '</ANO>';
            xml += '<TOTAL_KMS>' + $('#totalKms').val().trim() + '</TOTAL_KMS>';
            xml += '<TOTAL_RECEBIDO>' + $('#valorTotal').val().trim() + '</TOTAL_RECEBIDO>';

            for (i = 0; i < 500; i++) {
                if (!isNaN($('#kms' + i).val().trim()) && $('#kms' + i).val().trim() != '') {
                    xml += '<FOLHA_LN>';

                    xml += '<DATA_KMS>' + $('#dia' + i).val().trim() + '</DATA_KMS>';
                    xml += '<HORA_PARTIDA>' + $('#horaPartida' + i).val().trim() + '</HORA_PARTIDA>';
                    xml += '<HORA_CHEGADA>' + $('#horaChegada' + i).val().trim() + '</HORA_CHEGADA>';
                    xml += '<DESTINO>' + $('#destino' + i).val().trim() + '</DESTINO>';
                    xml += '<KMS>' + $('#kms' + i).val().trim() + '</KMS>';
                    xml += '<CUSTO>' + $('#valor' + i).val().trim() + '</CUSTO>';
                    xml += '<ORIGEM>' + $('#origem' + i).val().trim() + '</ORIGEM>';
                    xml += '<NOTAS>' + $('#notas' + i).val().trim() + '</NOTAS>';

                    xml += '</FOLHA_LN>';
                }                
            }

            xml += '</FOLHA>';
            return xml;
        }

        function showFolha(id) {
            folhaKmsID = id;
            
            $.ajax({
                type: "POST",
                url: "FolhasKms.aspx/LoadFolha",
                data: '{"idFolha":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            $('#editFolha').html(res.d);
                            $('#mesEdit').val($('#mesValueEdit').html());
                            openEditFolha();
                        }
                    }
                }
            });
        }

        function calculateValueEdit(x) {
            if (!isNaN($('#kmsEdit' + x).val().trim())) {
                var res = parseFloat(parseFloat($('#kmsEdit' + x).val().trim()) * parseFloat($('#precokmEdit').val().trim())).toFixed(2);
                $('#valorEdit' + x).val(res.toString());
            }
            else {
                $('#valorEdit' + x).val('0.00');
            }
            
            calculateHeaderValuesEdit();
        }

        function calculateHeaderValuesEdit() {
            var kms = 0.00;
            var val = 0.00;

            for (i = 0; i < 500; i++) {
                if (!isNaN($('#kmsEdit' + i).val().trim()) && $('#kmsEdit' + i).val().trim() != '') {
                    kms += parseFloat($('#kmsEdit' + i).val().trim());
                    val += parseFloat($('#valorEdit' + i).val().trim());
                }                
            }

            $('#totalKmsEdit').val(kms.toString());
            $('#valorTotalEdit').val(val.toFixed(2).toString());
        }

        function createXMLEdit() {
            var xml = '<FOLHA><BENEFICIARIO_NOME>' + $('#nomeBeneficiarioEdit').val().trim() + '</BENEFICIARIO_NOME>';
            xml += '<BENEFICIARIO_NIF>' + $('#nifBeneficiarioEdit').val().trim() + '</BENEFICIARIO_NIF>';
            xml += '<VIATURA_MATRICULA>' + $('#matriculaEdit').val().trim() + '</VIATURA_MATRICULA>';
            xml += '<VIATURA_PROPRIETARIO>' + $('#proprietarioEdit').val().trim() + '</VIATURA_PROPRIETARIO>';
            xml += '<PRECO_KM>' + $('#precokmEdit').val().trim() + '</PRECO_KM>';
            xml += '<MES>' + $('#mesEdit').val().trim() + '</MES>';
            xml += '<ANO>' + $('#anoEdit').val().trim() + '</ANO>';
            xml += '<TOTAL_KMS>' + $('#totalKmsEdit').val().trim() + '</TOTAL_KMS>';
            xml += '<TOTAL_RECEBIDO>' + $('#valorTotalEdit').val().trim() + '</TOTAL_RECEBIDO>';
            xml += '<ID_FOLHA>' + folhaKmsID + '</ID_FOLHA>';

            for (i = 0; i < 500; i++) {
                if (!isNaN($('#kmsEdit' + i).val().trim()) && $('#kmsEdit' + i).val().trim() != '') {
                    xml += '<FOLHA_LN>';

                    xml += '<DATA_KMS>' + $('#diaEdit' + i).val().trim() + '</DATA_KMS>';
                    xml += '<HORA_PARTIDA>' + $('#horaPartidaEdit' + i).val().trim() + '</HORA_PARTIDA>';
                    xml += '<HORA_CHEGADA>' + $('#horaChegadaEdit' + i).val().trim() + '</HORA_CHEGADA>';
                    xml += '<DESTINO>' + $('#destinoEdit' + i).val().trim() + '</DESTINO>';
                    xml += '<KMS>' + $('#kmsEdit' + i).val().trim() + '</KMS>';
                    xml += '<CUSTO>' + $('#valorEdit' + i).val().trim() + '</CUSTO>';
                    xml += '<ORIGEM>' + $('#origemEdit' + i).val().trim() + '</ORIGEM>';
                    xml += '<NOTAS>' + $('#notasEdit' + i).val().trim() + '</NOTAS>';

                    xml += '</FOLHA_LN>';
                }                
            }

            xml += '</FOLHA>';
            return xml;
        }

        function editFolhaKms() {
            var xml = createXMLEdit();

            $.ajax({
                type: "POST",
                url: "FolhasKms.aspx/EditFolhaKms",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "xml":"' + xml + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0)
                                closeEditFolha();
                        }
                    }
                }
            });
        }

        function deleteFolhaKms() {
            $.ajax({
                type: "POST",
                url: "FolhasKms.aspx/DeleteFolhaKms",
                data: '{"operatorID":"' + $('#lbloperatorid').html() + '", "idFolha":"' + folhaKmsID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0)
                                closeEditFolha();
                        }
                    }
                }
            });
        }

        function sendEmail(id) {
            folhaKmsID = id;
            alertify.prompt('Enviar Folha de Kms', 'Por favor, insira o email para onde quer enviar a Folha de Kms. <br />Se quiser enviar para mais do que um email, por favor separe com ";"', ''
                , function (evt, value) { buildEmail(value); }
                , function () { }).set('labels', { ok: 'Enviar', cancel: 'Cancelar' });
        }

        function buildEmail(emailTo) {
            sendEmailFromTemplate(emailTo);
        }

        function sendEmailFromTemplate(emailTo) {
            $.ajax({
                type: "POST",
                url: "FolhasKms.aspx/sendEmailFromTemplate",
                data: '{"emailTo":"' + emailTo + '", "idFolha":"' + folhaKmsID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d != null) {
                        var result = res.d;

                        if (result != null) {
                            if (parseInt(res.d) >= 0) {
                                alertify.success('Email enviado com sucesso!');
                                folhaKmsID = undefined;
                            }
                        }
                    }
                }
            });
        }

        function exportExcel(mes, ano) {
            $('#editFolha').btechco_excelexport({
                containerid: 'editFolha'
               , datatype: $datatype.Table
               , filename: 'Folha Kms ' + mes + '/' + ano
            });
        }
    </script>

  </body> 
</html>
