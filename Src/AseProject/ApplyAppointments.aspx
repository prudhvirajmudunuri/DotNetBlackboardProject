<%@ Page Title="" Language="C#" MasterPageFile="~/AseMaster.master" AutoEventWireup="true" CodeFile="ApplyAppointments.aspx.cs" Inherits="ApplyAppointments" %>

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

         $(function () {
             $('#<%=Date.ClientID%>').datepicker();
         });

         function ApplyAppointments(Name, passwd) {
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
                 $.get("http://localhost:49177/AseProject/Service.svc/apply/date/professor/reason", function (data) {
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
  <h3>Request Appointment</h3>
  <div>
       <div class ="form-group" style="margin-left:370px;">
           <br />
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Request Appointment" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
   </div>
            <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblappdate" style="float:left;margin-right:25px;" runat="server" Text="Select Appointment Date" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="Date" name="from" class="form-control" placeholder="From Date" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
     </div>
      
            <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblProfessor" style="float:left;margin-right:100px;" runat="server" Text="Select Professor" Font-Bold="True" Font-Italic="True"></asp:Label>
     <asp:DropDownList ID="ddlProfessor"  CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" DataSourceID="SQLDsProfessor" DataTextField="InstructorName" DataValueField="InstructorName" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlProfessor_SelectedIndexChanged">
         <asp:ListItem>--SELECT--</asp:ListItem>
                </asp:DropDownList>
     <asp:SqlDataSource ID="SQLDsProfessor" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT [InstructorName] FROM [tbl_Instructor]"></asp:SqlDataSource>
     </div>

      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblAppointmentTime" style="float:left;margin-right:25px;" runat="server" Text="Select Appointment Time" Font-Bold="True" Font-Italic="True" Visible="False"></asp:Label>
         <asp:DropDownList ID="ddlAppointmentTime" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" Visible="False">
          </asp:DropDownList>
     </div>
      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblAppointmentType" style="float:left;margin-right:25px;" runat="server" Text="Select Appointment Type" Font-Bold="True" Font-Italic="True"></asp:Label>
         <asp:DropDownList ID="ddlAppointmentType" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server">
             <asp:ListItem>--SELECT--</asp:ListItem>
             <asp:ListItem>Enrollment</asp:ListItem>
             <asp:ListItem>Question</asp:ListItem>
             <asp:ListItem>Emergency</asp:ListItem>
             <asp:ListItem>Others</asp:ListItem>
          </asp:DropDownList>
     </div>
       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblDescription" style="float:left;margin-right:140px;" runat="server" Text="Description" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="txtDescription" name="from" class="form-control" placeholder="Description" style="width:400px;" runat="server" required TextMode="MultiLine"></asp:TextBox>
     </div>
                     <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Request Appointment" OnClick="btnSubmit_Click"/>
     <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Appointment Requested Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Appointment Request Failed</strong></div>
</div>
      </div>
  <h3>Check Status</h3>
  <div style="border-left:30px;">
      
<asp:UpdatePanel ID="UpRequests" runat="server">
    <ContentTemplate>
        <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="AppointmentId" DataSourceID="SqlDsRequests" OnPageIndexChanging="PageIndexChanging" OnRowDataBound="gvRequests_DataBound" PageSize="5" AllowPaging="True" EmptyDataText="No Records Found" ForeColor="Black" GridLines="Horizontal">
            <Columns>
              <asp:BoundField DataField="AppointmentId" HeaderText="AppointmentId" InsertVisible="False" ReadOnly="True" SortExpression="AppointmentId" >
                <HeaderStyle Font-Italic="True" Font-Size="Small" Width="200px" />
                <ItemStyle Font-Italic="True" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="SSO" HeaderText="SSO" SortExpression="SSO" Visible="False" />
                <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment  Date" SortExpression="AppointmentDate" DataFormatString="{0:d}" >
                <HeaderStyle Height="10px" Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" Font-Italic="True" />
                <ItemStyle HorizontalAlign="Center" Width="100px" Font-Italic="True" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="InstructorName" HeaderText="Instructor  Name" SortExpression="InstructorName" >
                <HeaderStyle HorizontalAlign="Center" Font-Size="Small" Width="200px" Font-Italic="True" />
                <ItemStyle Width="100px" Font-Italic="True" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="AppointmentTime" HeaderText="Appointment  Time" SortExpression="AppointmentTime" >
                <HeaderStyle Width="200px" Font-Size="Small" Font-Italic="True" />
                <ItemStyle HorizontalAlign="Center" Width="100px" Font-Italic="True" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="AppointmentType" HeaderText="Appointment  Type" SortExpression="AppointmentType" >
                <HeaderStyle Width="200px" Font-Size="Small" Font-Italic="True" />
                <ItemStyle HorizontalAlign="Center" Width="100px" Font-Italic="True" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Center" Font-Size="Small" Width="200px" Font-Italic="True" />
                <ItemStyle Font-Italic="True" Font-Size="Small" />
                </asp:BoundField>
                <asp:BoundField DataField="AppointmentStatus" HeaderText="AppointmentStatus" SortExpression="AppointmentStatus">
                <HeaderStyle Width="200px" Font-Size="Small" Font-Italic="True" />
                <ItemStyle Font-Italic="True" Font-Size="Small" Font-Bold="True" />
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" DeleteText="Cancel Appointment" ShowDeleteButton="True">
                <ControlStyle CssClass="btn btn-lg btn-primary btn-block" />
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
        <asp:SqlDataSource ID="SqlDsRequests" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" DeleteCommand="DELETE FROM [tbl_AppointmentRequests] WHERE [AppointmentId] = @original_AppointmentId" InsertCommand="INSERT INTO [tbl_AppointmentRequests] ([SSO], [AppointmentDate], [InstructorName], [AppointmentTime], [AppointmentType], [Description], [AppointmentStatus]) VALUES (@SSO, @AppointmentDate, @InstructorName, @AppointmentTime, @AppointmentType, @Description, @AppointmentStatus)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [tbl_AppointmentRequests] WHERE ([SSO] = @SSO)" UpdateCommand="UPDATE [tbl_AppointmentRequests] SET [SSO] = @SSO, [AppointmentDate] = @AppointmentDate, [InstructorName] = @InstructorName, [AppointmentTime] = @AppointmentTime, [AppointmentType] = @AppointmentType, [Description] = @Description, [AppointmentStatus] = @AppointmentStatus WHERE [AppointmentId] = @original_AppointmentId">
            <DeleteParameters>
                <asp:Parameter Name="original_AppointmentId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SSO" Type="Int32" />
                <asp:Parameter DbType="Date" Name="AppointmentDate" />
                <asp:Parameter Name="InstructorName" Type="String" />
                <asp:Parameter Name="AppointmentTime" Type="String" />
                <asp:Parameter Name="AppointmentType" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="AppointmentStatus" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter DefaultValue="123" Name="SSO" SessionField="SSO" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SSO" Type="Int32" />
                <asp:Parameter DbType="Date" Name="AppointmentDate" />
                <asp:Parameter Name="InstructorName" Type="String" />
                <asp:Parameter Name="AppointmentTime" Type="String" />
                <asp:Parameter Name="AppointmentType" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="AppointmentStatus" Type="String" />
                <asp:Parameter Name="original_AppointmentId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
    <Triggers>
                <asp:AsyncPostBackTrigger ControlID="gvRequests" EventName="PageIndexChanging" />
            </Triggers>
</asp:UpdatePanel>
  </div>
    </div>   
</asp:Content>

