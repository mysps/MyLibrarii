import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteBook extends HttpServlet 
{
    public void init(ServletConfig config) throws ServletException
    { 
     super.init(config);
    }
   public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
   {
  String connectionURL = "jdbc:mysql://localhost:3306/newdb";
  Connection connection=null;
  ResultSet rs,rs1;
  String sql;
  res.setContentType("text/html");
  PrintWriter out = res.getWriter();
  String book=req.getParameter("dbook");
  try {         // Load the database driver
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                // Get a Connection to the database
                connection = DriverManager.getConnection(connectionURL, "library", "admin"); 
                //Add the data into the database
                Statement stal=connection.createStatement(); 
                sql = "select bookId from books where bookTitle='"+book+"'";
                rs = stal.executeQuery(sql);
                int bookId=0,flag=0;
               
                while(rs.next())
                {
                    bookId=rs.getInt("bookId");
                    flag=1;
                    break;
                }
                if(flag==1)
                {
                    
                    sql = "delete from books where bookId='"+bookId+"'";
                    stal.executeUpdate(sql); 
                    HttpSession s1=req.getSession(true); 
//                     s1.setAttribute("bookid", ""+bookId);
                    s1.setAttribute("bookdelete", "yes");
                     res.sendRedirect("adminpage.jsp");
                }
                else
                {
                     HttpSession s1=req.getSession(true); 
                   s1.setAttribute("bookdelete", "No");
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
