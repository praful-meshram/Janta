package order;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.swing.*;

public class ManageOrder {
	
	public Connection conn=null;
	public Statement  stat,stmt;
	public ResultSet rs,rs1,rs2;
	public String query="";
	
	public ManageOrder(String envLookup){
		initialize(envLookup);
	}
	public void  initialize(String envLookup){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(envLookup);
			conn = ds.getConnection();
			stat=conn.createStatement();
			stmt=conn.createStatement();
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
			int max;
			query="select max(order_num) from orders";
			ResultSet rs=stat.executeQuery(query);
			if(rs.next()) {
				max=rs.getInt(1);
				max=max + 1;
			}
			else{ 
				max =1;
			}
			return(max);
		}
		catch(Exception e){
				System.out.println("Error occurred in find order no. in Database " + e);
				closeAll();	
				return(0);
		}	
	}
	
	public void addOrders(int max,String customerCode,int totItems, long totTaken, float totOrderValue,float totMRPValue,float totDisValue,String user,String p_type, String status1){	
		
		try{ 
			
			query="insert into orders (order_num, custcode, order_date, del_date, total_items, total_taken, "+
		     	   "total_value, total_value_mrp, total_value_discount, enterd_by, lastmodifieddate, "+
		     	   "lastmodifiedby, payment_type_code,status_code) values(" +max+ ",'"+customerCode+"',now(), "+
		     	   "now()," +totItems + "," +totTaken + ", "+totOrderValue+" + IF((0.50 -("+totOrderValue+" %0.50))=0.50,0,(0.50 -("+totOrderValue+" %0.50))) ," + totMRPValue+ "," +totDisValue+ ", "+
		     	   "'" + user + "',now(), "+
		     	   "'" + user + "','"+p_type+"','"+status1+"')";
			
			stat.execute(query);     
		}
		catch(Exception e){
				System.out.println("Error occurred in add order entry in Database " + e);
				closeAll();				
		}	

	}
	
	public void addOrderDetail(int max,String itemCode,float itemRate,float itemQty,float totItemPrice,float totItemDisAmt, String disRemark,float  itemMRP,int i, long item_taken){	
		
		try{	
			
			query= "insert into order_detail (order_num, item_code, rate, qty, price, item_discount, remark, mrp, entry_no, item_taken) "+
					"values("+max+",'"+itemCode+"',"+itemRate+","+
					itemQty+","+totItemPrice+","+totItemDisAmt+",'"+disRemark+"',"+itemMRP+","+i+","+item_taken+")";
			
			stat.execute(query);	  
		}
		catch(Exception e){
				System.out.println("Error occurred in add order_detail entry in Database " + e);
				closeAll();				
		}	

	}
	
	public void deleteOrder(int orderNo){			
		try{
			query="delete from orders where order_num="+orderNo+" ";
			stat.execute(query);
			query="delete from order_detail where order_num="+orderNo+" ";
			stat.execute(query);	  
		}
		catch(Exception e){
				System.out.println("Error occurred in delete order_detail entry in Database " + e);
				closeAll();				
		}	

	}
	
	public void listOrders(String phone_Number,String customer_Name,String order_Number,String cust_Code,String enteredBy,String c_date1,String c_date2,String u_date1,String u_date2){	
		
		try{
			String query="select b.custname, a.order_num, a.custcode, a.order_date, "+
					"a.del_date, a.enterd_by,b.phone,b.add1,b.add2,b.building,b.block, "+
					"b.wing, a.lastmodifieddate ,a.status_code,c.dstaff_name,a.del_datetime, a.sent_datetime from orders a "+
					"left outer join delivery_staff c on a.dstaff_code=c.dstaff_code,"+
					"customer_master b where a.custcode = b.custcode ";
			if(!phone_Number.equals("")){
	    		query = query + " and b.phone like '" + phone_Number + "%'";
	    	}
			if(!customer_Name.equals("")){
	    		query = query + " and b.custname like '" + customer_Name + "%'";
	    	}
	    	if(!order_Number.equals("")){
	    		query = query + " and a.order_num like '" + order_Number + "%'";
	    	}
	    	if(!cust_Code.equals("")){
	    		query = query + " and b.custcode like '" + cust_Code + "%'";
	    	}
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and trim(date(a.order_date)) >= '" + c_date1 + "' and trim(date(a.order_date)) <= '" + c_date2 + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and trim(date(a.order_date)) = '" + c_date1 + "'";
	    	} 
	    	   		
	    	if(!u_date1.equals("") && !u_date2.equals("")){
	    		query = query + " and trim(date(a.lastmodifieddate))  between '" + u_date1 + "' and '" + u_date2 + "'";
	    	}
	    	else if(!u_date1.equals("")){
	    		query = query + " and trim(date(a.lastmodifieddate)) = '" +u_date1+ "'";
	    	} 
	    	if(!enteredBy.equals("")){
	    		query = query + " and enterd_by like '" + enteredBy + "%'";
	    	}
	    	query=query + " order by(a.order_date)";	  
	    	System.out.println(query);
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}

	public void submittedOrdersList(String SubmittedType){			
		try{
			
			if(SubmittedType.equals("Submitted1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="SUBMITTED",in_range="0";	
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')   1");
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");
			}
			else if(SubmittedType.equals("Submitted2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="SUBMITTED",in_range="5";
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')  2");
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
			}
			else if(SubmittedType.equals("Submitted3")){  	 
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="SUBMITTED",in_range=null;
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")   3");
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				
			}						
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}

	public void checkedOrdersList(String SubmittedType){			
		try{
			
			if(SubmittedType.equals("Checked1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CHECKED",in_range="0";		
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");
			}
			else if(SubmittedType.equals("Checked2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CHECKED",in_range="5";
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
			}
			else if(SubmittedType.equals("Checked3")){  
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CHECKED",in_range=null;
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				
			}						
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	
	
	
	public void bothOrdersList(){			
		try{
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="",in_range=null;
				rs = stat.executeQuery("call order_details_sc("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");		
									
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	public void TransitOrdersList(String SubmittedType){		
		try{
			if(SubmittedType.equals("Transit1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="TRANSIT",in_range="0";		
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");
			}	
			else if(SubmittedType.equals("Transit2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="TRANSIT",in_range="5";
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
    	
			}	
			else if(SubmittedType.equals("Transit3")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="TRANSIT",in_range=null;
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				
			}					
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	public void DeliveredOrdersList(String SubmittedType){		
		try{
			
			if(SubmittedType.equals("Delivered1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="DELIVERED",in_range="0";		
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')  1");
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");    	
		    	//rs = stat.executeQuery(query);
			}
			if(SubmittedType.equals("Delivered2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="DELIVERED",in_range="5";
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')  2" );
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
			}
			if(SubmittedType.equals("Delivered3")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="DELIVERED",in_range=null;
				System.out.println("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")   3");
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				

			}				
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}
	
	public void HoldOrdersList(String SubmittedType){
		//String query="";
		try{
			if(SubmittedType.equals("Hold1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="HOLD",in_range="0";		
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");
			}	
			else if(SubmittedType.equals("Hold2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="HOLD",in_range="5";
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
    	
			}	
			else if(SubmittedType.equals("Hold3")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="HOLD",in_range=null;
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				
			}		
		}
		catch(Exception e){
			System.out.println("Exception occured in HoldOrderList "+e);
		}
	}
	
	public void ClosedOrdersList(String SubmittedType){			
		try{
			if(SubmittedType.equals("Closed1")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CLOSED",in_range="0";		
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");
			}	
			else if(SubmittedType.equals("Closed2")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CLOSED",in_range="5";
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , '"+in_range+"')");				
    	
			}	
			else if(SubmittedType.equals("Closed3")){
				String in_order_num=null,in_fromdate=null,in_todate=null,in_status="CLOSED",in_range=null;
				rs = stat.executeQuery("call order_details("+in_order_num+" , "+in_fromdate+" , "+in_todate+" , '"+in_status+"' , "+in_range+")");				
			}		
			
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
	
	public int getVersionNo(int order_num){
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
	
	public void updateOrderHistory(int orderNo,String savingType,int comm){
		String orderHistoryQuery="";
		try{	
			orderHistoryQuery="insert into order_history (select order_num , "+
			"(select ifnull(max(version_no),0)+1 from order_history where "+
			"order_num = "+orderNo+"), lastmodifieddate,total_items,total_taken,total_value, "+
			"total_value_mrp,total_value_discount,enterd_by,lastmodifiedby, "+
			"payment_type_code,bags,dstaff_code,status_code, change_amt,paid_amt, "+
			"comm_amt,remark,now(),action,advance_amt,discount_amt,balance_amt, "+
			"other_charges from orders where order_num = "+orderNo+")";
			System.out.println(orderHistoryQuery);
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
	
	
	public void getDeliveryStaffList(){
		try{	
			query="select a.dstaff_code, a.dstaff_name from delivery_staff a";	
			System.out.println("query "+query);
			rs1=stmt.executeQuery(query);			
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}	
	
	public void getOrderDetails(String orderNo){
		String in_fromdate=null,in_todate=null,in_status=null,in_range=null;
		try{
			rs = stat.executeQuery("call order_details('"+orderNo+"' , "+in_fromdate+" , "+in_todate+" , "+in_status+" , "+in_range+")");
		}
		catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	public void getOrderDetailsbyDP(String d_staff_code){		
		String taction="TRANSIT";
		try{
			System.out.println("call order_details_dlv('"+d_staff_code+"' ,'"+taction+"')");
			rs = stat.executeQuery("call order_details_dlv('"+d_staff_code+"' ,'"+taction+"')");
		}
		catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	
	public void getcoininfo(){
		try{
			query="select denom_value from valid_denominations where active_flag='Y' order by denom_value Desc";
			rs2 = stat.executeQuery(query);
		}catch(Exception e){
			System.out.println("Exception occured in getcoininfo");
			e.printStackTrace();
			closeAll();	
		}
	}
	public void getAllcoininfo(){
		try{
			query="select * from valid_denominations";
			rs2 = stat.executeQuery(query);
		}catch(Exception e){
			System.out.println("Exception occured in getcoininfo");
			e.printStackTrace();
			closeAll();	
		}
	}
	
	
	public void setOrderCommission(int order_num, String d_staff_code, float comm_amt, String action){
		try{
			/*
			 * Commented by vikas on 2-may-2011
			 * resaon : the alert message accumulate on server side due some problem and server get down
			 * changes asked by Divyesh sir  
			 */
			rs = stat.executeQuery("call upd_order_comm("+order_num+" ,'"+d_staff_code+"' ,"+comm_amt+" ,'"+action+"')");
			System.out.println("call upd_order_comm("+order_num+" ,'"+d_staff_code+"' ,"+comm_amt+" ,'"+action+"')");
			//rs = stat.executeQuery("call upd_order_comm(516 ,'DS11' ,11.0 ,'ADD')");
			
			while(rs.next()){
				String dstaff_name = rs.getString("out_dstaff_name");
				//String out_dstaff_code = rs.getString("out_dstaff_code");
				String upd_datetime = rs.getString("out_upd_datetime");
				String old_comm_amt = rs.getString("out_old_comm_amt");
				String status = rs.getString("out_status");
			    System.out.println("status:  "+status);	
				if(status.equals("EXIST")){
					//String msg = "Commission (amt: "+old_comm_amt+") for this order is already registered against "+dstaff_name+" on "+upd_datetime;
					//System.out.println(msg);
					//int selection = JOptionPane.showConfirmDialog(null,msg,"RMS",JOptionPane.YES_NO_CANCEL_OPTION);
					//System.out.println(selection);
					//if( selection == 0){
						//rs = stat.executeQuery("call upd_order_comm("+order_num+" ,'"+d_staff_code+"' ,"+comm_amt+" ,'READD')");
						//rs = stat.executeQuery("call upd_order_comm(516 ,'DS11' ,11.0 ,'READD')");
					//	break;
					//}
					//else if (selection == 1 ){
						rs = stat.executeQuery("call upd_order_comm("+order_num+" ,'"+d_staff_code+"' ,"+comm_amt+" ,'UPDATE')");
						//rs = stat.executeQuery("call upd_order_comm(516 ,'DS11' ,11.0 ,'UPDATE')");
						break;
					//}
					//else{
					//	break;
					//}
					
				}
			}
			
		}
		catch(Exception e){
			System.out.println("Exception occured in setOrderCommission " +e);
			e.printStackTrace();
			closeAll();	
		}
	}
	



	public void TodaysCustOrderList(String custcode){
		try{	
			query="select order_num from orders where custcode='"+custcode+"' and trim(DATE(order_date))=CURDATE();";
			System.out.println(query);
			rs=stmt.executeQuery(query);			
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	
public void listRecOrders(String customer_Name,String order_Number,String cust_Code,String enteredBy,String c_date1,String c_date2,String selstatus){	
		
		try{
			String query="select  a.order_num, a.order_date,a.custcode, b.custname," +
					" a.enterd_by, a.order_status, count(*)" +
					" from orders_rec a ,customer_master b, order_detail_rec c where a.custcode = b.custcode and a.order_num = c.order_num ";
			
			if(!customer_Name.equals("")){
	    		query = query + " and b.custname like '" + customer_Name + "%'";
	    	}
	    	if(!order_Number.equals("")){
	    		query = query + " and a.order_num like '" + order_Number + "%'";
	    	}
	    	if(!cust_Code.equals("")){
	    		query = query + " and b.custcode like '" + cust_Code + "%'";
	    	}
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and trim(date(a.order_date)) >= '" + c_date1 + "' and trim(date(a.order_date)) <= '" + c_date2 + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and trim(date(a.order_date)) = '" + c_date1 + "'";
	    	}   		
	    	if(!enteredBy.equals("")){
	    		query = query + " and a.enterd_by like '" + enteredBy + "%'";
	    	}
	    	if(!selstatus.equals("")){
	    		if(selstatus.equals("INS")){
	    			query = query + " and a.order_status = 'INS' ";
	    		}else if(selstatus.equals("EDI")){
	    			query = query + " and a.order_status = 'EDI' ";
	    		}
	    	}
	    	query=query + " group by c.order_num order by(a.order_date) Desc";	  
	    	System.out.println(query);
	    	rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
			closeAll();			
		}
	}

public void listOrderItemList(String orderno){
	try{	
		query="select a.* , b.item_name from order_detail_rec a, item_master b where a.item_code = b.item_code and order_num='"+orderno+"' order by entry_no";	
		rs=stmt.executeQuery(query);			
	}catch(Exception e){
		System.out.println("Exception occured in getDeliveryStaffList");
		e.printStackTrace();
		closeAll();	
	}
}
public String getCustomerName(String custcode){
	try{	
		query="select custname from customer_master  where custcode = '"+custcode+"'";	
		rs=stmt.executeQuery(query);
		String name="";
		if(rs.next()){
			name = rs.getString(1);
		}
		return(name);
	}catch(Exception e){
		System.out.println("Exception occured in getDeliveryStaffList");
		e.printStackTrace();
		closeAll();	
		return("blank");
		
	}
}

	public boolean saveCheckedOrder(String orderNo, String userName,String bagNo){
		try{	
			int orderNo1 = Integer.parseInt(orderNo);
			int bagNo1=Integer.parseInt(bagNo);
			//System.out.println("bagNo1 is:"+bagNo1);
			updateOrderHistory(orderNo1,"",0);
			query="update orders set status_code = 'CHECKED' ," +
			       " lastmodifieddate = now() ," +
			       " lastmodifiedby = '" +userName +"' ," +
					" bags="+ bagNo1+" " +
					" where" +
					" order_num = '"+orderNo+"'";
						
			
			int ans1 =stmt.executeUpdate(query);
			System.out.println(" Save Order Status :"+query);
			if( ans1 == 1) return(true);
			
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
			return(false);		
		}
		return false;
	}
	
	public boolean saveCheckedOrderItems(String orderNo,String oldItemCode,float oldPrice, String newItemCode,float iprice,float iqty){
		try{	
			double rate = 0.0,totalValue=0.0;
			//double mrp =0.0;
			query="insert ignore into order_detail_swap select * from order_detail where " +
					" order_num = '"+orderNo+"' " +
					" and item_code = '"+oldItemCode+"'";	
			System.out.println(" Insert Order Items :"+query);
			int ans = stmt.executeUpdate(query);
			if(ans == 1){
				query = "select item_rate, item_mrp from item_master where item_code ='"+oldItemCode+"'";
				rs = stmt.executeQuery(query);
				System.out.println(" Select Order Items :"+query);
				if(rs.next()){
					rate = rs.getDouble(1);
					//mrp = rs.getDouble(2);
					
					query = "update order_detail set item_code ='"+newItemCode+"', " +
							" rate="+rate+"," +
							" qty="+iqty+", " +
							" price="+iprice+" " +
							" where " +
							" order_num = '"+orderNo+"' " +
							" and item_code = '"+oldItemCode+"'";	
					
					ans = stmt.executeUpdate(query);
					System.out.println(" Update Order Items :"+query);
					if(ans == 1){
						query = "select total_value, total_value_mrp, total_value_discount from orders" +
								" where order_num = '"+orderNo+"' ";
						rs = stmt.executeQuery(query);
						System.out.println(" Select Order Items :"+query);
						if(rs.next()){
							totalValue = rs.getDouble(1);
							totalValue = totalValue - oldPrice;
							totalValue = totalValue + iprice;
							query = "update orders set "+ 
									" total_value="+totalValue+" " +
									" where " +
									" order_num = '"+orderNo+"' ";	
							
							ans = stmt.executeUpdate(query);
							System.out.println(" Update Order Items :"+query);
							if(ans == 1){
								return true;
							}
						}
					}
				}				
			}		
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();
			return false;
		}
		return false;
	}
	
	
	
	
	public boolean isExistOrderNumber(String orderNo, String status){
		try{	
			query="Select order_num from orders " +
					" where " +
					" order_num='"+orderNo+"'"+
					" and status_code='"+status+"' ";	
			System.out.println("Check Order Number :"+query);
			rs =stmt.executeQuery(query);
			if(rs.next()) return(true);
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
			return(false);		
		}
		return false;
	}
	
	public void getOrderItemDetails(String orderNo){
		try{	
			query="  SELECT b.barcode,b.item_group_code,b.item_code,b.item_name,b.item_weight,a.rate, a.qty, a.price, a.remark" +
					" from order_detail a,item_master b" +
					" where a.item_code=b.item_code "+
					" and order_num='"+orderNo+"'";	
			System.out.println("Get Order Item details :"+query);
			rs =stmt.executeQuery(query);			
		}catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();			
		}	
	}
	
	public void getCheckedOrderInfo(String orderNo){
		try{			
			query="select a.order_num, a.order_date, a.total_items,a.total_value,a.total_value_discount,a.total_value_mrp," +
					" b.payment_type_desc,a.status_code, a.remark  " +
					" from orders a, payment_type b" +
					" where order_num ='"+orderNo+"'" +
					" and b.payment_type_code = a.payment_type_code";
			System.out.println(query);
			rs = stat.executeQuery(query);
		}catch(Exception e){
			System.out.println("Error in GetEditOrderInfo() "+e);
		}
	}
}