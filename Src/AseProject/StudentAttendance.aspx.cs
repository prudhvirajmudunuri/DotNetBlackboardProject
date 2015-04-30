using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentAttendance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        diverror2.Visible = false;
        divSuccess.Visible = false;
        divError3.Visible = false;
        diverror4.Visible = false;
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Location(); ", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int ret = 0;
        string CurrentTime = DateTime.Now.ToString("h:mm:ss tt");
        DateTime ct = Convert.ToDateTime(CurrentTime);
        string StartTime = "";
        string EndTime = "";
        int ret2 = 0;
        ret2=daobj.GetStartEndTime(ddlCourse.SelectedValue.ToString(),Date.Text,out StartTime,out EndTime);
        DateTime st = DateTime.Now;
        DateTime et = DateTime.Now;
        if (ret2 == 1)
        {
            st = Convert.ToDateTime(StartTime);
            et = Convert.ToDateTime(EndTime);

            int Latitude = Convert.ToInt32(Convert.ToDouble(latitude.Text));
            int Longitude = Convert.ToInt32(Convert.ToDouble(longitude.Text));
            if (ct >= st && ct <= et)
            {
                ret = daobj.MarkAttendance(Convert.ToInt32(Session["SSO"]), ddlCourse.SelectedValue.ToString(), Date.Text, txtCode.Text, Latitude, Longitude);
                if (ret == 1)
                {
                    gvCheck.DataBind();
                    divSuccess.Visible = true;
                }
                else if (ret == 2)
                {
                    diverror2.Visible = true;
                }
                else if (ret == 3)
                {
                    divError3.Visible = true;
                }
            }
            else
            {
                diverror.Visible = true;
            }
        }
        else if(ret2==2)
        {
            diverror4.Visible = true;
        }
        
    }

    protected void gvCheck_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[2].Text == "Present")
            {
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Green;
            }
            else if (e.Row.Cells[2].Text == "Absent")
            {
                e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
            }

        }
    }
}