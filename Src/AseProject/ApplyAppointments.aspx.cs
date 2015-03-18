using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ApplyAppointments : System.Web.UI.Page
{
    ApplyAppointmentsBAL daobj = new ApplyAppointmentsBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        divSuccess.Visible = false;
        diverror.Visible = false;
        if (Session["Email"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        
    }
    protected void ddlProfessor_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAppointmentTime.Items.Clear();
        ddlAppointmentTime.Items.Add("--SELECT--");
        lblAppointmentTime.Visible = true;
        ddlAppointmentTime.Visible = true;
        if (ddlProfessor.SelectedValue != "--SELECT--")
        {
        Session["InstructorName"] = ddlProfessor.SelectedValue;
        int InstructorId = -99;
        string AppointmentDate = Date.Text;
        DataTable dt = null;
        string FromTime = "";
        string ToTime = "";
        string ddlValue = "";
        int retId = daobj.GetInstructorId(Session["InstructorName"].ToString(), out InstructorId);
        if (retId == 1)
        {  
                dt = daobj.GetAppointmentTime(InstructorId, AppointmentDate);
        }
        foreach (DataRow row1 in dt.Rows)
        {
            FromTime = row1[0].ToString();
            ToTime = row1[1].ToString();
            ddlValue = FromTime + "   pm   " + "    to   " + ToTime + "   pm   ";
            ddlAppointmentTime.Items.Add(ddlValue);
        }
    }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int SSO = -99;
        int retid= daobj.GetStudentId(Session["Email"].ToString(), out SSO);
        int ret = daobj.InsertAppointments(SSO,Date.Text,ddlProfessor.SelectedValue,ddlAppointmentTime.SelectedValue,ddlAppointmentType.SelectedValue,txtDescription.Text);
        if (ret == 1)
        {
            gvRequests.DataBind();
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
        gvRequests.PageIndex = e.NewPageIndex;
        gvRequests.DataBind();
    }

    protected void gvRequests_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[7].Text == "Pending")
            {
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Orange;
            }
            else if (e.Row.Cells[7].Text == "Rejected")
            {
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[8].Enabled = false;
            }
            else if (e.Row.Cells[7].Text == "Approved")
            {
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Green;
                e.Row.Cells[8].Enabled = false;
            }
        }
    }
}