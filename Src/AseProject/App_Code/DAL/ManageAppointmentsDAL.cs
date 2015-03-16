using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ManageAppointmentsDAL
/// </summary>
public class ManageAppointmentsDAL
{
    SqlConnection con;
	public ManageAppointmentsDAL()
	{
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
	}

    public int SetAppointments(int InstructorId,string FromDate, string ToDate, string FromTime, string ToTime, int AppointmentDuration, int MaxAppointments)
    {
        int returnValue = -99;
        SqlCommand cmd = new SqlCommand("usp_SetAppointments", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@InstructorId", InstructorId);
        cmd.Parameters.AddWithValue("@FromDate", FromDate);
        cmd.Parameters.AddWithValue("@ToDate", ToDate);
        cmd.Parameters.AddWithValue("@FromTime", FromTime);
        cmd.Parameters.AddWithValue("@ToTime", ToTime);
        cmd.Parameters.AddWithValue("@AppointmentDuration", AppointmentDuration);
        cmd.Parameters.AddWithValue("@MaxAppointments", MaxAppointments);

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

    public int GetInstructorId(string Email,out int InstructorId)
    {
        int returnValue = -99;
        InstructorId = -99;
        SqlCommand cmdVisitCount = new SqlCommand("usp_GetInstructorId", con);
        cmdVisitCount.CommandType = CommandType.StoredProcedure;
        cmdVisitCount.Parameters.AddWithValue("@Email", Email);

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

    public DataTable GetAppointments(int InstructorId)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = new SqlCommand("SELECT * FROM tbl_SetAppointments WHERE InstructorId = @InstructorId", con);
        da.SelectCommand.Parameters.AddWithValue("@InstructorId", InstructorId);
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

    public int DeleteAppointments(int InstructorId, string AppointmentDate,string FromTime,string ToTime)
    {
        DataTable dt = new DataTable();
        int retvalue = -99;
        SqlCommand cmd = new SqlCommand("DELETE FROM tbl_SetAppointments WHERE InstructorId = @InstructorId AND AppointmentDate = @AppointmentDate AND FromTime = @FromTime AND ToTime = @ToTime",con);
        cmd.Parameters.AddWithValue("@InstructorId", InstructorId);
        cmd.Parameters.AddWithValue("@AppointmentDate", AppointmentDate);
        cmd.Parameters.AddWithValue("@FromTime", FromTime);
        cmd.Parameters.AddWithValue("@ToTime", ToTime);

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

}