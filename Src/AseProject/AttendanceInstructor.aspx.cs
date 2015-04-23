using System;
using System.Collections.Generic;
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
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Location(); ", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       int ret = 0;
       int Duration = Convert.ToInt32(txtDuration.Text);
       string RandomCode = RandomString(8);
       string StartTime = DateTime.Now.ToString("h:mm:ss tt");
       string EndTime = DateTime.Now.AddMinutes(Duration).ToString("h:mm:ss tt");
       ret =  daobj.SetAttendance(ddlCourse.SelectedValue, Date.Text, Convert.ToInt32(Convert.ToDouble(latitude.Text)),Convert.ToInt32(Convert.ToDouble(longitude.Text)),RandomCode,StartTime,EndTime);
      
        if (ret == 1)
       {
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
}