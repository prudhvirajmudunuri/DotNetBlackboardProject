using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LoginDAL
/// </summary>
public class LoginDAL
{
    SqlConnection con;
	public LoginDAL()
	{
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
	}

    public int Login(string Email,string passwd)
    {
        int returnValue = -99;
        SqlCommand cmd = new SqlCommand("usp_Login", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", Email);
        cmd.Parameters.AddWithValue("@passwd",passwd);
        

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