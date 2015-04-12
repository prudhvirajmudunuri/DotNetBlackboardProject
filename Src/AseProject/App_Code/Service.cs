using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
public class Service : IService
{
     [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, UriTemplate = "login/{Name}/{Passwd}")]
     public int LoginService(string Name, string passwd)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         SqlCommand cmd = new SqlCommand("usp_LoginService", con);
         cmd.CommandType = CommandType.StoredProcedure;
         cmd.Parameters.AddWithValue("@Name", Name);
         cmd.Parameters.AddWithValue("@passwd", passwd);


         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmd.Parameters.Add(RetValue);
         try
         {
             con.Open();
             cmd.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
         }
         catch (SqlException)
         {
             returnValue = -99;
         }
         finally
         {
             con.Close();
         }
         return returnValue;
     }

     public DataTable GetSchedule(string CourseId)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT * FROM tbl_CoursePlan WHERE CourseId = @CourseId", con);
         da.SelectCommand.Parameters.AddWithValue("@CourseId", CourseId);
         try
         {
             da.Fill(dt);
         }
         catch (SqlException)
         {
             return null;
         }
         catch (Exception)
         {
             return null;
         }
         return dt;
     }

     public DataTable GetLabs(string CourseId)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT TopicName FROM tbl_CoursePlan WHERE CourseId = @CourseId AND TopicName LIKE '%Lab%'", con);
         da.SelectCommand.Parameters.AddWithValue("@CourseId", CourseId);
         try
         {
             da.Fill(dt);
         }
         catch (SqlException)
         {
             return null;
         }
         catch (Exception)
         {
             return null;
         }
         return dt;
     }

     public DataTable GetAssignments(string CourseId)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT Assignment FROM tbl_CoursePlan WHERE CourseId = @CourseId AND Assignment != ''", con);
         da.SelectCommand.Parameters.AddWithValue("@CourseId", CourseId);
         try
         {
             da.Fill(dt);
         }
         catch (SqlException)
         {
             return null;
         }
         catch (Exception)
         {
             return null;
         }
         return dt;
     }

     public DataTable GetExams(string CourseId)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT TopicName FROM tbl_CoursePlan WHERE CourseId = @CourseId AND (TopicName LIKE '%Exam%' OR TopicName LIKE '%Midterm%')", con);
         da.SelectCommand.Parameters.AddWithValue("@CourseId", CourseId);
         try
         {
             da.Fill(dt);
         }
         catch (SqlException)
         {
             return null;
         }
         catch (Exception)
         {
             return null;
         }
         return dt;
     }

     public int InsertMarks(int SSO, string CourseId, string TopicName, int TotalMarks, int MarksObtained, int Percentage,string Comments)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         int retvalue = -99;
         SqlCommand cmd = new SqlCommand("INSERT INTO tbl_Performance(SSO,CourseId,TopicName,TotalMarks,MarksObtained,Percentage,Comments) VALUES(@SSO,@CourseId,@TopicName,@TotalMarks,@MarksObtained,@Percentage,@Comments) ", con);
         cmd.Parameters.AddWithValue("@SSO", SSO);
         cmd.Parameters.AddWithValue("@CourseId", CourseId);
         cmd.Parameters.AddWithValue("@TopicName", TopicName);
         cmd.Parameters.AddWithValue("@TotalMarks", TotalMarks);
         cmd.Parameters.AddWithValue("@MarksObtained", MarksObtained);
         cmd.Parameters.AddWithValue("@Percentage", Percentage);
         cmd.Parameters.AddWithValue("@Comments", Comments);
         try
         {
             con.Open();
             cmd.ExecuteNonQuery();
         }
         catch (SqlException)
         {
             retvalue = -99;
         }
         catch (Exception)
         {
             retvalue = -99;
         }
         finally
         {
             con.Close();
             retvalue = 1;
         }
         return retvalue;
     }


     public DataTable GetPerformance(string CourseId,int SSO)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT * FROM tbl_Performance WHERE CourseId = @CourseId AND SSO = @SSO", con);
         da.SelectCommand.Parameters.AddWithValue("@SSO", SSO);
         da.SelectCommand.Parameters.AddWithValue("@CourseId", CourseId);
         try
         {
             da.Fill(dt);
         }
         catch (SqlException)
         {
             return null;
         }
         catch (Exception)
         {
             return null;
         }
         return dt;
     }


     public int AnalyzePerformance(string CourseId, string TopicName,out int Top1,out int Top2,out int Top3,out int Top4,out int Top5)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         Top1 = -99;
         Top2 = -99;
         Top3 = -99;
         Top4 = -99;
         Top5 = -99;
         SqlCommand cmdVisitCount = new SqlCommand("usp_AnalyzePerformance", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);
         cmdVisitCount.Parameters.AddWithValue("@TopicName", TopicName);

         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmdVisitCount.Parameters.Add(RetValue);

         SqlParameter vc = new SqlParameter("@Top1", SqlDbType.Int);
         vc.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc);
         SqlParameter vc1 = new SqlParameter("@Top2", SqlDbType.Int);
         vc1.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc1);
         SqlParameter vc2 = new SqlParameter("@Top3", SqlDbType.Int);
         vc2.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc2);
         SqlParameter vc3 = new SqlParameter("@Top4", SqlDbType.Int);
         vc3.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc3);
         SqlParameter vc4 = new SqlParameter("@Top5", SqlDbType.Int);
         vc4.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc4);
         try
         {
             con.Open();
             cmdVisitCount.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
             Top1 = Convert.ToInt32(vc.Value);
             Top2 = Convert.ToInt32(vc1.Value);
             Top3 = Convert.ToInt32(vc2.Value);
             Top4 = Convert.ToInt32(vc3.Value);
             Top5 = Convert.ToInt32(vc4.Value);
         }
         catch (SqlException)
         {
             returnValue = -99;
         }
         finally
         {
             con.Close();
         }
         return returnValue;
     }
}
