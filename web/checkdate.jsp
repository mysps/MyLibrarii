<%-- 
    Document   : checkdate
    Created on : Feb 18, 2014, 7:06:07 AM
    Author     : Sylita Thomas
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <table BORDER="1" width="150%">
             <%String name = (String)session.getAttribute("screenname");
session.setAttribute( "theName", name );
       %>
                     <%
                     
                     
                    
    Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/newdb" ,"library","admin");
            Statement stm=con.createStatement();
    ResultSet rs=(ResultSet)stm.executeQuery("select * from borrow");
    Calendar now = Calendar.getInstance();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    String nowStr = df.format(new Date());
    while(rs.next())
               {
        String brwfinish=rs.getString("borrowFinish");
        String bid=rs.getString("bookId");
        
        if(brwfinish.equals(nowStr))
                       {
            
                     String queryString = "update books set bookStatus=1 where bookId= ?"; 
              PreparedStatement pt2 = con.prepareStatement(queryString);
            pt2.setString(1, bid);
            
            int n2=pt2.executeUpdate();          
            
            RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
        }
        else
                       {
            RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
            
        }
               
    }
  
    
       %>
    </body>
</html>
