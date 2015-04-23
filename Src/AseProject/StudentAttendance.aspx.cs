﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentAttendance : System.Web.UI.Page
{
    Service daobj = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        diverror2.Visible = false;
        divSuccess.Visible = false;
        divError3.Visible = false;
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Location(); ", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int ret = 0;
        string CurrentTime = DateTime.Now.ToString("h:mm:ss tt");
        DateTime ct = Convert.ToDateTime(CurrentTime);
        string StartTime = "";
        string EndTime = "";
        daobj.GetStartEndTime(ddlCourse.SelectedValue.ToString(),Date.Text,out StartTime,out EndTime);
        DateTime st = Convert.ToDateTime(StartTime);
        DateTime et = Convert.ToDateTime(EndTime);
        int Latitude = Convert.ToInt32(Convert.ToDouble(latitude.Text));
        int Longitude = Convert.ToInt32(Convert.ToDouble(longitude.Text));
        if (ct >= st && ct <= et)
        {
            ret = daobj.MarkAttendance(Convert.ToInt32(Session["SSO"]),ddlCourse.SelectedValue.ToString(),Date.Text,txtCode.Text,Latitude,Longitude);
            if (ret == 1)
            {
                divSuccess.Visible = true;
            }
            else if (ret == 2)
            {
                diverror2.Visible = true;
            }
            else if (ret == 3)
            {
                divError3.Visible = true;
            }
        }
        else 
        {
            diverror.Visible = true;
        }
        
    }
}