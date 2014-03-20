/**
 * 
 */
package inventory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.PreparedStatement;

/**
 * @author Sanketa
 *
 */
public class ManageVendor {
	public Connection conn=null;
	public Statement  stat;
	public PreparedStatement  pstmt;
	public ResultSet rs;
	public String query;
	String envLookup;
	public ManageVendor(String envLook){
		envLookup = envLook;
		initialize(envLookup);
	}
	public void  initialize(String env){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(env);
			conn = ds.getConnection();
			stat=conn.createStatement();
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
			
	}
	
	public void closeAll(){
		try{
			if(stat != null)
				stat.close();
			if(conn != null) 
				conn.close();
	   
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	// check availabilty of vendor name in DB
	public boolean isExist(String vendorName){
		try {
			query="select * from vendor_master where " +
					"vendor_name = '"+vendorName+"'";
			System.out.println(query);
			rs = stat.executeQuery(query);			
			if(rs.next()){
				return true;			
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return false;
	}
	
	// duplicate vendor name not allowed
	public String insert(String vendorName, String vendorAddress, String phone){
		try {
			
			query="insert into vendor_master(vendor_name, vendor_address, phone_number)" +
					" values (?,?,?)"; 
			
			pstmt = conn.prepareStatement(query);			
			pstmt.setString(1,vendorName);
			pstmt.setString(2, vendorAddress);
			pstmt.setString(3, phone);
			System.out.println(query);
			int run_sql= pstmt.executeUpdate();
			if(run_sql==1){
				 return "Success";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
		
			return "Error";
		}
		return "Error";
	}
	
	// search vendor as input parameter
	public void search(String vendorName,String vendorPhone){
		try {
			query="select vendor_id, vendor_name, vendor_address, phone_number from vendor_master";
			if((vendorName != "" && vendorName != null) || (vendorPhone != "" && vendorPhone != null))
				query = query + " where ";
			if(vendorName != "" && vendorName != null){
				query= query+	" vendor_name like '"+vendorName+"%'" ;
				if(vendorPhone != "" && vendorPhone != null){
					query= query+	" and phone_number like '"+vendorPhone+"%'" ;
				}
			} else if(vendorPhone != "" && vendorPhone != null){
				query= query+	" phone_number like '"+vendorPhone+"%'" ;
			}
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// update vendor master
	public String update(int vendorId,String vendorName, String vendorAddress, String phone){
		try {
			
			query="update vendor_master set " +
					" vendor_name =? ," +
					" vendor_address=?," +
					" phone_number=?" +
					" where vendor_id=?"; 
			
			pstmt = conn.prepareStatement(query);			
			pstmt.setString(1,vendorName);
			pstmt.setString(2, vendorAddress);
			pstmt.setString(3, phone);
			pstmt.setInt(4, vendorId);
			System.out.println("vendoe id "+vendorId+"\n vendor name :"+vendorName+"\n vendor address :"+vendorAddress +"\n phone "+phone);
			System.out.println(query);
			int run_sql= pstmt.executeUpdate();
			if(run_sql==1){
				 return "Success";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
			return "Error";
		}
		return "Error";
	}
	
	public  void getVendor(){
		try {
			query="select vendor_id, vendor_name from vendor_master order by vendor_id";			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	public void getVendorAddress(Integer vendorId){
		try {
			query="select vendor_address from vendor_master where vendor_id="+vendorId;			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// check for new vendor name availability in DB in case of edit
	public boolean isExistEdit(String vendorName,int vendorId){
		try {
			query="select vendor_name from vendor_master where " +
					"vendor_id = "+vendorId+"";
			System.out.println(query);
			rs = stat.executeQuery(query);			
			
			if(rs.next()){
				// compare old name with new name
				if(!rs.getString(1).equals(vendorName)){
					query="select * from vendor_master where " +
							"vendor_name = '"+vendorName+"'";
					if(stat.executeQuery(query).next())
						return false;
				}			
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
}
