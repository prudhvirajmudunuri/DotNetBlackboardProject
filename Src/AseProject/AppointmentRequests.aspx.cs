using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppointmentRequests : System.Web.UI.Page
{
    ApplyAppointmentsBAL daobj = new ApplyAppointmentsBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null)
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void gvRequests_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[5].Text == "Emergency")
            {
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
            }
            else if (e.Row.Cells[5].Text == "Enrollment")
            {
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Orange;
            }
            else if (e.Row.Cells[5].Text == "Question")
            {
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Green;
            }

        }
    }


    protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string StatusUpdate = "";
        if (e.CommandName == "Approve")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = gvRequests.Rows[index];
            int AppointmentId = Convert.ToInt32(row.Cells[0].Text);
            StatusUpdate = "Approved";
            int ret = daobj.AppRejAppointments(AppointmentId,StatusUpdate);
            if (ret == 1)
            {
                gvRequests.DataBind();
            }
        }
        else if (e.CommandName == "Reject")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = gvRequests.Rows[index];
            int AppointmentId = Convert.ToInt32(row.Cells[0].Text);
            StatusUpdate = "Rejected";
            int ret = daobj.AppRejAppointments(AppointmentId, StatusUpdate);
            if (ret == 2)
            {
                gvRequests.DataBind();
            }
        }
    }
}