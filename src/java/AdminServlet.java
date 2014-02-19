/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author sylita
 */
public class AdminServlet extends HttpServlet 
{

     public void init(ServletConfig config) throws ServletException
     {
      
         super.init(config);
     }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
       String bookTitle=request.getParameter("btitle");
       String bookPublisher=request.getParameter("bpubl");
       String bookCreator=request.getParameter("bcreator");
       String bookPage=request.getParameter("bpage");
       String bookIsbn=request.getParameter("bisbn");
       String bookDescription=request.getParameter("bdesc");
//       String bookPrice=request.getParameter("bprice");
       response.setContentType("text/html");
        PrintWriter out = response.getWriter();
       String connectionURL = "jdbc:mysql://localhost:3306/newdb";
        Connection connection=null;
        Statement st = null;
        ResultSet rs;
        HttpSession sess;
        int exists=0;
       
//        out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet abcd</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet abcd at " + request.getContextPath() + "</h1>");
//            out.println("<h1>Servlet abcd at " + bookTitle + "</h1>");
//            out.println("<h1>Servlet abcd at " + bookPublisher + "</h1>");
//             out.println("<h1>Servlet abcd at " + bookCreator + "</h1>");
//            out.println("<h1>Servlet abcd at " + bookPage + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
        try {
      
         // Load the database driver
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                // Get a Connection to the database
                connection = DriverManager.getConnection(connectionURL, "library", "admin"); 
                //Add the data into the database
                Statement stal=connection.createStatement(); 
                 String sql="select bookTitle from books where bookTitle='"+bookTitle+"'";
                rs = stal.executeQuery(sql);
                int flag=0;
               
                while(rs.next())
                {
                    if(rs.getString("bookTitle").equals(bookTitle))
                    {
                        flag=1;
                        break;
                    }
                }
                if(flag==1)
                {
                    HttpSession s1=request.getSession(true); 
                    s1.setAttribute("book", "exists");
                    response.sendRedirect("adminpage.jsp");

                }
                else
                {
                    sql="insert into books values(null,?,?,?,?,?,?,?,1)";
                    PreparedStatement pst =  connection.prepareStatement(sql);
                    pst.setString(1,bookTitle);
                    pst.setString(2,bookPublisher);
                    pst.setString(3,bookCreator);
                    pst.setString(4,bookPage);
                    pst.setString(5,bookIsbn);
                    pst.setString(6,bookDescription); 
                    pst.setString(7,"1111"); 
                    int a=pst.executeUpdate();
                    HttpSession s1=request.getSession(true); 
                    s1.setAttribute("book", "added");
                    response.sendRedirect("adminpage.jsp");
                }
     
  }
  catch(ClassNotFoundException e){
  out.println("Couldn't load database driver: " 
  + e.getMessage());
  }
  catch(SQLException e)
  {
//  HttpSession sal=request.getSession(true);
//     sal.setAttribute("screenname", "Error occured");     
//     response.sendRedirect("UserPage.jsp");
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
