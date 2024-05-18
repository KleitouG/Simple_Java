<%-- 
    Document   : Shop
    Created on : Dec 24, 2022, 1:36:14 PM
    Author     : giorg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.mycompany.hittasticwebpage.SongDao" %>
<%@page import="com.mycompany.hittasticwebpage.Song" %>
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
                stmt0.executeUpdate("create table if not exists shop (id integer primary key autoincrement, title string,"
                + " artist string, price double, stock integer, sales integer)");
                
                SongDao dao = new SongDao(conn, "shop");
                
                String type = request.getParameter("loginType");
                String id = request.getParameter("loginId");
                
                ArrayList<Song> songs = dao.findAllSongs();
                        for(Song s: songs)
                        {
                            out.println(s + "<br />");
                        }
                        
                        
                %>
                
                <form action="./PurchaseHistory.jsp" method="get">
                     <h2> View Purchase History </h2>                 
                    <input type="hidden" name="loginType" value="<%=type%>" />
                    <input type="hidden" name="loginId" value="<%=id%>" />
                    <input type="submit" value="View purchase history" />
                </form>
                    
                <form action="./Shop.jsp" method="get">
                    <h2> Search by artist </h2>
                    <p>Artist:<input type="text" name="searchArtist" value="" required/></p>
                    <input type="hidden" name="loginType" value="<%=type%>" />
                    <input type="hidden" name="loginId" value="<%=id%>" />
                    <input type="submit" value="Search Arist!" />
                </form>
                    
                <form action="./Shop.jsp" method="get">
                    <h2> Search by title </h2>
                    <p>Title:<input type="text" name="searchTitle" value="" required/></p>
                    <input type="hidden" name="loginType" value="<%=type%>" />
                    <input type="hidden" name="loginId" value="<%=id%>" />
                    <input type="submit" value="Search Title!" />
                </form>
                    
                <form action="./Shop.jsp" method="get">
                    <h2> Add a song to your basket </h2>
                    <p>Song ID:<input type="text" name="addBasket" value="" required/></p>
                    <p>How many would you like to purchase:<input type="number" name="songQuantity" value="" required/></p>
                    <input type="hidden" name="loginType" value="<%=type%>" />
                    <input type="hidden" name="loginId" value="<%=id%>" />
                    <input type="submit" value="Add Song to Basket!" />
                </form>
                    
                 
                    
                <%
                
                
                String basket = request.getParameter("addBasket");
                
                String quantity = request.getParameter("songQuantity");
                
                if(session.getAttribute("addBasket") == null)
                {
                    session.setAttribute("addBasket",new ArrayList<Song>());
                }
                
                ArrayList<Song> sessionBaskets = (ArrayList<Song>) session.getAttribute("addBasket");
                
                

                
                if(basket != null)
                {
                
                 double sum = 0;
                 Integer numbasket = Integer.valueOf(basket);
                 
                 Integer quantityOfSongs = Integer.valueOf(quantity);
                 
                 Song b = dao.findSongById(numbasket); 
                 int stocks = b.getStock();
                 long songId = b.getSid();
                            
                    if(sessionBaskets.size() < 1 )
                    {
                            if(stocks >= quantityOfSongs)
                            {
                                
                                double priceAddition = b.getPrice();
                
                                   b.sell(quantityOfSongs);
                                   
                                   sum = priceAddition * quantityOfSongs;

                                   out.println(b.displaySong() + "<br />");
                                   
                                            sessionBaskets.add(b);%>
                                            
                                <form action="./CustomerBasket.jsp" method="post">
                                <h2> Basket</h2>
                                <input type="hidden" name="loginId" value="<%=id%>" />
                                <input type="hidden" name="BasketsId" value="<%=songId%>" />
                                <input type="hidden" name="FinalPrice" value="<%=sum%>" />
                                <input type="hidden" name="songQuantity" value="<%=quantityOfSongs%>" />
                                <input type="submit" value="Go to Basket!" />
                                </form>

                            <%       
                            }

                                 else{
                                        out.println("No more stock on song Id" + songId + "<br />");
                                       
                                        
                                     }
                            out.println("Your total price for checkout:" + sum);
                    }
                    
                        else
                        {
                            sessionBaskets.clear();
                            out.print("Last item removed");
                        }
                    }    
                        else
                        {
                            out.println("Basket is Empty");
                        }
                        
                            
              String artist = request.getParameter("searchArtist");

                if(artist != null)
                {
                ArrayList<Song> artists = dao.findSongByArtist(artist);
                        for(Song s1: artists)
                        {
                            out.println(s1 + "<br />");
                        }
                }
                    
                String title = request.getParameter("searchTitle");
                
                if(title != null)
                {
                    ArrayList<Song> titles =dao.findSongByTitle(title);
                    for(Song s2: titles)
                    {
                        out.println(s2 + "<br />");
                    }
                }

                
                

                
                

                if(type.equals("Admin"))
                {%>
                 <form action="./NewSong.jsp" method="post">
                <h2> Add a new song </h2>
                <p>Title:<input type="text" name="songTitle" value="" /></p>
                <p>Artist:<input type="text" name="songArtist" value="" /></p>
                <p>Price:<input type="text" name="songPrice" value="" /></p>
                <p>Stock:<input type="text" name="songStock" value="" /></p>
                <p>Sales:<input type="text" name="songSales" value="" /></p>
                <input type="hidden" name="loginType" value="<%=type%>" />
                <input type="hidden" name="loginId" value="<%=id%>" />
                <input type="submit" value="Add Song!" />
                </form> 
                <br />
                
                <%}
                
                else
                {

               
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
    </body>
    
</html>
