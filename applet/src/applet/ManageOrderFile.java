package applet;

import java.sql.*;

import sms.ManageMessage;
import beans.MessageBean;

public class ManageOrderFile  {
	
	public Connection conn=null;
	public Statement  stat;
	public ResultSet rs;
	public String query;
	public 	int max;
	public PreparedStatement pstmt;
	
	public ManageOrderFile(String dburl, String dbusername,String dbpassword){
		initialize(dburl, dbusername, dbpassword);
	}
	public void  initialize(String dburl, String dbusername,String dbpassword){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dburl, dbusername, dbpassword);
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
	
	public String getStatus(String st){
		try{
			String status;
			query="select status_code from status where status_code='"+st+"' ";
			System.out.println("status code "+query);
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				status=rs.getString(1);
				return(status);
			}
			else{ 
				return("No");
			}			
		}
		catch(Exception e){
				System.out.println("Error occurred in find order no. in Database " + e);
				closeAll();	
				return("No");
		}	
	}
	
	public int getOrderNum(){
		try{		
			conn.setAutoCommit(false);
			query="update code_table set value= value + 1 where category = 'order_id'";
			int ans = stat.executeUpdate(query);	
			if(ans == 1){
				query="select value from code_table where category = 'order_id'";
				System.out.println("order num "+query);
				ResultSet rs=stat.executeQuery(query);
				if(rs.next()) {
					max = rs.getInt(1);					
				}				
			}
			conn.commit();
			conn.setAutoCommit(true);
		
			return(max);
		}
		catch(Exception e){
				System.out.println("Error occurred in find order no. in Database " + e);
				closeAll();	
				return(0);
		}	
	}	
	
	public void addOrderDetail(int max,String itemCode,double itemRate,double itemQty,double totItemPrice,double totItemDisAmt,
			String disRemark,double  itemMRP,int i, long item_taken, long item_returned,int priceVersion,int siteId){			
		try{
			System.out.println("add  new item ");
			conn.setAutoCommit(false);
			query= "insert into order_detail (order_num, item_code, rate, qty, price, item_discount, remark, mrp, entry_no," +
					" item_taken, item_returned,price_version) "+
					"values("+max+",'"+itemCode+"',"+itemRate+","+
					itemQty+","+totItemPrice+","+totItemDisAmt+",'"+disRemark+"',"+itemMRP+","+i+","+item_taken+","+item_returned+","+priceVersion+")";
			System.out.println("add order Detail query: " + query);
			stat.executeUpdate(query);	 
			
			query = "update item_site_inventory set item_site_qty=item_site_qty-?"+
					"where item_code= ?" +
					"and price_version = ? "+
					"and site_id = ?; ";
			PreparedStatement  preparedStatement = conn.prepareStatement(query);
			preparedStatement.setDouble(1, itemQty);
			preparedStatement.setString(2, itemCode);
			preparedStatement.setInt(3, priceVersion);
			preparedStatement.setInt(4, siteId);
			
			System.out.println("update item site inventory "+ query );
			int rows = preparedStatement.executeUpdate();
			
		}
		catch(Exception e){
				System.out.println("Error occurred in add order_detail entry in Database " + e);
				e.printStackTrace();
				closeAll();				
		}	
	}	
	
	// update Order Detail and item_site_inventory
	public void updateOrderDetail(int max,String itemCode,double itemRate,double itemQty,double totItemPrice,double totItemDisAmt,
			String disRemark,double  itemMRP,int i, long item_taken, long item_returned,int priceVersion,int siteId,int prevQty){			
		try{	
			System.out.println("udate order detail ");
			conn.setAutoCommit(false);
			query= "insert into order_detail (order_num, item_code, rate, qty, price, item_discount, remark, mrp, entry_no," +
					" item_taken, item_returned,price_version) "+
					"values("+max+",'"+itemCode+"',"+itemRate+","+
					itemQty+","+totItemPrice+","+totItemDisAmt+",'"+disRemark+"',"+itemMRP+","+i+","+item_taken+","+item_returned+","+priceVersion+")";
			System.out.println("add order Detail query: " + query);
			stat.executeUpdate(query);	 
			int diff =0;
			if((int)itemQty > prevQty){
				diff = (int)itemQty - prevQty;
				query = "update item_site_inventory set item_site_qty=item_site_qty-?"+
						"where item_code= ?" +
						"and price_version = ? "+
						"and site_id = ?; ";
				
			}else{
				diff = prevQty -(int)itemQty;
				query = "update item_site_inventory set item_site_qty=item_site_qty+?"+
						"where item_code= ?" +
						"and price_version = ? "+
						"and site_id = ?; ";
			}
			
			PreparedStatement  preparedStatement = conn.prepareStatement(query);
			preparedStatement.setDouble(1, diff);
			preparedStatement.setString(2, itemCode);
			preparedStatement.setInt(3, priceVersion);
			preparedStatement.setInt(4, siteId);
			
			System.out.println("update item site inventory "+ query );
			int rows = preparedStatement.executeUpdate();
			conn.commit();
		}
		catch(Exception e){
				System.out.println("Error occurred in update order_detail entry in Database " + e);
				e.printStackTrace();
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				closeAll();				
		}	
	}	
	
	public void addOrders(int max,String customerCode,int totItems, long totTaken, double totOrderValue,double totMRPValue,double totDisValue,
					String user,String p_type, String status1,String deliveryRemark, String orderType, String lastOrdDate,String copyOrder,
					String orderDate,double balanceValue,double advanceValue,double otherDiscountValue,double otherChargesValue,int siteId){
		System.out.println("this is test application add orders ");
		try{ 	
			if(orderType.equals("CREATE") ){
				//tot = advanceValue + balanceValue + otherDiscountValue - otherChargesValue;
				//if to != totOrderValue then alert
				query="insert into orders (order_num, custcode, order_date, del_date, total_items, total_taken, "+
			     	   "total_value, total_value_mrp, total_value_discount, enterd_by, lastmodifieddate, "+
			     	   "lastmodifiedby, payment_type_code,status_code,remark,action,advance_amt,discount_amt,balance_amt,other_charges,site_id) " +
			     	   "values(" +max+ ",'"+customerCode+"',now(), "+
			     	   "now()," +totItems + "," +totTaken + ", "+totOrderValue+" + IF((0.50 -("+totOrderValue+" %0.50))=0.50,0,(0.50 -("+totOrderValue+" %0.50))) ,"+totMRPValue+" + IF((0.50 -("+totMRPValue+" %0.50))=0.50,0,(0.50 -("+totMRPValue+" %0.50))) ," +
			     	   totDisValue+ ", "+
			     	   "'" + user + "',now(), '" + user + "','"+p_type+"','"+status1+"','"+deliveryRemark+"', "+
			     	   "'"+orderType+"',"+advanceValue+" + IF((0.50 -("+advanceValue+" %0.50))=0.50,0,(0.50 -("+advanceValue+" %0.50))), "+
			     	   otherDiscountValue+" + IF((0.50 -("+otherDiscountValue+" %0.50))=0.50,0,(0.50 -("+otherDiscountValue+" %0.50))),"+
			     	   balanceValue+" + IF((0.50 -("+balanceValue+" %0.50))=0.50,0,(0.50 -("+balanceValue+" %0.50))), "+
			     	   otherChargesValue+" + IF((0.50 -("+otherChargesValue+" %0.50))=0.50,0,(0.50 -("+otherChargesValue+" %0.50))),"+siteId+" )";
				System.out.println(" CREATE add Order query: " + query);
				stat.executeUpdate(query);
				System.out.println("\n\n\n CREATE add Order query: " + query);
				
				
				//Message to be sent to the customer once the order is created
				
				
				
				//new SMSRecords().addSMSDetails(max);				
			}
			
			else if(orderType.equals("EDIT")){	
				query="insert into orders (order_num, custcode, order_date, del_date, total_items, total_taken, "+
		     	   "total_value, total_value_mrp, total_value_discount, enterd_by, lastmodifieddate, "+
		     	   "lastmodifiedby, payment_type_code,status_code,remark,action,advance_amt,discount_amt,balance_amt,other_charges,site_id) values(" +max+ ",'"+customerCode+"','"+orderDate+"', "+
		     	   "now()," +totItems + "," +totTaken + ", "+totOrderValue+" + IF((0.50 -("+totOrderValue+" %0.50))=0.50,0,(0.50 -("+totOrderValue+" %0.50))) ,"+totMRPValue+" + IF((0.50 -("+totMRPValue+" %0.50))=0.50,0,(0.50 -("+totMRPValue+" %0.50))) ," +totDisValue+ ", "+
		     	   "'" + user + "',now(), "+
		     	   "'" + user + "','"+p_type+"','"+status1+"','"+deliveryRemark+"','"+orderType+"', "+
		     	   advanceValue+"  + IF((0.50 -("+advanceValue+" %0.50))=0.50,0,(0.50 -("+advanceValue+" %0.50))), "+
		     	   otherDiscountValue+" + IF((0.50 -("+otherDiscountValue+" %0.50))=0.50,0,(0.50 -("+otherDiscountValue+" %0.50))),"+
		     	   balanceValue+" + IF((0.50 -("+balanceValue+" %0.50))=0.50,0,(0.50 -("+balanceValue+" %0.50))), "+
		     	   otherChargesValue+" + IF((0.50 -("+otherChargesValue+" %0.50))=0.50,0,(0.50 -("+otherChargesValue+" %0.50))),"+siteId+" )";
				   System.out.println("EDIT add Order query: " + query);
				   stat.execute(query);
				   //new SMSRecords().addSMSDetails(max);
				   
			}
			//stat.execute("call upd_cust_stats('')");
			
		}
		
		catch(Exception e){
				System.out.println("Error occurred in add order entry in Database " + e);
				e.printStackTrace();
				closeAll();				
		}	

	}
	
	
	public void deleteOrderDetail(int orderNo){
		try{
			query="delete from order_detail where order_num="+orderNo+" ";
			stat.execute(query);				
		}
		catch(Exception e){
				System.out.println("Error occurred in delete order_detail entry in Database " + e);
				closeAll();				 
		}	

	}
	
	public void deleteOrder(int orderNo){			
		try{				  
			query="delete from orders where order_num="+orderNo+" ";
			stat.execute(query);
			
		}
		catch(Exception e){
				System.out.println("Error occurred in delete order_detail entry in Database " + e);
				closeAll();				
		}	

	}
	
	public void listOrders(String customer_Name,String order_Number,String cust_Code,String enteredBy,String c_date1,String c_date2,String u_date1,String u_date2){	
		
		try{
			String query="select b.custname, a.order_num, a.custcode, a.order_date, a.del_date, a.enterd_by,b.phone,b.add1,b.add2,b.building,b.block,b.wing, a.lastmodifieddate , a.status_code from orders a, customer_master b where a.custcode = b.custcode";
	    	if(customer_Name!=""){
	    		query = query + " and b.custname like'" + customer_Name + "%'";
	    	}
	    	if(order_Number!=""){
	    		query = query + " and a.order_num like'" + order_Number + "%'";
	    	}
	    	if(cust_Code!=""){
	    		query = query + " and b.custcode like'" + cust_Code + "%'";
	    	}
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and a.order_date >= '" + c_date1 + "%' and a.order_date <= '" + c_date2 + "%'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and a.order_date like'" + c_date1 + "%'";
	    	} 
	    	   		
	    	if(!u_date1.equals("") && !u_date2.equals("")){
	    		query = query + " and a.lastmodifieddate  between '" + u_date1 + "%' and '" + u_date2 + "%'";
	    	}
	    	else if(!u_date1.equals("")){
	    		query = query + " and a.lastmodifieddate like'" +u_date1+ "%'";
	    	} 
	    	if(enteredBy!=""){
	    		query = query + " and enterd_by like'" + enteredBy + "%'";
	    	}
	    	query=query + "order by(a.order_date)";
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}

	public void submittedOrdersList(){	
		
		try{
			String query="select a.order_num,a.order_date,a.status_code,a.total_items,a.total_value,a.custcode,b.custname,b.area,b.phone,b.add1,b.add2 from orders a, customer_master b where a.custcode = b.custcode and a.order_date >= CURDate() and a.status_code='SUBMITTED'";
	    	query=query + "order by(a.order_date)";
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	public void TransitOrdersList(){	
		
		try{
			String query="select a.order_num,a.order_date,a.sent_datetime,a.status_code,a.total_items,a.total_value,a.custcode,b.custname,b.area,b.phone,b.add1,b.add2,a.dstaff_code,c.dstaff_name,a.change_amt,c.dstaff_code from orders a, customer_master b, delivery_staff c where a.custcode = b.custcode and a.order_date >= CURDate() and a.status_code='TRANSIT' and a.dstaff_code=c.dstaff_code";
	    	query=query + " order by(a.order_date)";
	    	
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	public void DeliveredOrdersList(){	
		
		try{
			String query="select a.order_num,a.order_date,a.sent_datetime,a.status_code,a.total_items,a.total_value,a.custcode,b.custname,b.area,b.phone,b.add1,b.add2,a.dstaff_code,c.dstaff_name,a.change_amt,c.dstaff_code,a.paid_amt from orders a, customer_master b, delivery_staff c where a.custcode = b.custcode and a.order_date >= CURDate() and a.status_code='DELIVERED' and a.dstaff_code=c.dstaff_code";
	    	query=query + " order by(a.order_date)";
	    	
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	public void ClosedOrdersList(){	
		
		try{
			String query="select a.order_num,a.order_date,a.sent_datetime,a.status_code,a.total_items,a.total_value,a.custcode,b.custname,b.area,b.phone,b.add1,b.add2,a.dstaff_code,c.dstaff_name,a.change_amt,c.dstaff_code from orders a, customer_master b, delivery_staff c where a.custcode = b.custcode and a.order_date >= CURDate() and a.status_code='CLOSED' and a.dstaff_code=c.dstaff_code";
	    	query=query + " order by(a.order_date)";
	    	
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
    
	public String TestOrder(int max,String customerCode){	
		
		try{ 
			return("Y");
			
		}
		catch(Exception e){
				System.out.println("Error occurred in add order entry in Database " + e);
				closeAll();
				return("N");
		}	

	}
	
/*	public int getVersionNo(int order_num){
		int verNum=0;		
		try{		
			query="select max(version_no) from order_history where order_num = "+order_num+"";
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				verNum = rs.getInt(1);					
			}	
			if(verNum==0)
				verNum=1;
			else 
				verNum+=1;
		}
		catch(Exception e){
			System.out.println("Exception occured in getVersionNo"+e);
			e.printStackTrace();
		}
		return verNum;		
	}
*/
	public String getLastOrderDate(int order_num){
		Date dt = null;
		String startTime="";
		try{
			query="select order_date from orders where order_num = "+order_num+"";
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				//dt = rs.getDate(1);	
				java.sql.Timestamp stamp = (java.sql.Timestamp)rs.getObject(1);
				startTime = stamp.toString();		
			}
		}
		catch(Exception e){
			System.out.println("Exception occured in getLastOrderDate"+e);
			e.printStackTrace();
		}	
		return startTime;
	}
	
	public void updateOrderHistory(int orderNo,String savingType,int currentQuantity){
		String orderHistoryQuery="";
		try{
			if(savingType.equals("HOLD"))
				updateDeliveryBalance(orderNo,currentQuantity);
			orderHistoryQuery="insert into order_history (select order_num , "+
			"(select ifnull(max(version_no),0)+1 from order_history where "+
			"order_num = "+orderNo+"), lastmodifieddate,total_items,total_taken,total_value, "+
			"total_value_mrp,total_value_discount,enterd_by,lastmodifiedby, "+
			"payment_type_code,bags,dstaff_code,status_code, change_amt,paid_amt, "+
			"comm_amt,remark,now(),action,advance_amt,discount_amt,balance_amt,other_charges from orders where order_num = "+orderNo+")";
			stat.execute(orderHistoryQuery);	
				
		}catch(Exception e){
			System.out.println("Exception occured in updateOrderHistory");
			e.printStackTrace();
			closeAll();	
		}
	}
	
	public void updateDeliveryBalance(int orderNo, int currentQuantity){
		String delBalance="",dstaffCode="";
		float baltoPay=0.0f,commAmt=0.0f, balanceToPay=0.0f;
		try{
				delBalance="select a.dstaff_code, a.balance_to_pay,comm_amt from delivery_staff a, "+ 
						   "(select dstaff_code,comm_amt from orders where order_num='"+orderNo+"') b "+
						   "where a.dstaff_code=b.dstaff_code";
				rs=stat.executeQuery(delBalance);
				while(rs.next()){
					dstaffCode=rs.getString(1);
					baltoPay=rs.getFloat(2);
					commAmt=rs.getFloat(3);
				}
				balanceToPay=baltoPay-commAmt;
				String query="update delivery_staff set balance_to_pay="+balanceToPay+" where dstaff_code='"+dstaffCode+"'";
				stat.execute(query);
		}
		catch(Exception e){
			System.out.println("Exception occured in v");
			e.printStackTrace();
			closeAll();	
		}
	}

	public int getTransactionId(){
		try{
			int tid=0;
			query="select max(tran_id) from transaction";
			System.out.println("transaction id "+query);
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				tid=rs.getInt(1);
				tid=tid + 1;
			}
			else{ 
				tid =1;
			}
			return(tid);
		}
		catch(Exception e){
				System.out.println("Error occurred in find tran id in Database " + e);
				closeAll();	
				return(0);
		}	
	}
	
	public void addTransactionDetails(int tid,double advanceValue, double totOrderValue, double balanceValue, int max){
		String transType="A";
		/*	Here advanceValue is transAmt, totOrderValue is old_amt, and new=balanceValue	*/
		try{
			query="insert into transaction (tran_id, tran_type, tran_dt, tran_amt, old_balance_amt, "+
			"new_balance_amt,order_num) values(" +tid+ ",'"+transType+"',now(), "+
	     	"" +advanceValue + "," +totOrderValue + ", "+balanceValue+","+max+")";	
			System.out.println("transaction query "+query);
			System.out.println("insert transaction "+stat.executeUpdate(query));
			
		}
		catch(Exception e){
				System.out.println("Error occurred while inserting transaction details " + e);
				closeAll();	
		}
	}
	
	public int getOrderNumRec(){
		try{		
			conn.setAutoCommit(false);			
			query="select max(order_num) from orders_rec";
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				max = rs.getInt(1);					
			}else{
				max = 0;
			}
			max = max +1;
			conn.commit();
			conn.setAutoCommit(true);
		
			return(max);
		}
		catch(Exception e){
				System.out.println("Error occurred in find order no. in Database " + e);
				closeAll();	
				return(0);
		}	
	}
	public int saveordersrec(String custcode, String enterby,String status){
		try{
			int orderno = getOrderNumRec();
			query = "insert into orders_rec values("+orderno+",'"+custcode+"',now(),'"+enterby+"','"+status+"')";
			System.out.println(query);
			stat.execute(query);
			return(orderno);
		}
		catch(Exception e){
				System.out.println("Error occurred while inserting transaction details " + e);
				closeAll();	
				return(0);
		}		
	}
	public void saveorderdetailrec(String insertdata){
		try{
			query = "insert into order_detail_rec(order_num, item_code, rate, qty, price, item_discount, remark, mrp, entry_no, item_taken, item_returned)" +
					" values("+insertdata+")";
			System.out.println(query);
			stat.execute(query);
			
		}
		catch(Exception e){
				System.out.println("Error occurred while inserting transaction details " + e);
				closeAll();	
		}
	}
	public void deleteorderec(int orderno){
		try{
			query = "delete from order_detail_rec where order_num = "+orderno+"";		
			stat.executeUpdate(query);
			query = "delete from orders_rec where order_num = "+orderno+"";		
			stat.executeUpdate(query);
		}
		catch(Exception e){
				System.out.println("Error occurred while inserting transaction details " + e);
				closeAll();	
		}
	}
	


	
}