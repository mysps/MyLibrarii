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

public class LoginServlet extends HttpServlet 
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
  //get the variables entered in the form 
  String uname = req.getParameter("uname");
  String pswd=req.getParameter("pswd");  
  try {
      
      if(uname.equalsIgnoreCase("admin")&&pswd.equalsIgnoreCase("admin"))//if admin show other page
      {
          res.sendRedirect("adminpage.jsp");
      }
      else{
                // Load the database driver
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                // Get a Connection to the database
                connection = DriverManager.getConnection(connectionURL, "library", "admin"); 
                //Add the data into the database
                Statement stal=connection.createStatement(); 
                sql = "select uname,pswd from users where uname='"+uname+"' and pswd='"+pswd+"'";
                rs = stal.executeQuery(sql);
                int flag=0;
               
                while(rs.next())
                {
                    if(rs.getString("uname").equals(uname)&&rs.getString("pswd").equals(pswd))
                    {
                        flag=1;
                        break;
                    }
                }
                if(flag==1)
                {
                    HttpSession s1=req.getSession(true); 
                    s1.setAttribute("screenname", uname);
                    res.sendRedirect("UserPage.jsp");

                }
                else
                {
                     HttpSession s1=req.getSession(true); 
                    s1.setAttribute("wrong", "wrong");
                     res.sendRedirect("index.jsp");
                }
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
