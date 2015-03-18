using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplyAppointmentsBAL
/// </summary>
public class ApplyAppointmentsBAL
{
    ApplyAppointmentsDAL daobj = new ApplyAppointmentsDAL();
	public ApplyAppointmentsBAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DataTable GetAppointmentTime(int InstructorId,string AppointmentDate)
    {
        return daobj.GetAppointmentTime(InstructorId,AppointmentDate);
    }
    public int GetInstructorId(string InstructorName, out int InstructorId)
    {
        return daobj.GetInstructorId(InstructorName, out InstructorId);
    }

    public int InsertAppointments(int SSO, string AppointmentDate, string InstructorName, string AppointmentTime, string AppointmentType, string Description)
    {
        return daobj.InsertAppointments(SSO,AppointmentDate,InstructorName,AppointmentTime,AppointmentType,Description);
    }

    public int GetStudentId(string Email, out int SSO)
    {
        return daobj.GetStudentId(Email, out SSO);
    }

    public int GetInstructorNameByEmail(string Email, out string InstructorName)
    {
       return daobj.GetInstructorNameByEmail(Email,out InstructorName);
    }

    public int AppRejAppointments(int AppointmentId, string StatusUpdate)
    {
        return daobj.AppRejAppointments(AppointmentId,StatusUpdate);
    }
}