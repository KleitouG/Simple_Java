<%-- 
    Document   : DeleteUserDao
    Created on : Dec 21, 2022, 11:48:19 AM
    Author     : giorg
--%>

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
            
            
            Statement stmt0 = conn.createStatement();
            stmt0.executeUpdate("create table if not exists user (id integer primary key autoincrement, username string,"
            + " password string, name string, type string)");
   
            
            UserDao dao = new UserDao(conn, "user");
            
            
            String uId = request.getParameter("userId");
            
            if(uId == null || uId.isEmpty())
            {%>
            
            <h2>Something went wrong with the deletion please try again.</h2>
     
            <form action="./DisplayAllUsers.jsp" method="post">
            <input type="hidden" name="loginType" value="Admin" />
            <input type="submit" value="Try Again!" />
            </form>
          <%}
            else
            {     
            Integer id = Integer.valueOf(uId);
            User u = dao.findUserById(id);
            dao.deleteUser(u);%>
            <h2> User deleted successfully </h2>
            <form action="./DisplayAllUsers.jsp" method="post">
                <input type="hidden" name="loginType" value="Admin" />
                <input type="submit" value="Back!" />
                </form> 
                <br />
        <%  }
            
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
                    out.println("<strong> Seems like the website has some trouble clossing the connection please try going back </strong>");
                }
            }
        }
            
        %>
            
        %>

        
    </body>
</html>
