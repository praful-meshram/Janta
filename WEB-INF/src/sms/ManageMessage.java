package sms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import beans.MessageBean;

public class ManageMessage {
	
	public Connection con=null;
	public Statement stmt,stmt1;
	PreparedStatement pstmt;
	public ResultSet rs;
	String envLookup;
	
	      public ManageMessage(String envLook){
	    	  envLookup = envLook;
	  		  initialize(envLookup);
	      }
	      
	      public void  initialize(String env){
	  		try{
	  			Context initContext = new InitialContext();
	  			Context envContext  = (Context)initContext.lookup("java:/comp/env");
	  			DataSource ds = (DataSource)envContext.lookup(env);
	  			con = ds.getConnection();
	  			stmt=con.createStatement();
	  			stmt1=con.createStatement();
	  			
	  		}
	  		catch (Exception e){
				System.out.println("Error occurred in Database Connection " + e);			
			}
	      }
	      
	      
	      public void closeAll(){
	  		try{
	  			stmt.close();
	  	    	con.close();
	  	   
	  		}
	  		
	  		catch(Exception e)
	  		{
	  	        e.getMessage();
	  			e.printStackTrace();
	  	    }	
	  	}
    
	      public String insertMsgData(MessageBean msgbn){
	    	  
	    	   try
	    	   {
	    		 pstmt=con.prepareStatement("insert into message_master(cust_code,mobile_no,message,sent_by,init_date,sent_date,status,message_type)values(?,?,?,?,now(),now(),'INIT',?)");
	    		 pstmt.setString(1, msgbn.getCust_code());
	    		 pstmt.setString(2, msgbn.getMobile_no());
	    		 pstmt.setString(3,msgbn.getMessage());
	    		 pstmt.setString(4,msgbn.getSent_by());
	    		 pstmt.setString(5,msgbn.getMessage_type());
	    		 pstmt.executeUpdate();
	    		 return("JS");
	    	  }
	    	 
	    	   catch(Exception e){
	    		  System.out.print("Error While Inserting" + e);
	    		  return("JS");
	    	  }
	    	  
	       }
	      


	      }



