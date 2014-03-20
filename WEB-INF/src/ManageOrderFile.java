 

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageOrderFile  {
	
	public Connection conn=null;
	public Statement  stat;
	public ResultSet rs;
	public String query;
	
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
	
	public void addOrders(int max,String customerCode,int totItems, long totTaken, double totOrderValue,double totMRPValue,double totDisValue,String user,String p_type, String status1){	
		
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
	
	public void addOrderDetail(int max,String itemCode,double itemRate,double itemQty,double totItemPrice,double totItemDisAmt, String disRemark,double  itemMRP,int i, long item_taken){	
		
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
	

}