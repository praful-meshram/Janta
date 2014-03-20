package customer;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import beans.CustomerBean;
import beans.CustomerListOutputBean;

public class ManageCustomer {
	
	public Connection conn=null;
	public Statement  stat,stat1;
	public ResultSet rs,rs1;
	String envLookup;
	PreparedStatement addValue;
	PreparedStatement editValue;
	
	
	public ManageCustomer(String envLook){
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
			stat.close();
	    	conn.close();
	   
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	public String addCustomer(String get1,String custName,String building,String buildingno,String block,String wing,String add1,String add2,String area,String station,String city,String state,String country,String pinCode,String phoneNo, String payment, String mobile){	
		
		try{			
			addValue = conn.prepareStatement("insert into customer_master (custcode, custname, building, building_no, block, wing, add1, add2, add3, area, station, city, state, country, pincode, phone, fax, mobile, create_datetime, update_datetime, dob, anniversary, noofper, occupation, offadd1, offadd2, offadd3, offphone1, offphone2, email, custtype, maritalstatus, narration,payment_type_code)values(?,?,?,?,?,?,?,?,'',?,?,?,?,?,?,?,'',?,now(),now(),now(),now(),1,'','','','','','','','','M','',?)"); 
			addValue.setString(1,get1);	
			addValue.setString(2,custName);	
			addValue.setString(3,building);	
			addValue.setString(4,buildingno);	
			addValue.setString(5,block);	
			addValue.setString(6,wing);	
			addValue.setString(7,add1);	
			addValue.setString(8,add2);	
			addValue.setString(9,area);				
			addValue.setString(10,station);	
			addValue.setString(11,city);
			addValue.setString(12,state);	
			addValue.setString(13,country);	
			addValue.setString(14,pinCode);	
			addValue.setString(15,phoneNo);	
			addValue.setString(16,mobile);	
			addValue.setString(17,payment);
			addValue.executeUpdate();			
	    	return("JS");
	    		 	
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();
			return("S");
		}
	}
	
	public int editCustomer(String custCode, String custName,String building,String buildingno,String block,String wing,String add1,String add2,String area,String station,String city,String state,String pinCode,String phoneNo,String payment,String mobile){	
		
		try{
			editValue = conn.prepareStatement("update customer_master set custname=?,building=?,building_no=?,block=?,wing=?,add1=?,add2=?,area=?,station=?,city=?,state=?,pincode=?,phone=?,update_datetime= sysdate(),payment_type_code=?,mobile=? where custcode=?"); 
			editValue.setString(1,custName);	
			editValue.setString(2,building);	
			editValue.setString(3,buildingno);	
			editValue.setString(4,block);	
			editValue.setString(5,wing);	
			editValue.setString(6,add1);	
			editValue.setString(7,add2);	
			editValue.setString(8,area);				
			editValue.setString(9,station);	
			editValue.setString(10,city);
			editValue.setString(11,state);				
			editValue.setString(12,pinCode);	
			editValue.setString(13,phoneNo);
			editValue.setString(14,payment);
			editValue.setString(15, mobile);
			editValue.setString(16,custCode);
			
			
			int run_sql= editValue.executeUpdate();
			//System.out.println(run_sql);
			return(run_sql);	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in edit Customer entry in Database " + e);
			closeAll();
			return(0);
		}
	
	}
	
	public void listCustomer(String name,String phone,String building,String building_no,String block,String wing,String add1,String add2,String custCode,String c_date1,String u_date1,String nameString, String area,String station){	
		
		try{
			String query="select custname,phone,building,block,wing,add1,add2,custCode,create_datetime,update_datetime,area,pincode,city,state,building_no,station,mobile,payment_type_code from customer_master where 1=1 ";
	    	
	    	if(name!=null){
	    		query = query + " and custname like'" + name + "%'";
	    	}
			if(phone!=null){
	    		query = query + " and phone like'" + phone + "%'";
	    	}
	    	
			if(building!=null){
	    		query = query + " and building like'" + building + "%'";
	    	}
	    	if(building_no!=null){
	    		query = query + " and building_no like'" + building_no + "%'";
	    	}
	    	
			if(block!=null){
	    		query = query + " and block like'" + block + "%'";
	    	}
			if(wing!=null){
				query = query + " and wing like'" + wing + "%'";
			}
	    	
			if(add1!=null){
	    		query = query + " and add1 like'" + add1 + "%'";
	    	}
	    	
			if(add2!=null){
				query = query + " and add2 like'" + add2 + "%'";
	    	}
	    	if(custCode!=null){
	    		query = query + "and custcode like'" + custCode + "%'";
	    	}
	    	if(nameString!=null){
	    		query = query + "and custname like '%"+ nameString + "%'";
	    	}	
	    	if(!c_date1.equals("")){
	    		query = query + " and trim(date(create_datetime)) = '" + c_date1 + "'";
	    	} 	    	   		
	    	if(!u_date1.equals("")){
	    		query = query + " and trim(date(update_datetime)) ='" +u_date1+ "%'";
	    	} 
	    	   	
	    	if(area!=null){
	    		query = query + " and area like'" + area + "%'";
	    	}
	    	if(station!=null){
	    		query = query + " and station like'" + station + "%'";
	    	}
	    	query =query + "order by update_datetime DESC";	
	    	System.out.println(" list customer "+query);
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();			
		}
	}
	
	
	// code for RcustList.jsp
	public ResultSet listCustomer1(String name,String phone,String building,String building_no,String block,String wing,String add1,String add2,String custCode,String c_date1,String c_date2,String u_date1,String u_date2 ,String nameString, String area,String station){	
		System.out.println("in method ....");
		try{
			String query="select custname,phone,building,block,wing,add1,add2,custCode,create_datetime,update_datetime,area,pincode,city,state,building_no,station,mobile,payment_type_code from customer_master where 1=1 ";
	    	
	    	if(name!=null){
	    		query = query + " and custname like'" + name + "%'";
	    	}
			if(phone!=null){
	    		query = query + " and phone like'" + phone + "%'";
	    	}
	    	
			if(building!=null){
	    		query = query + " and building like'" + building + "%'";
	    	}
	    	if(building_no!=null){
	    		query = query + " and building_no like'" + building_no + "%'";
	    	}
	    	
			if(block!=null){
	    		query = query + " and block like'" + block + "%'";
	    	}
			if(wing!=null){
				query = query + " and wing like'" + wing + "%'";
			}
	    	
			if(add1!=null){
	    		query = query + " and add1 like'" + add1 + "%'";
	    	}
	    	
			if(add2!=null){
				query = query + " and add2 like'" + add2 + "%'";
	    	}
	    	if(custCode!=null){
	    		query = query + "and custcode like'" + custCode + "%'";
	    	}
	    	if(nameString!=null){
	    		query = query + "and custname like '%"+ nameString + "%'";
	    	}	
	    	if(c_date1!=null){
	    		//query = query + " and trim(date(create_datetime)) = '" + c_date1 + "'";
	    		//query = query + " and trim(date(create_datetime)) between '" + c_date1 + "' and '"+ c_date2+"' ";
	    		query = query + " and date_format(create_datetime,'%Y-%m-%d') between '" + c_date1 + "' and '"+ c_date2+"' ";
	    	} 	    	   		
	    	if(u_date1!=null){
	    		//query = query + " and trim(date(update_datetime)) ='" +u_date1+ "%'";
	    		//query = query + " and trim(date(update_datetime)) between '" +u_date1+ "' and '"+u_date2+"' ";
	    		query = query + " and date_format(create_datetime,'%Y-%m-%d') between '" +u_date1+ "' and '"+u_date2+"' ";
	    	} 
	    	   	
	    	if(area!=null){
	    		query = query + " and area like'" + area + "%'";
	    	}
	    	if(station!=null){
	    		query = query + " and station like'" + station + "%'";
	    	}
	    	query =query + "order by update_datetime DESC ";	
	    	System.out.println(" RcustList.jsp  "+ query);
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();	
			
		}
		return rs;
	}
	
	public void listCustomerWithDate(String name,String phone,String building,String building_no,String block,String wing,String add1,String add2,String custCode,String c_date1,
								String c_date2,String u_date1,String u_date2,String nameString, String area,String station,String selmonth,String payment,String mobile,
									String call_type,String order_num){	
		try{
			String query="";
	    	if(selmonth !=null && selmonth !=""){
	    		query="select custname,phone,building,block,wing,add1,add2,a.custCode,date(create_datetime),date(update_datetime),area," +
	    				"pincode,city,state,building_no," +
	    				"station,mobile,a.payment_type_code, b.last_order_num,b.last_order_date,DATEDIFF(now(),b.last_order_date) ";
	    		if(call_type.equals("search_payment") || call_type.equals("communication")){
	    			query = query +",o.balance_amt balance,o.order_num order_number,o.order_date  orderdate,case when o.del_datetime= '0000-00-00 00:00:00' then o.order_date else o.del_datetime end del_date  from customer_master a, customer_stats b , orders o ";
	    		} else if(call_type.equals("receive_payment")){
	    			query = query +",sum(o.balance_amt) balance  from customer_master a, customer_stats b , orders o ";
	    		}else{
	    			query = query + "  from customer_master a, customer_stats b";
	    		}
	    	}else{
	    		query="select custname,phone,building,block,wing,add1,add2,a.custCode,date(create_datetime),date(update_datetime),area,pincode,city,state,building_no,station,mobile,a.payment_type_code ";
	    		if(call_type.equals("search_payment") || call_type.equals("communication")){
	    			query = query +",o.balance_amt balance,o.order_num order_number,o.order_date orderdate,case when o.del_datetime= '0000-00-00 00:00:00' then o.order_date else o.del_datetime end del_date from customer_master a, orders o ";
	    		} else if(call_type.equals("receive_payment")){
	    			query = query +",sum(o.balance_amt) balance from customer_master a, orders o ";
	    		}else{
	    			query = query + " from customer_master a";
	    		}
	    	} 
	    	query = query + " where 1=1 ";
	    	if(call_type.equals("receive_payment")){
	    		query = query + "and a.custCode = o.custCode and o.balance_amt > 0 and status_code in ('DELIVERED','CLOSED') ";
	    	}
	    	if(call_type.equals("communication") || call_type.equals("search_payment")){
	    		query = query + "and a.custCode = o.custCode and o.balance_amt > 0 and status_code in ('DELIVERED','CLOSED') ";
	    		if(!order_num.equals(""))
	    			query = query +"and  o.order_num in (select order_num from orders where custcode = (select custcode from orders where order_num ='"+order_num+"')) ";
	    	}
	    	
	    	if(name!=null && !name.equals("")){
	    		query = query + " and custname like'" + name + "%'";
	    	}
			if(phone!=null && !phone.equals("")){
	    		query = query + " and phone like'" + phone + "%'";
	    	}
			
			if(mobile!=null && !mobile.equals("")){
	    		query = query + " and mobile like'" + mobile + "%'";
	    	}
	    	
			if(building!=null && !building.equals("")){
	    		query = query + " and building like'" + building + "%'";
	    	}
	    	if(building_no!=null && !building_no.equals("")){
	    		query = query + " and building_no like'" + building_no + "%'";
	    	}
	    	
			if(block!=null && !block.equals("")){
	    		query = query + " and block like'" + block + "%'";
	    	}
			if(wing!=null && !wing.equals("")){
				query = query + " and wing like'" + wing + "%'";
			}
	    	
			if(add1!=null && !add1.equals("")){
	    		query = query + " and add1 like'" + add1 + "%'";
	    	}
	    	
			if(add2!=null && !add2.equals("")){
				query = query + " and add2 like'" + add2 + "%'";
	    	}
			if(payment!=null && !payment.equals("")){
				if(payment.equals("NoType")){
					query = query + " and a.payment_type_code not in ('CA','CHQ','CR','H') ";
				}else{
					query = query + " and a.payment_type_code like'" + payment + "%'";
				}
	    	}
			if(selmonth !=null && !selmonth.equals("")){
				if(custCode!=null){
		    		query = query + "and a.custcode like'" + custCode + "%'";
		    	}
			}else{
				if(custCode!=null && !custCode.equals("")){
		    		query = query + "and a.custcode like'" + custCode + "%'";
		    	}
			}
	    	
	    	if(nameString!=null && !nameString.equals("")){
	    		query = query + "and custname like'%"+ nameString + "%'";
	    	}	
	    	try{
	    	if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and trim(date(create_datetime)) >='" + c_date1 + "' and  trim(date(create_datetime)) <= '" + c_date2 + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and trim(date(create_datetime)) = '" + c_date1 + "'";
	    	} 
	    	
	    	if(!u_date1.equals("") && !u_date2.equals("")){
	    		query = query + " and trim(date(update_datetime))  between '" + u_date1 + "' and '" + u_date2 + "'";
	    	}
	    	else if(!u_date1.equals("")){
	    		query = query + " and trim(date(update_datetime)) = '" +u_date1+ "'";
	    	} 
	    	}catch(Exception e){}
	    	if(area!=null && !area.equals("")){
	    		query = query + " and area like'" + area + "%'";
	    	}
	    	if(station!=null && !station.equals("")){
	    		query = query + " and station like'" + station + "%'";
	    	}
	    	System.out.println("1");
	    	if(selmonth !=null && selmonth !=""){
	    		query = query+" and a.custcode = b.custcode ";
	    		int days = Integer.parseInt(selmonth);
	    		if(days >= 0){
	    			query = query+" and trim(DATE(b.last_order_date)) <= trim(DATE(DATE_ADD(now(),INTERVAL - "+days+" DAY))) ";
	    		}
	    		if(call_type.equals("receive_payment")){
	    			query =query + " group by 8  order by a.custcode, b.last_order_date DESC";
	    		}else{
	    			query =query + "  order by a.custcode, b.last_order_date DESC";	
	    		}
	    		}else{
	    			if(call_type.equals("receive_payment")){
		    			query =query + " group by 8  order by a.custcode,update_datetime DESC";
		    		}else if(call_type.equals("search_payment")){
		    			query =query + "  order by a.custname,a.custcode, o.order_num DESC";
		    		}else{
		    			query =query + "  order by a.custcode,update_datetime DESC";
		    		}
	    	}
	    	System.out.println(query);
	    			    	
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in Disp Cust List " + e);
			closeAll();			
		}
	}
	
 	
	public ResultSet listCustomers(){
		//ResultSet resultSet=null;
		ArrayList<CustomerListOutputBean> customerListOutputBeans=null;
		try{
			String query="select custname,phone,building,block,wing,add1,add2,custCode,date(create_datetime),date(update_datetime),area,pincode,city,state," +
					"building_no,station,mobile,payment_type_code from customer_master where 1=1 ";
			query =query + "order by custCode ";
	    	System.out.println("cust details all "+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();			
		}
		return rs;
	}
	public int deleteCustomer(String custCode){
		try{
			String query="delete from customer_master where custCode='"+custCode+"' ";
	    	int ans =stat.executeUpdate(query);
	    	return(ans);
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();	
			return(0);
		}
	}
	public void customerInfo(String custCode){
		try{
			
			rs = stat.executeQuery("call get_cust_info_rms1('"+custCode+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();			
		}
	}
	public void CustomerStatsDetail(String action,String fromDate,String toDate,String custCode,String custName,String area){
		try{
			System.out.println("===>"+action+","+fromDate+","+toDate+","+custCode+","+custName+","+area);
			rs = stat.executeQuery("call get_cust_stats_detail('"+action+"','"+fromDate+"','"+toDate+"','"+custCode+"','"+custName+"','"+area+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	
	public void CustomerStatsFMCGDetail(String action,String custCode,String custName,String area,String fmcg){
		try{
			//System.out.println("===>"+action+","+fmcg+","+custCode+","+custName+","+area);
			rs = stat.executeQuery("call get_cust_stats_fmcg('"+action+"','"+custCode+"','"+custName+"','"+area+"','"+fmcg+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	
	public void listCustomerAttribute(String custCode){
		try{
			System.out.println(custCode);
			String query1="SELECT language_code, custCode, mobile, email_id, ifnull(DATE_FORMAT(dob,'%d/%m/%Y'),''), marital_status, spouse_name, ifnull(DATE_FORMAT(spouse_dob,'%d/%m/%Y'),''), ifnull(DATE_FORMAT(marriage_ann,'%d/%m/%Y'),''), total_members, grocery_person_name, occupation_code, work_name, work_add1, work_add2, work_city, work_state, work_pincode, work_country, work_telephone, work_fax FROM customer_attribute where custCode='"+custCode+"' ";
			rs=stat.executeQuery(query1);    
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer entry in Database " + e);
			closeAll();				
		}
	}
	
public int editCustomerAttribute(String language_code,String custCode,String mobile,String email,String dob,String marital_status,String spouse_name,String spouse_dob,String marr_ann,String totalmemb,String groceryname,String occu_code,String work_name, String work_add1,String work_add2,String work_city,String work_state,String work_pincode,String work_country,String work_telephone,String work_fax){	
		
		try{	
			String query="delete from customer_attribute where custCode='"+custCode+"' ";
	    	stat.executeUpdate(query);
	    	if(dob == ""){
	    		dob = null;
	    	}
	    	if(marr_ann == ""){
	    		marr_ann = null;
	    	}
	    	if(spouse_dob == ""){
	    		spouse_dob = null;
	    	}
			addValue = conn.prepareStatement("insert into customer_attribute (language_code, custCode, mobile, email_id, dob, marital_status, spouse_name, spouse_dob, marriage_ann, total_members, grocery_person_name, occupation_code, work_name, work_add1, work_add2, work_city, work_state, work_pincode, work_country, work_telephone, work_fax) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 
			addValue.setInt(1,Integer.parseInt(language_code));	
			addValue.setString(2,custCode);	
			addValue.setString(3,mobile);	
			addValue.setString(4,email);	
			addValue.setString(5,dob);			
			addValue.setString(6,marital_status);	
			addValue.setString(7,spouse_name);	
			addValue.setString(8,spouse_dob);	
			addValue.setString(9,marr_ann);			
			addValue.setInt(10,Integer.parseInt(totalmemb));	
			addValue.setString(11,groceryname);
			addValue.setInt(12,Integer.parseInt(occu_code));	
			addValue.setString(13,work_name);	
			addValue.setString(14,work_add1);	
			addValue.setString(15,work_add2);	
			addValue.setString(16,work_city);	
			addValue.setString(17,work_state);	
			addValue.setString(18,work_pincode);	
			addValue.setString(19,work_country);	
			addValue.setString(20,work_telephone);	
			addValue.setString(21,work_fax);	
			
			addValue.executeUpdate();			
	    	return(1);
	    		 	
		}
		catch(Exception e){
			System.out.println("Error occurred in add Customer Attribute entry in Database " + e);
			closeAll();
			return(0);
		}
	}
	public void CustPmtHistory(String CustCode){
		try{
			String query="select order_num,order_date,ifnull(del_datetime,'0000-00-00 00:00:00'),ifnull(closed_datetime,'0000-00-00 00:00:00')closed_datetime,close_status,balance_amt,change_amt,paid_amt,remark,ABS((balance_amt + change_amt)-paid_amt) from orders "+
				" where custcode='"+CustCode+"'"+
				" order by 2";
			System.out.println("CustPmtHistory query="+query);
			rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();
		}
		
	}
	public String getpaytype(String paycode){
		try{
			String name="";
			String query="select payment_type_desc from payment_type where payment_type_code = '"+paycode+"'";
			rs1=stat1.executeQuery(query);
			if(rs1.next()){
				name = rs1.getString(1);
				return name;
			}
			return "No Type";
						
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();
			return "No Type";
		}
	}
	public void disppaytype(){
		try{
			
			String query="select payment_type_code, payment_type_desc from payment_type ";
			rs1=stat1.executeQuery(query);						
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();			
		}
	}
	
	public void getcustDetails(String custcode){
		try{
			String query="select  a.order_num, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate, a.status_code, a.balance_amt from orders a, payment_type b where a.payment_type_code=b.payment_type_code and a.custcode='"+custcode+"'";
			rs=stat.executeQuery(query);						
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();			
		}
	}
	
	public int savePaymentType(String custcode,String selpay){
		try{
			String query="update customer_master set payment_type_code='"+selpay+"' where custcode ='"+custcode+"'";
			//System.out.println(query);
			int ans=stat.executeUpdate(query);	
			return ans;
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();	
			return 0;
		}
	}
	
	public void getCustInfoByOrderNumber(String orderNo){
		try{
			String query="select a.custcode, a.custname, a.phone, a.building, a.building_no," +
					" a.wing, a.block,a.add1, a.add2, a.area, a.station" +
					" from customer_master a , orders o " +
					" where a.custcode = o.custcode " +
					" and o.order_num ='"+orderNo+"'";
			System.out.println(query);
			rs=stat.executeQuery(query);						
		}
		catch(Exception e){
			System.out.println("Error occurred in Edit Customer Payment History Report " + e);
			closeAll();			
		}
	}
	
	public String getCuode(String order_num){
		try{
			String query="SELECT custcode FROM orders where order_num = '"+order_num+"'";
			System.out.println(query);
			rs=stat.executeQuery(query);
			rs.next();
			return rs.getString(1);
		}
		catch(Exception e){
			return "";		
		}
	}
	
	public void getPaymentList(String orders[]){
		String query = "select a.custCode,custname,o.balance_amt ,o.order_num,o.order_date,phone,mobile,building,building_no,block," +
				"wing,add1,add2,area,pincode,city,station,case when o.del_datetime= '0000-00-00 00:00:00' then o.order_date else o.del_datetime end del_date " +
				"from customer_master a, orders o where a.custCode = o.custCode and o.balance_amt > 0";
		
		query = query +" and o.order_num in (" ;
		for(int i=0;i<orders.length;i++){
			query = query + "'"+orders[i]+"'";
			if(i != orders.length-1){
				query=query+",";
			}
		}
		query = query + ")";
		
		query = query +" and status_code in ('DELIVERED','CLOSED') order by a.custname,a.custcode, o.order_num DESC";
		try{
			System.out.println(query);
			rs=stat.executeQuery(query);
		//	rs.next();
		}
		catch(Exception e){}
	}
	
	public ArrayList<CustomerBean> getCustomerList(CustomerBean bean){
		ArrayList<CustomerBean> beanList = new ArrayList<CustomerBean>();
		try{
			String query = "select * from customer_master where 1=1";
			if( bean.getCustcode()!=null && !bean.getCustcode().equals("")){
				query=query+" and  custcode like '"+bean.getCustcode()+"%' ";
			}
			if(bean.getCustname()!=null && !bean.getCustname().equals("")){
				query=query+" and custname like  '"+bean.getCustname()+"%' ";
			}
			if(bean.getBuilding()!=null && !bean.getBuilding().equals("")){
				query=query+" and building like '"+bean.getBuilding()+"%' ";
			}
			if(bean.getBuilding_no()!=null && !bean.getBuilding_no().equals("")){
				query=query+" and building_no  like '"+bean.getBuilding_no()+"%' ";
			}
			if(bean.getBlock()!=null && !bean.getBlock().equals("")){
				query=query+" and block like '"+bean.getBlock()+"%' ";
			}
			if(bean.getWing()!=null && !bean.getWing().equals("")){
				query=query+" and wing like '"+bean.getWing()+"%' ";
			}
			if(bean.getAdd1()!=null && !bean.getAdd1().equals("")){
				query=query+" and add1 like '"+bean.getAdd1()+"%' ";
			}
			if(bean.getAdd2()!=null && !bean.getAdd2().equals("")){
				query=query+" and add2 like '"+bean.getAdd2()+"%' ";
			}
						
			if(bean.getArea()!=null && !bean.getArea().equals("")){
				query=query+" and area like '"+bean.getArea()+"%' ";
			}
			if(bean.getStation()!=null && !bean.getStation().equals("")){
				query=query+" and station like '"+bean.getStation()+"%' ";
			}
			if(bean.getPhone()!=null && !bean.getPhone().equals("")){
				query=query+" and phone like '"+bean.getPhone()+"%' ";
			}
			
			
			
			
			addValue=conn.prepareStatement(query);
			rs = addValue.executeQuery();
			System.out.println(addValue.toString());
			while(rs.next()){
				CustomerBean tempBean =new  CustomerBean();
				tempBean.setCustcode(rs.getString(1));
				tempBean.setCustname(rs.getString(2));
			    tempBean.setBuilding(rs.getString(3) + " " +rs.getString(4)+ " " +rs.getString(5)+ " "+rs.getString(6)+ " " +rs.getString(10)+ " "+rs.getString(11));
			    tempBean.setBuilding(rs.getString(3));
			    tempBean.setBuilding_no(rs.getString(4));
			    tempBean.setBlock(rs.getString(5));
			    tempBean.setWing(rs.getString(6));
			    tempBean.setAdd1(rs.getString(7));
			    tempBean.setAdd2(rs.getString(8));
			    //tempBean.setAdd3(rs.getString(9));
			    tempBean.setArea(rs.getString(10));
			    tempBean.setStation(rs.getString(11));
			    tempBean.setPhone(rs.getString(16));
			    /*tempBean.setCity(rs.getString(12));
			    tempBean.setState(rs.getString(13));
			    tempBean.setCountry(rs.getString(14));
			    tempBean.setPincode(rs.getLong(15));
			   
			    tempBean.setFax(rs.getLong(17));
			    tempBean.setMobile(rs.getInt(18));
			   // tempBean.setCreate_datetime(rs.getString(19));
			    //tempBean.setUpdate_datetime(rs.getString(20));
			    //tempBean.setDob(rs.getString(21));
			    //tempBean.setAnniversary(rs.getString(22));
			    tempBean.setNoofper(rs.getString(23));
			    tempBean.setOccupation(rs.getString(24));
			    tempBean.setOffadd1(rs.getString(25));
			    tempBean.setOffadd2(rs.getString(26));
			    tempBean.setOffadd3(rs.getString(27));
			    tempBean.setOffphone1(rs.getLong(28));
			    tempBean.setOffphone2(rs.getLong(29));
			    tempBean.setEmail(rs.getString(30));
			    tempBean.setCusttype(rs.getString(31));
			    tempBean.setNarration(rs.getString(32));*/
			    beanList.add(tempBean);
			
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return beanList;
		
	}
	
	
	public void List() {
		
		System.out.println("in the list ");
	}
	
} 
