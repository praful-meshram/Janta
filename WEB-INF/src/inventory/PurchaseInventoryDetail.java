/**
 * 
 */
package inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import beans.PurchaseDetailsOutputBean;

import outputbean.ItemPurchaseInventoryBean;
import outputbean.PurchaseInventoryJasperBean;



/**
 * @author praful
 * @date 12-02-2014
 * 
 * code for manage purchase inventory 
 *
 */
public class PurchaseInventoryDetail {
	
	private static Vector iReportDataSource = new Vector();
	// return connection according to the resource name passed as parameter
	public Connection  getConnection(){
		Connection connection = null;
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource dataSource = (DataSource)envContext.lookup("jdbc/re"); // always point to main DB
			connection = dataSource.getConnection();
			
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
			
		return connection;
	}
	
	public Hashtable getVendorList() {
		System.out.println("in method ");
		Hashtable<Integer, String> vendorList =null;
		Connection connection = getConnection();
		String vendorListQuery = "select vendor_id,vendor_name from vendor_master order by 1 desc ; ";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(vendorListQuery);
			System.out.println("vendorListQuery "+vendorListQuery);
			ResultSet resultSet = preparedStatement.executeQuery();  
			vendorList = new Hashtable<Integer, String>();
			while (resultSet.next()) {
				System.out.println(resultSet.getInt(1)+" "+ resultSet.getString(2));
				vendorList.put(resultSet.getInt(1), resultSet.getString(2));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return vendorList;
		
	}
	
	// following method will return Arraylist of PurchaseInventoryJasperBean which 
	// consist Arraylist of ItemPurchaseInventoryBean used for ireport
	public ArrayList<PurchaseInventoryJasperBean> getPurchaseInventoryDetails(String vendorID ,String fromDate ,String toDate) {
		String purchaseDetailsQuery = "select h.po_number,m.item_name,d.item_code ,p.item_mrp ,p.item_rate,d.new_qty,"
									+"s.site_name ,h.bill_number,h.po_date,h.enteredby,v.vendor_name ,v.vendor_id "
									+"from item_receipt_header h ,item_receipt_details d ,item_price p ,site_master s ," +
									"vendor_master v , item_master m "
									+"where date(h.po_date) between ? and ? ";
		if(vendorID!="" && vendorID!=null)
			purchaseDetailsQuery +=	"and h.vendor_id= ? ";
		
			purchaseDetailsQuery += "and h.po_number = d.po_number "
									+"and d.item_code = p.item_code "
									+"and d.price_version = p.price_version "
									+"and s.site_id = h.site_id " +
									"and h.vendor_id=v.vendor_id " +
									"and m.item_code = d.item_code " +
									"order by v.vendor_id desc ";
		
		
		ArrayList<ItemPurchaseInventoryBean> purchaseDetailsList = new ArrayList<ItemPurchaseInventoryBean>(); // list for subReport
		ArrayList<PurchaseInventoryJasperBean> purchaseDetailsMasterList = new ArrayList<PurchaseInventoryJasperBean>(); // list for subReport
		int vendorIdDB = 0;
		
		Connection connection = getConnection();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(purchaseDetailsQuery);
			
			preparedStatement.setString(1, fromDate);
			preparedStatement.setString(2, toDate);
			if(vendorID!="" && vendorID!=null)
				preparedStatement.setString(3, vendorID);
			
			System.out.println("purchaseDetailsQuery "+purchaseDetailsQuery);
			System.out.println("from date "+fromDate+"\t to date "+toDate+"\tvendorID "+vendorID);
			ResultSet resultSet = preparedStatement.executeQuery();
			//int i =0;
			while (resultSet.next()) {
				if(vendorIdDB==0)
					vendorIdDB = resultSet.getInt("vendor_id");
				
				ItemPurchaseInventoryBean purchaseInventoryBean = new ItemPurchaseInventoryBean();
				purchaseInventoryBean.setPo_number(resultSet.getInt("po_number"));
				purchaseInventoryBean.setItemCode(resultSet.getString("item_code"));
				purchaseInventoryBean.setItemName(resultSet.getString("item_name"));
				
				purchaseInventoryBean.setItemMRP(resultSet.getFloat("item_mrp"));
				purchaseInventoryBean.setItemRate(resultSet.getFloat("item_rate"));
				purchaseInventoryBean.setItemQty(resultSet.getInt("new_qty"));
				purchaseInventoryBean.setSiteName(resultSet.getString("site_name"));
				purchaseInventoryBean.setBillNumber(resultSet.getString("bill_number"));
				purchaseInventoryBean.setPoDate(resultSet.getString("po_date"));
				purchaseInventoryBean.setEnteredBy(resultSet.getString("enteredby"));
				purchaseInventoryBean.setVendorName(resultSet.getString("vendor_name"));
				
				
				
				if(vendorIdDB!=resultSet.getInt("vendor_id")){
					System.out.println(" list add "+vendorIdDB);
					//add subreport  arrylist in main report 
					PurchaseInventoryJasperBean purchaseInventoryJasperBean=new PurchaseInventoryJasperBean(); 
					purchaseInventoryJasperBean.setListItemPurchseInventoryBean(purchaseDetailsList);
					purchaseDetailsMasterList.add(purchaseInventoryJasperBean);
					
					// create new Array list for diffrent vendor 
					purchaseDetailsList = new ArrayList<ItemPurchaseInventoryBean>();
					purchaseDetailsList.add(purchaseInventoryBean);
				}else{
					purchaseDetailsList.add(purchaseInventoryBean);
				}
				
				vendorIdDB = resultSet.getInt("vendor_id");	
				//System.out.println(vendorIdDB + " result set "+(i++));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				connection.close();
				System.out.println("connection closed ");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// adding last vendor detail
		PurchaseInventoryJasperBean purchaseInventoryJasperBean=new PurchaseInventoryJasperBean(); 
		purchaseInventoryJasperBean.setListItemPurchseInventoryBean(purchaseDetailsList);
		purchaseDetailsMasterList.add(purchaseInventoryJasperBean);
		
		return purchaseDetailsMasterList;
		
		
	} 
	
	
}
