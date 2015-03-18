using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace NunitTesting
{
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void LoginTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc/login/Goutham Donthu/gou");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1,Convert.ToInt32(reader.ReadToEnd()));
                }
 
            }


        }

    }
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void LoginTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc/login/Goutham Donthu/gou");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1, Convert.ToInt32(reader.ReadToEnd()));
                }

            }


        }

    }
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void ManageAppointmentsTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc/manage/fromtime/totime/fromdate/todate/maxapp");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1, Convert.ToInt32(reader.ReadToEnd()));
                }

            }


        }

    }
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void ApplyAppointmentsTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc/Apply/appdate/professor.time.apptime/description");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1, Convert.ToInt32(reader.ReadToEnd()));
                }

            }


        }

    }
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void AppRejAppointmentsTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc/login/10/Approved");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1, Convert.ToInt32(reader.ReadToEnd()));
                }

            }


        }

    }
    [TestFixture]
    public class LoginTesting
    {
        [Test]
        public void ValidationsTest()
        {
            WebRequest request = WebRequest.Create(@"http://localhost:50926/AseLab6/Service.svc");
            request.Method = "GET";
            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            if (response.StatusCode == HttpStatusCode.OK)
            {
                using (Stream respStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(respStream, Encoding.UTF8);
                    Assert.AreEqual(1, Convert.ToInt32(reader.ReadToEnd()));
                }

            }


        }

    }
}
