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

public partial class Consultas : Page
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
            if (!oCsm.IsStartupScriptRegistered(GetType(), "Consultas"))
            {

            }
        }

        lbloperatorid.InnerHtml = id;
    }

    private void loadMedicos()
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET LANGUAGE PORTUGUESE;
                                            DECLARE @id_medico int

                                            SELECT
                                                id_medico, medico, notas, id_especialidade, especialidade
                                            FROM [REPORT_MEDICOS](@id_medico)
                                            order by medico");

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                // Adiciona as linhas
                table.AppendFormat(@"Médico<select class='form-control' id='medico' style='width: 100 %; margin: auto;'>");
                table.AppendFormat(@"<option value='0'>Sem Médico Associado</option>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"<option value='{0}'>{1}</option>",
                                                oDs.Tables[0].Rows[i]["id_medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString(),
                                                oDs.Tables[0].Rows[i]["id_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["especialidade"].ToString());
                }

                table.AppendFormat("</select>");
            }
            else
            {
                table.AppendFormat(@"Médico<select class='form-control' id='medico' style='width: 100 %; margin: auto;'>");
                table.AppendFormat(@"<option value='0'>Não existem médicos a apresentar!</option>");
                table.AppendFormat("</select>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat(@"Médico<select class='form-control' id='medico' style='width: 100 %; margin: auto;'>");
            table.AppendFormat(@"<option value='0'>Não existem médicos a apresentar!</option>");
            table.AppendFormat("</select>");
        }

        divMedico.InnerHtml = table.ToString();
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
                                            DECLARE @id_medico int;
                                            DECLARE @id_especialidade int;

                                            SELECT
                                                id_especialidade,
		                                        especialidade,
		                                        horario,
		                                        clinica,
		                                        notas_especialidade,
		                                        foto,
		                                        id_medico,
		                                        medico,
		                                        notas_medico
                                            FROM [REPORT_MEDICOS_ESPECIALIDADES](@id_medico, @id_especialidade)
                                            WHERE @filtro is null
                                            or especialidade like '%' + @filtro + '%'
                                            or horario like '%' + @filtro + '%'
                                            or clinica like '%' + @filtro + '%'
                                            or medico like '%' + @filtro + '%'
                                            order by especialidade", string.IsNullOrEmpty(filtro) ? "NULL" : "'" + filtro + "'");

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
                                                    <th class='headerColspan'>Especialidades</th>
						                        </tr>
						                    </thead>
                                            <tbody>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"<tr ondblclick='showEspecialidade({0});'>
                                            <td>{1}</td>
                                        </tr>",
                                                oDs.Tables[0].Rows[i]["id_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["especialidade"].ToString());
                }

                table.AppendFormat("</tbody></table>");
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem especialidades a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem especialidades a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string InsertEspecialidade(string operatorID, string nome, string medicoID, string horario, string foto, string notas)
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
	                                        declare @id_medico int = {2};
	                                        declare @horario varchar(500) = '{3}';
	                                        declare @foto VARCHAR(500) = '{4}';
	                                        declare @notas varchar(max) = '{5}';
	                                        declare @res int;

                                            exec CRIA_ESPECIALIDADE @id_operador,@nome,@id_medico,@horario,@foto,@notas,@res output

                                            select @res as ret", operatorID, nome, medicoID, horario, foto, notas);

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
    public static string LoadEspecialidade(string idEspecialidade)
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
                                            DECLARE @id_especialidade int = {0};
                                            DECLARE @id_medico int;

                                            SELECT
                                                id_especialidade,
		                                        especialidade,
		                                        horario,
		                                        clinica,
		                                        notas_especialidade,
		                                        foto,
		                                        id_medico,
		                                        medico,
		                                        notas_medico
                                            FROM [REPORT_MEDICOS_ESPECIALIDADES](@id_medico, @id_especialidade)", idEspecialidade);

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
                    table.AppendFormat(@"   <div style='width: 100 %; text-align: right; height: auto; cursor: pointer;' onclick='closeEditEspecialidade(); '><i class='fa fa-times-circle' style='height: 20px; width: auto'></i></div>
                                            <input type='button' class='form-control' id='edit' value='Guardar' onclick='editEspecialidade();' style='height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;'/>
                                            <input type='button' class='form-control' id='delete' value='Apagar' onclick='deleteEspecialidade();' style='height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;'/>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
                                                Nome
                                                <input type='text' class='form-control' id='nomeEdit' placeholder='Nome' required='required' style='width: 100%; margin: auto;' value='{1}'/>
                                            </div>
                                            <div class='col-lg-6 col-md-6 col-sm-6 col-xs-12 line' id='divMedicoEdit' runat='server'></div>
                                            <div class='col-lg-6 col-md-6 col-sm-6 col-xs-12 line'>
                                                Horário
                                                <input type='text' class='form-control' id='horarioEdit' placeholder='Horário' required='required' style='width: 100%; margin: auto;' value='{2}'/>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
                                                Notas
                                                <textarea class='form-control' id='notasEdit' placeholder='Notas' style='width: 100%; margin: auto; height: auto;' rows='5'>{4}</textarea>
                                            </div>
                                            <span class='variaveis' id='idMedicoEdit'>{6}</span>",
                                                oDs.Tables[0].Rows[i]["id_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["horario"].ToString(),
                                                oDs.Tables[0].Rows[i]["clinica"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["foto"].ToString(),
                                                oDs.Tables[0].Rows[i]["id_medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas_medico"].ToString());
                }
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem especialidades a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem especialidades a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string LoadMedicosSelectEdit(string idMedico)
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET LANGUAGE PORTUGUESE;
                                            DECLARE @id_medico int

                                            SELECT
                                                id_medico, medico, notas, id_especialidade, especialidade
                                            FROM [REPORT_MEDICOS](@id_medico)
                                            order by medico");

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                // Adiciona as linhas
                table.AppendFormat(@"Médico<select class='form-control' id='medicoEdit' style='width: 100 %; margin: auto;'>");
                table.AppendFormat(@"<option value='0'>Sem Médico Associado</option>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"<option value='{0}' {5}>{1}</option>",
                                                oDs.Tables[0].Rows[i]["id_medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString(),
                                                oDs.Tables[0].Rows[i]["id_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["id_medico"].ToString() == idMedico ? "selected" : "");
                }

                table.AppendFormat("</select>");
            }
            else
            {
                table.AppendFormat(@"Médico<select class='form-control' id='medicoEdit' style='width: 100 %; margin: auto;'>");
                table.AppendFormat(@"<option value='0'>Não existem médicos a apresentar!</option>");
                table.AppendFormat("</select>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat(@"Médico<select class='form-control' id='medicoEdit' style='width: 100 %; margin: auto;'>");
            table.AppendFormat(@"<option value='0'>Não existem médicos a apresentar!</option>");
            table.AppendFormat("</select>");
        }

        return table.ToString();
    }

    [WebMethod]
    public static string EditEspecialidade(string operatorID, string nome, string medicoID, string horario, string foto, string notas, string especialidadeID)
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
                                            declare @id_especialidade int = {6};
	                                        declare @nome varchar(500) = '{1}';
	                                        declare @id_medico int = {2};
	                                        declare @horario varchar(500) = '{3}';
	                                        declare @foto VARCHAR(500) = '{4}';
	                                        declare @notas varchar(max) = '{5}';
	                                        declare @res int;

                                            exec ALTERA_ESPECIALIDADE @id_operador,@id_especialidade,@nome,@id_medico,@horario,@foto,@notas,@res output

                                            select @res as ret", operatorID, nome, medicoID, horario, foto, notas, especialidadeID);

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
    public static string DeleteEspecialidade(string operatorID, string especialidadeID)
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
                                            DECLARE @id_especialidade int = {1};
                                            DECLARE @erro int

                                            exec APAGA_ESPECIALIDADE @id_op, @id_especialidade, @erro output

                                            select @erro as ret", operatorID, especialidadeID);

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
