/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.hittasticwebpage;

/**
 *
 * @author giorg
 */

//Georgios: Creating the user class
//Group: Added 1 more attribute
public class User {
    protected long userid;
    protected String username,password,name,type;
    protected double balance;
    
    //Georgios: Having atributes username, password and name.
    //Group: Had to change add a user id as well so we can use it on orders.
    public User(long useridIn, String usernameIn, String passwordIn, String nameIn, String typeIn, double balanceIn)
    {
        //Changed userid to long
        userid = useridIn;
        username = usernameIn;
        password = passwordIn;
        name = nameIn;
        type = typeIn;
        balance = balanceIn;
        
    }
    //Georgios: Setter function used to change details of a user
    
    //AE2: Added more things to the setter, including type if a user 
    //by some chance becomes an admin, but no id so it can be unique
    public void setter( String newUsername, String newPassword, String newName, String newType)
    {
        username = newUsername;
        password = newPassword;
        name = newName;
        type = newType;
    }
    
    //Georgios: Gets username
    public String getUsername() 
    {
        return username;
    }
    
    
    //Georgios: Gets password
    public String getPassword() 
    {
        return password;
    }
    
    //Georgios: Gets name
    public String getName() 
    {
        return name;
    }
    //Georgios: Gets id
    public long getId() 
    {
        return userid;
    }
    
    public String getType()
    {
        return type;
    }
    
     public double getBalance()
    {
        return balance;
    }
     
     public  void lowerBalance(double price)
    {
           if(balance >= price)
        {
            balance = balance - price;
        }
    }
    
    
     public String toString()
    {
        return "ID: " + userid + " Username: " + username + " Password: " + password + " Name: " + name +" Type: " + type + " Balance:" + balance;
    }
}
