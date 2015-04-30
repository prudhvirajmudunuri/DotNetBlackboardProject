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

     public int CourseStrength(string CourseId, out int Strength)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         Strength = -99;
         SqlCommand cmdVisitCount = new SqlCommand("usp_GetStrength", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);

         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmdVisitCount.Parameters.Add(RetValue);

         SqlParameter vc = new SqlParameter("@Strength", SqlDbType.Int);
         vc.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc);
         try
         {
             con.Open();
             cmdVisitCount.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
             Strength = Convert.ToInt32(vc.Value);
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

     public int GetPosPer(string TopicName, string CourseId,int SSO, out int Position, out int Percentage)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         Position = -99;
         Percentage = -99;
         SqlCommand cmdVisitCount = new SqlCommand("usp_GetPosPer", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);
         cmdVisitCount.Parameters.AddWithValue("@TopicName", TopicName);
         cmdVisitCount.Parameters.AddWithValue("@SSO", SSO);

         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmdVisitCount.Parameters.Add(RetValue);

         SqlParameter vc = new SqlParameter("@Position", SqlDbType.Int);
         vc.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc);

         SqlParameter vc1 = new SqlParameter("@Percentage", SqlDbType.Int);
         vc1.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc1);
         try
         {
             con.Open();
             cmdVisitCount.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
             Percentage = Convert.ToInt32(vc1.Value);
             Position = Convert.ToInt32(vc.Value);
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



     public int AnalyzeCoursePerformance(string CourseId,out int Top1, out int Top2, out int Top3, out int Top4, out int Top5)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         Top1 = -99;
         Top2 = -99;
         Top3 = -99;
         Top4 = -99;
         Top5 = -99;
         SqlCommand cmdVisitCount = new SqlCommand("tbl_AnalyzeCoursePerformance", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);

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

     public int InsertSchedule(string CourseId, string TopicDate, string TopicName,string Assignment,string AssignmentDeadline)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         int retvalue = -99;
         SqlCommand cmd = new SqlCommand("INSERT INTO tbl_CoursePlan(CourseId,TopicDate,TopicName,Assignment,AssignmentDeadline) VALUES(@CourseId,@TopicDate,@TopicName,@Assignment,@AssignmentDeadline) ", con);
         cmd.Parameters.AddWithValue("@CourseId", CourseId);
         cmd.Parameters.AddWithValue("@TopicDate", TopicDate);
         cmd.Parameters.AddWithValue("@TopicName", TopicName);
         cmd.Parameters.AddWithValue("@Assignment", Assignment);
         cmd.Parameters.AddWithValue("@AssignmentDeadline", AssignmentDeadline);
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

     public int SetAttendance(string CourseId,int InstructorId, string AttendanceDate, int Latitude, int Longitude, string RandomCode, string StartTime, string EndTime)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         int retvalue = -99;
         SqlCommand cmd = new SqlCommand("INSERT INTO tbl_SetAttendance(CourseId,InstructorId,AttendanceDate,Latitude,Longitude,RandomCode,StartTime,EndTime) VALUES(@CourseId,@InstructorId,@AttendanceDate,@Latitude,@Longitude,@RandomCode,@StartTime,@EndTime) ", con);
         cmd.Parameters.AddWithValue("@CourseId", CourseId);
         cmd.Parameters.AddWithValue("@InstructorId", InstructorId);
         cmd.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);
         cmd.Parameters.AddWithValue("@Latitude", Latitude);
         cmd.Parameters.AddWithValue("@Longitude", Longitude);
         cmd.Parameters.AddWithValue("@RandomCode", RandomCode);
         cmd.Parameters.AddWithValue("@StartTime", StartTime);
         cmd.Parameters.AddWithValue("@EndTime", EndTime);
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


     public int GetStartEndTime(string CourseId,string AttendanceDate, out string StartTime,out string EndTime)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         StartTime = "";
         EndTime = "";
         SqlCommand cmdVisitCount = new SqlCommand("usp_GetStartEndTime", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);
         cmdVisitCount.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);

         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmdVisitCount.Parameters.Add(RetValue);

         SqlParameter vc = new SqlParameter("@StartTime", SqlDbType.VarChar,20);
         vc.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc);

         SqlParameter vc1 = new SqlParameter("@EndTime", SqlDbType.VarChar,20);
         vc1.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc1);
         try
         {
             con.Open();
             cmdVisitCount.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
             StartTime = vc.Value.ToString();
             EndTime = vc1.Value.ToString();
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

     public int MarkAttendance(int SSO, string CourseId,string AttendanceDate,string RandomCode,int Latitude,int Longitude)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         SqlCommand cmd = new SqlCommand("usp_MarkAttendance", con);
         cmd.CommandType = CommandType.StoredProcedure;
         cmd.Parameters.AddWithValue("@SSO", SSO);
         cmd.Parameters.AddWithValue("@CourseId", CourseId);
         cmd.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);
         cmd.Parameters.AddWithValue("@RandomCode", RandomCode);
         cmd.Parameters.AddWithValue("@Latitude", Latitude);
         cmd.Parameters.AddWithValue("@Longitude", Longitude);


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

     public DataTable GetAbsentStudentsList(string CourseId, string AttendanceDate)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT SSO FROM tbl_CourseEnrollment WHERE CourseId = @CourseId AND SSO NOT IN(SELECT SSO FROM tbl_Attendance WHERE CourseId=@CourseId AND AttendanceDate = @AttendanceDate)", con);
         da.SelectCommand.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);
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


     public int GenerateAttendance(int SSO,string CourseId, string AttendanceDate,string AttendanceStatus)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         int retvalue = -99;
         SqlCommand cmd = new SqlCommand("INSERT INTO tbl_Attendance(SSO,CourseId,AttendanceDate,AttendanceStatus) VALUES(@SSO,@CourseId,@AttendanceDate,@AttendanceStatus) ", con);
         cmd.Parameters.AddWithValue("@CourseId", CourseId);
         cmd.Parameters.AddWithValue("@SSO", SSO);
         cmd.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);
         cmd.Parameters.AddWithValue("@AttendanceStatus", AttendanceStatus);
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

     public int AnalyzeAttendance(string CourseId, string AttendanceDate, out int Present, out int Absent)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         int returnValue = -99;
         Present = -99;
         Absent = -99;
         SqlCommand cmdVisitCount = new SqlCommand("usp_AnalyzeAttendance", con);
         cmdVisitCount.CommandType = CommandType.StoredProcedure;
         cmdVisitCount.Parameters.AddWithValue("@CourseId", CourseId);
         cmdVisitCount.Parameters.AddWithValue("@AttendanceDate", AttendanceDate);

         SqlParameter RetValue = new SqlParameter();
         RetValue.Direction = ParameterDirection.ReturnValue;
         RetValue.SqlDbType = SqlDbType.Int;
         cmdVisitCount.Parameters.Add(RetValue);

         SqlParameter vc = new SqlParameter("@Present", SqlDbType.Int);
         vc.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc);
         SqlParameter vc1 = new SqlParameter("@Absent", SqlDbType.Int);
         vc1.Direction = ParameterDirection.Output;
         cmdVisitCount.Parameters.Add(vc1);
         try
         {
             con.Open();
             cmdVisitCount.ExecuteNonQuery();
             returnValue = Convert.ToInt32(RetValue.Value);
             Present = Convert.ToInt32(vc.Value);
             Absent = Convert.ToInt32(vc1.Value);
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

     public DataTable GetAttendance(string CourseId, int SSO)
     {
         SqlConnection con;
         con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASEDataBase"].ConnectionString);
         DataTable dt = new DataTable();
         SqlDataAdapter da = new SqlDataAdapter();
         da.SelectCommand = new SqlCommand("SELECT AttendanceDate,AttendanceStatus FROM tbl_Attendance WHERE CourseId = @CourseId AND SSO = @SSO", con);
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

}
