<%-- 
    Document   : bookreturndb
    Created on : Feb 19, 2014, 4:10:44 AM
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
        <%
        String unm=(String)session.getAttribute( "theName" );
        String bid=request.getParameter("bid");

Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/newdb" ,"library","admin");
            Statement stm=con.createStatement();
            String queryString = "update books set bookStatus=1 where bookId= ?"; 
              PreparedStatement pt2 = con.prepareStatement(queryString);
            pt2.setString(1, bid);
            
            int n2=pt2.executeUpdate();
  
            PreparedStatement pt = con.prepareStatement("delete from borrow where bookId= ?");
            pt.setString(1, bid);
            pt.executeUpdate();         
            if(n2>0)
                {
                session.setAttribute( "bookreturn", "yes");
                RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
                
                }
            else
                                 {
                session.setAttribute("bookreturn", "no");
                     RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
            }
        



%>
    </body>
</html>
