<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>Free International Library</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
    </head>
    <script>
    
            var xmlHttp
            function showState(str){ 
                if (typeof XMLHttpRequest != "undefined"){
                    xmlHttp= new XMLHttpRequest();
                }
                else if (window.ActiveXObject){
                    xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
                }
                if (xmlHttp==null){
                    alert ("Browser does not support XMLHTTP Request")
                    return
                } 
                var url="regajax.jsp";
                url += "?count=" +str;
                xmlHttp.onreadystatechange = stateChange;
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
            function stateChange(){   
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
                    document.getElementById("rdisp").innerHTML=xmlHttp.responseText;  
                } 
            }
</script>
    <body>
 
     <div class="container">

      <!-- Static navbar -->
      <div class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../LibraryNew">Free International Library</a>
          </div>
          <div class="navbar-collapse collapse">
            
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="#">Register</a></li>
              <li><a href="#">About</a></li>
              <li><a href="#">Contact</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </div>
    
   
     <div class="navbar brand">
<div class="navbar-inner">
    <div class="container">
        <a class="brand" href="../LibraryNew/"><img src="images/librarylogo.png" /></a>
    </div>
</div>
</div>   
      
       <div class="container">
        <div class="page-header">
          <h1>Welcome to the Free International Library</h1>
        </div>
        <p class="lead">Register with us and check out any book from our library anytime that you need.</p>
        
      </div>
       
       
       
       
                                             <!-- Login Form -->
  <div class="col-md-4">
      <p class="text-primary text-center">Please Login Here</p>
     <form class="form-horizontal" role="form" action="LoginServlet" method="POST">
  <div class="form-group">
    <label for="uname" class="col-sm-2 control-label">Username</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="uname" name ="uname" placeholder="UserName" required="">
    </div>
  </div>
  <div class="form-group">
    <label for="pswd" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
        <input type="password" class="form-control" id="pswd" name="pswd" placeholder="Password" required="">
    </div>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Login</button>
    </div>      
  </div>
         
         <%
    String une1=(String)session.getAttribute("wrong");
    if(une1=="wrong")
    {
        out.println("<font color='red'>Entered Wrong Credentials</font>");
    
    
    }

%>
</form>
      
  </div>
                                             
                                             
  <div class="col-md-2"></div>
  
  
  
                             <!-- Registration Form -->
  <div class="col-md-4">
        <p class="text-primary text-center">Please Register  Here</p>

     <form class="form-horizontal" role="form" action="RegistrationServlet" method="POST">
  <div class="form-group">
    <label for="rname" class="col-sm-2 control-label">Name</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="rname" name ="rname" placeholder="Name" pattern="[a-zA-Z\s]*{3,10}" title="Name shouldn't have numeric's and special symbols "required="">
    </div>
  </div>
  <div class="form-group">
    <label for="runame" class="col-sm-2 control-label">Username</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="runame" name ="runame" placeholder="UserName" required="" onkeyup="showState(this.value)">
    </div>
  </div>
  <div class="form-group">
    <label for="rpswd" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
        <input type="password" class="form-control" id="rpswd" name="rpswd" placeholder="Password" required="">
    </div>
  </div>
<div class="form-group">
    <label for="rmobile" class="col-sm-2 control-label">Mobile</label>
    <div class="col-sm-10">
        <input type="tel" class="form-control" id="rmobile" name="rmobile" placeholder="Mobile Number"  pattern="[0-9]{10}" title="Mobile Number with 10 digits" required="">
    </div>
  </div>
    <div class="form-group">
    <label for="remail" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
        <input type="email" class="form-control" id="remail" name="remail" placeholder="Email Address" required="">
    </div>
  </div>
         <div id='rdisp' style="position:absolute;top:320px;left:130px;">  
 </div> 
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Register</button>
    </div>
              <%
    String une=(String)session.getAttribute("unameexists");
    if(une=="unexists")
    {
        out.println("<font color='red'>Username Exists.Choose another one</font>");
    
    
    }

%>
  </div>
</form>
         
  </div>
    </div>  
 
  
    <!-- Footer -->
     

      <div id="push"></div>
    </div>

    <div id="footer">
      <div class="container">
        <p class="muted credit">All Rights Reserved & Copyright &copy; <a href="../LibraryNew">The International Library</a> </p>
      </div>
    </div>
  
    </body>
</html>
