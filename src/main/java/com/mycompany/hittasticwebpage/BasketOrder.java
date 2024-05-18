/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebpage;

/**
 *
 * @author czerw
 */
//Maciej:  creating Basket Order class
public class BasketOrder {
    
    protected long basketId;
    protected int  userid;
    protected String  ordertdetails;
    protected int orderquantity;
    protected double orderprice;
    
    //Maciej:  Constructor
    public BasketOrder(long basketIdIn, int useridIn, String ordertdetailsIn, int orderquantityIn, double orderpriceIn)
    {
      basketId = basketIdIn;
      userid = useridIn;  
      ordertdetails = ordertdetailsIn;
      orderquantity = orderquantityIn;
      orderprice = orderpriceIn;
    }
    //Maciej:  
    /**
     * @return the user id
     */
    
    public void setBasketId(long basketIdIn) 
    {
        basketId = basketIdIn;
    }
    
    public long getBasketId()
    {
        return basketId;
    }
    
    
    public int getOrderUserId() 
    {
        return userid;
    }
    /**
     * @return the order  details
     */
    public String getOrdertDetails() 
    {
        return ordertdetails;
    }

    public double getOrderPrice() 
    {
        return orderprice;
    }
    
    public int getOrderQuantity() 
    {
        return orderquantity;
    }
    
    //Maciej:  printing
    public String displayOrder()
    { 
        return(" OrderId: " + basketId  +  " Price: " + orderprice);
    }
    
    public String toString()
    {
        return "ID: " + basketId + " UserId: " + userid + " Details: " + ordertdetails + " Quantity: " + orderquantity + " Price: " + orderprice;
    }
}
