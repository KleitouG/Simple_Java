/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebpage;

/**
 *
 * @author giorg
 */

//Georgios: Creating Song Class
//Group: Changed the constructor to adapt to the song class Maciej created
//inserted new attributes, changed the constructor to take more things into
//account.
public class Song{
    protected String title, artist;
    //Maciej: Attribute of sid, price, stock and sales
    protected double price;
    protected int stock, sales;
    protected long sid;
    
//Maciej: constructor
    public Song(long sidIn, String titleIn, String artistIn ,double priceIn, int stockIn, int salesIn)
    {
        //Maciej: Attribute of sid, title, artist, price, stocks, sales
        sid = sidIn;
        title = titleIn;
        artist = artistIn;
        price = priceIn;
        stock = stockIn;
        sales = salesIn;
        
    }
        
    //Maciej:
     /**
     * @return the title
     */
    public String getTitle() 
    {
        return title;
    }
    
    /**
     * @return the artist
     */
    public String getArtist() 
    {
        return artist;
    }
    
    /**
     * @return the song ID
     */
    public long getSid() 
    {
        return sid;
    }
    
    
    public void setSid(long sidIn) 
    {
        sid = sidIn;
    }
    
     /**
     * @return the price
     */
    public Double getPrice() 
    {
        return price;
    }
    
    /**
     * @return the stock
     */
    public Integer getStock() 
    {
        return stock;
    }
    
    //* @return the sales
    public Integer getSales() 
    {
        return sales;
    }
    
    //Maciej: Method decresing a stock attribute and increasing sales when song is sold
    
    public  void sell(int newStock)
    {
           if(stock >= newStock)
        {
            stock = stock - newStock;
            sales = sales + newStock;
        }
    }
    
    
    //Maciej: Prints all details about song object
    public void print()
    {
        System.out.println("ID:  " + sid + " " + "Title:  " + title + " " + "Artist:  " + artist + " " 
                + "Price:  " + price + " " + "Stock:  " + stock + " " + "Sales:  " + sales);
    }
    
    //Georgios: Prints the name of the song the admin chose
    public void choiceDisplay() 
    {
        System.out.println(title);
    }
    
    //Georgios: made it for a simple display
     public String displaySong()
    { 
        return "Id: " +  sid + "        " + "Title: " + title + "        " + "Artist: " + artist + "        " + "Stock: " + stock;
    }
     
     public String toString()
    {
        return "ID: " + sid + " Title: " + title + " Artist: " + artist + " Price: " + price + " Stock: " + stock + " Sales: " + sales;
    }
}
