<%-- 
    Document   : regisdb
    Created on : Feb 17, 2014, 8:50:48 PM
    Author     : Sylita Thomas
--%>



<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BK</title>
    </head>
    <body>
        
        <%
            String unm=(String)session.getAttribute( "theName" );
            String bid=request.getParameter("bid");//book title taken
            session.setAttribute( "bid", bid);//book id taken
            Statement stm=null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost/newdb" ,"library","admin");
            stm = (Statement) con.createStatement();
             String q="select * from users where uname=?";//to get userid of user by his.her username
            PreparedStatement st = con.prepareStatement(q);
            st.setString(1,unm);
            ResultSet rs=(ResultSet)st.executeQuery();
            while(rs.next())
            {
                String mid=rs.getString("id");
                session.setAttribute( "mids", mid );//set userid to mids session variable
            }
            Date dNow = new Date( );
   SimpleDateFormat ft =new SimpleDateFormat ("yyyy.MM.dd ");
  
   String mid2=(String)session.getAttribute("mids");
    Calendar cal = Calendar.getInstance();
cal.setTime(new Date());
int num =7; // here is a number of days to add/subtract
// add number of days
cal.add(Calendar.DATE ,num);
Date ed = cal.getTime();
//and now formatting the date to meet ur requirements,I prefer
// dd.MM.yy
SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
String end_date = formatter.format(ed);
          
           
            PreparedStatement pt=con.prepareStatement("insert into borrow values(null,?,?,?,?)");
            
            pt.setString(1,mid2);
            pt.setString(2,ft.format(dNow));
             pt.setString(3,end_date);
            pt.setString(4,bid);
            String queryString = "update books set bookStatus=0 where bookId= ?"; 
              PreparedStatement pt2 = con.prepareStatement(queryString);
            pt2.setString(1, bid);
            int n=pt.executeUpdate();
            int n2=pt2.executeUpdate();
           
            if(n>0)
                {
                session.setAttribute( "bookorder", "yes");
                RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
                
                }
            else
                                 {
                session.setAttribute("bookdelete", "no");
                     RequestDispatcher rd=request.getRequestDispatcher("UserPage.jsp");
        rd.forward(request, response);
            }
       

        %>
        
    </body>
</html>

