<%@ Page Title="" Language="C#" MasterPageFile="~/ASEMasterInstructor.master" AutoEventWireup="true" CodeFile="AppointmentRequests.aspx.cs" Inherits="AppointmentRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class ="form-group" style="margin-left:370px;">
    <script>
        function Requestservice(Name, passwd) {
            var echo = function (dataPass) {
                $.ajax({
                    type: "POST",
                    url: "/echo/json/",
                    data: dataPass,
                    cache: false,
                    success: function (json) {
                        alert("UID=" + json.id + "\nName=" + json.name);
                    }
                });
            };
            $('.list').live('click', function () {
                $.get("http://localhost:49177/AseProject/Service.svc/appointmentdate/professor/apptype/description", function (data) {
                    var json = {
                        json: JSON.stringify(data),
                        delay: 1
                    };
                    echo(json);
                });
            });
        }
    </script>
           <br />
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Appointment Requests" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
       </div>
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="SSO" DataSourceID="SqlDsRequests" ForeColor="Black" OnRowDataBound="gvRequests_DataBound" OnRowCommand="gvRequests_RowCommand" GridLines="Horizontal" EmptyDataText="No Records Found">
        <Columns>
            <asp:BoundField DataField="AppointmentId" HeaderText="AppointmentId" ReadOnly="True" SortExpression="AppointmentId" >
            <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" Height="20px" />
                <ItemStyle Font-Italic="True" />
            </asp:BoundField>
            <asp:BoundField DataField="SSO" HeaderText="SSO" ReadOnly="True" SortExpression="SSO" >
            <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" Height="20px" />
                <ItemStyle Font-Italic="True" />
            </asp:BoundField>
            <asp:BoundField DataField="StudentName" HeaderText="StudentName" SortExpression="StudentName">
                <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" />
                <ItemStyle Font-Italic="True" />
            </asp:BoundField>
            <asp:BoundField DataField="AppointmentDate" HeaderText="AppointmentDate" SortExpression="AppointmentDate" DataFormatString="{0:d}" >
                <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" />
                <ItemStyle Font-Italic="True" />
            </asp:BoundField>
            <asp:BoundField DataField="AppointmentTime" HeaderText="AppointmentTime" SortExpression="AppointmentTime">
                <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" />
                <ItemStyle Font-Italic="True" />
            </asp:BoundField>
            <asp:BoundField DataField="AppointmentType" HeaderText="AppointmentType" SortExpression="AppointmentType">
                <HeaderStyle Font-Bold="True" Font-Italic="True" Width="250px" />
                <ItemStyle Font-Italic="True" Font-Bold="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle Font-Bold="True" Font-Italic="True" Width="220px" />
            <ItemStyle Font-Italic="True" Width="300px" />
            </asp:BoundField>
            <asp:ButtonField ButtonType="Button" CommandName="Approve" Text="Approve">
            <ControlStyle CssClass="btn btn-lg btn-success btn-block" />
            <ItemStyle Font-Italic="True" />
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="Reject" Text="Reject">
            <ControlStyle CssClass="btn btn-lg btn-danger btn-block" />
            <ItemStyle Font-Italic="True" />
            </asp:ButtonField>
        </Columns>
        <EmptyDataRowStyle Font-Bold="True" Font-Italic="True" ForeColor="Red" HorizontalAlign="Center" />
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
           </asp:GridView>
           <asp:SqlDataSource ID="SqlDsRequests" runat="server" ConnectionString="<%$ ConnectionStrings:ASEDataBase %>" SelectCommand="SELECT tbl_AppointmentRequests.AppointmentId,tbl_Student.SSO, tbl_Student.StudentName, tbl_AppointmentRequests.AppointmentDate, tbl_AppointmentRequests.AppointmentTime, tbl_AppointmentRequests.AppointmentType, tbl_AppointmentRequests.Description FROM tbl_AppointmentRequests INNER JOIN tbl_Student ON tbl_AppointmentRequests.SSO = tbl_Student.SSO AND tbl_AppointmentRequests.InstructorName = @t1 AND tbl_AppointmentRequests.AppointmentStatus = 'Pending'">
               <SelectParameters>
                   <asp:SessionParameter DefaultValue="Sumanth" Name="t1" SessionField="InstructorName" />
               </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

