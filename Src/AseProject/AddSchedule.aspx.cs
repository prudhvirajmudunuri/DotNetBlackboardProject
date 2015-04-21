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

public partial class AddSchedule : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        divSuccess.Visible = false;
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

        string CourseId;
        string TopicDate;
        string TopicName;
        string Assignment;
        string AssignmentDeadline;
        int ret = 0;
        foreach (DataRow row1 in dt.Rows)
        {
            CourseId = row1[0].ToString();
            TopicDate = row1[1].ToString();
            TopicName = row1[2].ToString();
            Assignment = row1[3].ToString();
            AssignmentDeadline = row1[4].ToString();
            ret = daobj.InsertSchedule(CourseId, TopicDate, TopicName, Assignment, AssignmentDeadline);
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
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        gvEdit.Visible = true;
    }
}