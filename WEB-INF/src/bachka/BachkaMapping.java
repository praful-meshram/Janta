package bachka;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.google.gson.Gson;

import beans.JasonObject;


public class BachkaMapping {
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
	
	
	
	// serach bachka or item 
	public ResultSet searchBachka(String barcode,String itemName, String is_bachka,String item_group_code){
		String where =null;
		String query =null;
		
		try {
			//query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
			//		" p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code ";
			//query = query +", m.item_group_code";
			
			// query="SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty," +
			//	" m.box_qty , m.item_group_code ";

			query = "select m.item_code, m.item_weight, m.item_name, m.item_qty , m.item_mrp ,m.item_group_code";
			
			
			 where = " WHERE 1=1 ";
			if(barcode != "" && barcode != null)
				where= where +" and m.barcode = '"+barcode+"'" ;
			if(itemName != "" && itemName != null)
				where= where+	" and m.item_name like '"+itemName +"%'";
			//where= where + " and p.item_code = m.item_code and m.box_qty=1";
			where= where + " and m.box_qty=1";
			
			if(is_bachka.equals("searchBachka")){
				where=where+" and m.is_bachka='true' and mix_item = 'false'";
			}
			//query = query + " FROM item_master m,item_price p "+where;
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
	
	
	// code to retrive item by group code
	public ResultSet getItemBygroupCode(String item_group_code,String itemName) {
		
		System.out.println(" ========== item_group_code "+item_group_code );
		System.out.println(" itemName "+itemName );
		
		/*
		String query  = "SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty ,p.price_version, p.item_mrp, p.item_rate," +
						" p.item_pv_qty, m.box_qty , m.item_group_code "+ 
						" from item_master m , item_price p where 1=1 ";*/
		
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
	
	
	
	// code to retrive item code from mixture mapping 
	public ArrayList<String> getItemCode(String mixtureCode) {
		String itemCodeQuery = "SELECT item_code FROM bachka_mapping b where bachka_code=?";
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
	
	// code for item group code
	public  ResultSet getItemGroupCode(){
		
		try {
			//String query="select distinct item_group_code from item_master where  is_bachka='true' and mix_item='false' order by item_group_code ";	
			String query="select item_group_code, item_group_desc from item_group";
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
	
	//get Bachka Mapping
	public ResultSet getBachkaMappingResult(String bachkaCode) {
		
		String query ="SELECT  m.item_code,m.item_name,m.item_weight  FROM item_master m , bachka_mapping b where bachka_code= ? and b.item_code = m.item_code";		
		
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bachkaCode);
			System.out.println("bachka mapping query ::\n" +query +" "+bachkaCode);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
	// code for insering record into DB
	public int insertIntoBachkaMapping(String[] itemCodeArray , String[] bachkaCodeArray) {
		System.out.println("bachka mapping insert");
		String insertQuery = "insert into bachka_mapping (bachka_code,item_code) values (?,?)";
		int rows []=new int[10];
		int count =0;
		PreparedStatement preparedStatement =null;
		try {
			connection = getConnection("jdbc/js");
			connection.setAutoCommit(false);
			 preparedStatement = connection.prepareStatement(insertQuery);
			for (int i = 0; i < bachkaCodeArray.length && i<itemCodeArray.length ; i++) {
				System.out.println(bachkaCodeArray[i]+" "+itemCodeArray[i]);
				preparedStatement.setString(1,bachkaCodeArray[i]);
				preparedStatement.setString(2,itemCodeArray[i]);
				preparedStatement.addBatch();
				System.out.println("insert query "+rows +" : "+insertQuery);
			}
			
			rows = preparedStatement.executeBatch();
			count = rows.length;
			connection.commit();
			System.out.println("insert  rows :"+count);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				connection.rollback();
				count =preparedStatement.getUpdateCount();
				System.out.println("updated rows "+count);
				System.out.println("error occured in "+Math.abs(PreparedStatement.EXECUTE_FAILED));
				preparedStatement.clearBatch();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
		}
		
		return count;
	}
	
	// code for checking duplicate record  
	public int checkBackaMapping(String bachkaCode ,String itemCode) {
		int count = 0;
		String duplicateQuery = "select count(1) from bachka_mapping where bachka_code =? and item_code=?";
		try {
			connection = getConnection("jdbc/js");
			PreparedStatement preparedStatement = connection.prepareStatement(duplicateQuery);
			preparedStatement.setString(1, bachkaCode);
			preparedStatement.setString(2, itemCode);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next())
					count =Integer.parseInt( resultSet.getString(1));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return count;
	}
	
	
	// delete record from databse bachka Mapping
	public int deleteRecord(String bachkaCode,String itemCode) {
		String deleteQuery = "delete from bachka_mapping where bachka_code=? and item_code = ?";
		int count = 0;
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
			preparedStatement.setString(1, bachkaCode);
			preparedStatement.setString(2,itemCode);
			System.out.println(deleteQuery);
			count = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
	public ResultSet getItemfromBachkaMapping(String barcode,String itemName,String bachkaCode) {
		
		System.out.println("bachka Code "+bachkaCode);
		String query = "SELECT m.barcode,m.item_code, m.item_weight, m.item_name, m.item_qty,p.price_version, p.item_mrp, p.item_rate, p.item_pv_qty, m.box_qty , m.item_group_code " 
						+" from item_master m ,item_price p , bachka_mapping mp where 1=1 and p.item_code = m.item_code ";
		String where = " and mp.bachka_code = ? and mp.item_code = m.item_code and p.active_flag = 'Y'";
		if(barcode !=null && barcode !="")
			where=where + " and m.barcode = '"+barcode+"'";
		if(itemName != "" && itemName != null)
			where= where+	" and m.item_name like '"+itemName +"%'";
		query = query + where;
		connection = getConnection("jdbc/js");
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bachkaCode);
			System.out.println("getItemFromMixtureMapping "+query);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
		
	}
	
	// insert exception details
	public boolean insertExceptionDetails(String exceptionPage , String exception ,String message ) {
		String insertQuery = "insert into exception_detail (ExceptionPage, Date, Exception, ExceptionMessage) values(?,now(),?,?)";
		connection = getConnection("jdbc/js");
		int rows=0;
		try {
			Statement statement = connection.createStatement();
			resultSet = statement.executeQuery("select count(1) from exception_detail");
			if(resultSet.next()){
				rows = Integer.parseInt(resultSet.getString(1));
			}
			resultSet.close();	
			if(rows>=300)
			{
				int count = statement.executeUpdate("delete a from exception_detail a,(select min(Date) as Date from exception_detail) b where a.Date = b.Date");
				if(count>0)
					System.out.println("deleted 1 record from exception details ");
				
			}
			PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
			preparedStatement.setString(1, exceptionPage);
			preparedStatement.setString(2, exception);
			preparedStatement.setString(3, message);
		 	int count = preparedStatement.executeUpdate();
		 	if(count>0)
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
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
