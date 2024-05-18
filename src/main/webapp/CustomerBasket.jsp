<%-- 
    Document   : CustomerBasket
    Created on : Dec 30, 2022, 5:10:36 PM
    Author     : giorg
--%>



<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.hittasticwebpage.UserDao"%>
<%@page import="com.mycompany.hittasticwebpage.User"%>
<%@page import="com.mycompany.hittasticwebpage.BasketOrderDao" %>
<%@page import="com.mycompany.hittasticwebpage.BasketOrder" %>
<%@page import="com.mycompany.hittasticwebpage.SongDao"%>
<%@page import="com.mycompany.hittasticwebpage.Song"%>
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
            stmt0.executeUpdate("create table if not exists orders (id INTEGER primary key autoincrement, userid INTEGER,"
            + "orderdetails string, orderquantity INTEGER,orderprice double)");
            
            
   
            UserDao userDao = new UserDao(conn, "user");
            SongDao songDao = new SongDao(conn, "shop");
            BasketOrderDao orderDao = new BasketOrderDao(conn, "orders");
            %>
               <h1>Checkout Basket</h1>
            <%
                

                
                ArrayList<Song> sessionBaskets = (ArrayList<Song>) session.getAttribute("addBasket");   
                
                String type = request.getParameter("loginType");
                String songId = request.getParameter("BasketsId");
                String userId = request.getParameter("loginId");
                String price = request.getParameter("FinalPrice");
                String quantity = request.getParameter("songQuantity");
                
                
                

                if(songId != null || songId.isEmpty())
                {
                
                int songid = Integer.valueOf(songId);
                int userid = Integer.valueOf(userId);
                double prices = Double.valueOf(price);
                int quantities = Integer.valueOf(quantity);
                
                
                    for(Song s: sessionBaskets)
                    {
                            if(s.getSid() == songid)
                            {

                            out.println(s + "<br />");

                          }
                                               
                
                        out.println("Check out Price: " + prices);
                        %>
                        <form action="./CustomerBasket.jsp">
                            <input type="hidden" name="purchase" value="True">
                            <input type="hidden" name="loginType" value="<%=type%>" />
                             <input type="hidden" name="BasketsId" value="<%=songId%>" />
                              <input type="hidden" name="loginId" value="<%=userId%>" />
                               <input type="hidden" name="FinalPrice" value="<%=price%>" />
                                <input type="hidden" name="songQuantity" value="<%=quantities%>" />
                                 <input type="submit" value="Purchase!" />   
                        </form>
                        <%

                        String purchase = request.getParameter("purchase");

                        boolean click = Boolean.valueOf(purchase);

                            if (click)
                             {      
                                    User u = userDao.findUserById(userid);
                                    
                                    double userBalance = u.getBalance();
                                    
                                    if(userBalance >= prices)
                                    {
                                        u.lowerBalance(prices);
                                        
                                        userDao.updateBalance(u);
                                        
                                        songDao.updateSong(s);
                                        
                                        String details = sessionBaskets.toString();
                                        
                                        BasketOrder bo = new BasketOrder(0,userid,details,quantities,prices);
                                        
                                        long id = orderDao.addBasket(bo);

                                        if (id > 0) 
                                        {
                                            
                                            out.println("Successfully purchased song");%>
                                            <form action="./Shop.jsp" method="get">
                                            <input type="hidden" name="loginType" value="<%=type%>" />
                                            <input type="hidden" name="loginId" value="<%=userId%>"
                                            <input type="submit" value="Back!" />
                                            </form> 
                                      <%}
                                    }
                                    else
                                    {%>
                                            <form action="./Shop.jsp" method="get">
                                            <h2> Not enough balance for purchase</h2>
                                            <input type="hidden" name="loginType" value="<%=type%>" />
                                            <input type="hidden" name="loginId" value="<%=userId%>" />
                                            <input type="submit" value="Back!" />
                                            </form>     
                                  <%}
                             }
                        }       
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
                    out.println("<strong> Seems like the website has some trouble clossing the connection please try going back </strong>");
                }
            }
        }
            
        %>
                
            
            %>
    </body>
</html>
