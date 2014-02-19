<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap-theme.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Librarian Administration</title>
<style type="text/css">
	.bs-example{
		margin: 20px;
	}
        
          #push,
      #footer {
        height: 60px;
      }
      #footer {
        background-color: #f5f5f5;
      }
</style>

      
</head>
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
       
    
    <!--Header Part-->
     <div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8"><h3 class="text-center"><p class="text-primary">Welcome back Librarian</p></h3></div>
  <div class="col-md-2">
      
      <form class="form-horizontal" role="form" action="LogoutServlet" method="POST">
       <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <p><br></p>
      <button type="submit" class="btn btn-primary">Log Out</button>
    </div>
       </div>
      </form> 
      
      
      
      
  </div>
    </div> 
    
    
    
    
<div class="bs-example">
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#sectionA">Create</a></li>
        <li><a data-toggle="tab" href="#sectionB">Read</a></li>
        <li ><a data-toggle="tab" href="#sectionC">Update</a></li>
        <li><a data-toggle="tab" href="#sectionD">Delete</a></li>
    </ul>
    <div class="tab-content">
        <div id="sectionA" class="tab-pane fade in active">
            <h3><p class="text-primary">Create a book here:</p></h3><!--Code for creating book-->
            
            
           <form class="form-horizontal" role="form" action="AdminServlet" method="POST">
  <div class="form-group">
    <label for="btitle" class="col-sm-2 control-label">Title</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="btitle" name ="btitle" placeholder="Book Title" required="">
    </div>
  </div>
   <div class="form-group">
    <label for="bpubl" class="col-sm-2 control-label">Publisher</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bpubl" name ="bpubl" placeholder="Book Publisher" required="">
    </div>
  </div>

   <div class="form-group">
    <label for="bcreator" class="col-sm-2 control-label">Author</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bcreator" name ="bcreator" placeholder="Book Creator" required="">
    </div>
  </div>
         
    <div class="form-group">
    <label for="bpage" class="col-sm-2 control-label">Book Pages</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bpage" name ="bpage" placeholder="Book Page" required="">
    </div>
  </div>
         
   <div class="form-group">
    <label for="bisbn" class="col-sm-2 control-label">Book ISBN</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bisbn" name ="bisbn" placeholder="Book ISBN" required="">
    </div>
  </div>    
   
   <div class="form-group">
    <label for="bdesc" class="col-sm-2 control-label">Description</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bdesc" name ="bdesc" placeholder="Book Description" required="">
    </div>
  </div>
    
         <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Add Book</button>
    </div>      
  </div>
         
   <%
    String une2=(String)session.getAttribute("book");
    if(une2=="exists")
    {
        out.println("<font color='red'>Book with same title exists Already, Enter unique details</font>");
    
    
    }else if(une2=="added")
       {
            out.println("<font color='red'>Book Added Sucessfully</font>");
       }

%>       
</form>  
 </div>       
      
                                                          <!--Code for Reading books-->
    
    
    
    <div id="sectionB" class="tab-pane fade">
            <h3><p class="text-primary">View Book Details here:</p></h3>
            <!--<p>Vestibulum nec erat eu nulla rhoncus fringilla ut non neque. Vivamus nibh urna, ornare id gravida ut, mollis a magna. Aliquam porttitor condimentum nisi, eu viverra ipsum porta ut. Nam hendrerit bibendum turpis, sed molestie mi fermentum id. Aenean volutpat velit sem. Sed consequat ante in rutrum convallis. Nunc facilisis leo at faucibus adipiscing.</p>-->
            <h3><p class="text-warning">Existing books in Library:</p></h3>
            <table class="table table-striped table-bordered">
                <tr>
                <th>Book Title</th>  
                <th>Author</th>
                </tr>
 <%
      Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb" ,"library","admin");
            String q="select * from books where bookStatus=1";
            PreparedStatement st = con.prepareStatement(q);
            ResultSet rs=(ResultSet)st.executeQuery();           
             while(rs.next()){ 
                 %>
                <TR>                    
                    <TD><%= rs.getString("bookTitle") %></TD>
                     <TD><%= rs.getString("bookCreator") %></TD> 

            </TR>
            <% } %>
             
            </table>
            
             <h3><p class="text-warning">Books Taken By Students:</p></h3>
            <table class="table table-striped table-bordered">
                <tr>
                <th>Book Title</th>  
                <th>Student Borrowed</th>
                </tr>
 <%
             Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection cone=DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb" ,"library","admin");
            String qq="select books.bookTitle,users.uname from books join borrow on books.bookId=borrow.bookId join users on borrow.userId=users.id;";
            PreparedStatement stt = cone.prepareStatement(qq);
            ResultSet rss=(ResultSet)stt.executeQuery();           
             while(rss.next()){ 
                 %>
                <TR>                    
                    <TD><%= rss.getString("bookTitle") %></TD>
                     <TD><%= rss.getString("uname") %></TD> 

            </TR>
            <% } %>
             
            </table>
            
            
            
            
        </div>




                                                        <!--Code for Update books-->


        <div id="sectionC" class="tab-pane fade ">
            <h3><p class="text-primary">Update Book Details Here:</p></h3>
             <form class="form-horizontal" role="form" action="UpdateBook" method="POST">
    
    <div class="form-group">
         <label for="delete" class="col-sm-2 control-label">Book To Update</label>
     <div class="col-sm-10">
        <select name="ubook"  class="selectpicker" id="dbook">
        <option value="-1" selected disabled>Select a Book</option>   
