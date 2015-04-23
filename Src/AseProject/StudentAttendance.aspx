<%@ Page Title="" Language="C#" MasterPageFile="~/AseMaster.master" AutoEventWireup="true" CodeFile="StudentAttendance.aspx.cs" Inherits="StudentAttendance" %>

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
  <h3>Mark Attendance</h3>
  <div>
     <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Mark Attendance" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
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
     </div>

      <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblappdate" style="float:left;margin-right:25px;" runat="server" Text="Select Date" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="Date" name="from" class="form-control" placeholder="Select Date" style="width:400px;margin-left:220px;" runat="server" required></asp:TextBox>
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
    <asp:Label ID="lblCode" style="float:left;margin-right:5px;" runat="server" Text="Code" Font-Bold="True" Font-Italic="True"></asp:Label>
      <asp:TextBox ID="txtCode" name="from" class="form-control" placeholder="Attendance Code" style="width:400px;margin-left:220px;" runat="server" ClientIDMode="Static" required></asp:TextBox>
     </div>
   <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:300px;" runat="server" Text="Mark Attendance" OnClick="btnSubmit_Click"/>
      <div class="alert alert-success alert-dismissible" id="divSuccess" runat="server" role="alert">
       <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span><strong>Attendance Marked Successfully</strong></div>
</div>
       <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Attendance Code Expired</strong></div>
</div>

      <div class="alert alert-danger alert-dismissible" id="diverror2" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Incorrect Attendance Code</strong></div>
</div>

      
      <div class="alert alert-danger alert-dismissible" id="divError3" runat="server" role="alert">
                    
 <div style="margin-left:350px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! You Need To Be in Class To Mark Attendance</strong></div>
</div>
      </div>   
 </div>
</asp:Content>

