<%@ Page Title="" Language="C#" MasterPageFile="~/AseMaster.master" AutoEventWireup="true" CodeFile="ViewPerformance.aspx.cs" Inherits="ViewPerformance" %>

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
                 $.get("http://localhost:49177/AseProject/Service.svc/CourseId/SSO", function (data) {
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
  <h3>View Performance</h3>
  <div>
       <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="View Performance" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
            </div>
       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblCourse" style="float:left;margin-right:100px;" runat="server" Text="Select Course" Font-Bold="True" Font-Italic="True"></asp:Label>
                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="btn btn-default dropdown-toggle" style="width:400px;" AppendDataBoundItems="True" DataSourceID="SqlDsvieCourse" DataTextField="CourseId" DataValueField="CourseId">
                    <asp:ListItem>--SELECT--</asp:ListItem>
           </asp:DropDownList>
           <asp:SqlDataSource ID="SqlDsvieCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT [CourseId] FROM [tbl_CourseEnrollment] WHERE ([SSO] = @SSO)">
               <SelectParameters>
                   <asp:SessionParameter DefaultValue="111" Name="SSO" SessionField="SSO" Type="Int32" />
               </SelectParameters>
           </asp:SqlDataSource>
</br>
      </br>
           <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:150px;" runat="server" Text="View Performance" OnClick="btnSubmit_Click"/>
           </div>
     <asp:UpdatePanel ID="upPerformance" runat="server" Visible="False">
         <ContentTemplate>
                                <div class="alert alert-info alert-dismissible" id="diverror" runat="server" role="alert">
 <div style="margin-left:240px;"></span>
  <span class="sr-only">Error:</span><strong>Performance For Course: <asp:Label ID="lblcou" runat="server" Text="Label"></asp:Label></strong></div>
</div>
             <asp:GridView ID="gvPerformance" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" OnRowDataBound="gvPerformance_DataBound" AutoGenerateColumns="False" EmptyDataText="No Records Found">
                 <Columns>
                     <asp:BoundField DataField="CourseId" HeaderText="CourseId">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                     <asp:BoundField DataField="TopicName" HeaderText="TopicName">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                     <asp:BoundField DataField="TotalMarks" HeaderText="TotalMarks">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                     <asp:BoundField DataField="MarksObtained" HeaderText="MarksObtained">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                     <asp:BoundField DataField="Percentage" HeaderText="Percentage">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                     <asp:BoundField DataField="Comments" HeaderText="Comments">
                          <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
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
     </asp:UpdatePanel>
     
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

