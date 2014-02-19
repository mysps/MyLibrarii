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
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>User Book Borrow</title>
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
        
<%        
String name=(String)session.getAttribute("screenname");
//out.println("<font face='chiller' color='brown' size='5px'>"+name+"</font>"); 
%>
<!--Header Part-->
     <div class="row">
  <div class="col-md-2"></div>
  <div class="col-md-8"><h3 class="text-center"><p class="text-primary">Welcome Back: <%=name%></p></h3></div>
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
        <li class="active"><a data-toggle="tab" href="#sectionA">Books Available</a></li>
        <li><a data-toggle="tab" href="#sectionB">Return Books</a></li>
        <li ><a data-toggle="tab" href="#sectionC">Books Borrowed</a></li>
        
    </ul>
    <div class="tab-content">
        <div id="sectionA" class="tab-pane fade in active">
            <table class="table table-striped table-bordered">
                
                <h3><p class="text-primary">Please click on the book to borrow</p></h3>
            <%session.setAttribute( "theName", name );
       
    Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/newdb" ,"library","admin");
            String q="select * from books where bookStatus=1";
            PreparedStatement st = con.prepareStatement(q);
          
            
            ResultSet rs=(ResultSet)st.executeQuery();
    %>
            
    <TR>
<TH>Book ID</TH>
                <TH>Book Title</TH>
                <TH>Book Publisher</TH>
                <th>Book Author</th>
                <TH>Book Pages</TH>
                <TH>Book ISBN</TH>
                 <TH>Book Description</TH>
                 


            </TR>
            <% while(rs.next()){ %>

                <TR>
                    <TD><%=rs.getString("bookId")%></TD>
                    <TD><a href=<%= "\"bkorderdb.jsp?bkt=" + rs.getString("bookTitle") +"&bid="+rs.getString("bookId")+ "\"" %> ><%= rs.getString("bookTitle") %></a></TD>
                    
                    <TD><%=rs.getString("bookPublisher")%></TD>
                    <TD><%=rs.getString("bookCreator")%></TD>
                    <TD><%=rs.getString("bookPage")%></TD>
                    <td><%=rs.getString("bookIsbn")%></td>
                    <td><%=rs.getString("bookDescription")%></td>
                    





            </TR>
            <% } %>
            </table>
             
          <%
          
    String dbook=(String)session.getAttribute("bookorder");
//     String bookid=(String)session.getAttribute("bookid");
    if(dbook=="yes")
    {
        out.println("<font color='green'>Book Added to your cart. To view open the Books Taken TAB</font>");
        %><h3><p class="text-primary">You Have 7 days to return book</p></h3><%
        request.getSession(true).removeAttribute("bookorder");
    }
       else if(dbook=="no")
        {
        out.println("<font color='red'>Some thing went wrong</font>");
        request.getSession(true).removeAttribute("bookorder");
    }
        
     
   
%>
    
        </div>
       
     
     
                                                          <%-- books return --%>
         <div id="sectionB" class="tab-pane fade"> 
         <h3><p class="text-primary">Click on the book you want to return:</p></h3>
            <table class="table table-striped table-bordered">
             
                     <%
                     
                     //String name = request.getParameter( "usrnm" );
                    
    Class.forName("com.mysql.jdbc.Driver").newInstance();
            //Connection con=DriverManager.getConnection("jdbc:mysql://localhost/library" ,"library","admin");
            String q4="select * from users where uname=?";
            PreparedStatement st4 = con.prepareStatement(q4);
            st4.setString(1,name);
            ResultSet rs4=(ResultSet)st4.executeQuery();
            while(rs4.next())
            {
            String mid=rs4.getString("id");
            session.setAttribute( "mids", mid );
            }
            String mid3=(String)session.getAttribute("mids");
            String q5="select * from books where bookId in(Select bookId from borrow where userId=? )";
            PreparedStatement st5 = con.prepareStatement(q5);
          st5.setString(1,mid3);
            
            ResultSet rs5=(ResultSet)st5.executeQuery();
    %>
     <TR>
<TH>Book ID</TH>
                <TH>Book Title</TH>
                <TH>Book Publisher</TH>
                <th>Book Author</th>
                <TH>Book Pages</TH>
                <TH>Book ISBN</TH>
                 <TH>Book Description</TH>
                  


            </TR>
                <% while(rs5.next()){ %>

                <TR>
                    <TD><%=rs5.getString("bookId")%></TD>
                    <TD><a href=<%= "\"bookreturndb.jsp?bkt=" + rs5.getString("bookTitle") +"&bid="+rs5.getString("bookId")+ "\"" %> ><%= rs5.getString("bookTitle") %></a></TD>
                    
                    <TD><%=rs5.getString("bookPublisher")%></TD>
                    <TD><%=rs5.getString("bookCreator")%></TD>
                    <TD><%=rs5.getString("bookPage")%></TD>
                    <td><%=rs5.getString("bookIsbn")%></td>
                    <td><%=rs5.getString("bookDescription")%></td>
                   





            </TR>
            <% } %>
    </table>
          <%
          
    String rbook=(String)session.getAttribute("bookreturn");
//     String bookid=(String)session.getAttribute("bookid");
    if(rbook=="yes")
    {
        out.println("<font color='red'>Book returned Sucessfully...</font>");
        request.getSession(true).removeAttribute("bookreturn");
    }
       else if(rbook=="no")
        {
        out.println("<font color='red'>Some thing went wrong</font>");
        request.getSession(true).removeAttribute("bookreturn");
    }
        
     
   
%>
         
         </div>
    
         
    
     
     
     
     
<%-- books taken --%>
         <div id="sectionC" class="tab-pane fade">
             <h3><p class="text-primary">Books you have borrowed:</p></h3>
            <table class="table table-striped table-bordered">
             
                     <%
                     
                     //String name = request.getParameter( "usrnm" );
                    
    Class.forName("com.mysql.jdbc.Driver").newInstance();
            //Connection con=DriverManager.getConnection("jdbc:mysql://localhost/library" ,"library","admin");
            String q1="select * from users where uname=?";
            PreparedStatement st2 = con.prepareStatement(q1);
            st2.setString(1,name);
            ResultSet rs2=(ResultSet)st2.executeQuery();
            while(rs2.next()){
           String mid=rs2.getString("id");
            session.setAttribute( "mids", mid );
            }
            String mid2=(String)session.getAttribute("mids");
            String q3="select * from books where bookId in(Select bookId from borrow where userId=? )";
            PreparedStatement st3 = con.prepareStatement(q3);
          st3.setString(1,mid2);
            
            ResultSet rs3=(ResultSet)st3.executeQuery();
    %>
     <TR>
<TH>Book ID</TH>
                <TH>Book Title</TH>
                <TH>Book Publisher</TH>
                <th>Book Creator</th>
                <TH>Book Page</TH>
                <TH>Book Lsbn</TH>
                 <TH>Book Description</TH>
                  


            </TR>
                <% while(rs3.next()){ %>

                <TR>
                    <TD><%=rs3.getString("bookId")%></TD>
                    <TD><%= rs3.getString("bookTitle") %></a></TD>
                    
                    <TD><%=rs3.getString("bookPublisher")%></TD>
                    <TD><%=rs3.getString("bookCreator")%></TD>
                    <TD><%=rs3.getString("bookPage")%></TD>
                    <td><%=rs3.getString("bookIsbn")%></td>
                    <td><%=rs3.getString("bookDescription")%></td>
                   





            </TR>
            <% } %>
    </table>
             
             
             
         </div> 
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
