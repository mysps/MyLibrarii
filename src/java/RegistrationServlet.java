/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.Date;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegistrationServlet extends HttpServlet 
{
    public void init(ServletConfig config) throws ServletException{
      
  super.init(config);
  }
  /**Process the HTTP Get request*/
   public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
   {
  String connectionURL = "jdbc:mysql://localhost:3306/newdb";
  Connection connection=null;
  ResultSet rs;
  String sql;
  res.setContentType("text/html");
  PrintWriter out = res.getWriter();
   DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
    Date d = new Date();
  //get the variables entered in the form
  String name = req.getParameter("rname"); 
  String uname = req.getParameter("runame");
  String pswd=req.getParameter("rpswd");
  String email = req.getParameter("remail"); 
  String mobile = req.getParameter("rmobile");
  String date = dateFormat.format(d);
  try {
  // Load the database driver
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  // Get a Connection to the database
  connection = DriverManager.getConnection(connectionURL, "library", "admin"); 
  //Add the data into the database
  Statement stal=connection.createStatement();  
  //before adding need to check wheter same username exists or not
  sql = "select uname from users where uname='"+name+"'";
  rs = stal.executeQuery(sql);
  if(rs.wasNull())
  {
        HttpSession s1=req.getSession(true);
        s1.setAttribute("username",uname);
        sql ="insert into users values(null,?,?,?,?,?,?)";
        PreparedStatement pst =  connection.prepareStatement(sql);
        pst.setString(1,name);
        pst.setString(2,uname);
        pst.setString(3,pswd);
        pst.setString(4,mobile);
        pst.setString(5,email);
        pst.setString(6,date);  
        int numRowsChanged = pst.executeUpdate();
         HttpSession s=req.getSession(true);
         s.setAttribute("screenname", name);  
        res.sendRedirect("UserPage.jsp");
        pst.close();
  }
  else
  {
      HttpSession s1=req.getSession(true);
        s1.setAttribute("unameexists","unexists");
        res.sendRedirect("index.jsp");
  }
  
  
  
  
  
  
  
  }
  catch(ClassNotFoundException e){
  out.println("Couldn't load database driver: " 
  + e.getMessage());
  }
  catch(SQLException e)
  {
  HttpSession sal=req.getSession(true);
     sal.setAttribute("screenname", "Error occured");     
     res.sendRedirect("UserPage.jsp");
     out.println(""+e.getMessage());
 
  }
  catch (Exception e){
  out.println(e);
  }
  finally {
  // Always close the database connection.
     // res.sendRedirect("sampleregis.html");
  try {
  if (connection != null) connection.close();
  }
  catch (SQLException ignored){
  out.println(ignored);
  }
  }
  }
 
}
