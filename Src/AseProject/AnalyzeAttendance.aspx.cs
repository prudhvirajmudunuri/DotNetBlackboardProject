using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AnalyzeAttendance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        upGraph.Visible = true;
        int Present = 0;
        int Absent = 0;
        int Strength;
        daobj.AnalyzeAttendance(ddlCourse.SelectedValue, Date.Text, out Present, out Absent);
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:BarChart(" + Present + "," + Absent + "); ", true);
        lblCourseId.Text = ddlCourse.SelectedValue;
        daobj.CourseStrength(ddlCourse.SelectedValue, out Strength);
        lblStrength.Text = Strength.ToString();
    }

    protected void gvAttendance_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[1].Text == "Present")
            {
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Green;
            }
            else if (e.Row.Cells[1].Text == "Absent")
            {
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
            }

        }
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        DataTable dt;
        dt = daobj.GetAttendance(DropDownList1.SelectedValue, Convert.ToInt32(TextBox1.Text));
        gvAttendance.DataSource = dt;
        gvAttendance.DataBind();
    }
}