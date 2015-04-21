<%@ Page Title="" Language="C#" MasterPageFile="~/ASEMasterInstructor.master" AutoEventWireup="true" CodeFile="AddSchedule.aspx.cs" Inherits="AddSchedule" %>

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
         </script>

     <div id="accordion">
  <h3>Add Course Plan</h3>
    <div>
       <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Add Course Plan" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
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
    <asp:Label ID="lblSelectFile" style="float:left;margin-right:120px;" runat="server" Text="Browse For File" Font-Bold="True" Font-Italic="True"></asp:Label>
          <asp:FileUpload ID="FileUpload1" CssClass="btn btn-default dropdown-toggle" runat="server" />
     </div>

     
                                   <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Upload Schedule" OnClick="btnSubmit_Click"/>
     <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Schedule Uploaded Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Schedule Uploading Failed</strong></div>
</div>
        </br></br></br></br></br></br></br></br></br>
      </div>
  <h3>Edit Course Plan</h3>
  <div style="border-left:30px;">
      <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="Label1" runat="server" Text="Edit Course Plan" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
            </div>
        <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblCourse1" style="float:left;margin-right:140px;" runat="server" Text="Select Course" Font-Bold="True" Font-Italic="True"></asp:Label>
         <asp:DropDownList ID="ddlCourse1" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" AppendDataBoundItems="True" DataSourceID="SqldsCourse" DataTextField="CourseId" DataValueField="CourseId">
         <asp:ListItem>--SELECT--</asp:ListItem> 
         </asp:DropDownList>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT [CourseId] FROM [tbl_CourseAllotment] WHERE ([InstructorId] = @InstructorId)">
                 <SelectParameters>
                     <asp:SessionParameter DefaultValue="122" Name="InstructorId" SessionField="InstructorId" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>
   
</div>
      <asp:Button ID="btnEdit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Edit Schedule" OnClick="btnEdit_Click"/>
      </br></br>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvEdit" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqldsEdit" ForeColor="Black" GridLines="Horizontal" EmptyDataText="No Records Found" Visible="False" DataKeyNames="UniqueId" PageSize="6">
                            <Columns>
                                <asp:BoundField DataField="UniqueId" HeaderText="UniqueId" SortExpression="UniqueId" Visible="false" InsertVisible="False" ReadOnly="True">
                                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="100px" Height="35px"/>
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId">
                                    <HeaderStyle Font-Italic="True" Font-Size="Small" Width="100px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:BoundField DataField="TopicDate" HeaderText="TopicDate" SortExpression="TopicDate" DataFormatString="{0:d}">
                                    <HeaderStyle Font-Italic="True" Font-Size="Small" Width="100px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:BoundField DataField="TopicName" HeaderText="TopicName" SortExpression="TopicName">
                                    <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:BoundField DataField="Assignment" HeaderText="Assignment" SortExpression="Assignment">
                                    <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:BoundField DataField="AssignmentDeadline" HeaderText="AssignmentDeadline" SortExpression="AssignmentDeadline" DataFormatString="{0:d}">
                                    <HeaderStyle Font-Italic="True" Font-Size="Small" Width="100px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                                <asp:CommandField ButtonType="Button" ShowEditButton="True">
                                    <ControlStyle CssClass="btn btn-lg btn-info btn-block" />
                                     <ItemStyle Font-Italic="True" />
                                    </asp:CommandField>
                            </Columns>
                            <EmptyDataRowStyle Font-Bold="True" Font-Italic="True" ForeColor="#FF3300" />
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#242121" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqldsEdit" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT * FROM [tbl_CoursePlan] WHERE ([CourseId] = @CourseId)" DeleteCommand="DELETE FROM [tbl_CoursePlan] WHERE [UniqueId] = @UniqueId" InsertCommand="INSERT INTO [tbl_CoursePlan] ([CourseId], [TopicDate], [TopicName], [Assignment], [AssignmentDeadline]) VALUES (@CourseId, @TopicDate, @TopicName, @Assignment, @AssignmentDeadline)" UpdateCommand="UPDATE [tbl_CoursePlan] SET [CourseId] = @CourseId, [TopicDate] = @TopicDate, [TopicName] = @TopicName, [Assignment] = @Assignment, [AssignmentDeadline] = @AssignmentDeadline WHERE [UniqueId] = @UniqueId">
                            <DeleteParameters>
                                <asp:Parameter Name="UniqueId" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="CourseId" Type="String" />
                                <asp:Parameter DbType="Date" Name="TopicDate" />
                                <asp:Parameter Name="TopicName" Type="String" />
                                <asp:Parameter Name="Assignment" Type="String" />
                                <asp:Parameter DbType="Date" Name="AssignmentDeadline" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCourse1" DefaultValue="CS55" Name="CourseId" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CourseId" Type="String" />
                                <asp:Parameter DbType="Date" Name="TopicDate" />
                                <asp:Parameter Name="TopicName" Type="String" />
                                <asp:Parameter Name="Assignment" Type="String" />
                                <asp:Parameter DbType="Date" Name="AssignmentDeadline" />
                                <asp:Parameter Name="UniqueId" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
      </br></br></br></br></br>
  </div>
    </div>  
</asp:Content>

