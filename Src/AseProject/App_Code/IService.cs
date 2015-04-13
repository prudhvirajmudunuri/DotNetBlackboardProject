﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService" in both code and config file together.
[ServiceContract]
public interface IService
{
    [OperationContract]
    int LoginService(string Name, string passwd);

    [OperationContract]
    DataTable GetSchedule(string CourseId);

    [OperationContract]
    DataTable GetLabs(string CourseId);

    [OperationContract]
    DataTable GetAssignments(string CourseId);

    [OperationContract]
    DataTable GetExams(string CourseId);

    [OperationContract]
    int InsertMarks(int SSO, string CourseId, string TopicName, int TotalMarks, int MarksObtained, int Percentage, string Comments);

    [OperationContract]
    DataTable GetPerformance(string CourseId,int SSO);

    [OperationContract]
    int AnalyzePerformance(string CourseId, string TopicName, out int Top1, out int Top2, out int Top3, out int Top4, out int Top5);

    [OperationContract]
    int CourseStrength(string CourseId, out int Strength);

    [OperationContract]
    int GetPosPer(string TopicName, string CourseId, int SSO, out int Position, out int Percentage);

    [OperationContract]
    int AnalyzeCoursePerformance(string CourseId, out int Top1, out int Top2, out int Top3, out int Top4, out int Top5);


}
