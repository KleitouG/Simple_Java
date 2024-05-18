<%-- 
    Document   : DisplayAllUsers
    Created on : Dec 20, 2022, 3:51:38 PM
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
            
             ArrayList<User> users = dao.findAllUsers();
                        for(User u: users)
                        {
                            out.println(u + "<br />");
                        }%>
                        <h2> If you want to alter the details of a user please insert their username </h2>
                        <form action="./UpdateUser.jsp" method="post">
                        <p>Username:<input type="text" name="oldUsername" value="" required/></p>
                        <h3> and the new information about the user </h3>
                        <p>New username:<input type="text" name="username" value="" required/></p>
                        <p>New password:<input type="text" name="password" value="" required/></p>
                        <p>New name:<input type="text" name="name" value="" required/></p>
                        <p>User type:
                        <select name='userType' required>
                            <option>User</option>
                            <option>Admin</option>
                        </select>
                        </p>
                        <input type="submit" value="Change User!" />
                        </form> 
                        <br />
                        
                        <h2> If you want to delete a user please insert their ID </h2>
                        <form action="./DeleteUser.jsp" method="post">
                        <p>ID:<input type="number" name="userId" value="" required/></p>
                        <input type="submit" value="Delete!" />
                        </form> 
                        <br />
             <%
                 
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
</html>
