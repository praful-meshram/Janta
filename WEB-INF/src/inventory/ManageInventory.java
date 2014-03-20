/**
 * 
 */
package inventory;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * @author Sanketa
 *
 */
public class ManageInventory {
	public Connection conn=null;
	public Statement  stat,stat1;
	public PreparedStatement  pstmt;
	public ResultSet rs,rs1;
	public String query;
	String envLookup;
	public ManageInventory(String envLook){
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
			stat1=conn.createStatement();
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
			
	}
	
	public void closeAll(){
		try{
			if(stat != null)
				stat.close();
			if(stat1 != null)
				stat1.close();
			if(conn != null) 
				conn.close();	
			if(rs!=null)
				rs=null;
			if(rs1!=null)
				rs=null;
			
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	public void getQtyPerSide(String item_code,int price_version){
		try{
			query="select s.site_name,i.item_site_qty from item_site_inventory i,site_master s"
					+" where i.item_code='"+item_code+"' and i.price_version="+price_version
					+" and s.site_id=i.site_id";
			//System.out.println(query);
			rs = stat.executeQuery(query);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void getBachkaList(String start_with){
		try{
			query="select item_name from item_master where item_name like '"+start_with+"%' and is_bachka='true' limit 10";
			System.out.println(query);
			rs = stat.executeQuery(query);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void searchItem(String barcode,String itemName){
		try {
			query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
					" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty,m.is_bachka" +
					" FROM item_master m,item_price p" +
					" WHERE 1=1 ";						
			if(barcode != "" && barcode != null)
				query= query+	" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				query= query+	" and m.item_name like '"+itemName +"%'";
			
			query= query + " and p.item_code = m.item_code";
			/* query=query+" and p.price_version = (" +
					" select max(ip.price_version) " +
					" from item_price ip " +
					" where ip.item_code = m.item_code" +
					")"; */
			System.out.println("====\n\n search item  "+ query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void searchBachka(String barcode,String itemName, String is_bachka,String item_group_code){
		String where =null;
		
		try {
//			query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
//					" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code" +
//					" FROM item_master m,item_price p" +
//					" WHERE 1=1 ";
//			
			query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
					" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code ";
			//query = query +", m.item_group_code";
					
			 where = " WHERE 1=1 ";
			if(barcode != "" && barcode != null)
				where= where +" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				where= where+	" and m.item_name like '"+itemName +"%'";
			where= where + " and p.item_code = m.item_code and m.box_qty=1";
			if(is_bachka.equals("searchBachka")){
				where=where+" and m.is_bachka='true'";
			}else if(is_bachka.equals("searchItem")){
				
				where=where+" and m.is_bachka='false'";
				 if(item_group_code!=null)
				 {
					 where = where +" and m.item_group_code='"+item_group_code+"'";
				 }
			}
			query = query + " FROM item_master m,item_price p "+where;
			System.out.println("=========\n"+is_bachka+ query+"\n========");
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void searchItem1(String itemCode,int priceVersion){
		try {
			query="SELECT item_mrp, item_rate FROM item_price WHERE ";						
			if(itemCode != "" && itemCode != null)
				query= query+	"item_code = '"+itemCode +"' and price_version ="+priceVersion+"";
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public String venderName(int vendorId){
		try{
			rs=stat.executeQuery("select vendor_name from vendor_master where vendor_id="+vendorId);
			rs.next();
			String op= rs.getString(1);
			closeAll();
			return op;
		}catch(Exception e){
			System.out.println("Error in : ");
			e.printStackTrace();
			closeAll();
			return "error";
		}
	}
	public String siteName(int siteId){
		try{
			rs=stat.executeQuery("select site_name from site_master where site_id="+siteId);
			rs.next();
			String op= rs.getString(1);
			closeAll();
			return op;
		}catch(Exception e){
			System.out.println("Error in : ");
			e.printStackTrace();
			closeAll();
			return "error";
		}
	}
	
	public String poDate(int poNo){
		try{
			rs=stat.executeQuery("select po_date from item_receipt_header where po_number="+poNo);
			rs.next();
			String op= rs.getString(1);
			closeAll();
			return op;
		}catch(Exception e){
			System.out.println("Error in : ");
			e.printStackTrace();
			closeAll();
			return "error";
		}
	}
	
	public String bdDate(int poNo){
		try{
			rs=stat.executeQuery("select bd_date from breakdown_header where bd_number="+poNo);
			rs.next();
			String op= rs.getString(1);
			closeAll();
			return op;
		}catch(Exception e){
			System.out.println("Error in : ");
			e.printStackTrace();
			closeAll();
			return "error";
		}
	}
		
	public void searchTrnsNum(String trnsNumber,String siteId ,String desId){
		try {
			
			query="SELECT t.transfer_id,t.total_trans_items " +
					" FROM transfer_inventory t" ;
									
			if( trnsNumber != null)
				query= query+" where status='TRANSFER' and  source_site_id='"+siteId+"'  and  dest_site_id='"+desId+"'"+
				"  and t.transfer_id like '"+trnsNumber+"%'" ;
			
			System.out.println(query);
			rs = stat.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	public void getTrnsList(Integer trnsNumber,Integer siteId,Integer desId){
		try {
			query="SELECT m.item_code,m.barcode,m.item_name,m.item_weight,ip.item_mrp,ip.item_rate,ip.price_version,t.transfer_qty,t.item_trans_status,"+
				"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id = '"+siteId+"' and it.price_version = t.price_version),0),"+
						"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id ='"+ desId+"'  and it.price_version = t.price_version),0)"+
			     " FROM transfer_inventory_details t,item_master m ,item_price ip ";
			     if( trnsNumber != null)
			   query= query+" where t.transfer_id ='"+trnsNumber+"'"; 
			 query=query+" and m.item_code=t.item_code "  +
			"  and ip.item_code=t.item_code "  +
			"  and ip.price_version=t.price_version ";
			
			System.out.println(query);
			rs = stat.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	// fetching transfer details fro editing
	public void getTrnsListEdit(Integer trnsNumber,Integer siteId,Integer desId){
		System.out.println("===========transfer inventory details ");
		try {
			query="SELECT m.item_code,m.barcode,m.item_name,m.item_weight,ip.item_mrp,ip.item_rate,ip.price_version,t.transfer_qty,t.item_trans_status,"+
				"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id = '"+siteId+"' and it.price_version = t.price_version),0),"+
						"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id ='"+ desId+"'  and it.price_version = t.price_version),0)"+
			     " FROM transfer_inventory_details t,item_master m ,item_price ip ,(select * from transfer_inventory where transfer_id ='"+trnsNumber+"') ti ";
			     
			 query= query+" where t.transfer_id ='"+trnsNumber+"'"; 
			 query=query+" and m.item_code=t.item_code and ti.status!='Closed'" +
			"  and ip.item_code=t.item_code "  +
			"  and ip.price_version=t.price_version ";
			
			System.out.println(query);
			rs = stat.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	// code for reprint receive inventory
	public void getTrnsListReprint(Integer trnsNumber,Integer siteId,Integer desId){
		System.out.println("===========transfer inventory details ");
		try {
			query="SELECT m.item_code,m.barcode,m.item_name,m.item_weight,ip.item_mrp,ip.item_rate,ip.price_version,t.transfer_qty,t.item_trans_status,"+
				"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id = '"+siteId+"' and it.price_version = t.price_version),0),"+
						"ifnull((select it.item_site_qty from item_site_inventory it where it.item_code=t.item_code and it.site_id ='"+ desId+"'  and it.price_version = t.price_version),0)"+
			     " FROM transfer_inventory_details t,item_master m ,item_price ip ,(select * from transfer_inventory where transfer_id ='"+trnsNumber+"') ti ";
			     if( trnsNumber != null)
			   query= query+" where t.transfer_id ='"+trnsNumber+"'"; 
			 //query=query+" and m.item_code=t.item_code and ti.status='Closed'" +
			  
			     //all status 
			 query=query+" and m.item_code=t.item_code " +  
				"  and ip.item_code=t.item_code "  +
				"  and ip.price_version=t.price_version ";
			
			System.out.println(query);
			rs = stat.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	
	public void getitemstatus(){
		try {
			query="SELECT * FROM transfer_inventory_status st order by st.item_status desc  ";
			System.out.println(query);
			rs1 = stat1.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	// fecth stsus for reprint
	public String getitemstatusReprint(int transferId,String itemCode, int priceversion){
		try {
			String itemTransStatusQuery="select item_trans_status from transfer_inventory_details where item_code = ?" +
					"and price_version = ? and transfer_id = ?";
			PreparedStatement preparedStatement = conn.prepareStatement(itemTransStatusQuery);
			preparedStatement.setString(1,itemCode);
			preparedStatement.setInt(2, priceversion);
			preparedStatement.setInt(3, transferId);
			System.out.println(itemTransStatusQuery);
			rs1 = preparedStatement.executeQuery();
			if(rs1.next())
				return rs1.getString(1);
				
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}	
		return null;
	}
	
	
	
	public int getTotalSiteQuantity(String itemCode,Integer price_version){
		try {
			query="select sum(s.item_site_qty) from item_site_inventory s where s.item_code = '"+itemCode+"' and price_version="+price_version;
			//System.out.println(query);
			int retValue = 0;
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getInt(1);
			}
			return retValue;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}		
	}
	
	public int getSiteQuantity(String itemCode,Integer siteId, Integer priceVersion){
		int retValue = 0;
		try {
			query="select item_site_qty from item_site_inventory s" +
					" where s.item_code = '"+itemCode +"'" +					
					" and s.site_id = "+siteId +
					" and s.price_version = "+priceVersion;
			//System.out.println(query);
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println(""+e);
			e.printStackTrace();
			return 0;
		}		
		return retValue;
	}
	public int getSiteQuantity1(String itemCode,Integer siteId, Integer priceVersion){
		try {
			query="select item_site_qty from item_site_inventory " +
					" where item_code = '"+itemCode +"'" +					
					" and site_id = "+siteId +
					" and price_version = "+priceVersion;
			System.out.println(query);
			int retValue = 0;
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getInt(1);
			}
			return retValue;
		} catch (SQLException e) {
			System.out.println(""+e);
			e.printStackTrace();
			return 0;
		}		
	}
	public String getItemName(String itemCode){
		String retValue = null;
		try {
			query="select item_name from item_master" +
					" where item_code ='"+itemCode +"'";
			System.out.println(query);
			
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return retValue;
		}		
		return retValue;
	}
	public String getItemWeight(String itemCode){
		try {
			query="select item_weight from item_master" +
					" where item_code ='"+itemCode +"'";
			System.out.println(query);
			String retValue = "";
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getString(1);
			}
			return retValue;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}		
	}
	
	
	public int getBoxQty(String itemCode){
		int retValue = 0;
		try {
			query="select box_qty from item_master" +
					" where item_code ='"+itemCode +"'";
			System.out.println(query);
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}		
		return retValue;
	}
	
	public int getDesQuantityTrans(String itemCode,Integer desId, Integer priceVersion){
		try {
			query="select item_site_qty from item_site_inventory s" +
					" where s.item_code = '"+itemCode +"'" +					
					" and s.site_id = "+desId +
					" and s.price_version = "+priceVersion;
			System.out.println(query);
			int retValue = 0;
			rs1 = stat1.executeQuery(query);
			if(rs1.next()){				
				retValue = rs1.getInt(1);
			}
			return retValue;
		} catch (SQLException e) {
			System.out.println(""+e);
			e.printStackTrace();
			return 0;
		}		
	}
	
	public void getMrpValues(String itemCode, int siteId){
		try {
			query="SELECT ip.item_mrp,ip.item_rate,ip.price_version "
					+"FROM item_price ip where ip.item_code='"+itemCode+"'" 
					+"and  ip.active_flag='Y' "
					+"order by ip.price_version asc";
			
/*			query="SELECT  ip.item_mrp, ip.item_rate, ip.price_version,ip.item_pv_qty, isi.item_site_qty" +
					" FROM item_price ip, item_site_inventory isi" +
					" where ip.item_code='"+itemCode+"'" +
							"and isi.site_id="+siteId+
							" and isi.item_code = ip.item_code" +
							" and ip.price_version = isi.price_version" +
					" order by ip.price_version asc";
*/			System.out.println(query);			
			rs= stat.executeQuery(query);	
			
		} catch (SQLException e) {
			e.printStackTrace();	
		}		
	}
	
	
	//
	
	public ResultSet getMrpValuesNew(String itemCode, int siteId){
		try {
			query="SELECT ip.item_mrp,ip.item_rate,ip.price_version "
					+"FROM item_price ip where ip.item_code='"+itemCode+"' "
					+"order by ip.price_version asc";
			/*query="SELECT  ip.item_mrp, ip.item_rate, ip.price_version,ip.item_pv_qty, isi.item_site_qty" +
					" FROM item_price ip, item_site_inventory isi" +
					" where ip.item_code='"+itemCode+"'" +
							"and isi.site_id="+siteId+
							" and isi.item_code = ip.item_code" +
							" and ip.price_version = isi.price_version" +
					" order by ip.price_version asc";*/
			System.out.println(query);			
			ResultSet resultSet= stat.executeQuery(query);	
			
			
		} catch (SQLException e) {
			e.printStackTrace();	
		}	
		
		return rs;
	}
	
	
	public void getMrpValuesTrans(String itemCode,Integer siteId){
		try {
			query="SELECT  ip.item_mrp, ip.item_rate, ip.price_version,ip.item_pv_qty, isi.item_site_qty" +
					" FROM item_price ip, item_site_inventory isi" +
					" where ip.item_code='"+itemCode+"'" +
							"and isi.site_id="+siteId+
							" and isi.item_code = ip.item_code" +
							" and ip.price_version = isi.price_version" +
							" and isi.item_site_qty > 0" +
					" and ip.active_flag='Y' order by ip.price_version desc";
			System.out.println(query);			
			rs= stat.executeQuery(query);			
		} catch (SQLException e) {
			e.printStackTrace();	
		}		
	}
	public void getValuesTrans(String itemCode,Integer priceversion){
		try {
			query="SELECT  ip.item_mrp, ip.item_rate, ip.price_version " +
					" FROM item_price ip, item_site_inventory isi" +
					" where ip.item_code='"+itemCode+"'"+
						"  and ip.price_version = isi.price_version"  +
						"  and isi.price_version = '"+priceversion+"'" +
					" order by ip.item_mrp desc";
			System.out.println(query);			
			rs= stat.executeQuery(query);			
		} catch (SQLException e) {
			e.printStackTrace();	
		}		
	}
	
	// public int saveInBreakDownHeader(String bachka_code, float loss, int site_id, String userName)
	public int saveInBreakDownHeader(String bachka_code, float loss, float gain,int site_id, String userName){
		try {
			System.out.println(" bachka code  "+bachka_code);
			
			/*
			 
			  PreparedStatement stmt = conn.prepareStatement("insert into breakdown_header(bachka_code,loss_in_breakdown,site_id, bd_date, entered_by)" +
					" values ('"+bachka_code+"',"+loss+","+site_id+", now(),'"+userName+"')",Statement.RETURN_GENERATED_KEYS);
			*/
			
			PreparedStatement stmt = conn.prepareStatement("insert into breakdown_header(bachka_code,loss_in_breakdown,site_id, bd_date, entered_by,gain_in_breakdown)" +
					" values ('"+bachka_code+"',"+loss+","+site_id+", now(),'"+userName+"',"+gain+")",Statement.RETURN_GENERATED_KEYS);
			
			System.out.println(stmt.toString());
			stmt.executeUpdate();
			rs=stmt.getGeneratedKeys();
			if(rs.next()){
				int pkey = rs.getInt(1);
				System.out.println("return key "+pkey);
				//return rs.getInt(1);
				System.out.println("save in brekdown header .... ");
				return pkey;
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return 0;
	}
	
	public Integer saveInItemReceiptHeader(Integer vendor_id, Integer site_id, String bill_number, Integer total_items,String enteredby){
		try {
			PreparedStatement stmt = conn.prepareStatement("insert into item_receipt_header(vendor_id, site_id, bill_number, total_items, po_date, enteredby)" +
					" values ("+vendor_id+","+site_id+",'"+bill_number+"',"+total_items+",now(),'"+enteredby+"')",Statement.RETURN_GENERATED_KEYS);
			System.out.println(stmt.toString());
			stmt.executeUpdate();
			rs=stmt.getGeneratedKeys();
			if(rs.next()){
				return rs.getInt(1);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return 0;
		
	}
	public Integer saveInTransferInventory(Integer site_id, Integer desId, Integer total_items,Integer total_trans_qty,String status,String transfer_by){
		try {
			conn.setAutoCommit(false);
			String transfer_inventory = "insert into transfer_inventory(source_site_id, dest_site_id, total_trans_items,total_trans_qty, status,transfer_date,transfer_by)" +
					" values ("+site_id+","+desId+","+total_items+","+total_trans_qty+",'"+status+"',CURDATE(),'"+transfer_by+"')"; 
			PreparedStatement stmt = conn.prepareStatement(transfer_inventory,Statement.RETURN_GENERATED_KEYS);
			System.out.println(stmt.toString()+"\n transfer_inventory "+transfer_inventory);
			
			stmt.executeUpdate();
			rs=stmt.getGeneratedKeys();
			if(rs.next()){
				return rs.getInt(1);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return 0;
		
	}
	
	// edit Transfer Inventory 
	public boolean editInTransferInventory(Integer total_trans_qty,String transferID,int totalItems){
		try {
			conn.setAutoCommit(false);
			String updateTransferInventory = "update transfer_inventory set  total_trans_qty=? ,total_trans_items =? " +
											 " where transfer_id=?"; 
			
			PreparedStatement preparedStatement = conn.prepareStatement(updateTransferInventory);
			preparedStatement.setInt(1,total_trans_qty);
			preparedStatement.setInt(2,totalItems);
			preparedStatement.setString(3,transferID);
			
			System.out.println(preparedStatement.toString()+"\n transfer_inventory "+updateTransferInventory);
			int count = preparedStatement.executeUpdate();
			if(count>0){
				return true;
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return false;
		
	}
	
	
	public boolean saveInTransferDetails( Integer transfer_id,String item_code, Integer price_version, Integer transfer_qty,String item_trans_status,String sourceID){
		try {
			
			query="insert into transfer_inventory_details(transfer_id,item_code, price_version, transfer_qty,item_trans_status)" +
					" values ("+transfer_id+",'"+item_code+"',"+price_version+","+transfer_qty+",'"+item_trans_status+"')";
			System.out.println(" transfer inventory deatails "+ query);
			//conn.setAutoCommit(false);
			int ans = stat.executeUpdate(query);
			
			if(ans > 0){ 
				query=	" update item_site_inventory "
						+" set item_site_qty=item_site_qty-"+transfer_qty
						+" where item_code=?"
						+" and price_version=?"
						+" and site_id=?;";
				PreparedStatement preparedStatement = conn.prepareStatement(query);
				preparedStatement.setString(1, item_code);
				preparedStatement.setInt(2, price_version);
				preparedStatement.setString(3, sourceID);
				ans = preparedStatement.executeUpdate();
				if(ans>0)
					conn.commit();
				return true;
			}	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback();
				e.printStackTrace();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return false;
		
	}
	
	/// edit Transfer Inventory Deails
	public boolean editInTransferDetails( String transfer_id,String[] item_code, String[] price_version, String[] transfer_qty,String[] transfer_qty2){
		PreparedStatement preparedStatement=null;
		String updateTransferInvenetoryDetails = null;
		String insertTransferInvenetoryDetails=null;
		String updateItemSiteInventoryDetails = null; 
		int count=0,executeQuery=0;
		
		try {
			/*query="insert into transfer_inventory_details(transfer_id,item_code, price_version, transfer_qty,item_trans_status)" +
					" values ("+transfer_id+",'"+item_code+"',"+price_version+","+transfer_qty+",'"+item_trans_status+"')";
			*/
			insertTransferInvenetoryDetails="insert into transfer_inventory_details (transfer_id, item_code, price_version, transfer_qty, item_trans_status, remark)"
											+" values (?,?,?,?,?,null);";
			updateTransferInvenetoryDetails = "update transfer_inventory_details set transfer_qty=? " +
													"where  transfer_id=? and item_code=? and price_version=? ";
			
			
			
			for(int i=0;i<item_code.length;i++){
				boolean flag=false;
				preparedStatement = conn.prepareStatement("select * from transfer_inventory_details where transfer_id=? and item_code=? and price_version=? ");
				preparedStatement.setString(1, transfer_id);
				preparedStatement.setString(2,item_code[i]);
				preparedStatement.setInt(3, Integer.parseInt(price_version[i]));
				System.out.println("select * from transfer_inventory_details where transfer_id=? and item_code=? and price_version=? ");
				System.out.println("transfer Id "+transfer_id+"\t item Code "+item_code[i]+"\t price version "+price_version[i]+"\t transfer Qty "+transfer_qty[i]);
				ResultSet resultSet = preparedStatement.executeQuery();
				if(resultSet.next())
					flag=true;
				//preparedStatement.close();
				if(flag){
					//update operation	
					preparedStatement = conn.prepareStatement(updateTransferInvenetoryDetails);
					preparedStatement.setInt(1, Integer.parseInt(transfer_qty[i]));
					preparedStatement.setString(2, transfer_id);
					preparedStatement.setString(3,item_code[i]);
					preparedStatement.setInt(4, Integer.parseInt(price_version[i]));
					System.out.println(" updateTransferInvenetoryDetails "+ updateTransferInvenetoryDetails);
					
					executeQuery =preparedStatement.executeUpdate();
				}else{
					// insert operation
					preparedStatement = conn.prepareStatement(insertTransferInvenetoryDetails);
					preparedStatement.setString(1, transfer_id);
					preparedStatement.setString(2, item_code[i]);
					preparedStatement.setString(3, price_version[i]);
					preparedStatement.setString(4, transfer_qty[i]);
					preparedStatement.setString(5, "TRANSFER");
					System.out.println(" insertTransferInvenetoryDetails "+ insertTransferInvenetoryDetails);
					executeQuery=preparedStatement.executeUpdate();
					
				}
				if(executeQuery>0){
					//add item site inventory
					if(Integer.parseInt(transfer_qty[i])>Integer.parseInt(transfer_qty2[i])){
						int trsnsQty =Integer.parseInt(transfer_qty[i])-Integer.parseInt(transfer_qty2[i]);
						updateItemSiteInventoryDetails=	" update item_site_inventory "
														+" set item_site_qty=item_site_qty-"+trsnsQty
														+" where item_code=?"
														+" and price_version=?"
														+" and site_id=?;";
					}else{
						//substract item site inventory
						int trsnsQty =Integer.parseInt(transfer_qty2[i])-Integer.parseInt(transfer_qty[i]);
						updateItemSiteInventoryDetails=	" update item_site_inventory "
														+" set item_site_qty=item_site_qty+"+trsnsQty
														+" where item_code=?"
														+" and price_version=?"
														+" and site_id=?;";
						
					}	
					
					preparedStatement = conn.prepareStatement(updateItemSiteInventoryDetails);
					preparedStatement.setString(1,item_code[i]);
					preparedStatement.setString(2,price_version[i]);
					preparedStatement.setString(3, "1");
					System.out.println("updateItemSiteInventoryDetails "+updateItemSiteInventoryDetails);
					preparedStatement.execute();
					
				}
							
				count++;
				
			}
			System.out.println("count "+count);
			if(count>0){
				conn.commit();
				return true;
			}	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			return false;
		}
		return false;
		
	}
	
	public boolean saveBreakDownDetails(Integer bd_number, String item_code, Integer price_version, Integer new_qty){
		try {
			query="insert into breakdown_detail(bd_number, item_code, price_version, new_qty)" +
					" values ("+bd_number+",'"+item_code+"',"+price_version+","+new_qty+")";
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	public void setBaachkaCount(int break_count, String item_code, int site_id,int price_version){
		try {
			query="SELECT m.item_qty,i.item_pv_qty,s.item_site_qty "+
					"FROM item_price i,item_master m,item_site_inventory s "+
					"where m.item_code = '"+item_code+"' and i.item_code = '"+item_code+"' and i.price_version ="+price_version+" and s.item_code = '"+item_code+"' and s.price_version = "+price_version+" and s.site_id="+site_id;
			System.out.println(query);
			rs = stat.executeQuery(query);
			int master_prev_qty=0;
			int price_prev_qty=0;
			int site_prev_qty=0;
			if(rs.next()){
				master_prev_qty = rs.getInt(1);
				price_prev_qty = rs.getInt(2);
				site_prev_qty = rs.getInt(3);
			}
			
			System.out.println("==========================================================");
			System.out.println("master_prev_qty ="+master_prev_qty );
			System.out.println("price_prev_qty ="+price_prev_qty );
			System.out.println("site_prev_qty ="+site_prev_qty );
			System.out.println("breake_count ="+break_count );
			
			System.out.println("==========================================================");
		
				// updating item_master table  
			
				query = "update item_master set item_qty = "+(master_prev_qty-break_count)+" where item_code = '"+item_code+"'";
				stat.executeUpdate(query);
				System.out.println(query);
				System.out.println("master prev qty greater than brek count .. ");
				
				// updating item_price table  
					
				query = "update item_price i set i.item_pv_qty="+(price_prev_qty-break_count)+" where i.item_code = '"+item_code+"' and i.price_version ="+price_version;
				stat.executeUpdate(query);
				System.out.println(query);
				System.out.println("price prev qty greater than brek count .. ");
				
				// updating item_site table  
				
				query = "update item_site_inventory i set i.item_site_qty="+(site_prev_qty-break_count)+" where i.item_code = '"+item_code+"' and i.price_version="+price_version+" and i.site_id="+site_id;
				stat.executeUpdate(query);
				System.out.println(query);
				System.out.println("site prev qty greater than brek count .. ");
			
			
			
			
			
			/*
				code to save gain updates
			
			query = "update item_master set item_qty = "+(break_count-master_prev_qty)+" where item_code = '"+item_code+"'";
			stat.executeUpdate(query);
			System.out.println(query);
			query = "update item_price i set i.item_pv_qty="+(break_count-price_prev_qty)+" where i.item_code = '"+item_code+"' and i.price_version ="+price_version;
			stat.executeUpdate(query);
			System.out.println(query);
			query = "update item_site_inventory i set i.item_site_qty="+(break_count-site_prev_qty)+" where i.item_code = '"+item_code+"' and i.price_version="+price_version+" and i.site_id="+site_id;
			stat.executeUpdate(query);
			System.out.println(query);
			 	
						  
			 */
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean saveInItemReceiptDetails(Integer po_number, String item_code, Integer price_version, Integer new_qty){
		try {
			query="insert into item_receipt_details(po_number, item_code, price_version, new_qty)" +
					" values ("+po_number+",'"+item_code+"',"+price_version+","+new_qty+")";
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	//po_number, item_code, price_version, new_qty
	
	public boolean saveInItemMaster(String itemCode,String rate,String mrp, Integer newQty){
		try {
			query="SELECT item_qty FROM item_master ip " +
					"where ip.item_code= '"+itemCode+"'";
			rs= stat.executeQuery(query);
			int item_qty = 0;
			
			if(rs.next()){
				item_qty = rs.getInt(1);
			}
			
			System.out.println(" item qty "+ item_qty);
			System.out.println(" new qty "+ newQty);
			
			int totalQty = item_qty + newQty;
			
			query="update item_master set " +
					" item_rate='"+rate+"'," +
					" item_mrp='"+mrp+"'," +
					" item_qty="+totalQty+"" +
					" where  item_code = '"+itemCode+"'";
			
			System.out.println("rate "+rate);
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean updatetrnsferInventory(String itemStatus, Integer transferid,String Remark,int grandAcceptQty,String receive_by){
		try {
		System.out.println(" === updating transfer inventory ");
			
			query=" update transfer_inventory set " +
				  " status=? ,remark=?,total_trans_qty=?,receive_by=?"+
				  " where  transfer_id= ?";
				
					
			
			
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, itemStatus);
			preparedStatement.setString(2, Remark);
			preparedStatement.setInt(3, grandAcceptQty);
			preparedStatement.setString(4, receive_by);
			preparedStatement.setInt(5, transferid);
			System.out.println("update transfer inventory "+query);
			int ans=preparedStatement.executeUpdate();
			if(ans > 0){
				conn.commit();
				return true;
			}
		} catch (SQLException e) {
			System.out.println("Error in update : "+e);
			e.printStackTrace();
			return false;
		}
		return false;
	}
	public boolean updatetrnsInventory(String itemStatus, Integer transferid,String remark){
		try {
			query="update transfer_inventory set " +
					" status='"+itemStatus+"'," +
					" remark='"+remark+"'"+
					" where  transfer_id= '"+transferid+"'";
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
		
	public boolean updateCloseDetailsInventory(String itemCode, String remark,Integer transferId){
		try {
			query="update transfer_inventory_details set " +
					"remark='"+remark+"'"+
					" where  transfer_id= '"+transferId+"'" +
							" and item_code='"+itemCode+"'";
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean updatetrnsInventorydetails(String itemStatus,String itemcode, Integer transferid,String Remark,int siteId,int desID,String priceversion,int srcQty,int destQty,String transferQty){
		try {
			System.out.println(priceversion +" source qty "+srcQty+"\n dest qty "+destQty+"\n transfer qty "+transferQty);
			
			CallableStatement callableStatement = conn.prepareCall("CALL updateItemSiteQtyOnReceiveInventory(?,?,?,?,?,?,?,?,?,?,?)");
			callableStatement.setString(1, itemStatus);
			callableStatement.setString(2, itemcode);
			callableStatement.setInt(3, transferid);
			
			callableStatement.setInt(4, srcQty);
			callableStatement.setInt(5, destQty);
			callableStatement.setInt(6, Integer.parseInt(transferQty));
			
			callableStatement.setString(7, Remark);
			callableStatement.setInt(8, siteId);
			callableStatement.setInt(9, desID);
			callableStatement.setInt(10, Integer.parseInt(priceversion));
			callableStatement.registerOutParameter(11, java.sql.Types.BOOLEAN);
			
			
			System.out.println("CALL updateItemSiteQtyOnReceiveInventory(?,?,?,?,?,?,?,?,?) "+callableStatement.execute());
			ResultSet resultSet = callableStatement.executeQuery();
			if(resultSet.next()){
				System.out.println("count tows "+resultSet.getString(1));
				System.out.println("source tows "+resultSet.getString(2));
				System.out.println("dest tows "+resultSet.getString(3));
				System.out.println("transfer tows "+resultSet.getString(4));
				
				
			}
			boolean flag = callableStatement.getBoolean(11);
			
			if(flag) {
				System.out.println("updated item site inventory and transfer ineventory details ");
				return true;
			}
				
			
		} catch (SQLException e) {
			System.out.println("Error : "+e);
			e.printStackTrace();
			return false;
		}
		return false;
	}
	public boolean updateitemsiteInventory(String itemcode,int itemqty,Integer priceversion,Integer siteId){
		try {
			System.out.println("updating tem java ");
			query="update item_site_inventory  set " +
					" item_site_qty='"+itemqty+"'" +
					" where item_code='"+itemcode+"'" +
					" and price_version='"+priceversion+"'" +
					" and site_id='"+siteId+"'" ;
			System.out.println(query);
			int ans = stat.executeUpdate(query);
			if(ans == 1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean updateitemdesInventory(String itemcode,int desqty,Integer priceversion,Integer desId){
		try {
			query="SELECT site_id FROM item_site_inventory i" +
					" where item_code='"+itemcode+"'" +
						" and price_version='"+priceversion+"'" +
						" and site_id='"+desId+"'";
			rs= stat.executeQuery(query);
			int site_id = 0;
			int ans =0;
			if(rs.next()){
				query="update item_site_inventory  set " +
						" item_site_qty='"+desqty+"'" +
						" where item_code='"+itemcode+"'" +
						" and price_version='"+priceversion+"'" +
						" and site_id='"+desId+"'" ;
				System.out.println(query);
				 ans = stat.executeUpdate(query);
				 if(ans == 1) return true;
					else return false;
			}else{
				query="insert into item_site_inventory(item_code, price_version, site_id, item_site_qty)" +
						"values ('"+itemcode+"','"+priceversion+"','"+desId+"','"+desqty+"')";
				System.out.println(query);
				 ans = stat.executeUpdate(query);
				 if(ans == 1) return true;
					else return false;
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public boolean saveInItemPrice(String itemCode,String rate,String mrp, Integer newQty,Integer priceVersion){
		//item_code, price_version, item_mrp, item_rate, item_pv_qty
		try {
			System.out.println("update item price ite rate "+ rate);
			Integer item_pv_qty=0;
			query="SELECT item_pv_qty " +
					" FROM item_price" +
					" where item_code='"+itemCode+"'"+						
							" and price_version = " +priceVersion;				
			System.out.println(query);			
			rs= stat.executeQuery(query);
			if(rs.next()){
				item_pv_qty = rs.getInt(1);
				item_pv_qty = item_pv_qty + newQty;
				query="update item_price set " +
						" item_rate='"+rate+"'," +
						" item_mrp='"+mrp+"'," +
						" item_pv_qty="+item_pv_qty+"," +
						" active_flag='Y'" +
						" where  item_code = '"+itemCode+"'" +
							" and price_version = " +priceVersion;
				System.out.println("\n\nupdate item price  "+ query);
				int ans = stat.executeUpdate(query);
				if(ans == 1) return true;
				else return false;
			}else{
				query="insert into item_price(item_code, price_version, item_mrp, item_rate, item_pv_qty, current_flag)" +
						" values ('"+itemCode+"',"+priceVersion+",'"+mrp+"','"+rate+"',"+newQty+",'N')";
				System.out.println(query);
				int ans = stat.executeUpdate(query);
				if(ans == 1) return true;
				else return false;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}	
	}

	public boolean saveInItemSiteInventory(String itemCode,Integer siteId, Integer newQty,Integer priceVersion){
		//item_code, price_version, site_id, item_site_qty
		try {
			Integer item_site_qty=0;
			query="SELECT item_site_qty " +
					" FROM item_site_inventory" +
					" where item_code='"+itemCode+"'"+						
							" and price_version = " +priceVersion+
							" and site_id="+siteId;				
			System.out.println(query);			
			rs= stat.executeQuery(query);
			if(rs.next()){
				item_site_qty = rs.getInt(1);
				item_site_qty = item_site_qty + newQty;
				query="update item_site_inventory set " +
						" item_site_qty="+item_site_qty+"" +
						" where  item_code = '"+itemCode+"'" +
							" and price_version = " +priceVersion+
							" and site_id="+siteId;
				System.out.println(query);	
				int ans = stat.executeUpdate(query);
				if(ans == 1) return true;
				else return false;
			}else{
				query="insert into item_site_inventory(item_code, price_version, site_id, item_site_qty)" +
						" values ('"+itemCode+"',"+priceVersion+",'"+siteId+"',"+newQty+")";
				System.out.println(query);	
				int ans = stat.executeUpdate(query);
				if(ans == 1) return true;
				else return false;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}	
	}
	
	public ResultSet getItemDetails(String item_code,String priceVersion) {
		ResultSet resultSet=null;;
		//String itemDetailsQuery = "select barcode,item_name,item_weight,item_rate, item_mrp "
		//						  +"from item_master where item_code=?; ";	
		
		String itemDetailsQuery = "select m.barcode,m.item_name,m.item_weight,m.item_rate, m.item_mrp,p.price_version "
								+" from item_master m,item_price p "
								+" where m.item_code=?"
								+" and p.price_version=? "
								+" and p.active_flag='Y'"
								+" and p.item_code=m.item_code ;";	  
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(itemDetailsQuery);
			preparedStatement.setString(1,item_code);
			preparedStatement.setString(2, priceVersion);
			System.out.println("itemDetailsQuery "+itemDetailsQuery);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
	}
	
	public boolean preventDuplicateTransfer(String transferId,String itemCode,String priceVersion) {
		String duplicateTransferQuery =  "select * from transfer_inventory_details "
									+" where transfer_id=?"
									+" and item_code=?"
									+" and price_version=?;";
		System.out.println("transfer Id "+transferId+"\n itemCode "+itemCode+"\n priceVersion "+priceVersion);
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(duplicateTransferQuery);
			preparedStatement.setString(1, transferId);
			preparedStatement.setString(2, itemCode);
			preparedStatement.setString(3, priceVersion);
			System.out.println("duplicateTransferQuery "+duplicateTransferQuery);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
