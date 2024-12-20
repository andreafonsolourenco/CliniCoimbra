using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;

public partial class login : Page
{
    string erro = "";
    string msgErro = "";
    

    protected void Page_Init(object sender, EventArgs e)
    {
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //this.txtLogin.Focus();

        //try {
        //    erro = HttpContext.Current.Request.Url.PathAndQuery;
        //    msgErro = Request.QueryString["msg"];

        //    if (msgErro != "")
        //    {
        //        lblerror.InnerHtml = msgErro;
        //    }
        //    else
        //    { 
        //        lblerror.InnerHtml = "";
        //    }
        //}
        //catch(Exception exc) {
        //    lblerror.InnerHtml = "";
        //}
    }

    [WebMethod]
    public static string Login(string user, string pass)
    {
        var table = new StringBuilder();

        string connectionstring = ConfigurationManager.ConnectionStrings["connectionString"].ToString();
        SqlConnection connection = new SqlConnection(connectionstring);

        try
        {
            connection.Open();

            string sql = string.Format(@"   DECLARE @user char(30) = '{0}';
                                            DECLARE @pass varchar(60) = '{1}';
                                            DECLARE @ret int;
                                        
                                            EXEC LOGIN @user, @pass, @ret output

                                            SELECT @ret as ret", user, pass);

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
