<%@ Page Title="" Language="C#" MasterPageFile="~/AseMaster.master" AutoEventWireup="true" CodeFile="StudentHomePage.aspx.cs" Inherits="StudentHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
     <link href="css/bootstrap.min.css" rel="stylesheet"/>
     <link href="css/navbar.css" rel="stylesheet"/>
     <script>
         $(function () {
             var icons = {
                 header: "ui-icon-circle-arrow-e",
                 activeHeader: "ui-icon-circle-arrow-s"
             };
             $("#accordion").accordion({
                 icons: icons
             });
             $("#toggle").button().click(function () {
                 if ($("#accordion").accordion("option", "icons")) {
                     $("#accordion").accordion("option", "icons", null);
                 } else {
                     $("#accordion").accordion("option", "icons", icons);
                 }
             });
         });

         $('#myModal').on('shown.bs.modal', function () {
             $('#myInput').focus()
         })

         function service(CourseId, SSO) {
             var echo = function (dataPass) {
                 $.ajax({
                     type: "POST",
                     url: "/echo/json/",
                     data: dataPass,
                     cache: false,
                     success: function (json) {

                     }
                 });
             };
             $('.list').live('click', function () {
                 $.get("http://localhost:49177/AseProject/Service.svc/CourseId/InstructorId", function (data) {
                     var json = {
                         json: JSON.stringify(data),
                         delay: 1
                     };
                     echo(json);
                 });
             });
         }
         </script>
    <div id="accordion">
  <h3>Course Progress And Important Dates</h3>
  <div>
      <div class ="form-group" style="margin-left:20px;">
 <div class="panel panel-primary" style="float:left;margin-right:25px;width:500px;">
  <div class="panel-heading">Important Dates</div>
  <div class="panel-body">
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDeadline" ForeColor="#333333" GridLines="None" ShowHeader="False">
          <AlternatingRowStyle BackColor="White" />
          <Columns>
              <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId">
                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Width="200px"/>
                </asp:BoundField>
              <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment">
                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Width="200px"/>
                </asp:BoundField>
              <asp:BoundField DataField="AssignmentDeadline" DataFormatString="{0:d}" HeaderText="AssignmentDeadline" SortExpression="AssignmentDeadline">
                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Font-Bold="True" Width="200px"/>
                </asp:BoundField>
               <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
               <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">View</button>
            </ItemTemplate>
        </asp:TemplateField>
             
               
          </Columns>
          <EditRowStyle BackColor="#2461BF" />
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
          <RowStyle BackColor="#EFF3FB" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <SortedAscendingCellStyle BackColor="#F5F7FB" />
          <SortedAscendingHeaderStyle BackColor="#6D95E1" />
          <SortedDescendingCellStyle BackColor="#E9EBEF" />
          <SortedDescendingHeaderStyle BackColor="#4870BE" />
      </asp:GridView>
      <asp:SqlDataSource ID="SqlDeadline" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT CourseId,Assignment,AssignmentDeadline FROM tbl_CoursePlan WHERE Assignment!= '' AND AssignmentDeadline &gt;= GETDATE() AND AssignmentDeadline &lt; DATEADD(dd,14,GETDATE()) AND CourseId IN (SELECT CourseId FROM tbl_CourseEnrollment WHERE SSO = @t1)
">
          <SelectParameters>
              <asp:SessionParameter DefaultValue="122" Name="t1" SessionField="SSO" />
          </SelectParameters>
      </asp:SqlDataSource>
  </div>
</div>
          <div class="panel panel-primary" style="float:right;width:500px;">
  <div class="panel-heading">Upcoming Assessments</div>
  <div class="panel-body">
      <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDsded1" ForeColor="#333333" GridLines="None" ShowHeader="False" EmptyDataText="No Assessments Scheduled">
          <AlternatingRowStyle BackColor="White" />
          <Columns>
              <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId">
               <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Width="200px"/>
                </asp:BoundField>
              <asp:BoundField DataField="TopicName" HeaderText="TopicName" SortExpression="TopicName">
                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Width="200px"/>
                </asp:BoundField>
              <asp:BoundField DataField="TopicDate" HeaderText="TopicDate" SortExpression="TopicDate" DataFormatString="{0:d}">
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Width="200px" Font-Bold ="true"/>
                </asp:BoundField>
              <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
               <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal1">View</button>
            </ItemTemplate>
        </asp:TemplateField>
          </Columns>
          <EditRowStyle BackColor="#2461BF" />
          <EmptyDataRowStyle Font-Bold="True" Font-Italic="True" ForeColor="Red" />
          <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
          <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
          <RowStyle BackColor="#EFF3FB" />
          <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
          <SortedAscendingCellStyle BackColor="#F5F7FB" />
          <SortedAscendingHeaderStyle BackColor="#6D95E1" />
          <SortedDescendingCellStyle BackColor="#E9EBEF" />
          <SortedDescendingHeaderStyle BackColor="#4870BE" />
      </asp:GridView>
      <asp:SqlDataSource ID="SqlDsded1" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT CourseId,TopicDate,TopicName FROM tbl_CoursePlan WHERE TopicDate BETWEEN GETDATE() AND  DATEADD(dd,45,GETDATE()) AND (TopicName LIKE 'Midterm' OR TopicName LIKE '%Exam%') AND CourseId IN (SELECT CourseId FROM tbl_CourseEnrollment WHERE SSO = @t3)
