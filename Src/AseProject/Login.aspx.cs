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
            lblErrorMessage.ForeColor = System.Drawing.Color.Red;
            lblErrorMessage.Text = "Incorrect Password";
        }
        else if(ret==3)
        {
            Response.Redirect("InstructorHomePage.aspx");
        }
        else if(ret==4)
        {
             lblErrorMessage.ForeColor = System.Drawing.Color.Red;
             lblErrorMessage.Text = "Incorrect Password";
        }
        else if(ret==5)
        {
             lblErrorMessage.ForeColor = System.Drawing.Color.Red;
             lblErrorMessage.Text = "User DoesNot Exist";
        }
    }
}