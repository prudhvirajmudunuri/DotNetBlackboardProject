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
     
        if (Session["Email"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        diverror.Visible = false;
        divSuccess.Visible = false;
        gvAppointments.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int InstructorId = -99;
        int ret = -99;
        int retId = daobj.GetInstructorId(Session["Email"].ToString(), out InstructorId);
        if (retId == 1)
        {
             ret = daobj.SetAppointments(InstructorId,from.Text, to.Text,txtFromTime.Text,txtToTime.Text,Convert.ToInt32(txtDuration.Text), Convert.ToInt32(txtMaxSlots.Text));
        }
        if (ret == 1)
        {
            gvAppointments.DataBind();
            divSuccess.Visible = true;
            diverror.Visible = false;
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