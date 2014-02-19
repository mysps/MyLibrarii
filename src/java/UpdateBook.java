import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateBook extends HttpServlet 
{
    public void init(ServletConfig config) throws ServletException
    { 
     super.init(config);
    }
   public void doPost(HttpServletRequest request,HttpServletResponse res) throws ServletException, IOException
   {
  String connectionURL = "jdbc:mysql://localhost:3306/newdb";
  Connection connection=null;
  ResultSet rs,rs1;
  int a;
  String sql;
  res.setContentType("text/html");
  PrintWriter out = res.getWriter();
  String book=request.getParameter("dbook");
  try {  
                String booktoupdate=request.getParameter("ubook");
                String bookTitle=request.getParameter("untitle");
                String bookPublisher=request.getParameter("ubpubl");
                String bookCreator=request.getParameter("ubcreator");
                String bookPage=request.getParameter("ubpage");
                String bookIsbn=request.getParameter("ubisbn");
                String bookDescription=request.getParameter("ubdesc");
//                String bookPrice=request.getParameter("ubprice");
               // Load the database driver
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                // Get a Connection to the database
                connection = DriverManager.getConnection(connectionURL, "library", "admin"); 
                //Add the data into the database
                Statement stal=connection.createStatement(); 
                sql ="update books set bookTitle=?,bookPublisher=?,bookCreator=?,bookPage=?,bookIsbn=?,bookDescription=?,bookPrice=? where bookTitle='"+booktoupdate+"'";
                PreparedStatement pt2 = connection.prepareStatement(sql);
                pt2.setString(1, bookTitle);
                pt2.setString(2, bookPublisher);
                pt2.setString(3, bookCreator);
                pt2.setString(4, bookPage);
                pt2.setString(5, bookIsbn);
                pt2.setString(6, bookDescription);
                pt2.setString(7,"1111");
                a=pt2.executeUpdate();
                if(a>0)
                {
                    HttpSession s1=request.getSession(true); 
                    s1.setAttribute("booksupdated", "yes");
                    res.sendRedirect("adminpage.jsp");
                }
                else
                {
                    HttpSession s1=request.getSession(true); 
                    s1.setAttribute("booksupdated", "no");
                    res.sendRedirect("adminpage.jsp");
                }
     
  }
  catch(ClassNotFoundException e){
  out.println("Couldn't load database driver: " 
  + e.getMessage());
  }
  catch(SQLException e)
  {    
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
