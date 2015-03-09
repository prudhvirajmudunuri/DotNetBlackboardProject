using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    LoginBAL daobj = new LoginBAL();
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
            Response.Redirect("StudentHomePage.aspx");
        }
        else if(ret==2)
        {
            diverror.Visible = true;
        }
        else if(ret==3)
        {
            Session["Email"] = inputEmail.Value;
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