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
           <asp:TextBox ID="txtFromTime" name="to" class="form-control" placeholder="From Time" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
      </div>

      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblToTime" style="float:left;margin-right:5px;" runat="server" Text="Select To Time" Font-Bold="True" Font-Italic="True"></asp:Label>
           <asp:TextBox ID="txtToTime" name="to" class="form-control" placeholder="To Time" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
      </div>
    <div class ="form-group" style="margin-left:200px;">   
    <asp:Label ID="lblSlots" style="float:left;margin-right:5px;" runat="server" Text="Max No Of Appointments" Font-Bold="True" Font-Italic="True"></asp:Label>
                 <asp:TextBox ID="txtMaxSlots" name="to" class="form-control" placeholder="Max No of Appointments" style="width:400px;margin-left:200px;" runat="server" required></asp:TextBox>

</div>
      
               <asp:Button ID="btnLogin" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Sign In"/>
      </div>
  <h3>Cancel Appointments</h3>
  <div>
    <p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna. </p>
  </div>
        </div>
</asp:Content>

