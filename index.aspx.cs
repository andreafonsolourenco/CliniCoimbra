using System;
using System.Web.UI;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Net.Mail;
using System.IO;

public partial class index : Page
{
    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }

        getServices();
    }

    private void getServices()
    {
        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        command.Connection = connection;

        try
        {
            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_medico int
                                            DECLARE @id_especialidade int
                                            select especialidade as NOME, MEDICO, HORARIO, CLINICA, notas_especialidade as NOTAS, FOTO
                                            from report_medicos_especialidades(@id_medico, @id_especialidade)
                                            order by especialidade");

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
                    if(i%2 == 0) {
                        // Adiciona as linhas com dados
                        table.AppendFormat(@"   <div class='row justify-content-center no-gutters mb-5 mb-lg-0'>
                                                    <div class='col-lg-6'>
                                                        <img class='img-fluid' src='img/{5}' alt=''>
                                                    </div>
                                                    <div class='col-lg-6'>
                                                        <div class='bg-green text-center h-100 project'>
                                                          <div class='d-flex h-100'>
                                                            <div class='project-text w-100 my-auto text-center text-lg-left'>
                                                              <h4 class='text-white'>{0}</h4>
                                                              <p class='mb-0 text-white-50'>{1}{3}{2}{4}</p>
                                                              <hr class='d-none d-lg-block mb-0 ml-0'>
                                                            </div>
                                                          </div>
                                                        </div>
                                                      </div>
                                                    </div>"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["NOME"].ToString()) ? "" : oDs.Tables[0].Rows[i]["NOME"].ToString()
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["MEDICO"].ToString()) ? "" : oDs.Tables[0].Rows[i]["MEDICO"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["HORARIO"].ToString()) ? "" : oDs.Tables[0].Rows[i]["HORARIO"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["CLINICA"].ToString()) ? "" : oDs.Tables[0].Rows[i]["CLINICA"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["NOTAS"].ToString()) ? "" : oDs.Tables[0].Rows[i]["NOTAS"].ToString() + "<br />"
                            , oDs.Tables[0].Rows[i]["foto"].ToString());
                    }
                    else
                    {
                        // Adiciona as linhas com dados
                        table.AppendFormat(@"   <div class='row justify-content-center no-gutters'>
                                                    <div class='col-lg-6'>
                                                        <img class='img-fluid' src='img/{5}' alt=''>
                                                    </div>
                                                    <div class='col-lg-6 order-lg-first'>
                                                        <div class='bg-green text-center h-100 project'>
                                                          <div class='d-flex h-100'>
                                                            <div class='project-text w-100 my-auto text-center text-lg-right'>
                                                              <h4 class='text-white'>{0}</h4>
                                                              <p class='mb-0 text-white-50'>{1}{3}{2}{4}</p>
                                                              <hr class='d-none d-lg-block mb-0 mr-0'>
                                                            </div>
                                                          </div>
                                                        </div>
                                                      </div>
                                                    </div>"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["NOME"].ToString()) ? "" : oDs.Tables[0].Rows[i]["NOME"].ToString()
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["MEDICO"].ToString()) ? "" : oDs.Tables[0].Rows[i]["MEDICO"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["HORARIO"].ToString()) ? "" : oDs.Tables[0].Rows[i]["HORARIO"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["CLINICA"].ToString()) ? "" : oDs.Tables[0].Rows[i]["CLINICA"].ToString() + "<br />"
                            , string.IsNullOrEmpty(oDs.Tables[0].Rows[i]["NOTAS"].ToString()) ? "" : oDs.Tables[0].Rows[i]["NOTAS"].ToString() + "<br />"
                            , oDs.Tables[0].Rows[i]["foto"].ToString());
                    }
                }
            }
            else
            {
                
            }
        }
        catch (Exception exc)
        {

        }

        divServices.InnerHtml = table.ToString();
    }

    [WebMethod]
    public static string sendEmailFromTemplate(string assunto, string nome, string email, string body, string telefone)
    {
        try
        {
            MailMessage mailMessage = new MailMessage();
            string emailBody = "";
            string emailTo = "clinicoimbra@gmail.com";

            string newsletterText = string.Empty;
            newsletterText = File.ReadAllText(HttpContext.Current.Server.MapPath("~") + "\\templateemail.html");

            emailBody += "Nome: " + nome + "<br />";
            emailBody += "Email: " + email + "<br />";
            emailBody += "Telefone: " + telefone + "<br />";
            emailBody += body.Replace("\n", "<br />") + "<br /><br />";

            // ------------------------------------
            // Processa o template 
            // ------------------------------------
            newsletterText = newsletterText.Replace("[EMAIL_INTRO]", "Email de Contacto<br />" + assunto);
            newsletterText = newsletterText.Replace("[EMAIL_TEXTBODY]", emailBody);
            newsletterText = newsletterText.Replace("[SUBJECT]", assunto);
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

            mailMessage.Subject = assunto;
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

            newsletterText = string.Empty;
            newsletterText = File.ReadAllText(HttpContext.Current.Server.MapPath("~") + "\\templateemail.html");

            emailBody = string.Empty;
            emailBody += "Agradecemos a sua mensagem! Tentaremos responder o mais brevemente possível. Obrigado!<br /><br />";
            emailBody += "Nome: " + nome + "<br />";
            emailBody += "Email: " + email + "<br />";
            emailBody += "Telefone: " + telefone + "<br />";
            emailBody += body.Replace("\n", "<br />") + "<br /><br />";
            emailBody += "Esta resposta é enviada automaticamente! Por favor, não responda a este email. Para qualquer contacto, utilize o nosso site ou o email clinicoimbra@gmail.com. Obrigado!";
            newsletterText = newsletterText.Replace("[EMAIL_INTRO]", "Email de Contacto<br />" + assunto);
            newsletterText = newsletterText.Replace("[EMAIL_TEXTBODY]", emailBody);
            newsletterText = newsletterText.Replace("[SUBJECT]", assunto);

            mailMessage.From = new MailAddress(_from, "CliniCoimbra");

            mailMessage.To.Add(email);

            mailMessage.Subject = assunto;
            mailMessage.Body = newsletterText;
            mailMessage.IsBodyHtml = true;
            mailMessage.Priority = MailPriority.Normal;

            mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
            mailMessage.BodyEncoding = System.Text.Encoding.UTF8;

            smtpClient = new System.Net.Mail.SmtpClient(_smtp);
            mailAuthentication = new System.Net.NetworkCredential(_from, _emailpwd);

            //smtpClient.Port = Convert.ToInt32(_smtpport);
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
