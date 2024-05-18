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
public class BasketOrderDao {
    
    private Connection conn;
    private String table;

    public BasketOrderDao(Connection conn, String table) {
        this.conn = conn;
        this.table = table;
    }
    
    public long addBasket(BasketOrder bo) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("insert into orders(userid, orderdetails, orderquantity, orderprice) values (?, ?, ?, ?)");
        pStmt.setInt(1, bo.getOrderUserId());
        pStmt.setString(2, bo.getOrdertDetails());
        pStmt.setInt(3, bo.getOrderQuantity());
        pStmt.setDouble(4,  bo.getOrderPrice());

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
        bo.setBasketId(allocatedId);
        return allocatedId;
    }
    
          public ArrayList<BasketOrder> findBasketById(int userid) throws SQLException{
          PreparedStatement pStmt = conn.prepareStatement("select * from " + table + " where userid=?");
          ArrayList<BasketOrder>basketOrders = new ArrayList<>();
          pStmt.setInt(1, userid);
          ResultSet rs = pStmt.executeQuery();
          
          while(rs.next()){
              
            BasketOrder bo = new BasketOrder 
            (   
      rs.getLong("id"),
        rs.getInt("userid"),
   rs.getString("orderdetails"),
   rs.getInt("orderquantity"),
     rs.getDouble("orderprice")
                      
            );
              basketOrders.add(bo);
          }
          return basketOrders;
      }
    
    
}
