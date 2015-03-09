using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageAppointments : System.Web.UI.Page
{
    ManageAppointmentsBAL daobj = new ManageAppointmentsBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        int InstructorId = -99;
        if (Session["Email"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        diverror.Visible = false;
        divSuccess.Visible = false;

        daobj.GetInstructorId(Session["Email"].ToString(), out InstructorId);
        DataTable dt = daobj.GetAppointments(InstructorId);
        gvAppointments.DataSource = dt;
        gvAppointments.DataBind();

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int InstructorId = -99;
        int retId = daobj.GetInstructorId(Session["Email"].ToString(), out InstructorId);
        if (retId == 1)
        {
            int ret = daobj.SetAppointments(InstructorId,from.Text, to.Text,txtFromTime.Text,txtToTime.Text,Convert.ToInt32(txtDuration.Text), Convert.ToInt32(txtMaxSlots.Text));
        }
        if (retId == 1)
        {
            divSuccess.Visible = true;
            diverror.Visible = false;
            DataTable dt = daobj.GetAppointments(InstructorId);
            gvAppointments.DataSource = dt;
            gvAppointments.DataBind();
        }
        else 
        {
            divSuccess.Visible = false;
            diverror.Visible = true;
        }
    }
    protected void PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAppointments.PageIndex = e.NewPageIndex;
        gvAppointments.DataBind();
    }
}