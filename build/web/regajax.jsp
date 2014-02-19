

<%@page language="java" import ="java.sql.*" %>  
 <%  
 String name=request.getParameter("count");  
 String buffer=null;  
 Class.forName("com.mysql.jdbc.Driver").newInstance();  
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb","library","admin");  
 Statement stmt = con.createStatement();  
 ResultSet rs = stmt.executeQuery("select uname from users where uname='"+name+"'");  
   while(rs.next()){
       buffer=rs.getString(1);
   //buffer=buffer+rs.getString(1)+"<br>";  
   }
if(name==null||name.length()<5||name.length()>20)
buffer="<div><br><font color='red'>User name should be 5 to 10 characters ...</font>"     ;
 else if(buffer==null)
 buffer="<div><br><font color='green'>You can take this...</font>"+"</div>";  
 else
     buffer="<div><font color='red'>UserName Already Exists</font>";
 response.getWriter().println(buffer);  
 con.close();
 %>
