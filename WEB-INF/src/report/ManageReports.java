package report;

import java.sql.*;
import java.util.Iterator;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageReports {
	
	public Connection conn=null;
	public Statement  stat;
	public ResultSet rs;
	String envLookup, query1;
	PreparedStatement addValue;
	PreparedStatement editValue;
	
	
	public ManageReports(String envLook){
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
			stat.close();
	    	conn.close();
	   
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
		
	
		
	public void listCollectionDailyReports(){
		
		try{
			String query="select trim(Date(order_date)), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
						 "sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num),payment_type_code from orders group by trim(Date(order_date)),payment_type_code ";
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	

	public void listCollectionDailyReportsWithDate(String c_date1, String c_date2){
		
		try{
			String query="select trim(Date(order_date)), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
			 				"sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num),payment_type_code from orders ";
			   
			
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    //query = query + " where trim(Date(order_date)) between '" + c_date1 + "' and '" + c_date2 + "'";
	    		query = query + " where date_format(order_date,'%Y-%m-%d') between '"+Date.valueOf(c_date1)+"' and '"+Date.valueOf(c_date2)+"'";
	    	}
	    	else if(!c_date1.equals("")){
	    		//query = query + " where trim(Date(order_date)) ='" + c_date1 + "'";
	    		query = query + " where date_format(order_date,'%Y-%m-%d') ='" + Date.valueOf(c_date1) + "'";
	    	} 
	    	//query =query + "  group by trim(Date(order_date)),payment_type_code";	
	    	query =query + "  group by trim(Date(order_date)),payment_type_code";
	    	System.out.println("query "+query);
	    	
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}

	public void listCollectionDailyReportSummary(){
		
		try{
			String query="select trim(Date(order_date)), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
						 "sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num) " +
						 "from orders group by trim(Date(order_date)) ";
	    	System.out.println("rdaily Collections :"+query);
			rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	

	public void listCollectionDailyReportsWithDateSummary(String c_date1, String c_date2){
		
		try{
			String query="select trim(Date(order_date)), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
			 				"sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num) from orders ";
    		//c_date1=c_date1+" 00:00";
    		//c_date2=c_date2+" 23:59";   
			
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    //query = query + " where trim(Date(order_date)) between '" + c_date1 + "' and '" + c_date2 + "'";
	    		query = query + " where date_format(order_date,'%Y-%m-%d') between '" + Date.valueOf(c_date1) + "' and '" + Date.valueOf(c_date2) + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		//query = query + " where trim(Date(order_date)) ='" + c_date1 + "'";
	    		query = query + " where date_format(order_date,'%Y-%m-%d') ='" + Date.valueOf(c_date1) + "'";
	    	} 
	    	query =query + "  group by trim(Date(order_date))";	
	    	System.out.println("rdaily Collections by date :"+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}

	public void listCollectionMonthlyReports(){
		
		try{
			String query="select Monthname(order_date), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
						 "sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num),year(order_date) from orders group by month(order_date),year(order_date) order by year(order_date),month(order_date) ";
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listCollectionMonthlyReportsWithDate(String selMonth){
		
		try{
			String query="select Monthname(order_date), sum(total_value), sum(ifnull(change_amt,0)), sum(ifnull(paid_amt,0))," +
			 				"sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))),count(order_num),year(order_date) from orders ";
			   
			
	    	
	    	if(!selMonth.equals("")){
	    		query = query + " where monthname(order_date) ='" + selMonth + "'";
	    	} 
	    	query =query + "  group by month(order_date),year(order_date) order by year(order_date),month(order_date)";	
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}

	/* Following are the functions for Delivery Report */
	
	public void listDeliveryDailyReports(){
		try{		
			String query="select trim(Date(del_datetime)), sum(total_value), sum(ifnull(change_amt,0)), "+
						 "sum(ifnull(paid_amt,0)), sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))), "+
						 "count(order_num),payment_type_code from orders a "+
						 "where status_code = 'DELIVERED' "+
						 "or exists (select b.order_num from order_history b "+
						 	"where a.order_num = b.order_num "+
						 	"and b.status_code = 'TRANSIT' "+
						 	"and trim(DATE(a.del_datetime)) = DATE_ADD(trim(DATE(a.del_datetime)), INTERVAL 1 DAY)) "+
						 "group by trim(Date(del_datetime)),payment_type_code";				
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryDailyReportsWithDate(String c_date1, String c_date2){
			try{
				String query="select trim(Date(del_datetime)), sum(total_value), sum(ifnull(change_amt,0)), "+
							 "sum(ifnull(paid_amt,0)), sum((ifnull(total_value,0))+(ifnull(change_amt,0))-(ifnull(paid_amt,0))), "+
							 "count(order_num),payment_type_code from orders a";
							 
				
		    	if(!c_date1.equals("") && !c_date2.equals("")){
		    		c_date1=c_date1+" 00:00";
		    		c_date2=c_date2+" 23:59";
		    	    query = query +" where status_code = 'DELIVERED' "+
					 "and ( (trim(date(del_datetime)) between '" + c_date1 + "' and '" + c_date2 + "') "+
					 "or exists (select b.order_num from order_history b "+
					                  "where a.order_num = b.order_num "+
					                  "and b.status_code = 'TRANSIT' "+
					                  "and trim(date(b.record_datetime)) between '" + c_date1 + "' and '" + c_date2 + "' "+
					                  "and trim(DATE(a.del_datetime)) = DATE_ADD(trim(DATE(a.del_datetime)), INTERVAL 1 DAY)))";
		    	}
		    	else if(!c_date1.equals("")){
		    		c_date1=c_date1+" 00:00";
		    		query = query + " where status_code = 'DELIVERED' "+
					 "and ( trim(date(del_datetime)) ='" + c_date1 + "' "+
					 "or exists (select b.order_num from order_history b "+
					                  "where a.order_num = b.order_num "+
					                  "and b.status_code = 'TRANSIT' "+
					                  "and trim(date(b.record_datetime)) ='" + c_date1 + "' "+
					                  "and trim(DATE(a.del_datetime)) = DATE_ADD(trim(DATE(a.del_datetime)), INTERVAL 1 DAY)))";
		    	} 
		    	query =query + "  group by trim(Date(del_datetime)),payment_type_code";		    	
		    	rs=stat.executeQuery(query);
		    	
			}
			catch(Exception e){
				System.out.println("Error occurred in display list of Commission " + e);
				closeAll();			
			}
		}
		
	public void listDeliveryDailyReportSummary(){
		String reportType="DAILY",rangeType="ALL",monthName=null,frmDate=null,toDate=null;
		try{   	
			System.out.println("call delivery_report('"+reportType+"' , '"+rangeType+"' , "+monthName+" , "+frmDate+" , "+toDate+")");
	    	rs=stat.executeQuery("call delivery_report('"+reportType+"' , '"+rangeType+"' , "+monthName+" , "+frmDate+" , "+toDate+")");
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryDailyReportsWithDateSummary(String c_date1, String c_date2){
		String reportType="DAILY",rangeType="RANGE",monthName=null;
		try{   				
			System.out.println("call delivery_report('"+reportType+"' , '"+rangeType+"' , "+monthName+" , '"+c_date1+"' , '"+c_date2+"')");
			rs=stat.executeQuery("call delivery_report('"+reportType+"' , '"+rangeType+"' , "+monthName+" , '"+c_date1+"' , '"+c_date2+"')");	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}	
	public void listDeliveryDailyReportDetails(String order_date){
		try{   	
			System.out.println("call delivery_report_day('"+order_date+"')");
			rs=stat.executeQuery("call delivery_report_day('"+order_date+"')");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryDailyReportAllDetails(){
		try{   	
			rs=stat.executeQuery("call delivery_report_all()");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	//Monthly Delivery Functions
	
	public void listDeliveryMonthlyReports(){
		String reportType="MONTHLY",rangeType="ALL",monthName="ALL",frmDate=null,toDate=null;
		try{
			System.out.println("call delivery_report('"+reportType+"' , '"+rangeType+"' , '"+monthName+"' , "+frmDate+" , "+toDate+")"); 
	    	rs=stat.executeQuery("call delivery_report('"+reportType+"' , '"+rangeType+"' , '"+monthName+"' , "+frmDate+" , "+toDate+")");	    	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryMonthlyReportsWithDate(String selMonth){		
		String reportType="MONTHLY",rangeType="ALL",frmDate=null,toDate=null;		
		try{
			System.out.println("call delivery_report('"+reportType+"' , '"+rangeType+"' , '"+selMonth+"' , "+frmDate+" , "+toDate+")");
			rs=stat.executeQuery("call delivery_report('"+reportType+"' , '"+rangeType+"' , '"+selMonth+"' , "+frmDate+" , "+toDate+")");
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryDailyReportDetailsNew(String order_date, String pmt_type, String order_type){
		try{   	
			System.out.println("data available11 ");
			rs=stat.executeQuery("call delivery_report_day_det('"+order_date+"', '"+pmt_type+"', '"+order_type+"')");
			
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listDeliveryDailyReportAllDetailsNew(String pmt_type, String order_type){
		try{   	
			rs=stat.executeQuery("call delivery_report_det_all('"+pmt_type+"', '"+order_type+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	
	
	public void VlistDeliveryDailyReportSummary(){
		String reportType="DAILY",rangeType="ALL",monthName=null,frmDate=null,toDate=null;
		try{   	
			String query = "select   closed_datetime ,close_status , "+
							" count(order_num),sum(paid_amt),sum(balance_amt),(sum(balance_amt) + sum(paid_amt)) "+
							" ,del_datetime from orders "+
							" where status_code = 'CLOSED' "+							
							" group by closed_datetime ,close_status ";
			System.out.println(query);
			rs=stat.executeQuery(query);
			
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void VlistDeliveryDailyReportsWithDateSummary(String c_date1, String c_date2){
		System.out.println("In : VlistDeliveryDailyReportsWithDateSummary()");
		String reportType="DAILY",rangeType="RANGE",monthName=null;
		try{  
			String query = "select   closed_datetime ,close_status ,"+
							" count(order_num),sum(paid_amt),sum(balance_amt) ,(sum(balance_amt) + sum(paid_amt))"+
							" ,del_datetime from orders "+
							" where status_code = 'CLOSED' "+
							" and trim(date(closed_datetime)) >= '"+c_date1+"' "+ 
							" and trim(date(closed_datetime)) <= '"+c_date2+"' "+
							" group by closed_datetime ,close_status";
			rs=stat.executeQuery(query);
			System.out.println("Query : "+query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}	
	
	public void VlistDeliveryDailyReportAllDetailsNew(String pmt_type, String order_type){
		try{   
			System.out.println("In");
			rs=stat.executeQuery("call v_delivery_report_det_all('"+pmt_type+"', '"+order_type+"')");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void VlistDeliveryDailyReportDetails(String order_date, String close_status){
		try{   	
			rs=stat.executeQuery("call v_delivery_report_day_ana('"+order_date+"','"+close_status+"')");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void VlistDeliveryDailyReportDetailsNew(String order_date, String pmt_type, String order_type, String close_status){
		try{   	
			System.out.println("In");
				rs=stat.executeQuery("call v_delivery_report_day_det('"+order_date+"', '"+pmt_type+"', '"+order_type+"', '"+close_status+"')");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Closed orders " + e);
			closeAll();			
		}
	}
	

	public void VlistDeliveryDailyReportAllDetails(){
		try{   	
			rs=stat.executeQuery("call v_delivery_report_all()");
	    }
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public ResultSet getCheckedReportData() {
		ResultSet resultSet =null;
		/*String chekedquery  =  "SELECT  order_num, custcode, date(order_date) order_date, total_items, total_value, total_value_mrp," +
							 "  total_value_discount, date(lastmodifieddate) lastmodifieddate , status_code " +
							 "	FROM orders  where status_Code= 'CHECKED' " +
							 " and lastmodifieddate <= DATE_SUB(now(), INTERVAL 48 HOUR) order by lastmodifieddate desc ";
		
		*/
		
		String  chekedQuery = "SELECT  o.order_num, c.custname, date(o.order_date) order_date, o.total_items, o.total_value,"+
							"o.total_value_mrp,  o.total_value_discount,"+
							"date(o.lastmodifieddate) lastmodifieddate , o.status_code "+
							"FROM orders o,customer_master c "+
							"where o.status_Code= 'CHECKED' "+
							"and o.lastmodifieddate <= DATE_SUB(now(), INTERVAL 48 HOUR) "+
							"and c.custcode=o.custcode "+
							"order by o.lastmodifieddate desc;";
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(chekedQuery);
			System.out.println("chekedquery "+chekedQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		return resultSet;
	}
	
	public ResultSet getItemList() {
		ResultSet resultSet =null;
		String itemListQuery="select item_name , item_code FROM item_master order by item_name;";
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(itemListQuery);
			System.out.println("itemListQuery "+itemListQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
	public ResultSet getItemDetails(String itemCode) {
		ResultSet resultSet =null;
		System.out.println("item Code "+itemCode);
		String itemDetailsQuery =" select m.item_name,i.item_group_desc ,p.item_rate,p.item_mrp,s.item_site_qty ,sm.site_name "+
								 " from item_master m , item_price p , item_group i , item_site_inventory s , site_master sm " +	
								 " where m.item_code in (?) "+	
								 " and m.item_code= p.item_code " +
								 " and m.item_group_code = i.item_group_code "+
								 " and m.item_code = s.item_code "+
								 " and p.price_version = s.price_version "+
								 " and sm.site_id=s.site_id "+
								 " order by p.price_version;" ;	
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(itemDetailsQuery);
			preparedStatement.setString(1,itemCode);
			
			System.out.println("itemDetailsQuery "+itemDetailsQuery); 
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
	
	public ResultSet getItemDetails1(String [] itemCode) {
		ResultSet resultSet =null;
		System.out.println("item Code "+itemCode);
		
		String itemDetailsQuery =" select m.item_name,i.item_group_desc ,p.item_rate,p.item_mrp,s.item_site_qty ,sm.site_name "+
								 " from item_master m , item_price p , item_group i , item_site_inventory s , site_master sm " +	
								 " where m.item_code in (";
		
		String itemCodeQuery="";
		for (String string : itemCode) {
			itemCodeQuery+="'"+string+"',";
			
		}
		itemCodeQuery =(itemCodeQuery.substring(0, itemCodeQuery.length()-1)).trim();
		
		System.out.println("itemCodeQuery "+itemCodeQuery);
		
		itemDetailsQuery +=itemCodeQuery+ ") and m.item_code= p.item_code " +
							 " and m.item_group_code = i.item_group_code "+
							 " and m.item_code = s.item_code "+
							 " and p.price_version = s.price_version "+
							 " and sm.site_id=s.site_id "+
							 " order by m.item_name; "; 
	
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(itemDetailsQuery);
			
			System.out.println("itemDetailsQuery "+itemDetailsQuery); 
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
	public ResultSet getSuggestedItemList(String itemName) {
		ResultSet resultSet = null; 
		String suggestedItemListQuery = " SELECT item_code ,item_name ,item_qty,item_weight  FROM item_master i where item_name like '%"+itemName+"%' ;";
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(suggestedItemListQuery)	;
			System.out.println("suggestedItemListQuery "+suggestedItemListQuery); 
			resultSet = preparedStatement.executeQuery();
			
			
		} catch (SQLException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	} 
	
	//method for purchase details accoding to po_date and item_name
	public ResultSet getPurchaseDetails(String item_code,String fromDate,String toDate) {
		ResultSet resultSet = null;
		System.out.println("purchase details item code "+item_code +" \n frdate "+fromDate+"\n todate "+toDate);
		String purchaseDetailsQuery = " select h.po_number,h.bill_number,v.vendor_name,s.site_name,p.item_mrp,p.item_rate ,"+
										" h.total_items,date(h.po_date) as po_date,d.new_qty,h.enteredby"+
										" from item_receipt_header h ,item_receipt_details d , item_price p , vendor_master v , site_master s"+
										" where date(h.po_date) between ? and ? "+
										" and d.item_code=? "+
										" and  h.po_number = d.po_number"+
										" and d.price_version = p.price_version"+
										" and d.item_code = p.item_code"+
										" and h.vendor_id=v.vendor_id"+
										" and s.site_id=h.site_id; "; 
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(purchaseDetailsQuery);
			/*preparedStatement.setDate(1, Date.valueOf("2011-09-21"));
			preparedStatement.setDate(2, Date.valueOf("2011-09-23"));
			preparedStatement.setString(3, "IT941");*/
			
			preparedStatement.setDate(1, Date.valueOf(fromDate));
			preparedStatement.setDate(2, Date.valueOf(toDate));
			preparedStatement.setString(3, item_code);
			
			
			System.out.println("purchaseDetailsQuery "+purchaseDetailsQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
	// code for transfer details
	public ResultSet getTransferDetails(String item_code) {
		ResultSet resultSet = null;
		System.out.println("transfer item code "+item_code);
		String transferDetailsQuery = "select t.transfer_id ,(select site_name from site_master where site_id =ti.source_site_id) as source,"+
										"(select site_name from site_master where site_id =ti.dest_site_id) as dest, "+
										"p.item_mrp,p.item_rate,t.transfer_qty,t.item_trans_status,t.remark "+
										"from transfer_inventory_details t,item_price p,transfer_inventory ti "+
										"where t.item_code= ? "+
										"and p.item_code=t.item_code "+
										"and t.price_version =p.price_version "+
										"and t.transfer_id =ti.transfer_id;"; 
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(transferDetailsQuery);
			//preparedStatement.setString(1,"IT1167");
			preparedStatement.setString(1,item_code);
			System.out.println("transferDetailsQuery "+transferDetailsQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return resultSet;
	} 
	
	//code for sales report
	public ResultSet getSalesReport(String itemCode , String fromDate , String toDate) {
		ResultSet resultSet =null;
		System.out.println("sales reort item code "+itemCode+"\n frdate "+fromDate+"\n todate "+toDate);
		
/*		String salesReportQuery = "select a.custcode,e.custname, e.area, count(Distinct a.order_num), "+
								"count(*) Total_Items, sum(d.fmcg_ind)*100 / count(*) fmcg, sum(d.fmcg_ind) fmcg_items, "+
								"sum(b.price), sum(b.mrp * b.qty),sum((b.mrp * b.qty)-b.price) "+
								"from orders a, order_detail b, item_master c, item_group d, customer_master e "+
								"where date(a.order_date) between ? and ? "+
								"and b.item_code = ? "+
								"and a.order_num = b.order_num "+
								"and b.item_code = c.item_code "+
								"and c.item_group_code = d.item_group_code "+
								"and a.custcode=e.custcode "+
								"group by a.custcode, e.custname, e.area; ";
*/		
		String salesReportQuery ="select o.order_num,date(o.order_date) order_date,"+
								"sum(od.qty) qty,od.rate,od.price "+
								"from orders o,order_detail od "+
								"where date(o.order_date) between ? and ? "+
								"and od.item_code= ? "+
								"and o.order_num = od.order_num "+
								"group by o.order_num ,o.order_date,od.rate,od.price "; 
		
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(salesReportQuery);
			preparedStatement.setDate(1,Date.valueOf(fromDate));
			preparedStatement.setDate(2,Date.valueOf(toDate));
			preparedStatement.setString(3, itemCode);
			
			
			/*preparedStatement.setDate(1,Date.valueOf("2012-09-01"));
			preparedStatement.setDate(2,Date.valueOf("2012-09-01"));
			preparedStatement.setString(3, "IT1635");
			*/
			System.out.println("salesReportQuery "+salesReportQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
		
	}
	
	public ResultSet getSuggestedOrderNumberList(String orderNumber){
		ResultSet resultSet = null;
		String orderNumberQuery = "select distinct(order_num) from orders where order_num like '"+orderNumber+"%' limit 10; ";
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(orderNumberQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return resultSet;
		
	}
	
}