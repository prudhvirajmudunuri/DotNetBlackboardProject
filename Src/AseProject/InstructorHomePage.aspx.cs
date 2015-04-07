using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InstructorHomePage : System.Web.UI.Page
{
    Service obj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        gvSchedule.Visible = false;
        diverror.Visible = false;
        lblCourse.Visible = false;
    }

    protected void gvallotment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Schedule")
        {
            diverror.Visible = true;
            gvSchedule.Visible = true;
            lblCourse.Visible = true;
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = gvallotment.Rows[index];
            String CourseId = row.Cells[0].Text;
            lblCourse.Text = CourseId;
            DataTable dt = null;
            dt = obj.GetSchedule(CourseId);
            gvSchedule.DataSource = dt;
            gvSchedule.DataBind();
        }
    }
}