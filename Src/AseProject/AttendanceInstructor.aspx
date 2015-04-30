<%@ Page Title="" Language="C#" MasterPageFile="~/ASEMasterInstructor.master" AutoEventWireup="true" CodeFile="AttendanceInstructor.aspx.cs" Inherits="AttendanceInstructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <script src="http://maps.google.com/maps/api/js?sensor=false">
</script>
<script type="text/javascript">
    function Location() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var latitude = position.coords.latitude;
                document.getElementById("<%= latitude.ClientID %>").value = latitude;
                var longitude = position.coords.longitude;
                document.getElementById("<%= longitude.ClientID %>").value = longitude;
            });
        } else {
            alert("Geolocation API is not supported in your browser.");
        }
        
    }

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
    $(function () {
        $('#<%=Date.ClientID%>').datepicker();
     });
</script>
    <div id="accordion">
  <h3>Set Attendance</h3>
  <div>
     <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Set Attendance" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
            </div>


          <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblCourse" style="float:left;margin-right:105px;" runat="server" Text="Select Course" Font-Bold="True" Font-Italic="True"></asp:Label>
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
    <asp:Label ID="lblappdate" style="float:left;margin-right:25px;" runat="server" Text="Select Date" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="Date" name="from" class="form-control" placeholder="From Date" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
     </div>

      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblLatitude" style="float:left;margin-right:5px;" runat="server" Text="Latitude" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="latitude" name="from" class="form-control" placeholder="Latitude" style="width:400px;margin-left:220px;" runat="server" ClientIDMode="Static" required></asp:TextBox>
     </div>

              <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lbllongitude" style="float:left;margin-right:5px;" runat="server" Text="Longitude" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="longitude" name="from" class="form-control" placeholder="Longitude" style="width:400px;margin-left:220px;" runat="server" ClientIDMode="Static" required></asp:TextBox>
     </div>

        <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblDuration" style="float:left;margin-right:5px;" runat="server" Text="Duration" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="txtDuration" name="from" class="form-control" placeholder="Duration in Minutes" style="width:400px;margin-left:220px;" runat="server" ClientIDMode="Static" required></asp:TextBox>
     </div>
   <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Set Attendance" OnClick="btnSubmit_Click"/>
      <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Attendance Set Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Attendance Setting Failed</strong></div>
</div>
      </div>   

         <h3>List of Attendance</h3>
        <div>
            <asp:UpdatePanel ID="upAttendanceList" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" DataSourceID="SqldsAttendanceList" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnRowCommand="gvAttendance_RowCommand" CellPadding="4" ForeColor="Black" GridLines="Horizontal" DataKeyNames="Aid">
                        <Columns>
                            
                            <asp:BoundField DataField="CourseId" HeaderText="CourseId" SortExpression="CourseId">
                                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="AttendanceDate" HeaderText="AttendanceDate" SortExpression="AttendanceDate" DataFormatString="{0:d}">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="Latitude" HeaderText="Latitude" SortExpression="Latitude">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="Longitude" HeaderText="Longitude" SortExpression="Longitude">
                                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="RandomCode" HeaderText="RandomCode" SortExpression="RandomCode">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="StartTime" HeaderText="StartTime" SortExpression="StartTime">
                                   <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="EndTime" HeaderText="EndTime" SortExpression="EndTime">
                                  <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:BoundField DataField="Aid" HeaderText="Aid" InsertVisible="False" ReadOnly="True" SortExpression="Aid" Visible="False">
                                 <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" Height="35px" />
                                <ItemStyle Font-Italic="True" Height="20px" />
                                   </asp:BoundField>
                            <asp:ButtonField ButtonType="Button" Text="Generate Attendance" CommandName="Generate">
                                <ControlStyle CssClass="btn btn-lg btn-primary btn-block" />
                                 <ItemStyle Font-Italic="True" />
                                </asp:ButtonField>
                            <asp:CommandField ShowDeleteButton="True" ButtonType="Button">
                                <ControlStyle CssClass="btn btn-lg btn-primary btn-block" />
                                <HeaderStyle HorizontalAlign="Center" />
                                </asp:CommandField>
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
                    <asp:SqlDataSource ID="SqldsAttendanceList" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT [CourseId], [AttendanceDate], [Latitude], [Longitude], [RandomCode], [StartTime], [EndTime], [Aid] FROM [tbl_SetAttendance] WHERE ([InstructorId] = @InstructorId)" DeleteCommand="DELETE FROM [tbl_SetAttendance] WHERE [Aid] = @Aid" InsertCommand="INSERT INTO [tbl_SetAttendance] ([CourseId], [AttendanceDate], [Latitude], [Longitude], [RandomCode], [StartTime], [EndTime]) VALUES (@CourseId, @AttendanceDate, @Latitude, @Longitude, @RandomCode, @StartTime, @EndTime)" UpdateCommand="UPDATE [tbl_SetAttendance] SET [CourseId] = @CourseId, [AttendanceDate] = @AttendanceDate, [Latitude] = @Latitude, [Longitude] = @Longitude, [RandomCode] = @RandomCode, [StartTime] = @StartTime, [EndTime] = @EndTime WHERE [Aid] = @Aid">
                        <DeleteParameters>
                            <asp:Parameter Name="Aid" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="CourseId" Type="String" />
                            <asp:Parameter DbType="Date" Name="AttendanceDate" />
                            <asp:Parameter Name="Latitude" Type="Int32" />
                            <asp:Parameter Name="Longitude" Type="Int32" />
                            <asp:Parameter Name="RandomCode" Type="String" />
                            <asp:Parameter Name="StartTime" Type="String" />
                            <asp:Parameter Name="EndTime" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="44" Name="InstructorId" SessionField="InstructorId" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="CourseId" Type="String" />
                            <asp:Parameter DbType="Date" Name="AttendanceDate" />
                            <asp:Parameter Name="Latitude" Type="Int32" />
                            <asp:Parameter Name="Longitude" Type="Int32" />
                            <asp:Parameter Name="RandomCode" Type="String" />
                            <asp:Parameter Name="StartTime" Type="String" />
                            <asp:Parameter Name="EndTime" Type="String" />
                            <asp:Parameter Name="Aid" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

              <div class="alert alert-success alert-dismissible" id="div1" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Attendance Generated Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="div2" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Attendance Generation Failed</strong></div>
</div>
        </div>
 </div>
</asp:Content>

