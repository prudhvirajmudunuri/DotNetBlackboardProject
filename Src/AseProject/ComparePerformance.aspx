<%@ Page Title="" Language="C#" MasterPageFile="~/AseMaster.master" AutoEventWireup="true" CodeFile="ComparePerformance.aspx.cs" Inherits="ComparePerformance" %>

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

      <script type="text/javascript" src="JS/amcharts.js"></script>
<script type="text/javascript" src="JS/serial.js"></script>
     <style>
       #chartdiv {
	width		: 100%;
	height		: 435px;
	font-size	: 11px;
}	
       h1 {
  font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
  font-weight:700;
  font-style:italic;
}

.border {
  border: 2px solid #393939;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  border-radius: 10px;
  -webkit-box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);
  -moz-box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);
  box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);

}

label {
  display: block;
  margin-left: 3px;
  padding-top: 2px;
  text-shadow: 2px 2px 3px rgba(150, 150, 150, 0.75);
  font-family:Verdana, Geneva, sans-serif;
  font-size:.9em;
}

legend {
  text-shadow: 2px 2px 3px rgba(150, 150, 150, 0.75);
  font-family:Verdana, Geneva, sans-serif;
  font-size:1.4em;
  border-top: 2px solid #009;
  border-bottom:2px solid #009;
  border-left: 2px solid #009;
  border-right:  2px solid #009;
  border-radius: 10px;
  -webkit-box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);
  -moz-box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);
  box-shadow: 4px 4px 5px rgba(50, 50, 50, 0.75);
  padding: 3px;
}

.inline {
  display:inline-block;
}

   </style>
     <script>
         function BarChart(t1,t2,t3,t4,t5) {
             var t1 = t1;
             var t2 = t2;
             var t3 = t3;
             var t4 = t4;
             var t5 = t5;
             var chart = AmCharts.makeChart("chartdiv", {
                 "theme": "none",
                 "type": "serial",
                 "startDuration": 2,
                 "dataProvider": [{
                     "country": "90-100",
                     "visits": t1,
                     "color": "#FF0F00"
                 }, {
                     "country": "80-90",
                     "visits": t2,
                     "color": "#FF6600"
                 }, {
                     "country": "70-80",
                     "visits": t3,
                     "color": "#FF9E01"
                 }, {
                     "country": "60-70",
                     "visits": t4,
                     "color": "#FCD202"
                 }, {
                     "country": "below 60",
                     "visits": t5,
                     "color": "#F8FF01"
                 }],
                 "valueAxes": [{
                     "position": "left",
                     "axisAlpha": 0,
                     "gridAlpha": 0
                 }],
                 "graphs": [{
                     "balloonText": "[[category]]: <b>[[value]]</b>",
                     "colorField": "color",
                     "fillAlphas": 0.85,
                     "lineAlpha": 0.1,
                     "type": "column",
                     "topRadius": 1,
                     "valueField": "visits"
                 }],
                 "depth3D": 40,
                 "angle": 30,
                 "chartCursor": {
                     "categoryBalloonEnabled": false,
                     "cursorAlpha": 0,
                     "zoomable": false
                 },
                 "categoryField": "country",
                 "categoryAxis": {
                     "gridPosition": "start",
                     "axisAlpha": 0,
                     "gridAlpha": 0

                 },
                 "exportConfig": {
                     "menuTop": "20px",
                     "menuRight": "20px",
                     "menuItems": [{
                         "icon": '/lib/3/images/export.png',
                         "format": 'png'
                     }]
                 }
             }, 0);
         }
         jQuery('.chart-input').off().on('input change', function () {
             var property = jQuery(this).data('property');
             var target = chart;
             chart.startDuration = 0;

             if (property == 'topRadius') {
                 target = chart.graphs[0];
             }

             target[property] = this.value;
             chart.validateNow();
         });
    </script>



    <div id="accordion">
  <h3>Analyze Performance</h3>
  <div>
       <div class ="form-group" style="margin-left:370px;">
           <br />
          <asp:Label ID="lblHeading" runat="server" Text="Analyze Performance" Font-Bold="True" Font-Italic="True" Font-Size="X-Large" ForeColor="#333300"></asp:Label>
           <br />
           <br />
           <br />
            </div>
       <div class ="form-group" style="margin-left:200px;">
    <asp:Label ID="lblCourse" style="float:left;margin-right:140px;" runat="server" Text="Select Course" Font-Bold="True" Font-Italic="True"></asp:Label>
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
         <asp:DropDownList ID="ddlAssessment" CssClass="btn btn-default dropdown-toggle" style="width:400px;" runat="server" Visible="False"> 
         </asp:DropDownList>
     </div>
    
</br>
      </br>
           <asp:Button ID="btnSubmit" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:350px;" runat="server" Text="Analyze" OnClick="btnSubmit_Click"/>
          </br>
      </br>
        <asp:UpdatePanel ID="upGraph" runat="server" Visible="False">
            <ContentTemplate>
                                       <div class="alert alert-info alert-dismissible" id="diverror" runat="server" role="alert">
 <div style="margin-left:140px;"></span>
  <span class="sr-only">Error:</span><strong>Course: <asp:Label ID="lblCourseId" runat="server" Text="Label"></asp:Label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  Course Strength: <asp:Label ID="lblStrength" runat="server" Text="Label"></asp:Label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  Position: <asp:Label ID="lblPosition" runat="server" Text="Label"></asp:Label> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Percentage: <asp:Label ID="lblPercentage" runat="server" Text="Label"></asp:Label> </strong></div>
</div>
                 <fieldset class="border">
     <legend>Visualization</legend> 
                      <div id="chartdiv"></div>
<div class="container-fluid">
  <div class="row text-center" style="overflow:hidden;">
		<div class="col-sm-3" style="float: none !important;display: inline-block;">
			
		</div>

		<div class="col-sm-3" style="float: none !important;display: inline-block;">
			
		</div>

		<div class="col-sm-3" style="float: none !important;display: inline-block;">
			
		</div>
	</div>
</div></fieldset>
            </ContentTemplate>
        </asp:UpdatePanel>
                
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