<%
        try{
            String dbURL = "jdbc:mysql://localhost:3306/newdb";
            String user = "library";
            String pwd = "admin";
            String driver = "com.mysql.jdbc.Driver";            
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(dbURL, user, pwd);
            String query="select bookTitle from books where bookStatus=1 ";
            ResultSet rs2;
            String bn=null;
            Statement statement = conn.createStatement();
            rs2=statement.executeQuery(query);
            while(rs2.next())
            {
               bn=rs2.getString("bookTitle");%>	
			<option value="<%=bn%>"><%=bn%></option>
                        <% 
//                System.out.println(bn);
            }
                       }
            catch(Exception e)
            {
                e.printStackTrace();
            }



%>
</select>
    </div>     
    </div> 
<div class="form-group">
    <label for="ubpubl" class="col-sm-2 control-label ">New Title</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bpubl" name ="untitle" placeholder="New Title" required="">
    </div>
  </div>
 <div class="form-group">
    <label for="ubpubl" class="col-sm-2 control-label ">Publisher</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bpubl" name ="ubpubl" placeholder="New Book Publisher" required="">
    </div>
  </div>

   <div class="form-group">
    <label for="ubcreator" class="col-sm-2 control-label">Author</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bcreator" name ="ubcreator" placeholder="New Book Creator" required="">
    </div>
  </div>
         
    <div class="form-group">
    <label for="ubpage" class="col-sm-2 control-label">Book Pages</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bpage" name ="ubpage" placeholder="New Book Page" required="">
    </div>
  </div>
         
   <div class="form-group">
    <label for="ubisbn" class="col-sm-2 control-label">Book ISBN</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bisbn" name ="ubisbn" placeholder="New Book Page" required="">
    </div>
  </div>    
   
   <div class="form-group">
    <label for="ubdesc" class="col-sm-2 control-label">Description</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="bdesc" name ="ubdesc" placeholder="New Book Description" required="">
    </div>
  </div>
   
     <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Update This Book</button>
    </div>         
     </div>   </form> 

<%
          
    String ubookup=(String)session.getAttribute("booksupdated");
//     String bookid=(String)session.getAttribute("bookid");
    if(ubookup=="yes")
    {
        out.println("<font color='red'>Book Updated Sucessfully...</font>");
    }
       else if(ubookup=="no")
       {
           out.println("<font color='red'>Some thing went wrong</font>");
       }
//    session.invalidate(); 
   
%>


        </div>

       
       
                                                    <!--Code for Deleting books-->




        <div id="sectionD" class="tab-pane fade">
            
         
            <h3><p class="text-primary">Delete Books here:</p></h3>
           
        <form class="form-horizontal" role="form" action="DeleteBook" method="POST">
     
    <div class="form-group">  
        <label for="delete" class="control-label col-sm-2">Title</label>
    <div class="col-sm-10">        
        <select name="dbook"  class="selectpicker" id="dbook">
        <option value="-1" selected disabled>Select a Book</option>   
<%
        try{
            String dbURL = "jdbc:mysql://localhost:3306/newdb";
            String user = "library";
            String pwd = "admin";
            String driver = "com.mysql.jdbc.Driver";            
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(dbURL, user, pwd);
            String query="select bookTitle from books where bookStatus=1 ";
            ResultSet rs2;
            String bn=null;
            Statement statement = conn.createStatement();
            rs2=statement.executeQuery(query);
            while(rs2.next())
            {
               bn=rs2.getString("bookTitle");%>	
			<option value="<%=bn%>"><%=bn%></option>
                        <% 
                System.out.println(bn);
            }
                       }
            catch(Exception e)
            {
                e.printStackTrace();
            }



%>
</select>
    </div>     
    </div>         
     <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Delete This Book</button>
    </div>
          <%
          
    String dbook=(String)session.getAttribute("bookdelete");
//     String bookid=(String)session.getAttribute("bookid");
    if(dbook=="yes")
    {
        out.println("<font color='red'>Book Deleted Sucessfully...</font>");
    }
     
   
%>
     </div>          
               
           </form>  
    </div> </div>
     
      <!-- Footer -->
     

      <div id="push"></div>
    </div>

    <div id="footer">
      <div class="container">
        <p class="muted credit">All Rights Reserved & Copyright &copy; <a href="../LibraryNew">The International Library</a> </p>
      </div>
    </div>
</div>
     
     
</body>
</html>                                		