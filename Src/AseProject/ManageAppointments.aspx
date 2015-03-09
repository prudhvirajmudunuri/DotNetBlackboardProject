<%@ Page Title="" Language="C#" MasterPageFile="~/ASEMasterInstructor.master" AutoEventWireup="true" CodeFile="ManageAppointments.aspx.cs" Inherits="ManageAppointments" %>

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
             $('#<%=from.ClientID%>').datepicker({
                 defaultDate: "+1w",
                 changeMonth: true,
                 numberOfMonths: 1,
                 onClose: function (selectedDate) {
                     $('#<%=to.ClientID%>').datepicker("option", "minDate", selectedDate);
                 }
             });
             $('#<%=to.ClientID%>').datepicker({
                 defaultDate: "+1w",
                 changeMonth: true,
                 numberOfMonths: 1,
                 onClose: function (selectedDate) {
                     $('#<%=from.ClientID%>').datepicker("option", "maxDate", selectedDate);
                 }
             });
         });

</script>
    <div id="accordion">
  <h3>Set Appointments</h3>
  <div>
      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblFromDate" style="float:left;margin-right:5px;" runat="server" Text="Select From Date" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="from" name="from" class="form-control" placeholder="From Date" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
     </div>
      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblToDate" style="float:left;margin-right:5px;" runat="server" Text="Select To Date" Font-Bold="True" Font-Italic="True"></asp:Label>
           <asp:TextBox ID="to" name="to" class="form-control" placeholder="To Date" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
      </div>

       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblFromTime" style="float:left;margin-right:5px;" runat="server" Text="Select From Time" Font-Bold="True" Font-Italic="True"></asp:Label>
           <asp:TextBox ID="txtFromTime" name="to" class="form-control" placeholder="From Time" style="width:260px;margin-left:67px;display:block;float:left;" runat="server" required></asp:TextBox>
    <asp:DropDownList ID="ddlFromTime" CssClass="btn btn-default dropdown-toggle" style="width:140px;" runat="server" CausesValidation="True">
        <asp:ListItem>--SELECT--</asp:ListItem>
        <asp:ListItem>AM</asp:ListItem>
        <asp:ListItem>PM</asp:ListItem>
           </asp:DropDownList>
      </div>

      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblToTime" style="float:left;margin-right:5px;" runat="server" Text="Select To Time" Font-Bold="True" Font-Italic="True"></asp:Label>
           <asp:TextBox ID="txtToTime" name="to" class="form-control" placeholder="To Time" style="width:260px;margin-left:90px;display:block;float:left;" runat="server" required></asp:TextBox>
              <asp:DropDownList ID="ddlToTime" CssClass="btn btn-default dropdown-toggle" style="width:140px;" runat="server" CausesValidation="True">
        <asp:ListItem>--SELECT--</asp:ListItem>
        <asp:ListItem>AM</asp:ListItem>
        <asp:ListItem>PM</asp:ListItem>
           </asp:DropDownList>
      </div>

       <div class ="form-group" style="margin-left:200px;">   
    <asp:Label ID="lblDuration" style="float:left;margin-right:5px;" runat="server" Text="Duration of Appointment" Font-Bold="True" Font-Italic="True"></asp:Label>
                 <asp:TextBox ID="txtDuration" name="to" class="form-control" placeholder="Duration Of Appointment(in Minutes)" style="width:400px;margin-left:200px;" runat="server" required></asp:TextBox>

</div>
    <div class ="form-group" style="margin-left:200px;">   
    <asp:Label ID="lblSlots" style="float:left;margin-right:5px;" runat="server" Text="Max No Of Appointments" Font-Bold="True" Font-Italic="True"></asp:Label>
                 <asp:TextBox ID="txtMaxSlots" name="to" class="form-control" placeholder="Max No of Appointments" style="width:400px;margin-left:200px;" runat="server" required></asp:TextBox>

</div>
     
      
               <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Set Appointment" OnClick="btnSubmit_Click"/>
     <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Appointments Successfully Set </strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Can't Set Appointments</strong></div>
</div>
      </div>
  <h3>Cancel Appointments</h3>
  <div style="border-left:30px;">
        <asp:UpdatePanel ID="UpAppointments" runat="server">
            <ContentTemplate>
                 <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" OnPageIndexChanging="PageIndexChanging" PageSize="9" AllowPaging="True" EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date" DataFormatString="{0:D}" >
                <HeaderStyle HorizontalAlign="Center" Width="250px" Height ="35px"/>
                <ItemStyle HorizontalAlign="Center" Width="250px" Height ="35px" />
                </asp:BoundField>
                <asp:BoundField DataField="FromTime" HeaderText="From Time">
                <HeaderStyle HorizontalAlign="Center" Width="150px"/>
                <ItemStyle HorizontalAlign="Center" Width="150px"/>
                </asp:BoundField>
                <asp:BoundField DataField="ToTime" HeaderText="To Time" >
                <HeaderStyle HorizontalAlign="Center" Width="150px"/>
                <ItemStyle HorizontalAlign="Center" Width="150px"/>
                </asp:BoundField>
                <asp:BoundField DataField="AppointmentDuration" HeaderText="Duration" >
                <HeaderStyle HorizontalAlign="Center" Width="100px"/>
                <ItemStyle HorizontalAlign="Center" Width="100px"/>
                </asp:BoundField>
                <asp:BoundField DataField="MaxAppointments" HeaderText="Max Appointments" >
                <HeaderStyle HorizontalAlign="Center" Width="200px"/>
                <ItemStyle HorizontalAlign="Center" Width="200px"/>
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" HeaderText="Cancel Appointments">
                <ControlStyle CssClass="btn btn-lg btn-primary btn-block" />
                </asp:CommandField>
            </Columns>
            <EmptyDataRowStyle Font-Bold="True" Font-Italic="True" ForeColor="Red" HorizontalAlign="Center" VerticalAlign="Middle" />
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
                <asp:AsyncPostBackTrigger ControlID="gvAppointments" EventName="PageIndexChanging" />
            </Triggers>
        </asp:UpdatePanel>
  </div>
        </div>
</asp:Content>

