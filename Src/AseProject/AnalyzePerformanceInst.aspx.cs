using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AnalyzePerformanceInst : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        //div1.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlType.SelectedValue.Equals("Individual"))
        {
            upGraph.Visible = true;
            int Top1 = 0;
            int Top2 = 0;
            int Top3 = 0;
            int Top4 = 0;
            int Top5 = 0;
            int Strength;
            daobj.AnalyzePerformance(ddlCourse.SelectedValue, ddlAssessment.SelectedValue, out Top1, out Top2, out Top3, out Top4, out Top5);
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:BarChart(" + Top1 + "," + Top2 + "," + Top3 + "," + Top4 + "," + Top5 + "); ", true);
            lblCourseId.Text = ddlCourse.SelectedValue;
            daobj.CourseStrength(ddlCourse.SelectedValue, out Strength);
            lblStrength.Text = Strength.ToString();
        }
        else if (ddlType.SelectedValue.Equals("Complete Course"))
        {
            upGraph.Visible = true;
            int Top1 = 0;
            int Top2 = 0;
            int Top3 = 0;
            int Top4 = 0;
            int Top5 = 0;
            int Strength;
            daobj.AnalyzeCoursePerformance(ddlCourse.SelectedValue, out Top1, out Top2, out Top3, out Top4, out Top5);
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:BarChart(" + Top1 + "," + Top2 + "," + Top3 + "," + Top4 + "," + Top5 + "); ", true);
            lblCourseId.Text = ddlCourse.SelectedValue;
            daobj.CourseStrength(ddlCourse.SelectedValue, out Strength);
            lblStrength.Text = Strength.ToString();
        }
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedValue.Equals("Individual"))
        {
            lblType2.Visible = true;
            ddlType2.Visible = true;
        }
        else if (ddlType.SelectedValue.Equals("Complete Course"))
        {
            lblType2.Visible = false;
            ddlType2.Visible = false;
            lblAssessment.Visible = false;
            ddlAssessment.Visible = false;
        }
    }

    protected void ddlType2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAssessment.Items.Clear();
        ddlAssessment.Items.Add("--SELECT--");
        lblAssessment.Visible = true;
        ddlAssessment.Visible = true;
        DataTable dt = null;
        if (ddlType2.SelectedValue.Equals("Labs"))
        {
            dt = daobj.GetLabs(ddlCourse.SelectedValue);
            ddlAssessment.DataSource = dt;
            ddlAssessment.DataTextField = "TopicName";
            ddlAssessment.DataValueField = "TopicName";
        }
        else if (ddlType2.SelectedValue.Equals("Assignments"))
        {
            dt = daobj.GetAssignments(ddlCourse.SelectedValue);
            ddlAssessment.DataSource = dt;
            ddlAssessment.DataTextField = "Assignment";
            ddlAssessment.DataValueField = "Assignment";
        }
        else if (ddlType2.SelectedValue.Equals("Exams"))
        {
            dt = daobj.GetExams(ddlCourse.SelectedValue);
            ddlAssessment.DataSource = dt;
            ddlAssessment.DataTextField = "TopicName";
            ddlAssessment.DataValueField = "TopicName";
        }
        /*foreach (DataRow row1 in dt.Rows)
        {
            ddlAssessment.Items.Add(row1[0].ToString());
        }*/

        ddlAssessment.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
        DataTable dt;
        dt = daobj.GetPerformance(DropDownList1.SelectedValue, Convert.ToInt32(TextBox1.Text));
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