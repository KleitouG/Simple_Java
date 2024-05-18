
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebpage;

/**
 *
 * @author giorg
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class UserDao {
    
    

    private Connection conn;
    private String table;

    public UserDao(Connection conn, String table) {
        this.conn = conn;
        this.table = table;
    }
    
        // find a user with a given username and password
    public User findUserByUsernameAndPassword(String username, String password) throws SQLException {
        
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where username=? AND password=?");
        pStmt.setString(1, username);
        pStmt.setString(2,password);
        ResultSet rs = pStmt.executeQuery();

        // Is there a row? If so, next() will return true
        if (rs.next()) {
            // Create an Event object with the result
            return new User(
                    rs.getLong("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("balance")
            );
        }
        // return null if there were no matching rows
        return null;
    }
    public ArrayList<User> findAllUsers() throws SQLException {
        ArrayList<User> users = new ArrayList<>();
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table );
        ResultSet rs = pStmt.executeQuery();

        // Loop through the results
        while (rs.next()) {
            // Create an Event object with each result and add it to the
            // ArrayList

            User u = new User(
                    rs.getLong("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("balance")
            );
            users.add(u);
            
        }
        return users;
    }
    
    public User findUserByUsername(String username) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where username=?");
        pStmt.setString(1, username);
        ResultSet rs = pStmt.executeQuery();

        // Is there a row? If so, next() will return true
        if (rs.next()) {
            // Create an Event object with the result
            return new User(
                    rs.getLong("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("balance")
            );
        }
        // return null if there were no matching rows
        return null;
    }
    
    public User findUserById(long id) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where id=?");
        pStmt.setLong(1, id);
        ResultSet rs = pStmt.executeQuery();

        // Is there a row? If so, next() will return true
        if (rs.next()) {
            // Create an Event object with the result
            return new User(
                    rs.getLong("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("balance")
            );
        }
        // return null if there were no matching rows
        return null;
    }
    
    
            
    
    public int deleteUser(User user) throws SQLException
    {
        PreparedStatement pStmt = conn.prepareStatement ("delete from " + table + " where id=?");
        pStmt.setLong (1, user.getId()); 
        return pStmt.executeUpdate();
        
    }
    
    public int updateBalance(User user) throws SQLException
     {
         PreparedStatement pStmt = conn.prepareStatement ("update " + table + " set balance=? where id=?");
         pStmt.setDouble (1, user.getBalance()); 
         pStmt.setLong (2, user.getId()); 
         return pStmt.executeUpdate();

     }
    
    
}   