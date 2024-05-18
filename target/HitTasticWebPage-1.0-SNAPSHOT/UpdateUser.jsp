<%-- 
    Document   : UpdateUser
    Created on : Dec 28, 2022, 2:29:56 PM
    Author     : giorg
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.hittasticwebpage.UserDao" %>
<%@page import="com.mycompany.hittasticwebpage.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
            
        Connection conn = null;
        
        try 
        {
            //Connection with SQL, since no registering system has been asked
            //The database  has been made with the users inserted from the database manually
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:C:/Users/giorg/UsersDatabase.db");
            
            
            PreparedStatement pStmt = conn.prepareStatement ("update user set username=?, password=?, name=?, type=? where username=?");
            pStmt.setString (1, request.getParameter("username"));
            pStmt.setString (2, request.getParameter("password"));
            pStmt.setString (3, request.getParameter("name"));
            pStmt.setString (4, request.getParameter("userType"));
            pStmt.setString(5, request.getParameter("oldUsername"));
            
            int rowsAffected = pStmt.executeUpdate();
               if(rowsAffected == 1) 
               {
                    out.println("User Details Updated!");%>
                     <form action="./DisplayAllUser.jsp" method="post">
                     <input type="hidden" name="loginType" value="Admin" />
                     <input type="submit" value="Back!" />
                     </form> 
            <%  }
                            
               else
               {
                    System.out.println("Error: Could not update user details");
               }
        }
        catch(SQLException e)    
        {
            out.println("<strong>Seems like the website has some trouble processing the data please try going back</strong>");
        }    
        finally
        {
            // Close the connection if it was made successfully
            if(conn != null)
            {
                try
                {
                    conn.close();
                }
                catch(SQLException closeException)
                {
                    out.println("<strong>Seems like the website has some trouble clossing the connection please try going back</strong>");
                }
            }
        }%>
    </body>
</html>
