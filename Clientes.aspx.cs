using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Text;
using System.Security.Cryptography;
using System.Web.Services;
using System.Data;

public partial class Clientes : Page
{
    string id = "";

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        id = Request.QueryString["id"];

        if (!IsPostBack)
        {
            ClientScriptManager oCsm = this.Page.ClientScript;
            if (!oCsm.IsStartupScriptRegistered(GetType(), "Clientes"))
            {

            }
        }

        lbloperatorid.InnerHtml = id;
    }

    [WebMethod]
    public static string LoadGrid(string filtro)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT DMY;
                                            DECLARE @filtro varchar(max) = {0};
                                            DECLARE @id_cliente int

                                            SELECT
                                                id_cliente,
		                                        nome,
		                                        data_nascimento,
		                                        cc_nr,
		                                        nif,
		                                        profissao,
		                                        estado_civil,
		                                        naturalidade,
		                                        morada,
		                                        telefone,
		                                        diagnostico,
		                                        notas
                                            FROM [REPORT_CLIENTES](@id_cliente)
                                            WHERE @filtro is null
                                            or nome like '%' + @filtro + '%'
                                            or data_nascimento like '%' + @filtro + '%'
                                            or cc_nr like '%' + @filtro + '%'
                                            or nif like '%' + @filtro + '%'
                                            or profissao like '%' + @filtro + '%'
                                            or estado_civil like '%' + @filtro + '%'
                                            or naturalidade like '%' + @filtro + '%'
                                            or morada like '%' + @filtro + '%'
                                            or telefone like '%' + @filtro + '%'
                                            or diagnostico like '%' + @filtro + '%'
                                            order by nome", string.IsNullOrEmpty(filtro) ? "NULL" : "'" + filtro + "'");

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                // Adiciona as linhas
                table.AppendFormat(@"   <table id='tableGrid'>
                                            <thead>
						                        <tr>
                                                    <th class='headerColspan'>Clientes</th>
						                        </tr>
						                    </thead>
                                            <tbody>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"<tr ondblclick='showCliente({0});'>
                                            <td>{1}<br />{8}</td>
                                        </tr>",
                                                oDs.Tables[0].Rows[i]["id_cliente"].ToString(),
                                                oDs.Tables[0].Rows[i]["nome"].ToString(),
                                                oDs.Tables[0].Rows[i]["data_nascimento"].ToString(),
                                                oDs.Tables[0].Rows[i]["cc_nr"].ToString(),
                                                oDs.Tables[0].Rows[i]["nif"].ToString(),
                                                oDs.Tables[0].Rows[i]["profissao"].ToString(),
                                                oDs.Tables[0].Rows[i]["estado_civil"].ToString(),
                                                oDs.Tables[0].Rows[i]["naturalidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["morada"].ToString(),
                                                oDs.Tables[0].Rows[i]["telefone"].ToString(),
                                                oDs.Tables[0].Rows[i]["diagnostico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString());
                }

                table.AppendFormat("</tbody></table>");
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem clientes a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem clientes a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string InsertCliente(string operatorID, string nome, string data_nascimento, string cc_nr, string nif, string profissao, string estado_civil, string naturalidade, string morada, string telefone, string diagnostico, string notas)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   set dateformat dmy
                                            declare @id_operador int = {0};
	                                        declare @nome varchar(500) = '{1}';
	                                        declare @data_nascimento DATETIME = '{2}';
	                                        declare @cc_nr VARCHAR(100) = '{3}';
	                                        declare @nif VARCHAR(100) = '{4}';
	                                        declare @profissao VARCHAR(500) = '{5}';
	                                        declare @estado_civil VARCHAR(250) = '{6}';
	                                        declare @naturalidade VARCHAR(250) = '{7}';
	                                        declare @morada VARCHAR(500) = '{8}';
	                                        declare @telefone VARCHAR(250) = '{9}';
	                                        declare @diagnostico VARCHAR(MAX) = '{10}';
	                                        declare @notas varchar(max) = '{11}';
	                                        declare @res int;

                                            exec CRIA_CLIENTE @id_operador,@nome,@data_nascimento,@cc_nr,@nif,@profissao,@estado_civil,@naturalidade,@morada,@telefone,@diagnostico,@notas,@res output

                                            select @res as ret", operatorID, nome, data_nascimento, cc_nr, nif, profissao, estado_civil, naturalidade, morada, telefone, diagnostico, notas);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"{0}", oDs.Tables[0].Rows[i]["ret"].ToString());
                }
            }
            else
            {
                table.AppendFormat("-1");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("-1");
        }

        return table.ToString();
    }

    [WebMethod]
    public static string LoadCliente(string idCliente)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT DMY;
                                            DECLARE @id_cliente int = {0};

                                            SELECT
                                                id_cliente,
		                                        nome,
		                                        convert(varchar(10), data_nascimento, 103) as data_nascimento,
		                                        cc_nr,
		                                        nif,
		                                        profissao,
		                                        estado_civil,
		                                        naturalidade,
		                                        morada,
		                                        telefone,
		                                        diagnostico,
		                                        notas
                                            FROM [REPORT_CLIENTES](@id_cliente)", idCliente);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    table.AppendFormat(@"   <div style='width: 100 %; text-align: right; height: auto; cursor: pointer;' onclick='closeEditCliente(); '><i class='fa fa-times-circle' style='height: 20px; width: auto'></i></div>
                                            <input type='button' class='form-control' id='edit' value='Guardar' onclick='editCliente();' style='height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;'/>
                                            <input type='button' class='form-control' id='delete' value='Apagar' onclick='deleteCliente();' style='height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;'/>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
                                                Nome
                                                <input type='text' class='form-control' id='nomeEdit' placeholder='Nome' required='required' style='width: 100%; margin: auto;' value='{1}'/>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
                                                Morada
                                                <input type='text' class='form-control' id='moradaEdit' placeholder='Morada' required='required' style='width: 100%; margin: auto;' value='{8}'/>
                                            </div>
                                            <div class='col-lg-4 col-md-4 col-sm-12 col-xs-12 line'>
                                                Nº CC
                                                <input type= 'text' class='form-control' id='ccEdit' placeholder='Nº CC' required='required' style='width: 100%; margin: auto;' value='{3}'/>
                                            </div>
                                            <div class='col-lg-4 col-md-4 col-sm-12 col-xs-12 line'>
                                                NIF
                                                <input type='text' class='form-control' id='nifEdit' placeholder='NIF' required='required' style='width: 100%; margin: auto;' value='{4}'/>
                                            </div>
                                            <div class='col-lg-4 col-md-4 col-sm-12 col-xs-12 line'>
                                                Data Nascimento
                                                <input type= 'text' class='form-control' id='data_nascimentoEdit' placeholder='Data Nascimento' required='required' style='width: 100%; margin: auto;' value='{2}'/>
                                            </div>
                                            <div class='col-lg-6 col-md-6 col-sm-12 col-xs-12 line'>
                                                Profissão
                                                <input type='text' class='form-control' id='profissaoEdit' placeholder='Profissão' required='required' style='width: 100%; margin: auto;' value='{5}'/>
                                            </div>
                                            <div class='col-lg-6 col-md-6 col-sm-12 col-xs-12 line'>
                                                Naturalidade
                                                <input type='text' class='form-control' id='naturalidadeEdit' placeholder='Naturalidade' required='required' style='width: 100%; margin: auto;' value='{7}'/>
                                            </div>
                                            <div class='col-lg-6 col-md-6 col-sm-12 col-xs-12 line'>
                                                Estado Civil
                                                <input type= 'text' class='form-control' id='estado_civilEdit' placeholder='Estado Civil' required='required' style='width: 100%; margin: auto;' value='{6}'/>
                                            </div>
                                            <div class='col-lg-6 col-md-6 col-sm-12 col-xs-12 line'>
                                                Telefone
                                                <input type='text' class='form-control' id='telefoneEdit' placeholder='Telefone' required='required' style='width: 100%; margin: auto;' value='{9}'/>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
                                                Diagnóstico
                                                <textarea class='form-control' id='diagnosticoEdit' placeholder='Diagnóstico' style='width: 100%; margin: auto; height: auto;' rows='5'>{10}</textarea>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
                                                Notas
                                                <textarea class='form-control' id='notasEdit' placeholder='Notas' style='width: 100%; margin: auto; height: auto;' rows='5'>{11}</textarea>
                                            </div>",
                                                oDs.Tables[0].Rows[i]["id_cliente"].ToString(),
                                                oDs.Tables[0].Rows[i]["nome"].ToString(),
                                                oDs.Tables[0].Rows[i]["data_nascimento"].ToString(),
                                                oDs.Tables[0].Rows[i]["cc_nr"].ToString(),
                                                oDs.Tables[0].Rows[i]["nif"].ToString(),
                                                oDs.Tables[0].Rows[i]["profissao"].ToString(),
                                                oDs.Tables[0].Rows[i]["estado_civil"].ToString(),
                                                oDs.Tables[0].Rows[i]["naturalidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["morada"].ToString(),
                                                oDs.Tables[0].Rows[i]["telefone"].ToString(),
                                                oDs.Tables[0].Rows[i]["diagnostico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString());
                }
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem clientes a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem clientes a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string EditCliente(string operatorID, string nome, string data_nascimento, string cc_nr, string nif, string profissao, string estado_civil, string naturalidade, string morada, string telefone, string diagnostico, string notas, string clienteID)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   set dateformat dmy
                                            declare @id_operador int = {0};
                                            declare @id_cliente int = {12};
	                                        declare @nome varchar(500) = '{1}';
	                                        declare @data_nascimento DATETIME = '{2}';
	                                        declare @cc_nr VARCHAR(100) = '{3}';
	                                        declare @nif VARCHAR(100) = '{4}';
	                                        declare @profissao VARCHAR(500) = '{5}';
	                                        declare @estado_civil VARCHAR(250) = '{6}';
	                                        declare @naturalidade VARCHAR(250) = '{7}';
	                                        declare @morada VARCHAR(500) = '{8}';
	                                        declare @telefone VARCHAR(250) = '{9}';
	                                        declare @diagnostico VARCHAR(MAX) = '{10}';
	                                        declare @notas varchar(max) = '{11}';
	                                        declare @res int;

                                            exec ALTERA_CLIENTE @id_operador,@id_cliente,@nome,@data_nascimento,@cc_nr,@nif,@profissao,@estado_civil,@naturalidade,@morada,@telefone,@diagnostico,@notas,@res output

                                            select @res as ret", operatorID, nome, data_nascimento, cc_nr, nif, profissao, estado_civil, naturalidade, morada, telefone, diagnostico, notas, clienteID);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"{0}", oDs.Tables[0].Rows[i]["ret"].ToString());
                }
            }
            else
            {
                table.AppendFormat("-1");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("-1");
        }

        return table.ToString();
    }

    [WebMethod]
    public static string DeleteCliente(string operatorID, string clienteID)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   DECLARE @id_op int = {0};
                                            DECLARE @id_cliente int = {1};
                                            DECLARE @erro int

                                            exec APAGA_CLIENTE @id_op, @id_cliente, @erro output

                                            select @erro as ret", operatorID, clienteID);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"{0}", oDs.Tables[0].Rows[i]["ret"].ToString());
                }
            }
            else
            {
                table.AppendFormat("-1");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("-1");
        }

        return table.ToString();
    }
}
