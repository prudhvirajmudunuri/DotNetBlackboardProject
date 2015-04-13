using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ComparePerformance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAssessment.Items.Clear();
        ddlAssessment.Items.Add("--SELECT--");
        lblAssessment.Visible = true;
        ddlAssessment.Visible = true;
        DataTable dt = null;
        if (ddlType.SelectedValue.Equals("Labs"))
        {
            dt = daobj.GetLabs(ddlCourse.SelectedValue);
            ddlAssessment.DataSource = dt;
            ddlAssessment.DataTextField = "TopicName";
            ddlAssessment.DataValueField = "TopicName";
        }
        else if (ddlType.SelectedValue.Equals("Assignments"))
        {
            dt = daobj.GetAssignments(ddlCourse.SelectedValue);
            ddlAssessment.DataSource = dt;
            ddlAssessment.DataTextField = "Assignment";
            ddlAssessment.DataValueField = "Assignment";
        }
        else if (ddlType.SelectedValue.Equals("Exams"))
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        upGraph.Visible = true;
        int Top1 = 0;
        int Top2 = 0;
        int Top3 = 0;
        int Top4 = 0;
        int Top5 = 0;
        int Strength;
        int Percentage;
        int Position;
        daobj.AnalyzePerformance(ddlCourse.SelectedValue,ddlAssessment.SelectedValue,out Top1,out Top2,out Top3,out Top4,out Top5);
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:BarChart(" + Top1 + "," + Top2 + "," + Top3 + "," + Top4 + "," + Top5 + "); ", true);
        lblCourseId.Text = ddlCourse.SelectedValue;
        daobj.CourseStrength(ddlCourse.SelectedValue,out Strength);
        lblStrength.Text = Strength.ToString();
        daobj.GetPosPer(ddlAssessment.SelectedValue,ddlCourse.SelectedValue,Convert.ToInt32(Session["SSO"]),out Position,out Percentage);
        lblPosition.Text = Position.ToString();
        lblPercentage.Text = Percentage.ToString();

    }
}