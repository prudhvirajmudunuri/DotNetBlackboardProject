using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewPerformance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        upPerformance.Visible = true;
        DataTable dt;
        lblcou.Text = ddlCourse.SelectedValue;
        dt = daobj.GetPerformance(ddlCourse.SelectedValue, Convert.ToInt32(Session["SSO"]));
        gvPerformance.DataSource = dt;
        gvPerformance.DataBind();
    }

    protected void gvPerformance_DataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToInt32(e.Row.Cells[4].Text) >= 90 && Convert.ToInt32(e.Row.Cells[4].Text) <= 100)
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Green;
            }
            else if (Convert.ToInt32(e.Row.Cells[4].Text) >= 80 && Convert.ToInt32(e.Row.Cells[4].Text) < 90)
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Orange;
            }
            else if (Convert.ToInt32(e.Row.Cells[4].Text) >= 70 && Convert.ToInt32(e.Row.Cells[4].Text) < 80)
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Blue;
            }
            else if (Convert.ToInt32(e.Row.Cells[4].Text) >= 60 && Convert.ToInt32(e.Row.Cells[4].Text) < 70)
            {
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Brown;
            }

        }
    }
}