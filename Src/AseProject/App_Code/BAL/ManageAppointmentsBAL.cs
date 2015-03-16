using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ManageAppointmentsBAL
/// </summary>
public class ManageAppointmentsBAL
{
    ManageAppointmentsDAL daobj = new ManageAppointmentsDAL();
	public ManageAppointmentsBAL()
	{
		
	}
    public int SetAppointments(int InstructorId,string FromDate, string ToDate, string FromTime, string ToTime, int AppointmentDuration, int MaxAppointments)
    {
        return daobj.SetAppointments(InstructorId,FromDate,ToDate,FromTime,ToTime,AppointmentDuration,MaxAppointments);
    }

     public int GetInstructorId(string Email,out int InstructorId)
    {
        return daobj.GetInstructorId(Email, out InstructorId);
    }

     public DataTable GetAppointments(int InstructorId)
     {
         return daobj.GetAppointments(InstructorId);
     }
     public int DeleteAppointments(int InstructorId, string AppointmentDate, string FromTime, string ToTime)
     {
         return daobj.DeleteAppointments(InstructorId,AppointmentDate,FromTime,ToTime);
     }
}