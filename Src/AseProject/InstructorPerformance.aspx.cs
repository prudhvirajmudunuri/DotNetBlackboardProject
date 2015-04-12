using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InstructorPerformance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        divSuccess.Visible = false;
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
        else if(ddlType.SelectedValue.Equals("Assignments"))
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
        DataTable dt = null;
        string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
        FileUpload1.SaveAs(excelPath);

        string conString = string.Empty;
        string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        switch (extension)
        {
            case ".xls": //Excel 97-03
                conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                break;
            case ".xlsx": //Excel 07 or higher
                conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                break;

        }
        conString = string.Format(conString, excelPath);
        using (OleDbConnection excel_con = new OleDbConnection(conString))
        {
            excel_con.Open();
            string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
            DataTable dtExcelData = new DataTable();

            //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
            /* dtExcelData.Columns.AddRange(new DataColumn[3] { new DataColumn("Id", typeof(int)),
                 new DataColumn("Name", typeof(string)),
                 new DataColumn("Salary",typeof(decimal)) });*/

            using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
            {
                oda.Fill(dtExcelData);
            }
            excel_con.Close();
            dt = dtExcelData;
        }
        
        int SSO;
        int TotalMarks;
        int MarksObtained;
        string Comments = "";
        string CourseId = ddlCourse.SelectedValue;
        string TopicName;
        double Percentage;
        int SPercentage;
        int ret = 0;
        foreach (DataRow row1 in dt.Rows)
        {
            SSO = Convert.ToInt32(row1[0].ToString());
            TotalMarks = Convert.ToInt32(row1[2].ToString());
            TopicName = row1[1].ToString();
            MarksObtained = Convert.ToInt32(row1[3].ToString());
            Comments = row1[4].ToString();
            Percentage = ((MarksObtained *100)/ TotalMarks);
            SPercentage = Convert.ToInt32(Percentage);
            ret = daobj.InsertMarks(SSO,CourseId,TopicName,TotalMarks,MarksObtained,SPercentage,Comments);
        }
        if (ret == 1)
        {
            divSuccess.Visible = true;
        }
        else 
        {
            diverror.Visible = true;
        }
    }
}