">
          <SelectParameters>
              <asp:SessionParameter DefaultValue="122" Name="t3" SessionField="SSO" />
          </SelectParameters>
      </asp:SqlDataSource>
  </div>
</div>
<div class="panel panel-primary" style="float:left;margin-right:25px;width:1050px">
  <div class="panel-heading">Course Progress</div>
  <div class="panel-body">
      <asp:Label ID="lblCourse1" runat="server" Text="Course Id : CS551MT     CourseName : Software Methods and Tools" Font-Bold="True" Font-Italic="True" Font-Size="Small" ForeColor="#333300"></asp:Label>
      <div class="progress">
  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
    <span class="sr-only">40% Complete (success)</span>
  </div>
</div>
       <br />
 
<asp:Label ID="lblCourse2" runat="server" Text="Course Id : CS551NA     CourseName : Network Architecture" Font-Bold="True" Font-Italic="True" Font-Size="Small" ForeColor="#333300"></asp:Label>

<div class="progress">
  <div id="div1" class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 55.8%" runat="server">
    <span class="sr-only">20% Complete</span>
  </div>
</div>
  </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Description</h4>
      </div>
      <div class="modal-body">
          <asp:Label ID="lblDescription" runat="server" Text="This Assignment is due on mentioned date by Midnight(12:00am)"></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
      </div>
    </div>
  </div>
</div>
          <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="H1">Description</h4>
      </div>
      <div class="modal-body">
          <asp:Label ID="Label1" runat="server" Text="This Exam takes place in the respective classroom on that particular Date"></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
      </div>
    </div>
  </div>
</div>

     </div>

  </div>
  <h3>Course Plan</h3>
  <div style="border-left:30px;">
     
       <div class ="form-group" style="margin-left:370px;">

          <asp:Label ID="lblHeading" runat="server" Text="Enrolled Courses" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
   </div>
    <asp:GridView ID="gvallotment" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="CourseId" DataSourceID="SqldsAllotment" ForeColor="Black" OnRowCommand="gvallotment_RowCommand" GridLines="Horizontal">
        <Columns>
           <asp:BoundField DataField="CourseId" HeaderText="CourseId" ReadOnly="True" SortExpression="CourseId">
             <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" />
                </asp:BoundField>
            <asp:BoundField DataField="CourseName" HeaderText="CourseName" SortExpression="CourseName">
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" />
                </asp:BoundField>
            <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" DataFormatString="{0:d}">
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" />
                </asp:BoundField>
            <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" DataFormatString="{0:d}">
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True"  />
                </asp:BoundField>
            <asp:BoundField DataField="Credits" HeaderText="Credits" SortExpression="Credits">
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True"  />
                </asp:BoundField>
            
            <asp:ButtonField ButtonType="Button" CommandName="Schedule" Text="Get Schedule">
            <ItemStyle Font-Bold="True" Font-Italic="True" />
                <ControlStyle CssClass="btn btn-lg btn-primary btn-block" />
            </asp:ButtonField>
            
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqldsAllotment" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT CourseId,CourseName,StartDate,EndDate,Credits FROM tbl_Course WHERE CourseId IN (SELECT CourseId FROM tbl_CourseEnrollment WHERE SSO = @t8)
">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="122" Name="t8" SessionField="SSO" />
        </SelectParameters>
    </asp:SqlDataSource>
      </br>
      </br>
      </br>
               <asp:UpdatePanel ID="upSchedule" runat="server">
                   <ContentTemplate>
                       <div class="alert alert-info alert-dismissible" id="diverror" runat="server" role="alert">
 <div style="margin-left:340px;"></span>
  <span class="sr-only">Error:</span><strong>Course Schedule For : <asp:Label ID="lblCourse" runat="server" Text="Label"></asp:Label></strong></div>
</div>
                       <asp:GridView ID="gvSchedule" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" AutoGenerateColumns="False" EmptyDataText="No Records Found">
                           <Columns>
                               <asp:BoundField DataField="CourseId" HeaderText="Course Id" Visible="False">
                                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                               <asp:BoundField DataField="TopicDate" DataFormatString="{0:d}" HeaderText="Date">
                                 <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                               <asp:BoundField DataField="TopicName" HeaderText="Topic">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                                <ItemStyle Font-Italic="True" />
                                   </asp:BoundField>
                               <asp:BoundField DataField="Assignment" HeaderText="Assignment">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                                <ItemStyle Font-Italic="True" />
                                   </asp:BoundField>
                               <asp:BoundField DataField="AssignmentDeadline" HeaderText="AssignmentDeadline" DataFormatString="{0:d}">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                                <ItemStyle Font-Italic="True" />
                                   </asp:BoundField>
                           </Columns>
                           <EmptyDataRowStyle Font-Bold="True" Font-Italic="True" ForeColor="Red" />
                           <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                           <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                           <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                           <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                           <SortedAscendingCellStyle BackColor="#F7F7F7" />
                           <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                           <SortedDescendingCellStyle BackColor="#E5E5E5" />
                           <SortedDescendingHeaderStyle BackColor="#242121" />
                       </asp:GridView>
                   </ContentTemplate>
                   <Triggers>
                       <asp:AsyncPostBackTrigger ControlID="gvallotment" EventName="RowCommand" />
                   </Triggers>
               </asp:UpdatePanel>
  </div> 
     
  
    </div>  
</asp:Content>

