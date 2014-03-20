package code;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageCode {
	
	public Connection conn=null;
	PreparedStatement selectValue;
	PreparedStatement updateValue;
	public ManageCode(String envLookup){
		initialize(envLookup);
	}
	public void  initialize(String envLookup){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(envLookup);
			conn = ds.getConnection();			
			selectValue = conn.prepareStatement("select value from code_table where code=?");
			updateValue = conn.prepareStatement("update code_table set value= ? where code=?");
			
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
			
	}
	
	public void closeAll(){
		try{			
	    	conn.close();	   
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	public String getCodeValue(String code){
		try{
			String get1="";
			selectValue.setString(1,code);			
			ResultSet rs = selectValue.executeQuery();
	    	if(rs.next()){
				get1=rs.getString(1);			
			}
	    	rs.close();
			return(get1);
			
		}
		catch(Exception e){
			System.out.println("Error occurred in get code value from Database " + e);
			closeAll();
			return("0");
		}
	}
	public void editCodeValue(int cusCode, String code){
		try{		
			updateValue.setInt(1,cusCode);	
			updateValue.setString(2,code);	
			updateValue.executeUpdate(); 			
		}
		catch(Exception e){
			System.out.println("Error occurred in Updare code value from Database " + e);
			closeAll();			
		}
	}
}

	