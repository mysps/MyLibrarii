<%-- 
    Document   : regisdb
    Created on : Feb 17, 2014, 8:50:48 PM
    Author     : Sylita Thomas
--%>



<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        String fnm=request.getParameter("name");
        String unm=request.getParameter("rname");
        String eml=request.getParameter("remail");
        String pwd=request.getParameter("rpswd");
        String mobile=request.getParameter("rmobile");
        
        Statement stm=null;
       try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/library" ,"library","admin");
            stm = (Statement) con.createStatement();
            PreparedStatement pt=con.prepareStatement("insert into users values(null,?,?,?,?,?,?)");
            pt.setString(1,fnm);
            pt.setString(2,eml);
            pt.setString(3,pwd);
            pt.setString(4,mobile);
            int n=pt.executeUpdate();
            if(n>0)
                {
                RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
                out.println("<h1>insert success</h1>");
                }
            else
                out.println("<h1>insert failure</h1>");
                  }
       catch(Exception e)
        {
        %><script>alert("user name already exits");</script><%
        }

        %>
    </body>
</html>

