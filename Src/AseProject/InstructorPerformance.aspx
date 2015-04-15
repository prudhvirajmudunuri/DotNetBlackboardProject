<%@ Page Title="" Language="C#" MasterPageFile="~/ASEMasterInstructor.master" AutoEventWireup="true" CodeFile="InstructorPerformance.aspx.cs" Inherits="InstructorPerformance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
         function service(CourseId, TypeOFAssessment,FileName) {
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
                 $.get("http://localhost:49177/AseProject/Service.svc/CourseId/TypeOfAssessment/FileName", function (data) {
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
  <h3>Upload Marks</h3>
  <div>
     <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Upload Marks" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
            </div>
         <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblCourse" style="float:left;margin-right:140px;" runat="server" Text="Select Course" Font-Bold="True" Font-Italic="True"></asp:Label>
         <asp:DropDownList ID="ddlCourse" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" AppendDataBoundItems="True" DataSourceID="SqldsCourse" DataTextField="CourseId" DataValueField="CourseId">
         <asp:ListItem>--SELECT--</asp:ListItem> 
         </asp:DropDownList>
             <asp:SqlDataSource ID="SqldsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT [CourseId] FROM [tbl_CourseAllotment] WHERE ([InstructorId] = @InstructorId)">
                 <SelectParameters>
                     <asp:SessionParameter DefaultValue="122" Name="InstructorId" SessionField="InstructorId" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>
     </div>

       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblType" style="float:left;margin-right:25px;" runat="server" Text="Select Type Of Assessment" Font-Bold="True" Font-Italic="True"></asp:Label>
         <asp:DropDownList ID="ddlType" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
         <asp:ListItem>--SELECT--</asp:ListItem> 
             <asp:ListItem>Assignments</asp:ListItem>
             <asp:ListItem>Labs</asp:ListItem>
             <asp:ListItem>Exams</asp:ListItem>
         </asp:DropDownList>
     </div>

      
       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblAssessment" style="float:left;margin-right:95px;" runat="server" Text="Select Assessment" Font-Bold="True" Font-Italic="True" Visible="False"></asp:Label>
         <asp:DropDownList ID="ddlAssessment" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" Visible="False">
         <asp:ListItem>--SELECT--</asp:ListItem> 
         </asp:DropDownList>
     </div>

       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblSelectFile" style="float:left;margin-right:120px;" runat="server" Text="Browse For File" Font-Bold="True" Font-Italic="True"></asp:Label>
          <asp:FileUpload ID="FileUpload1" CssClass="btn btn-default dropdown-toggle" runat="server" />
     </div>

                           <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Upload Marks" OnClick="btnSubmit_Click"/>
     <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Marks Uploaded Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Marks Uploading Failed</strong></div>
</div>
       </br>
      </br>
      </br>
      </br>
      </br>
      </br>
      </br>
      </br>
      </br>
      </br>
      </br>

</div>
         </div>
</asp:Content>

