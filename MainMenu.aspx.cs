using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Text;
using System.Security.Cryptography;
using System.Web.Services;

public partial class MainMenu : Page
{
    string id = "";

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        id = Request.QueryString["id"];

        checkSessionID();

        if (!IsPostBack)
        {
            ClientScriptManager oCsm = this.Page.ClientScript;
            if (!oCsm.IsStartupScriptRegistered(GetType(), "MainMenu"))
            {

            }
        }
    }

    private void checkSessionID()
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
            Response.Redirect("login.aspx");
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

        lblsessionid.InnerHtml = id;

        var table = new StringBuilder();
        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);

        try
        {
            connection.Open();

            string sql = string.Format(@"   SET DATEFORMAT dmy;
                                            DECLARE @id_sessao INT = {0};
                                        
                                            SELECT ID_OP, NOME FROM OPERADORES_SESSAO opsess inner join OPERADORES op on op.OPERADORESID = opsess.ID_OP WHERE OPERADORES_SESSAOID = @id_sessao AND DATA_FIM IS NULL", id);

            SqlCommand myCommand = new SqlCommand(sql, connection);
            SqlDataReader myReader = myCommand.ExecuteReader();
            SqlDataAdapter adapter = new SqlDataAdapter(myCommand);

            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    if (Convert.ToInt32(myReader["ID_OP"].ToString()) < 0)
                    {
                        Response.Redirect("login.aspx");
                        return;
                    }

                    lbloperatorid.InnerHtml = myReader["ID_OP"].ToString();
                    footerText.InnerHtml = myReader["NOME"].ToString();
                }
                return;
            }
            else
            {
                connection.Close();
                id = "-1";
                Response.Redirect("login.aspx");
                return;
            }
        }
        catch (Exception exc)
        {
            connection.Close();
            id = "-1";
            Response.Redirect("login.aspx");
            return;
        }
    }

    [WebMethod]
    public static string Logout(string sessionID)
    {
        var table = new StringBuilder();

        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);

        try
        {
            connection.Open();

            string sql = string.Format(@"   DECLARE @ret int;
                                            DECLARE @id_sessao int = {0};

                                            EXEC LOGOUT @id_sessao_antiga, @ret output;
                                            SELECT @ret as ret", sessionID);

            SqlCommand myCommand = new SqlCommand(sql, connection);
            SqlDataReader myReader = myCommand.ExecuteReader();
            SqlDataAdapter adapter = new SqlDataAdapter(myCommand);

            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    table.AppendFormat(@"{0}", myReader["ret"].ToString());
                }

                connection.Close();

                return table.ToString();
            }
            else
            {
                table.AppendFormat(@"-1");
                connection.Close();
                return table.ToString();
            }
        }
        catch (Exception exc)
        {
            table.AppendFormat(@"-1");
            connection.Close();
            return table.ToString();
        }
    }

    [WebMethod]
    public static string Encrypt(string str)
    {
        string EncryptionKey = "CliniCoimbra";
        byte[] clearBytes = Encoding.Unicode.GetBytes(str);
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
                str = Convert.ToBase64String(ms.ToArray());
            }
        }
        return str;
    }
}
