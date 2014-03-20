package staff;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageStaff {
	
	public Connection conn=null;
	public Statement  stat;
	public ResultSet rs;
	String envLookup, query1;
	PreparedStatement addValue;
	PreparedStatement editValue;
	
	
	public ManageStaff(String envLook){
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
	
	public int addStaff(String dsName, String stDate,int dsBalance){	
		
		try{
			
			String selSql = "select dstaff_name from delivery_staff";
			selSql=selSql + " where dstaff_name='"+dsName+"'";
			rs = stat.executeQuery(selSql);
			if(rs.next()){ 
				return(2);
				
			}
			String get1="",code="";
			int Code=0;
			code.ManageCode c;
			c = new code.ManageCode(envLookup);
			get1 = c.getCodeValue("StaffCodeStart"); 
			code = c.getCodeValue("NextStaffCode");
			
			Code=Integer.parseInt(code);
			get1=get1+Code;					
		
			Code= Code + 1;
			addValue = conn.prepareStatement("insert into delivery_staff (dstaff_code, dstaff_name, start_date, balance_to_pay)values(?,?,?,?)"); 
			addValue.setString(1,get1);	
			addValue.setString(2,dsName);	
			addValue.setString(3,stDate);	
			addValue.setInt(4,dsBalance);
			
			int run_sql= addValue.executeUpdate();			
	    	if(run_sql==1){
	    		  c.editCodeValue(Code,"NextStaffCode");
	    	}
	    	c.closeAll();
	    	return(run_sql);	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add Staff entry in Database " + e);
			closeAll();
			return(0);
		}
	}
	
	public int editStaff(String dsCode, String dsName){	
		
		try{
			editValue = conn.prepareStatement("update delivery_staff set dstaff_name=? where dstaff_code=?"); 
			editValue.setString(1,dsName);	
			editValue.setString(2,dsCode);	
			
			int run_sql= editValue.executeUpdate();	
			return(run_sql);	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in edit Delivery Staff Member " + e);
			closeAll();
			return(0);
		}
	
	}
	
	public void listStaff(String dsCode,String dsName, String c_date1, String c_date2, String bal1,String bal2){	
		
		try{
			String query="select dstaff_code, dstaff_name, start_date, balance_to_pay from delivery_staff where 1=1 ";
	    	
	    	if(dsCode!=null){
	    		query = query + " and dstaff_code like'" + dsCode + "%'";
	    	}
			if(dsName!=null){
	    		query = query + " and dstaff_name like'" + dsName + "%'";
	    	}
	    	
			if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and trim(date(start_date)) between '" + c_date1 + "' and '" + c_date2 + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and trim(date(start_date)) ='" + c_date1 + "'";
	    	} 
	    	   		
	    	if(!bal1.equals("") && !bal2.equals("")){
	    		query = query + " and balance_to_pay  between '" + bal1 + "%' and '" + bal2 + "%'";
	    	}
	    	else if(!bal1.equals("")){
	    		query = query + " and balance_to_pay like'" +bal1+ "%'";
	    	} 
	    	query =query + "order by dstaff_name";	
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of staff members entry in Database " + e);
			closeAll();			
		}
	}

	public void listStaff(){	
		
		try{
			String query="select dstaff_code, dstaff_name, start_date, balance_to_pay from delivery_staff where 1=1 ";
	    	
	    	query =query + "order by dstaff_name";	
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of staff members  " + e);
			closeAll();			
		}
	}
	public void listCommissions(){
		
		try{
			/*String query="select a.dstaff_code, a.dstaff_name, a.balance_to_pay,"+
						"b.total_orders, b.total_comm, total_paid,"+
						"last_pay_dt, d.tran_amt "+
						"from delivery_staff a, "+
						"(select dstaff_code, count(order_num) total_orders,"+
						"sum(comm_amt) total_comm " +
						"from orders group by dstaff_code) b,"+
						"(select staff_code, sum(tran_amt) total_paid, max(tran_dt) last_pay_dt "+
						"from transaction "+
						"group by staff_code) c, "+
						"transaction d "+
						"where a.dstaff_code = b.dstaff_code "+
						"and b.dstaff_code = c.staff_code "+
						"and a.dstaff_code = d.staff_code "+
						"and d.tran_dt = c.last_pay_dt";*/
			
			//query changed
			String query = "select a.dstaff_code,a.dstaff_name, a.balance_to_pay, sum(b.tran_amt),max(b.tran_dt), (select tran_amt from transaction where tran_dt=max(b.tran_dt)) "
						+", count(distinct c.order_num),sum(distinct c.comm_amt) "
						+"from orders c, delivery_staff a "
						+"left join transaction b "
						+"on a.dstaff_code=b.staff_code "
						+"where c.dstaff_code= a.dstaff_code "
						+"group by a.dstaff_code,a.dstaff_name, a.balance_to_pay order by a.dstaff_name ";
			System.out.println("all commision "+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public void listCommissions(String name, String amt1, String amt2){
		
		try{
			String query="select a.dstaff_code,a.dstaff_name, a.balance_to_pay, sum(b.tran_amt), max(b.tran_dt), (select tran_amt from transaction where tran_dt=max(b.tran_dt))  , count(distinct c.order_num),sum(distinct c.comm_amt),c.status_code "+
							"from orders c, delivery_staff a "+
							"left join transaction b "+
							"on a.dstaff_code=b.staff_code "+
							"where c.dstaff_code= a.dstaff_code";
	    	if(name!=null){
	    		query = query + " and a.dstaff_name like'" + name + "%'";
	    	}			
	    	   		
	    	if(!amt1.equals("") && !amt2.equals("")){
	    		query = query + " and a.balance_to_pay  between '" + amt1 + "%' and '" + amt2 + "%'";
	    	}
	    	else if(!amt1.equals("")){
	    		query = query + " and a.balance_to_pay like'" +amt1+ "%'";
	    	} 
	    	query =query + " group by a.dstaff_code,a.dstaff_name, a.balance_to_pay order by a.dstaff_name";
	 
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}

	public void listCommissionsWithDate(String name, String amt1, String amt2, String c_date1, String c_date2){
		
		try{
			String query="select a.dstaff_code,a.dstaff_name, a.balance_to_pay, sum(b.tran_amt),max(b.tran_dt), (select tran_amt from transaction where tran_dt=max(b.tran_dt))  , count(distinct c.order_num),sum(distinct c.comm_amt)"+
							"from orders c, delivery_staff a "+
							"left join transaction b "+
							"on a.dstaff_code=b.staff_code "+
							"where c.dstaff_code= a.dstaff_code";
	    	if(name!=null){
	    		query = query + " and a.dstaff_name like'" + name + "%'";
	    	}			
	    	   		
	    	if(!amt1.equals("") && !amt2.equals("")){
	    		query = query + " and a.balance_to_pay  between '" + amt1 + "%' and '" + amt2 + "%'";
	    	}
	    	else if(!amt1.equals("")){
	    		query = query + " and a.balance_to_pay like'" +amt1+ "%'";
	    	}
	    	/*if(!c_date1.equals("") && !c_date2.equals("")){
	    	    query = query + " and trim(date(b.tran_dt)) between '" + c_date1 + "' and '" + c_date2 + "'";
	    	}
	    	else if(!c_date1.equals("")){
	    		query = query + " and trim(date(b.tran_dt)) ='" + c_date1 + "'";
	    	} 
	    	*/
	    	if(c_date1!=null){
	    		 query = query + " and date_format(b.tran_dt,'%Y-%m-%d')  between '" + c_date1 + "' and '" + c_date2 + "'";
	    	}
	    		
	    	query =query + " group by a.dstaff_code,a.dstaff_name, a.balance_to_pay order by a.dstaff_name";
	    	System.out.println("commicion "+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}

	public void listCommissionsWithCode(String code){
		
		try{
			String query="select tran_id, tran_type, tran_dt, tran_amt, old_balance_amt, new_balance_amt, staff_code "+
							"from transaction "+						
							"where staff_code='"+code+"' ";	
			query =query + "order by tran_id";	
			System.out.println("transction details "+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of Commission " + e);
			closeAll();			
		}
	}
	
	public int addTransaction(String d_code, float balance, float payamt){	
		
		try{
			int id=0;			
			String selSql = "select max(tran_id) from transaction";
			rs = stat.executeQuery(selSql);
			if(rs.next()){ 
				id= rs.getInt(1);				
			}
			id=id+1;				
			
			String query ="insert into transaction(tran_id, tran_type, tran_dt, tran_amt, old_balance_amt, new_balance_amt, staff_code) " +
					       "values ('"+id+"', 'C', now(),'"+payamt+"', '"+ balance+"',('"+balance+"' - '"+payamt+"'),'"+d_code+"')"; 
			
			int run_sql= stat.executeUpdate(query);
	    	if(run_sql==1){
	    		query1 = "update delivery_staff set balance_to_pay=('"+balance+"' - '"+payamt+"') where dstaff_code='"+d_code+"'";
	    		stat.executeUpdate(query1);
	    	}
	    	return(run_sql);	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add Staff entry in Database " + e);
			closeAll();
			return(0);
		}
	}
	
	public void getCommissionDetails(String d_staff_code, String frDate, String toDate){		
		
		try{
			//System.out.println(d_staff_code + ".."+frDate + ".."+toDate);
			rs = stat.executeQuery("call comm_dtl_list('"+d_staff_code+"' ,'"+frDate+"','"+toDate+"')");
			
			
			/*if(frDate == null && toDate == null ){
				rs = stat.executeQuery("call comm_dtl_list('"+d_staff_code+"' ,null,null)");
			}
			else if(frDate == null){
				rs = stat.executeQuery("call comm_dtl_list('"+d_staff_code+"' ,null,'"+toDate+"')");
			}
			else if(toDate == null){
				rs = stat.executeQuery("call comm_dtl_list('"+d_staff_code+"' ,'"+frDate+"',null)");
				
			}else{
				rs = stat.executeQuery("call comm_dtl_list('"+d_staff_code+"' ,'"+frDate+"','"+toDate+"')");
			}*/
		}
		catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	
	public void getCommissionSubDetails(String report, String d_staff_code, String date1, String date2){		
		
		try{
			System.out.println("call comm_dtl_sub('"+report+"' ,'"+d_staff_code+"','"+date1+"','"+date2+"')");
			rs = stat.executeQuery("call comm_dtl_sub('"+report+"' ,'"+d_staff_code+"','"+date1+"','"+date2+"')");
		}
		catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	
    public void getDeliveryStaffDetails(String d_staff_code, String frDate, String toDate){		
		
		try{
			System.out.println(d_staff_code + ".."+frDate + ".."+toDate);
			rs = stat.executeQuery("call report_dlv_list('"+d_staff_code+"' ,'"+frDate+"','"+toDate+"')");
		}
		catch(Exception e){
			System.out.println("Exception occured in getDeliveryStaffList");
			e.printStackTrace();
			closeAll();	
		}
	}
	
	
}