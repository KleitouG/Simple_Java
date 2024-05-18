/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebpage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author giorg
 */
public class SongDao {
    
    private Connection conn;
    private String table;

    public SongDao(Connection conn, String table) 
    {
        this.conn = conn;
        this.table = table;
    }
    
    public ArrayList<Song> findAllSongs() throws SQLException {
        ArrayList<Song>songs = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table );
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while (rs.next()) {
            // Create an Event object with each result and add it to the
            // ArrayList

            Song s = new Song(
                    rs.getLong("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("sales")
            );
            
            songs.add(s);
            
        }
        return songs;
    }
    
    public ArrayList<Song> findSongByArtist(String artist) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where artist=?");
        ArrayList<Song>songs = new ArrayList<>();
        pStmt.setString(1, artist);
        ResultSet rs = pStmt.executeQuery();

        // Is there a row? If so, next() will return true
        while (rs.next()) {
            // Create an Event object with the result
            Song s = new Song(
                    rs.getLong("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("sales")
            );
            songs.add(s);
        }
        // return null if there were no matching rows
        return songs;
    }
    
    public ArrayList<Song> findSongByTitle(String title) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where title=?");
        ArrayList<Song>songs = new ArrayList<>();
        pStmt.setString(1, title);
        ResultSet rs = pStmt.executeQuery();

        // Is there a row? If so, next() will return true
        while (rs.next()) {
            // Create an Event object with the result
            Song s = new Song(
                    rs.getLong("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("sales")
            );
            songs.add(s);
        }
        // return null if there were no matching rows
        return songs;
    }
    
      public Song findSongById(int id) throws SQLException{
          PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where id=?");
          pStmt.setLong(1, id);
          ResultSet rs = pStmt.executeQuery();
          
          while(rs.next()){
              
              return new Song (
                      rs.getLong("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getDouble("price"),
                    rs.getInt("stock"),
                    rs.getInt("sales")
                      
              );
          }
          return null;
      }
    
     public long addSong(Song s) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("insert into shop(title, artist, price, stock, sales) values (?, ?, ?, ?, ?)");
        pStmt.setString(1, s.getTitle());
        pStmt.setString(2, s.getArtist());
        pStmt.setDouble(3,  s.getPrice());
        pStmt.setInt(4, s.getStock());
        pStmt.setInt(5, s.getSales());

        int rowsAdded = pStmt.executeUpdate();
        long allocatedId = 0L;

        // Was a row added successfully?
        if (rowsAdded == 1) {
            // If so, get the keys added
            ResultSet rs = pStmt.getGeneratedKeys();

            // next() should return true, but check just in case
            if (rs.next()) {
                // get the allocated primary key
                allocatedId = rs.getLong(1);
            }
        }

        // Add the allocated ID to the event object and return the ID
        s.setSid(allocatedId);
        return allocatedId;
    }
     
     public int updateSong(Song s) throws SQLException
     {
         PreparedStatement pStmt = conn.prepareStatement ("update " + table + " set stock=?,sales=? where id=?");
         pStmt.setInt (1, s.getStock()); 
         pStmt.setInt (2, s.getSales()); 
         pStmt.setLong (3, s.getSid()); 
         return pStmt.executeUpdate();

     }
     
}
