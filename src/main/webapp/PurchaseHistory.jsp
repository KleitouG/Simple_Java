<%-- 
    Document   : PurchaseHistory
    Created on : Jan 3, 2023, 9:47:17 PM
    Author     : giorg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.hittasticwebpage.BasketOrderDao" %>
<%@page import="com.mycompany.hittasticwebpage.BasketOrder" %>
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
            
             BasketOrderDao orderDao = new BasketOrderDao(conn, "orders");
             
             String type = request.getParameter("loginType");
            
             String id = request.getParameter("loginId");
             
             
             
             if(id != null)
             {
             int userId = Integer.valueOf(id);
             ArrayList<BasketOrder> orders = orderDao.findBasketById(userId);
                        for(BasketOrder bo: orders)
                        {
                            out.println(bo + "<br />");
                            
                        }
             }
             
             %>
            <form action="./Shop.jsp" method="get">             
            <input type="hidden" name="loginType" value="<%=type%>" />
            <input type="hidden" name="loginId" value="<%=id%>" />
            <input type="submit" value="Back" />
            </form>
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
            
    </body>
</html>
