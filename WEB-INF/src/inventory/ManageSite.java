/**
 * 
 */
package inventory;

import java.sql.Connection;
import java.sql.Date;
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
public class ManageSite {
	public Connection conn=null;
	public Statement  stat;
	public PreparedStatement  pstmt;
	public ResultSet rs;
	public String query;
	String envLookup;
	public ManageSite(String envLook){
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
			if(pstmt!=null)
				pstmt.close();
			
			System.out.println("connection closed ....");
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	
	public boolean isExist(String siteName){
		try {
			query="select * from site_master where " +
					"site_name = '"+siteName+"'";
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
	public String insert(String siteName, String siteAddress, String phone){
		try {
			/*query="select ifnull(max(site_id),0) from site_master";
			rs = stat.executeQuery(query);
			int siteId =0;
			if(rs.next()){
				siteId = rs.getInt(1);				
			}
			siteId = siteId + 1;*/
			query="insert into site_master(site_name, site_address, phone_number)" +
					" values (?,?,?)"; 
			
			pstmt = conn.prepareStatement(query);			
			pstmt.setString(1,siteName);
			pstmt.setString(2, siteAddress);
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
	
	public void search(String siteName,String sitePhone){
		try {
			query="select site_id, site_name, site_address, phone_number from site_master ";
			if((siteName != "" && siteName != null) || (sitePhone != "" && sitePhone != null)){
				query= query+	" where ";
			}
			if(siteName != "" && siteName != null){
				query= query+	" site_name like '"+siteName+"%'" ;
				if(sitePhone != "" && sitePhone != null)
					query= query+	"and phone_number like '"+sitePhone+"%'" ;
			} else 	if(sitePhone != "" && sitePhone != null){
				query= query+	" phone_number like '"+sitePhone+"%'" ;
			}
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			System.out.println("Error : ManageSite : search : 105");
			e.printStackTrace();
		}	
	}
	
	public String update(int siteId,String siteName, String siteAddress, String phone){
		try {
			
			query="update site_master set " +
					" site_name =? ," +
					" site_address=?," +
					" phone_number=?" +
					" where site_id=?"; 
			
			pstmt = conn.prepareStatement(query);			
			pstmt.setString(1,siteName);
			pstmt.setString(2, siteAddress);
			pstmt.setString(3, phone);
			pstmt.setInt(4, siteId);
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
	
	public  void getSite(){
		try {
			query="select site_id, site_name from site_master order by site_id";			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	// code for item group code
	public  ResultSet getItemGroupCode(){
		try {
			query="select distinct item_group_code from item_master order by item_group_code ";			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return rs;
	}
	
	
	
	public  void getTransferNum(String siteId,String desId,String frDate,String toDate){
		try {
			query="select transfer_id from transfer_inventory where status!='Closed' and source_site_id='"+siteId+"' and dest_site_id='"+desId+"'";	
			if(frDate!=null)
				query+=" and transfer_date between '"+frDate+"' and '"+toDate+"'";
			query+=" order by transfer_id ";
			
			System.out.println("frdate "+frDate +" todate "+toDate);
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			
			System.out.println(query);
			rs = preparedStatement.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	// get transfer number for closed Inventory
	public  void getTransferNumReprint(Integer siteId,Integer desId,String frDate,String toDate){
		try {
			//query="select transfer_id from transfer_inventory where status='Closed' and source_site_id='"+siteId+"' and dest_site_id='"+desId+"' order by transfer_id";			
			
			// all transfer inventory
			query="select transfer_id from transfer_inventory where source_site_id='"+siteId+"' and dest_site_id='"+desId+"'";			
			if(frDate!=null)
				query+=" and transfer_date between '"+frDate+"' and '"+toDate+"'";
			query+=" order by transfer_id ";
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	public  void getTransferNumForClose(Integer siteId,Integer desId){
		try {
			query="select transfer_id from transfer_inventory where status not in ('TRANSFER', 'CLOSED') and source_site_id='"+siteId+"' and dest_site_id='"+desId+"' order by transfer_id";			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	public void getSiteAddress(Integer siteId){
		try {
			query="select site_address from site_master where site_id="+siteId;			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	
}
