using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplyAppointmentsDAL
/// </summary>
public class ApplyAppointmentsDAL
{
    SqlConnection con;
	public ApplyAppointmentsDAL()
	{
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
	}

    public DataTable GetAppointmentTime(int InstructorId,string AppointmentDate)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = new SqlCommand("SELECT FromTime,ToTime FROM tbl_SetAppointments WHERE InstructorId = @InstructorId AND AppointmentDate = @AppointmentDate", con);
        da.SelectCommand.Parameters.AddWithValue("@InstructorId", InstructorId);
        da.SelectCommand.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
        try
        {
            da.Fill(dt);
        }
        catch (SqlException)
        {
            return null;
        }
        catch (Exception)
        {
            return null;
        }
        return dt;
    }

    public int GetInstructorId(string InstructorName, out int InstructorId)
    {
        int returnValue = -99;
        InstructorId = -99;
        SqlCommand cmdVisitCount = new SqlCommand("usp_GetInstructorIdByname", con);
        cmdVisitCount.CommandType = CommandType.StoredProcedure;
        cmdVisitCount.Parameters.AddWithValue("@InstructorName", InstructorName);

        SqlParameter RetValue = new SqlParameter();
        RetValue.Direction = ParameterDirection.ReturnValue;
        RetValue.SqlDbType = SqlDbType.Int;
        cmdVisitCount.Parameters.Add(RetValue);

        SqlParameter vc = new SqlParameter("@InstructorId", SqlDbType.Int);
        vc.Direction = ParameterDirection.Output;
        cmdVisitCount.Parameters.Add(vc);
        try
        {
            con.Open();
            cmdVisitCount.ExecuteNonQuery();
            returnValue = Convert.ToInt32(RetValue.Value);
            InstructorId = Convert.ToInt32(vc.Value);
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

    public int InsertAppointments(int SSO,string AppointmentDate, string InstructorName, string AppointmentTime, string AppointmentType,string Description)
    {
        DataTable dt = new DataTable();
        int retvalue = -99;
        string AppointmentStatus = "Pending";
        SqlCommand cmd = new SqlCommand("INSERT INTO tbl_AppointmentRequests(SSO,AppointmentDate,InstructorName,AppointmentTime,AppointmentType,Description,AppointmentStatus) VALUES(@SSO,@AppointmentDate,@InstructorName,@AppointmentTime,@AppointmentType,@Description,@AppointmentStatus) ", con);
        cmd.Parameters.AddWithValue("@SSO", SSO);
        cmd.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
        cmd.Parameters.AddWithValue("@InstructorName", InstructorName);
        cmd.Parameters.AddWithValue("@AppointmentTime", AppointmentTime);
        cmd.Parameters.AddWithValue("@AppointmentType", AppointmentType);
        cmd.Parameters.AddWithValue("@Description", Description);
        cmd.Parameters.AddWithValue("@AppointmentStatus", AppointmentStatus);
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            retvalue = -99;
        }
        catch (Exception)
        {
            retvalue = -99;
        }
        finally
        {
            con.Close();
            retvalue = 1;
        }
        return retvalue;
    }

    public int GetStudentId(string Email, out int SSO)
    {
        int returnValue = -99;
        SSO = -99;
        SqlCommand cmdVisitCount = new SqlCommand("usp_GetStudentId", con);
        cmdVisitCount.CommandType = CommandType.StoredProcedure;
        cmdVisitCount.Parameters.AddWithValue("@Email", Email);

        SqlParameter RetValue = new SqlParameter();
        RetValue.Direction = ParameterDirection.ReturnValue;
        RetValue.SqlDbType = SqlDbType.Int;
        cmdVisitCount.Parameters.Add(RetValue);

        SqlParameter vc = new SqlParameter("@SSO", SqlDbType.Int);
        vc.Direction = ParameterDirection.Output;
        cmdVisitCount.Parameters.Add(vc);
        try
        {
            con.Open();
            cmdVisitCount.ExecuteNonQuery();
            returnValue = Convert.ToInt32(RetValue.Value);
            SSO = Convert.ToInt32(vc.Value);
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


    public int GetInstructorNameByEmail(string Email, out string InstructorName)
    {
        int returnValue = -99;
        InstructorName = "";
        SqlCommand cmdVisitCount = new SqlCommand("usp_GetInstructorNameByEmail", con);
        cmdVisitCount.CommandType = CommandType.StoredProcedure;
        cmdVisitCount.Parameters.AddWithValue("@Email",Email);

        SqlParameter RetValue = new SqlParameter();
        RetValue.Direction = ParameterDirection.ReturnValue;
        RetValue.SqlDbType = SqlDbType.Int;
        cmdVisitCount.Parameters.Add(RetValue);

        SqlParameter vc = new SqlParameter("@InstructorName", SqlDbType.VarChar,50);
        vc.Direction = ParameterDirection.Output;
        cmdVisitCount.Parameters.Add(vc);
        try
        {
            con.Open();
            cmdVisitCount.ExecuteNonQuery();
            returnValue = Convert.ToInt32(RetValue.Value);
            InstructorName = vc.Value.ToString();
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

    public int AppRejAppointments(int AppointmentId,string StatusUpdate)
    {
        int returnValue = -99;
        SqlCommand cmd = new SqlCommand("AppRejAppointments", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@AppointmentId", AppointmentId);
        cmd.Parameters.AddWithValue("@StatusUpdate", StatusUpdate);

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