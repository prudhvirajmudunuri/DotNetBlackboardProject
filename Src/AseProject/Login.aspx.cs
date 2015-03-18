using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    LoginBAL daobj = new LoginBAL();
    ApplyAppointmentsBAL daobj2 = new ApplyAppointmentsBAL();
    ManageAppointmentsBAL daobj3 = new ManageAppointmentsBAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        diverror.Visible = false;
        diverror2.Visible = false;
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        int ret = daobj.Login(inputEmail.Value,inputPassword.Value);
        if(ret==1)
        {
            Session["Email"] = inputEmail.Value;
            int SSO = -99;
            daobj2.GetStudentId(Session["Email"].ToString(), out SSO);
            Session["SSO"] = SSO;
            Response.Redirect("StudentHomePage.aspx");
        }
        else if(ret==2)
        {
            diverror.Visible = true;
        }
        else if(ret==3)
        {
            Session["Email"] = inputEmail.Value;
            string Email = Session["Email"].ToString();
            string InstructorName = "";
            daobj2.GetInstructorNameByEmail(Email, out InstructorName);
            Session["InstructorName"] = InstructorName;
            int InstructorId = -99;
            daobj3.GetInstructorId(Email,out InstructorId);
            Session["InstructorId"] = InstructorId;
            Response.Redirect("InstructorHomePage.aspx");
        }
        else if(ret==4)
        {
             diverror.Visible = true;
        }
        else if(ret==5)
        {
             diverror2.Visible = true;
        }
    }
}