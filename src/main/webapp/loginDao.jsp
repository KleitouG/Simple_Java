<%-- 
    Document   : login
    Created on : Dec 18, 2022, 10:41:56 AM
    Author     : giorg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.hittasticwebpage.UserDao" %>
<%@page import="com.mycompany.hittasticwebpage.User" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HitTastic Page</title>
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
            stmt0.executeUpdate("create table if not exists user (id INTEGER primary key autoincrement, username STRING,"
            + " password STRING, name STRING, type STRING, balance DOUBLE)");
            
            
   
            
            UserDao dao = new UserDao(conn, "user");
            //Gets username and password
            String username = request.getParameter("userUsername");
            String password = request.getParameter("userPassword");
                    
            if(session.getAttribute("userUsername") == null && session.getAttribute("userPassword") == null)
            {
                session.setAttribute("userUsername",new ArrayList<String>());
                session.setAttribute("userPassword",new ArrayList<String>());
            }
            
             ArrayList<String> sessionUsernames = (ArrayList<String>) session.getAttribute("userUsername");
             ArrayList<String> sessionPasswords = (ArrayList<String>) session.getAttribute("userPassword");
            
            if(username != null && password != null)
            {
                sessionUsernames.add(username);
                sessionPasswords.add(password);
            }
            
            
            User login = dao.findUserByUsernameAndPassword(username,password);
            if(login != null)
                {
               %>
               <h1> Welcome to HitTastic</h1>
               <%
                   //Figures out if your type is set to User or Admin by returning the type.
                   String type = login.getType();
                   if(type.equals("User"))
                   
                   {%>
                        
                        <h2> Hello User <%=username%> </h2>
                        
                        <form action="./Shop.jsp" method="post">
                        <input type="hidden" name="loginType" value="<%=login.getType()%>" />
                        <input type="hidden" name="loginId" value="<%=login.getId()%>" />
                        <input type="submit" value="Shop Catalog!" />
                        </form> 
                        <br />
                   <%}
                   
                   else
                   {%>
                        <h2> Hello Admin <%=username%> </h2>
                        <form action="./DisplayAllUsers.jsp" method="get">
                        <input type="hidden" name="loginType" value="<%=login.getType()%>" />
                        <input type="hidden" name="loginId" value="<%=login.getId()%>" />
                        <input type="submit" value="DisplayUsers!" />
                        </form> 
                        <br />
                        
                        
                        <form action="./Shop.jsp" method="post">
                        <input type="hidden" name="loginType" value="<%=login.getType()%>" />
                        <input type="hidden" name="loginType" value="<%=login.getType()%>" />
                        <input type="hidden" name="loginId" value="<%=login.getId()%>" />
                        <input type="submit" value="Shop Catalog!" />
                        </form> 
                        <br />
                        
                        <%
                         
                   }
                }
                
            else
                {%>
                <! -- self submitting form -->
                 <form action="./loginDao.jsp" method="post">
                 <h1> :( </h1>
                 <p>Please enter your username again:<input type="text" name="userUsername" value="" /></p>
                 <p>Please enter your password again:<input type="text" name="userPassword" value="" /></p>
                 <input type="submit" value="Try again!" />
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
    </body>
</html>
