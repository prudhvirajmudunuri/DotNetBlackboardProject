using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AttendanceInstructor : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        divSuccess.Visible = false;
        div1.Visible = false;
        div2.Visible = false;
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Location(); ", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       int ret = 0;
       int Duration = Convert.ToInt32(txtDuration.Text);
       string RandomCode = RandomString(8);
       string StartTime = DateTime.Now.ToString("h:mm:ss tt");
       string EndTime = DateTime.Now.AddMinutes(Duration).ToString("h:mm:ss tt");
       ret =  daobj.SetAttendance(ddlCourse.SelectedValue,Convert.ToInt32(Session["InstructorId"]), Date.Text, Convert.ToInt32(Convert.ToDouble(latitude.Text)),Convert.ToInt32(Convert.ToDouble(longitude.Text)),RandomCode,StartTime,EndTime);
      
        if (ret == 1)
       {
           gvAttendance.DataBind();
           divSuccess.Visible = true;
           diverror.Visible = false;
       }
       else
       {
           divSuccess.Visible = false;
           diverror.Visible = true; ;
       }
    }

    private string RandomString(int size)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }
        return builder.ToString();
    }

    protected void gvAttendance_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        if (e.CommandName == "Generate")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = gvAttendance.Rows[index];
            string CourseId = row.Cells[0].Text.ToString();
            string AttendanceDate = row.Cells[1].Text.ToString();
            DataTable dt;
            dt = daobj.GetAbsentStudentsList(CourseId, AttendanceDate);
            int SSO = 0;
            int ret=0;
            string AttendanceStatus = "Absent";
            foreach (DataRow row1 in dt.Rows)
            {
                SSO = Convert.ToInt32(row1[0].ToString());
                ret = daobj.GenerateAttendance(SSO, CourseId, AttendanceDate, AttendanceStatus);
            }
            if (ret == 1)
            {
                div1.Visible = true;
            }
            else 
            {
                div2.Visible = true;
            }
        }
    }
}