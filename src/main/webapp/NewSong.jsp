<%-- 
    Document   : NewUser
    Created on : Dec 27, 2022, 5:39:34 PM
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
                
                String title = request.getParameter("songTitle");
                String artist = request.getParameter("songArtist");
                String stringPrice = request.getParameter("songPrice");
                String stringStock = request.getParameter("songStock");
                String stringSales = request.getParameter("songSales");
                
                if (title == null || title.isEmpty() || artist == null || artist.isEmpty() || stringPrice == null || stringPrice.isEmpty() 
                    || stringStock == null || stringStock.isEmpty() || stringSales == null || stringSales.isEmpty())     
                {%>
                <h2>Something went wrong with the song, please try filling all the blanks</h2>
                <form action="./Shop.jsp" method="get">
                <input type="hidden" name="loginType" value="Admin" />
                <input type="submit" value="Back!" />
                </form> 
                <br />
                <%}
                else
                {
                   Double price = Double.valueOf(stringPrice);
                   Integer stock = Integer.valueOf(stringStock);
                   Integer sales = Integer.valueOf(stringSales);
                 
                
                    Song s = new Song (0,title,artist,price,stock,sales);

                    long id = dao.addSong(s);

                    if (id > 0) 
                    {
                        out.println("Successfully created with ID " + id);%>
                        <form action="./Shop.jsp" method="get">
                        <input type="hidden" name="loginType" value="Admin" />
                        <input type="submit" value="Back!" />
                        </form> 
                  <%}
                    else
                    {
                        out.println("Could not create student");
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
    </body>
</html>
