using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.Services;
using System.Collections.Generic;


namespace WebApplication2
{
    public partial class _Default : System.Web.UI.Page
    {
        public string svrname;
        public string database;
        public string password;
        public string userid;
        public static string con;
        
        

        protected void Page_Load(object sender, EventArgs e)
        {
            IniFile ini = new IniFile("C:\\WebApplication2\\WebApplication2\\ini.ini");
            svrname = ini.IniReadValue("Info", "Name");
            database = ini.IniReadValue("Info", "database");
            password = ini.IniReadValue("Info", "password");
            userid = ini.IniReadValue("Info", "password");

            con = "Data Source=" + svrname + ";Initial Catalog= " + database + ";User ID=" + userid + ";Password=" + password + " ";

        }

        [WebMethod]
        public static List<ListItem> GetCountry()
        {
            string connetionString = null;
            SqlConnection cnn;
            connetionString = con;
            cnn = new SqlConnection(connetionString);


            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cnn;
            cmd.CommandText = "SELECT * FROM Country order by Country asc";
            // cmd.ExecuteNonQuery();

            List<ListItem> country = new List<ListItem>();
            //cmd.CommandType = CommandType.Text;
            //cmd.Connection = con;
            cnn.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            {
                while (sdr.Read())
                {
                    country.Add(new ListItem
                    {
                        Value = sdr["Country"].ToString(),
                        Text = sdr["Country"].ToString()
                    });
                }
            }
            cnn.Close();
            return country;
        }

        [WebMethod]
        public static void SubmitData(string name, string ic, string dob, string gender, string country)
        {
            int indicate = 0;
            string connetionString = null;
            SqlConnection cnn;
            connetionString = con;
            cnn = new SqlConnection(connetionString);
            try
            {

                if (name == "")
                {
                    indicate = indicate - 1;
                }
                else
                {
                    indicate = indicate + 1;
                }

                if (ic == "")
                {
                    indicate = indicate - 1;
                }
                else
                {
                    indicate = indicate + 1;
                }

                if (gender == "1")
                {
                    indicate = indicate - 1;
                }
                else
                {
                    indicate = indicate + 1;
                }

                if (country == "0")
                {
                    indicate = indicate - 1;
                }
                else
                {
                    indicate = indicate + 1;
                }


                if (indicate > 3)
                {
                    cnn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = cnn;

                    cmd.CommandText = "INSERT INTO regis (Name,IC,DOB,gender,country ) VALUES ('" + name + "','" + ic + "','" + dob + "','" + gender + "','" + country + "')";

                    cmd.ExecuteNonQuery();
                    cnn.Close();
                }
            }
            catch (Exception ex)
            {


            }

        }

    }
}
