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
using System.Web.Security;
using System.Net.Mail;

public partial class VisualizarFolhaKms : Page
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
            if (!oCsm.IsStartupScriptRegistered(GetType(), "FolhasKms"))
            {

            }
        }
        Decrypt();
        LoadFolha();
    }

    public void Decrypt()
    {
        string EncryptionKey = "CliniCoimbra";
        id = id.Replace(" ", "+");
        byte[] cipherBytes = null;

        try
        {
            cipherBytes = Convert.FromBase64String(id);
        }
        catch (Exception e)
        {
            
        }
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                id = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
    }

    public void LoadFolha()
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
                                            DECLARE @id_folha int = {0};
                                            DECLARE @id_ln int

                                            SELECT
                                                FOLHA_KMSID, BENEFICIARIO_NOME, 
                                                BENEFICIARIO_NIF, VIATURA_MATRICULA, VIATURA_PROPRIETARIO,
                                                PRECO_KM, MES, ANO, TOTAL_KMS, TOTAL_RECEBIDO,
                                                MES_NOME,

                                                FOLHA_KMS_LNID,
		                                        ID_FOLHA_KMS,
		                                        DAY(DATA_KMS) as DATA_KMS,
		                                        CONVERT(VARCHAR(5), HORA_PARTIDA, 108) as HORA_PARTIDA,
		                                        CONVERT(VARCHAR(5), HORA_CHEGADA, 108) as HORA_CHEGADA,
		                                        ORIGEM,
		                                        DESTINO,
		                                        KMS,
		                                        CUSTO,
		                                        NOTAS
                                            FROM [REPORT_FOLHAS_KMS](@id_folha) f
                                            INNER JOIN REPORT_FOLHAS_KMS_LN(@id_folha, @id_ln) ln on ln.ID_FOLHA_KMS = f.FOLHA_KMSID", id);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                table.AppendFormat(@"   <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            Nome do Benefici�rio
                                            <input type='text' class='form-control' id='nomeBeneficiarioEdit' value='{0}' placeholder='Nome do Benefici�rio' required='required' style='width: 100%; margin: auto;' readonly/>
                                        </div>
                                        <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            NIF do Benefici�rio
                                            <input type='text' class='form-control' id='nifBeneficiarioEdit' value='{1}' placeholder='NIF do Benefici�rio' required='required' style='width: 100%; margin: auto;' readonly/>
                                        </div>
                                        <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            Matr�cula
                                            <input type='text' class='form-control' id='matriculaEdit' value='{2}' placeholder='Matr�cula' required='required' style='width: 100%; margin: auto;' readonly/>
                                        </div>
                                        <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            Propriet�rio
                                            <input type='text' class='form-control' id='proprietarioEdit' value='{3}' placeholder='Propriet�rio' required='required' style='width: 100%; margin: auto;' readonly/>
                                        </div>
                                        <div class='col-lg-4 col-md-4 col-sm-4 col-xs-4 line'>
                                            Pre�o p/ KM
                                            <input type='number' class='form-control' id='precokmEdit' value='{4}' placeholder='Pre�o p/ KM' required='required' style='width: 100%; margin: auto;' step='any' readonly/>
                                        </div>
                                        <div class='col-lg-4 col-md-4 col-sm-4 col-xs-4 line'>
                                            M�s
                                            <select class='form-control' id='mesEdit' style='width: 100%; margin: auto;'>
                                                <option value='{5}'>{9}</option>
                                            </select>
                                        </div>
                                        <div class='col-lg-4 col-md-4 col-sm-4 col-xs-4 line'>
                                            Ano
                                            <input type='number' class='form-control' id='anoEdit' value='{6}' placeholder='Ano' required='required' style='width: 100%; margin: auto;' readonly/>
                                        </div>
                                        <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            Total KM's
                                            <input type='number' class='form-control' id='totalKmsEdit' value='{7}' placeholder='Total KMS' required='required' style='width: 100%; margin: auto;' step='any' readonly/>
                                        </div>
                                        <div class='col-lg-6 col-md-6 col-sm-6 col-xs-6 line'>
                                            Valor Total
                                            <input type='number' class='form-control' id='valorTotalEdit' value='{8}' placeholder='Valor Total' required='required' style='width: 100%; margin: auto;' step='any' readonly/>
                                        </div>",
                                                oDs.Tables[0].Rows[0]["BENEFICIARIO_NOME"].ToString(),
                                                oDs.Tables[0].Rows[0]["BENEFICIARIO_NIF"].ToString(),
                                                oDs.Tables[0].Rows[0]["VIATURA_MATRICULA"].ToString(),
                                                oDs.Tables[0].Rows[0]["VIATURA_PROPRIETARIO"].ToString(),
                                                oDs.Tables[0].Rows[0]["PRECO_KM"].ToString().Replace(",", "."),
                                                oDs.Tables[0].Rows[0]["MES"].ToString(),
                                                oDs.Tables[0].Rows[0]["ANO"].ToString(),
                                                oDs.Tables[0].Rows[0]["TOTAL_KMS"].ToString().Replace(",", "."),
                                                oDs.Tables[0].Rows[0]["TOTAL_RECEBIDO"].ToString().Replace(",", "."),
                                                oDs.Tables[0].Rows[0]["MES_NOME"].ToString());

                table.AppendFormat(@"   <table id='tableLinhasFolhaKmsEdit'>
                                            <thead style='font-size: small;'>
                                            <tr><th style='width:10%'>Dia</th><th style='width:10%'>Hora Partida</th><th style='width:10%'>Hora Chegada</th>
                                            <th style='width:15%'>Origem</th><th style='width:15%'>Destino</th><th style='width:15%'>KMS</th><th style='width:10%'>Valor</th><th style='width:15%'>Notas</th></tr>
                                            </thead><tbody style='font-size: small;'>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    table.AppendFormat(@"   <tr>
                                            <td><input type='number' class='form-control' id='diaEdit{10}' placeholder='Dia' required='required' style='width: 100%; margin: auto;' value='{2}' readonly/></td>
                                            <td><input type='time' class='form-control' id='horaPartidaEdit{10}' placeholder='Partida' required='required' style='width: 100%; margin: auto;' value='{3}' readonly/></td>
                                            <td><input type='time' class='form-control' id='horaChegadaEdit{10}' placeholder='Chegada' required='required' style='width: 100%; margin: auto;' value='{4}' readonly/></td>
                                            <td><input type='text' class='form-control' id='origemEdit{10}' placeholder='Origem' required='required' style='width: 100%; margin: auto;' value='{5}' readonly/></td>
                                            <td><input type='text' class='form-control' id='destinoEdit{10}' placeholder='Destino' required='required' style='width: 100%; margin: auto;' value='{6}' readonly/></td>
                                            <td><input type='number' class='form-control' id='kmsEdit{10}' placeholder='KMS' required='required' style='width: 100%; margin: auto;' value='{7}' step='any' readonly/></td>
                                            <td><input type='number' class='form-control' id='valorEdit{10}' placeholder='Valor' required='required' style='width: 100%; margin: auto;' value='{8}' step='any' readonly/></td>
                                            <td><input type='text' class='form-control' id='notasEdit{10}' placeholder='Notas' style='width: 100%; margin: auto;' value='{9}' readonly/></td>
                                            </tr>", oDs.Tables[0].Rows[i]["FOLHA_KMS_LNID"].ToString(),
                                                    oDs.Tables[0].Rows[i]["ID_FOLHA_KMS"].ToString(),
                                                    oDs.Tables[0].Rows[i]["DATA_KMS"].ToString(),
                                                    oDs.Tables[0].Rows[i]["HORA_PARTIDA"].ToString(),
                                                    oDs.Tables[0].Rows[i]["HORA_CHEGADA"].ToString(),
                                                    oDs.Tables[0].Rows[i]["ORIGEM"].ToString(),
                                                    oDs.Tables[0].Rows[i]["DESTINO"].ToString(),
                                                    oDs.Tables[0].Rows[i]["KMS"].ToString().Replace(",", "."),
                                                    oDs.Tables[0].Rows[i]["CUSTO"].ToString().Replace(",", "."),
                                                    oDs.Tables[0].Rows[i]["NOTAS"].ToString(),
                                                    i.ToString());
                }

                table.AppendFormat(@"</tbody></table>");
            }
            else
            {
                table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableFolhasKms'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>N�o existem Folhas de KMS a apresentar!</div>");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("<div style='height:auto' class='panel-heading' id='tableFolhasKms'><span id='lblGroup' style='font-size:large;margin: auto;color:#000'>N�o existem Folhas de KMS a apresentar!</div>");
        }

        folhaKms.InnerHtml = table.ToString();
    }

    [WebMethod]
    public static string EditFolhaKms(string operatorID, string xml)
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
                                            DECLARE @DocXml nvarchar(max) = '{1}';
                                            DECLARE @erro int

                                            exec EDITA_FOLHA_KMS @id_op, @DocXml, @erro output

                                            select @erro as ret", operatorID, xml);

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
    public static string DeleteFolhaKms(string operatorID, string idFolha)
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
                                            DECLARE @id_folha int = {1};

                                            delete from folha_kms_ln where id_folha_kms = @id_folha
                                            delete from folha_kms where folha_kmsid = @id_folha

                                            select 0 as ret", operatorID, idFolha);

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
    public static string LoadIntroEmail(string idFolha)
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
                                            DECLARE @id_folha int = {0};
                                            DECLARE @id_ln int

                                            SELECT
                                                'Folha de Kms ' + MES_NOME + ' ' + LTRIM(RTRIM(STR(ANO))) as TAG
                                            FROM [REPORT_FOLHAS_KMS](@id_folha)", idFolha);

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
                    table.AppendFormat(@"{0}", oDs.Tables[0].Rows[i]["TAG"].ToString());
                }
            }
            else
            {
                table.AppendFormat("");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string LoadBodyEmail(string idFolha)
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
                                            DECLARE @id_folha int = {0};
                                            DECLARE @id_ln int

                                            SELECT
                                                FOLHA_KMSID, BENEFICIARIO_NOME, 
                                                BENEFICIARIO_NIF, VIATURA_MATRICULA, VIATURA_PROPRIETARIO,
                                                PRECO_KM, MES, ANO, TOTAL_KMS, TOTAL_RECEBIDO,
                                                MES_NOME,

                                                FOLHA_KMS_LNID,
		                                        ID_FOLHA_KMS,
		                                        DAY(DATA_KMS) as DATA_KMS,
		                                        CONVERT(VARCHAR(5), HORA_PARTIDA, 108) as HORA_PARTIDA,
		                                        CONVERT(VARCHAR(5), HORA_CHEGADA, 108) as HORA_CHEGADA,
		                                        ORIGEM,
		                                        DESTINO,
		                                        KMS,
		                                        CUSTO,
		                                        NOTAS
                                            FROM [REPORT_FOLHAS_KMS](@id_folha) f
                                            INNER JOIN REPORT_FOLHAS_KMS_LN(@id_folha, @id_ln) ln on ln.ID_FOLHA_KMS = f.FOLHA_KMSID", idFolha);

            command.CommandText = sql.ToString();
            da.SelectCommand = command;
            DataSet oDs = new DataSet();

            connection.Open();
            da.Fill(oDs);
            connection.Close();

            if (oDs.Tables != null && oDs.Tables.Count > 0 && oDs.Tables[0].Rows.Count > 0)
            {
                table.AppendFormat(@"   Nome do Benefici�rio: {0}<br />
                                        NIF do Benefici�rio: {1}<br />
                                        Matr�cula: {2}<br />
                                        Propriet�rio: {3}<br />
                                        Pre�o p/ KM: {4} �<br />
                                        Total KM's: {7} kms<br />
                                        Valor Total: {8} �<br /><br /><br />",
                                                oDs.Tables[0].Rows[0]["BENEFICIARIO_NOME"].ToString(),
                                                oDs.Tables[0].Rows[0]["BENEFICIARIO_NIF"].ToString(),
                                                oDs.Tables[0].Rows[0]["VIATURA_MATRICULA"].ToString(),
                                                oDs.Tables[0].Rows[0]["VIATURA_PROPRIETARIO"].ToString(),
                                                oDs.Tables[0].Rows[0]["PRECO_KM"].ToString().Replace(",", "."),
                                                oDs.Tables[0].Rows[0]["MES"].ToString(),
                                                oDs.Tables[0].Rows[0]["ANO"].ToString(),
                                                oDs.Tables[0].Rows[0]["TOTAL_KMS"].ToString().Replace(",", "."),
                                                oDs.Tables[0].Rows[0]["TOTAL_RECEBIDO"].ToString().Replace(",", "."));

                table.AppendFormat(@"   <table id='tableLinhasFolhaKmsEdit' class='tableData'>
                                            <thead style='font-size: small;'>
                                            <tr><th style='width:10%'>Dia</th><th style='width:10%'>Hora Partida</th><th style='width:10%'>Hora Chegada</th>
                                            <th style='width:15%'>Origem</th><th style='width:15%'>Destino</th><th style='width:15%'>KMS</th><th style='width:10%'>Valor</th><th style='width:15%'>Notas</th></tr>
                                            </thead><tbody style='font-size: small;'>");

                for (int i = 0; i < oDs.Tables[0].Rows.Count; i++)
                {
                    table.AppendFormat(@"   <tr>
                                                <td>{2}</td>
                                                <td>{3}</td>
                                                <td>{4}</td>
                                                <td>{5}</td>
                                                <td>{6}</td>
                                                <td>{7}</td>
                                                <td>{8}</td>
                                                <td>{9}</td>
                                            </tr>", oDs.Tables[0].Rows[i]["FOLHA_KMS_LNID"].ToString(),
                                                    oDs.Tables[0].Rows[i]["ID_FOLHA_KMS"].ToString(),
                                                    oDs.Tables[0].Rows[i]["DATA_KMS"].ToString(),
                                                    oDs.Tables[0].Rows[i]["HORA_PARTIDA"].ToString(),
                                                    oDs.Tables[0].Rows[i]["HORA_CHEGADA"].ToString(),
                                                    oDs.Tables[0].Rows[i]["ORIGEM"].ToString(),
                                                    oDs.Tables[0].Rows[i]["DESTINO"].ToString(),
                                                    oDs.Tables[0].Rows[i]["KMS"].ToString().Replace(",", "."),
                                                    oDs.Tables[0].Rows[i]["CUSTO"].ToString().Replace(",", "."),
                                                    oDs.Tables[0].Rows[i]["NOTAS"].ToString(),
                                                    i.ToString());
                }

                table.AppendFormat(@"</tbody></table>");
            }
            else
            {
                table.AppendFormat("");
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat("");
            return table.ToString();
        }

        return table.ToString();
    }

    [WebMethod]
    public static string sendEmailFromTemplate(string subject, string emailTo, string body, string idFolha)
    {
        try
        {
            MailMessage mailMessage = new MailMessage();

            string newsletterText = string.Empty;
            newsletterText = File.ReadAllText(HttpContext.Current.Server.MapPath("~") + "\\templatefolhaskms.html");

            string EncryptionKey = "CliniCoimbra";
            byte[] clearBytes = Encoding.Unicode.GetBytes(idFolha);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    idFolha = Convert.ToBase64String(ms.ToArray());
                }
            }

            string page = "http://www.clinicoimbra.pt/VisualizarFolhaKms.aspx?id=" + idFolha;

            // ------------------------------------
            // Processa o template 
            // ------------------------------------
            newsletterText = newsletterText.Replace("[EMAIL_INTRO]", subject);
            newsletterText = newsletterText.Replace("[EMAIL_TEXTBODY]", body);
            newsletterText = newsletterText.Replace("[SUBJECT]", subject);
            newsletterText = newsletterText.Replace("[UNSUBSCRIBE]", page);
            //newsletterText = newsletterText.Replace("[EMAIL_INTROIMAGE]", "  <img style='width:280px;height:100px' src='http://teu site publico/" + lic_num + @"/logocustomer.png'  alt='Logo'  data-default='placeholder' /> ");
            //newsletterText = newsletterText.Replace("[EMAIL_RODAPEIMAGE]", "  <img style='width:200px;height:50px' src='http:// teu site publico /" + lic_num + @"/logocustomer.png'    alt='Logo'  data-default='placeholder' /> ");
            //newsletterText = newsletterText.Replace("[EMAIL_LICNAME]", lic_name);
            //newsletterText = newsletterText.Replace("[EMAIL_LICEMAIL]", lic_email);


            // ------------------------------------
            string _from = "geral@clinicoimbra.pt";//getConfigurationField("email_user");
            string _emailpwd = "Coimbra2011";// getConfigurationField("email_password");
            string _smtp = "mail.clinicoimbra.pt";// getConfigurationField("email_smtp");
            string _smtpport = "465";// getConfigurationField("email_smtpport");  //  587

            mailMessage.From = new MailAddress(_from, "CliniCoimbra");

            mailMessage.To.Add(emailTo);
            mailMessage.Bcc.Add("clinicoimbra@gmail.com");

            mailMessage.Subject = subject;
            mailMessage.Body = newsletterText;
            mailMessage.IsBodyHtml = true;
            mailMessage.Priority = MailPriority.Normal;

            string html = "html";

            mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
            mailMessage.BodyEncoding = System.Text.Encoding.UTF8;

            System.Net.Mail.SmtpClient smtpClient = new System.Net.Mail.SmtpClient(_smtp);
            System.Net.NetworkCredential mailAuthentication = new System.Net.NetworkCredential(_from, _emailpwd);

            smtpClient.EnableSsl = false;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = mailAuthentication;
            smtpClient.Timeout = 50000;
            smtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            smtpClient.Send(mailMessage);
            smtpClient.Dispose();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

        return "0";
    }
}
