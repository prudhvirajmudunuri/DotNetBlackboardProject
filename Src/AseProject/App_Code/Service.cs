using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
public class Service : IService
{
     [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, UriTemplate = "login/{Name}/{Passwd}")]
     public int LoginService(string Name, string passwd)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         SqlCommand cmd = new SqlCommand("usp_LoginService", con);
         cmd.CommandType = CommandType.StoredProcedure;
         cmd.Parameters.AddWithValue("@Name", Name);
         cmd.Parameters.AddWithValue("@passwd", passwd);


         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmd.Parameters.Add(RetValue);
         try
         {
             con.Open();
             cmd.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
         }
         catch (SqlException)
         {
             returnValue = -99;
         }
         finally
         {
             con.Close();
         }
         return returnValue;
     }


}
