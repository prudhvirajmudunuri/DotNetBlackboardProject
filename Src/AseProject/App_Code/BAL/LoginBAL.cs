using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LoginBAL
/// </summary>
public class LoginBAL
{
    LoginDAL daobj = new LoginDAL();
	public LoginBAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int Login(string Email, string passwd)
    {
        return daobj.Login(Email,passwd);
    }
}