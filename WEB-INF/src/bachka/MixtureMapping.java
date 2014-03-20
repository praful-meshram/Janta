package bachka;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.org.apache.bcel.internal.generic.RETURN;

public class MixtureMapping {

	private Connection connection=null;
	private ResultSet resultSet =null;
	
	// code for Connection object
	public Connection getConnection(String env) {
		Context initContext;
		
		try {
			initContext = new InitialContext();
			Context envText = (Context)initContext.lookup("java:/comp/env");
			DataSource dataSource = (DataSource)envText.lookup(env);
			connection = dataSource.getConnection();
			System.out.println("===\nConneted to data base"); 
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}
	
	public  ResultSet getSite(){
		
		try {
		 String	query="select site_id, site_name from site_master order by site_id";			
			System.out.println(query);
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			System.out.println(query);
			resultSet = preparedStatement.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return resultSet;
	}
	
	
	
	// serach mixture item 
	public ResultSet searchMixture(String barcode,String itemName, String is_bachka,String item_group_code)
	{
		String where =null;
		String query =null;
		
		try {
		/*	query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
					" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code ";
			//query = query +", m.item_group_code";
					
			 where = " WHERE 1=1 ";
			if(barcode != "" && barcode != null)
				where= where +" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				where= where+" and m.item_name like '"+itemName +"%'";
			
			
			where= where + " and p.item_code = m.item_code and m.is_bachka='false' and mix_item = 'true'";
			//where=where+" and m.is_bachka='false' and mix_item = 'true'";
			
			query = query + " FROM item_master m,item_price p "+where;
			System.out.println("=========\n"+is_bachka+ query+"\n========");
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			resultSet = preparedStatement.executeQuery(query);
			*/
			//
			
			query = "select m.item_code, m.item_weight, m.item_name, m.item_qty , m.item_mrp ,m.item_group_code";
			 where = " WHERE 1=1 ";
			if(barcode != "" && barcode != null)
				where= where +" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				where= where+	" and m.item_name like '"+itemName +"%'";
			
			where=where+" and m.is_bachka='false' and mix_item = 'true'";
			
			query = query + " FROM item_master m "+where;
			System.out.println("=========\n"+is_bachka+ query+"\n========");
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			resultSet = preparedStatement.executeQuery();
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return resultSet;
	}
	
	public ResultSet getMixtureList(String barcode,String itemName, String is_bachka,String item_group_code) {
		String where =null;
		String query =null;
		
		query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
				" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code ";
		//query = query +", m.item_group_code";

		 where = " WHERE 1=1 and m.item_code=p.item_code ";
			if(barcode != "" && barcode != null)
				where= where +" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				where= where+	" and m.item_name like '"+itemName +"%'";
			
			where=where+" and m.is_bachka='false' and mix_item = 'true'";
			
			query = query + " FROM item_master m,item_price p "+where;
			System.out.println("=========\n"+is_bachka+ query+"\n========");
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement;
			try {
				preparedStatement = connection.prepareStatement(query);
				resultSet = preparedStatement.executeQuery();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	
		
		return resultSet;
	}
	
	// code for item group code
	public  ResultSet getItemGroupCode(){
		
		try {
			String query="select item_group_code, item_group_desc from item_group ";	
			//String query="select distinct item_group_code from item_master";	
			
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			System.out.println(query);
			resultSet= preparedStatement.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return resultSet;
	}
	
	
	public String getItemGrupCodeDesc(String itemGroupCode) {
		String itemGroupCodeDesc = null;
		connection = getConnection("jdbc/js");
		String selectQuery = "select item_group_desc from item_group  where item_group_code = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
			preparedStatement.setString(1,itemGroupCode);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()){
				itemGroupCodeDesc = resultSet.getString(1);
			}
			closeAll();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return itemGroupCodeDesc;
	}
	
	
	// fetching data item from database according to input
	public ResultSet getItemBygroupCode(String item_group_code,String itemName) {
/*		String query  = "SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty ,p.price_version, p.item_mrp, p.item_rate," +
						" p.item_pv_qty, m.box_qty , m.item_group_code "+ 
						" from item_master m , item_price p "+
						" where m.item_group_code = '"+item_group_code+"' and m.is_bachka='false' and p.item_code = m.item_code and m.mix_item='false'";*/
		
		//////
		System.out.println(" ========== item_group_code "+item_group_code );
		System.out.println(" itemName "+itemName );
		
		String query = "select m.item_code, m.item_weight, m.item_name, m.item_qty , m.item_mrp ,m.item_group_code from item_master m where 1=1 ";
		
		if(itemName==null){
			query = query +	" and m.item_group_code = '"+item_group_code+"'" ;
		}else{
			if(!item_group_code.equals("") && !itemName.equals(""))
				query = query +	" and m.item_group_code = '"+item_group_code+"' and m.item_name like '"+itemName +"%' ";
			else if(!itemName.equals(""))
				query = query +	" and m.item_name like '"+itemName +"%'";
			else
				query = query +	" and m.item_group_code = '"+item_group_code+"' ";
		}
		
		//query = query+ " and m.is_bachka='false' and mix_item='false' and p.item_code = m.item_code";	
		query = query+ " and m.is_bachka='false' and mix_item='false' ";	
		
		
		try {
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			System.out.println("===\n\n QUERY "+query);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
		
		return resultSet;
	}
	
	// method for inserting mapping into Mixture Mapping table
	
	public int insertIntoMapping(String mixtureCodeArray[],String itemCodeArray[]) {
		String insertQuery = "insert into mixture_mapping (mixture_code , item_code) values (?,?)";
		int count = 0;
		connection = getConnection("jdbc/js");
		
		PreparedStatement preparedStatement = null;
		try {
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertQuery);
			for(int i = 0;i<mixtureCodeArray.length && i<itemCodeArray.length ; i++ )
			{
				System.out.println("insert value "+ i);
				preparedStatement.setString(1, mixtureCodeArray[i]);
				preparedStatement.setString(2, itemCodeArray[i]);
				preparedStatement.addBatch();
				
			}
			int rows[] = preparedStatement.executeBatch();
			count = rows.length;
			connection.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				int update = preparedStatement.getUpdateCount();
				System.out.println(" rows inserted "+ update );
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		
		return count;
	}
	
	
	// code to retrive item code from mixture mapping 
	public ArrayList<String> getItemCode(String mixtureCode) {
		String itemCodeQuery = "SELECT item_code FROM mixture_mapping b where mixture_code=?";
		connection = getConnection("jdbc/js");
		ArrayList<String> itemCodeArray = new ArrayList<String>();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(itemCodeQuery);
			preparedStatement.setString(1, mixtureCode);
			System.out.println(itemCodeQuery+"  "+mixtureCode);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()){
				do{
					System.out.println(" array list item  code  ");	
					itemCodeArray.add(resultSet.getString(1));
				}while(resultSet.next()); 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("ayyay list size  "+itemCodeArray.size());
		return itemCodeArray;
	
	}
	
	
	// fetch data from mixture mapping
	public ResultSet getMixtureMapping(String mixtureCode) {
		String mixtureMappingQuery = "SELECT  m.item_code,m.item_name,m.item_weight  FROM item_master m join  mixture_mapping b on b.item_code = m.item_code  where mixture_code= ?";  
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(mixtureMappingQuery);
			preparedStatement.setString(1, mixtureCode);
			System.out.println(mixtureMappingQuery);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return resultSet;
	}
	
	
	public  int deleteFormDB(String mixtureCode , String itemCode) {
		
		String deleteQuery = "delete from mixture_mapping where mixture_code = ? and item_code = ?";
		int rowsUpdate =0;
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
			preparedStatement.setString(1, mixtureCode);
			preparedStatement.setString(2,itemCode);
			rowsUpdate = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rowsUpdate;
		
	}
	
	
	public ResultSet getItemFromMixtureMapping(String barcode,String itemName,String mixtureCode) {
		System.out.println("mixture code "+mixtureCode);
		String query = "SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty,p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code " 
						+" from item_master m ,item_price p , mixture_mapping mp where 1=1 and p.item_code = m.item_code and p.active_flag = 'Y' ";
		String where = " and mp.mixture_code = ? and mp.item_code = m.item_code";
		if(barcode !=null && barcode !="")
			where=where + " and m.barcode = '"+barcode+"'";
		if(itemName != "" && itemName != null)
			where= where+	" and m.item_name like '"+itemName +"%'";
		query = query + where;
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, mixtureCode);
			System.out.println("getItemFromMixtureMapping "+query);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
	}
	
	
	// code  to save Into ConversionHeader
		public int saveIntoConversionHeader(String mixture_code, float loss, float gain,int site_id, String userName){
			String insertIntoConversionHeader = "insert into conversion_header(mixture_code,loss_in_breakdown,site_id, bd_date, entered_by,gain_in_breakdown) values (?,?,?,now(),?,?)" ;
													
			try {
				System.out.println(" mixture_code  "+mixture_code);
				connection = getConnection("jdbc/js");
				
				PreparedStatement preparedStatement =  connection.prepareStatement(insertIntoConversionHeader,PreparedStatement.RETURN_GENERATED_KEYS);
				preparedStatement.setString(1,mixture_code);
				preparedStatement.setFloat(2, loss);
				preparedStatement.setInt(3, site_id);
				preparedStatement.setString(4, userName);
				preparedStatement.setFloat(5, gain);
				System.out.println(preparedStatement.toString() + " "+insertIntoConversionHeader);
				preparedStatement.executeUpdate();
				resultSet= preparedStatement.getGeneratedKeys();
				if(resultSet.next()){
					int pkey = resultSet.getInt(1);
					System.out.println("return key "+pkey);
					//return rs.getInt(1);
					System.out.println("save in Conversion header .... ");
					return pkey;
				}			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return 0;
			}
			return 0;
		}
	
		// coe to insert item details inro Conversion details
		public boolean saveConversionDetails(Integer bd_number, String item_code, Integer price_version, Integer new_qty){
			
			String saveConversionDetailsQuery = "insert into conversion_detail(bd_number, item_code, price_version, new_qty) values (?,?,?,?)";
			
			System.out.println("=================== ");
			System.out.println(" bd_number "+bd_number);
			System.out.println(" item_code "+item_code);
			System.out.println(" price_version "+price_version);
			System.out.println(" new_qty "+new_qty);
			
			System.out.println("=================== ");
			
			
			try {
				
				PreparedStatement preparedStatement = connection.prepareStatement(saveConversionDetailsQuery);
				preparedStatement.setInt(1, bd_number);
				preparedStatement.setString(2, item_code);
				preparedStatement.setString(3,price_version.toString());
				preparedStatement.setString(4, new_qty.toString());
				System.out.println(preparedStatement +"  "+ saveConversionDetailsQuery);
				int ans = preparedStatement.executeUpdate();
				System.out.println(" inserted into conversion details ");
				if(ans == 1){ 
					System.out.println("if.............");
					return true;
				}
									
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;
			
		}
		
		
		// coding update i item_master 
		public boolean saveInItemMaster(String itemCode,String rate,String mrp, Integer newQty){
			String  saveInItemMasterQuery="SELECT item_qty FROM item_master ip where ip.item_code= ?";
			try {
				PreparedStatement preparedStatement = connection.prepareStatement(saveInItemMasterQuery);
				preparedStatement.setString(1, itemCode); 
				resultSet = preparedStatement.executeQuery();
				int item_qty = 0;
				
				if(resultSet.next()){
					item_qty = resultSet.getInt(1);
				}
				System.out.println(" item qty "+ item_qty);
				System.out.println(" new qty "+ newQty);
				
				//int totalQty = item_qty + newQty;
				int totalQty = item_qty - newQty;
				
				String  upadteQuery="update item_master set " +
						" item_rate='"+rate+"'," +
						" item_mrp='"+mrp+"'," +
						" item_qty="+totalQty+"" +
						" where  item_code = '"+itemCode+"'";
				
				Statement statement = connection.createStatement();
				System.out.println("rate "+rate);
				System.out.println(" update query  "+ upadteQuery);
				int ans = statement.executeUpdate(upadteQuery);
				if(ans == 1) return true;
				else return false;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		

	// update or insert into Item_price 
		public boolean saveInItemPrice(String itemCode,String rate,String mrp, Integer newQty,Integer priceVersion){
			//item_code, price_version, item_mrp, item_rate, item_pv_qty\
			String selectQuery="SELECT item_pv_qty  FROM item_price  where item_code=?  and price_version = ?";	
		
			try {
				System.out.println("update item price ite rate "+ rate);
				Integer item_pv_qty=0;
				
				PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
				preparedStatement.setString(1, itemCode);
				preparedStatement.setInt(2, priceVersion);
				
				System.out.println(selectQuery);			
				resultSet= preparedStatement.executeQuery();
				if(resultSet.next()){
					item_pv_qty = resultSet.getInt(1);
					item_pv_qty = item_pv_qty + newQty;
					String  updateQuery="update item_price set " +
							" item_rate='"+rate+"'," +
							" item_mrp='"+mrp+"'," +
							" item_pv_qty="+item_pv_qty+"," +
							" active_flag='Y'" +
							" where  item_code = '"+itemCode+"'" +
								" and price_version = " +priceVersion;
					System.out.println("\n\nupdate item price  "+ updateQuery);
					Statement statement = connection.createStatement();
					int ans = statement.executeUpdate(updateQuery);
					if(ans == 1) return true;
					else return false;
				}else{
					String inserQuery="insert into item_price(item_code, price_version, item_mrp, item_rate, item_pv_qty, current_flag)" +
							" values ('"+itemCode+"',"+priceVersion+",'"+mrp+"','"+rate+"',"+newQty+",'N')";
					System.out.println(inserQuery);
					Statement statement = connection.createStatement();
					int ans = statement.executeUpdate(inserQuery);
					if(ans == 1) return true;
					else return false;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}	
		}	
	
		// code for save into item_site_invsentory 
		public boolean saveInItemSiteInventory(String itemCode,Integer siteId, Integer newQty,Integer priceVersion){
			//item_code, price_version, site_id, item_site_qty
			String selectQuery="SELECT item_site_qty  FROM item_site_inventory where item_code=? and price_version = ? and site_id=?";	
			
			try {
				Integer item_site_qty=0;
				PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
				preparedStatement.setString(1, itemCode);
				preparedStatement.setInt(2, priceVersion);
				preparedStatement.setInt(3, siteId);
				

				
				System.out.println(selectQuery);			
				resultSet = preparedStatement.executeQuery();
				if(resultSet.next()){
					item_site_qty = resultSet.getInt(1);
					item_site_qty = item_site_qty + newQty;
				 	String updateQuery="update item_site_inventory set " +
							" item_site_qty="+item_site_qty+"" +
							" where  item_code = '"+itemCode+"'" +
								" and price_version = " +priceVersion+
								" and site_id="+siteId;
					System.out.println(updateQuery);	
					Statement statement = connection.createStatement();
					int ans = statement.executeUpdate(updateQuery);
					if(ans == 1) return true;
					else return false;
				}else{
					String insertQuery="insert into item_site_inventory(item_code, price_version, site_id, item_site_qty)" +
							" values ('"+itemCode+"',"+priceVersion+",'"+siteId+"',"+newQty+")";
					System.out.println(insertQuery);
					Statement statement = connection.createStatement();
					int ans = statement.executeUpdate(insertQuery);
					if(ans == 1) return true;
					else return false;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}	
		}
		
		
		//updating all inventory of all tables
		public void setMixtureCount(int break_count, String item_code, int site_id,int price_version){
			try {
				String selectQuery="SELECT m.item_qty,i.item_pv_qty,s.item_site_qty "+
						"FROM item_price i,item_master m,item_site_inventory s "+
						"where m.item_code = '"+item_code+"' and i.item_code = '"+item_code+"' and i.price_version ="+price_version+" and s.item_code = '"+item_code+"' and s.price_version = "+price_version+" and s.site_id="+site_id;
				PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
				System.out.println(selectQuery);
				resultSet = preparedStatement.executeQuery();
				int master_prev_qty=0;
				int price_prev_qty=0;
				int site_prev_qty=0;
				if(resultSet.next()){
					master_prev_qty = resultSet.getInt(1);
					price_prev_qty = resultSet.getInt(2);
					site_prev_qty = resultSet.getInt(3);
				}
				
				System.out.println("==========================================================");
				System.out.println("master_prev_qty ="+master_prev_qty );
				System.out.println("price_prev_qty ="+price_prev_qty );
				System.out.println("site_prev_qty ="+site_prev_qty );
				System.out.println("breake_count ="+break_count );
				
				System.out.println("==========================================================");
			
					// updating item_master table  
					Statement statement = connection.createStatement();
					String UpadetQuery = "update item_master set item_qty = "+(master_prev_qty+break_count)+" where item_code = '"+item_code+"'";
					System.out.println(UpadetQuery);
					statement.executeUpdate(UpadetQuery);
					System.out.println("master prev qty greater than brek count .. ");
					
					// updating item_price table  
						
					UpadetQuery = "update item_price i set i.item_pv_qty="+(price_prev_qty+break_count)+" where i.item_code = '"+item_code+"' and i.price_version ="+price_version;
					System.out.println(UpadetQuery);
					statement.executeUpdate(UpadetQuery);
					System.out.println("price prev qty greater than brek count .. ");
					
					// updating item_site table  
					
					UpadetQuery = "update item_site_inventory i set i.item_site_qty="+(site_prev_qty+break_count)+" where i.item_code = '"+item_code+"' and i.price_version="+price_version+" and i.site_id="+site_id;
					System.out.println(UpadetQuery);
					statement.executeUpdate(UpadetQuery);
					System.out.println("site prev qty greater than brek count .. ");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		// fetch site name from Databse
		public String siteName(int siteId){
			String siteName = null;
			try{
				connection = getConnection("jdbc/js");	
				Statement statement = connection.createStatement();
				resultSet =statement.executeQuery("select site_name from site_master where site_id="+siteId);
				if(resultSet.next())
					siteName = resultSet.getString(1);
				closeAll();

			}catch(Exception e){
				System.out.println("Error in : ");
				e.printStackTrace();
				closeAll();
				return "error";
			}
			return siteName;
		}
		
		
		// fetch date from databse 
		public String bdDate(int poNo){
			String op = null;	
			try{
				
				connection = getConnection("jdbc/js");
				Statement statement = connection.createStatement();
	 			
				resultSet = statement.executeQuery("select bd_date from breakdown_header where bd_number="+poNo);
				if(resultSet.next())
					op= resultSet.getString(1);
				closeAll();
				
			}catch(Exception e){
				System.out.println("Error in : ");
				e.printStackTrace();
				closeAll();
				return "error";
			}
			return op;
		}
			
		
		
	// closing all connection
	public void closeAll() {
		
		try {
		if(resultSet!=null)
			resultSet.close();
		if(connection!=null)
			connection.close();
		
		System.out.println("connection closed....");
		}
			 catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}
