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

public partial class Medicos : Page
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
            if (!oCsm.IsStartupScriptRegistered(GetType(), "Medicos"))
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
            string sql = string.Format(@"   SET LANGUAGE PORTUGUESE;
                                            DECLARE @filtro varchar(max) = {0};
                                            DECLARE @id_medico int

                                            SELECT
                                                id_medico, medico, notas, id_especialidade, especialidade
                                            FROM [REPORT_MEDICOS](@id_medico)
                                            WHERE @filtro is null
                                            or medico like '%' + @filtro + '%'
                                            or especialidade like '%' + @filtro + '%'
                                            order by medico", string.IsNullOrEmpty(filtro) ? "NULL" : "'" + filtro + "'");

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
                                                    <th class='headerColspan'>Médicos</th>
						                        </tr>
						                    </thead>
                                            <tbody>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    // Adiciona as linhas com dados
                    table.AppendFormat(@"<tr ondblclick='showMedico({0});'>
                                            <td>{1}<br />{4}</td>
                                        </tr>",
                                                oDs.Tables[0].Rows[i]["id_medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString(),
                                                oDs.Tables[0].Rows[i]["id_especialidade"].ToString(),
                                                oDs.Tables[0].Rows[i]["especialidade"].ToString());
                }

                table.AppendFormat("</tbody></table>");
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem médicos a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableGrid'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem médicos a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string InsertMedico(string operatorID, string nome, string notas, string clinica)
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
                                            DECLARE @nome varchar(500) = '{1}';
                                            DECLARE @notas varchar(max) = '{2}';
                                            DECLARE @clinica varchar(500) = '{3}';
                                            DECLARE @erro int

                                            exec cria_medico @id_op, @nome, @notas, @clinica, @erro output

                                            select @erro as ret", operatorID, nome, notas, clinica);

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
    public static string LoadMedico(string idMedico)
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
                                            DECLARE @id_medico int = {0}

                                            SELECT
                                                id_medico, medico, notas, clinica, id_especialidade, especialidade
                                            FROM [REPORT_MEDICOS](@id_medico)", idMedico);

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
                    table.AppendFormat(@"   <div style='width: 100 %; text-align: right; height: auto; cursor: pointer; ' onclick='closeEditMedico(); '><i class='fa fa-times-circle' style='height: 20px; width: auto'></i></div>
                                        <input type='button' class='form-control' id='edit' value='Guardar' onclick='editMedico();' style='height: 50px; width: 50%; margin: auto; float: left; margin-bottom: 10px;'/>
                                        <input type='button' class='form-control' id='delete' value='Apagar' onclick='deleteMedico();' style='height: 50px; width: 50%; margin: auto; float: right; margin-bottom: 10px;'/>
                                        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
                                            Nome
                                            <input type='text' class='form-control' id='nomeEdit' placeholder='Nome' required='required' style='width: 100%; margin: auto;' value='{0}'/>
                                        </div>
                                        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12 line'>
                                            Clínica
                                            <input type='text' class='form-control' id='clinicaEdit' placeholder='Clínica' required='required' style='width: 100%; margin: auto;' value='{2}'/>
                                        </div>
                                        <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
                                            Notas
                                            <textarea class='form-control' id='notasEdit' placeholder='Notas' style='width: 100%; margin: auto; height: auto;' rows='5'>{1}</textarea>
                                        </div>",
                                                oDs.Tables[0].Rows[i]["medico"].ToString(),
                                                oDs.Tables[0].Rows[i]["notas"].ToString(),
                                                oDs.Tables[0].Rows[i]["clinica"].ToString());
                }
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableFolhasKms'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem médicos a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableFolhasKms'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>Não existem médicos a apresentar!</div>");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string EditMedico(string operatorID, string medicoID, string nome, string notas, string clinica)
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
                                            DECLARE @id_medico int = {1};
                                            DECLARE @nome varchar(500) = '{2}';
                                            DECLARE @notas varchar(max) = '{3}';
                                            DECLARE @clinica varchar(500) = '{4}';
                                            DECLARE @erro int

                                            exec ALTERA_MEDICO @id_op, @id_medico, @nome, @notas, @clinica, @erro output

                                            select @erro as ret", operatorID, medicoID, nome, notas, clinica);

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
    public static string DeleteMedico(string operatorID, string medicoID)
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
                                            DECLARE @id_medico int = {1};
                                            DECLARE @erro int

                                            exec APAGA_MEDICO @id_op, @id_medico, @erro output

                                            select @erro as ret", operatorID, medicoID);

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
