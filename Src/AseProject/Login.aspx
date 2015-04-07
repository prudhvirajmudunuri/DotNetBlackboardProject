<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
     <link href="css/bootstrap.min.css" rel="stylesheet"/>
     <link href="css/navbar.css" rel="stylesheet"/>
    <script>
        function service(Name,passwd)
        {
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
                $.get("http://localhost:49177/AseProject/Service.svc/name/passwd", function (data) {
                    var json = {
                        json: JSON.stringify(data),
                        delay: 1
                    };
                    echo(json);
                });
            });
        }
        </script>
</head>
    <body>
 <!-- Fixed navbar -->
        <div>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">The Campus Network</a>
        </div>
      </div>
    </nav></div>
        </br>
        </br>
         <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img src="images/1.jpg" style="width:1200px;margin-left:83px;" alt="Second slide"/>  
        </div>
        <div class="item">
          <img src="images/2.jpg" style="width:1200px;margin-left:83px;" alt="Third slide"/>
        </div>
           <div class="item">
          <img src="images/3.jpg" style="width:1200px;margin-left:83px;" alt="First slide"/>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div><!-- /.carousel -->

    <!-- Begin page content -->
    
     <form class="form-signin" runat="server">
        <h2 class="form-signin-heading" style="margin-left:500px;">Please sign in</h2>
        
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" style="width:400px;margin-left:500px;" runat="server" required autofocus/>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" style="width:400px;margin-left:500px;" runat="server" required/>
        <div class="checkbox">
            <input id="Checkbox1" type="checkbox" value="remember-me" style="margin-left:500px;" runat="server"/> 
          <label style="margin-left:500px;">Remember me</label>
            
          
        </div>
         <asp:Button ID="btnLogin" CssClass="btn btn-lg btn-primary btn-block" style="width:400px;margin-left:500px;" runat="server" Text="Sign In" OnClick="btnLogin_Click"/>
         <div class="alert alert-danger alert-dismissible" id="diverror" runat="server" role="alert">
 <div style="margin-left:580px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! Incorrect Password.</strong></div>
</div>
                <div class="alert alert-danger alert-dismissible" id="diverror2" runat="server" role="alert">
                    
 <div style="margin-left:580px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span><strong>Error! User does not Exist. </strong></div>
</div>
         <asp:Label ID="lblErrorMessage" style="margin-left:650px;" runat="server" Font-Bold="True" Font-Italic="True"></asp:Label>
      </form>
   

    <footer class="footer">
      <div class="container">
        <p class="text-muted">All Rights Reserved. ASE @PG7</p>
      </div>
    </footer>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

