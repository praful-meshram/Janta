package payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManagePayment {
	public Connection conn = null;
	public Statement stat, stat1;
	public PreparedStatement pstmt;
	public ResultSet rs, rs1;
	public String query;
	String envLookup;

	public ManagePayment(String envLook) {
		envLookup = envLook;
		initialize(envLookup);
	}

	public void initialize(String env) {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup(env);
			conn = ds.getConnection();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
		} catch (Exception e) {
			System.out.println("Receive Payment connection error : " + e);
		}

	}

	public void closeAll() {
		try {
			if (stat != null)
				stat.close();
			if (stat1 != null)
				stat1.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
	}
	
	public void getCommHistory(String cust_code){
		try{
			String query = "SELECT * FROM cust_commu where cust_code = '"+cust_code+"' order by 1 desc";
			rs1 = stat.executeQuery(query);
			System.out.println(query);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void getCustInfo(String cust_code){
		try{
			String query = "SELECT custname, building, block,wing, add1, area, station," +
					" city, phone,mobile, dob, occupation" +
					" FROM customer_master c where c.custcode = '"+cust_code+"'";
			rs = stat.executeQuery(query);
			System.out.println(query);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void getOrderInfo(String cust_code){
		try{
			String query = "SELECT order_num, order_date, total_value, change_amt, " +
					"paid_amt, advance_amt, discount_amt, balance_amt, other_charges, total_items " +
					"FROM orders o where custcode = '"+cust_code+"' and balance_amt > 0 and status_code in ('DELIVERED','CLOSED') order by 2 asc";
			rs = stat.executeQuery(query);
			System.out.println(query);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int getLastPayFromTable(){
		try{
			query = "select max(pay_id) from receive_payment_master";
			rs = stat.executeQuery(query);
			System.out.println("Max Pay Id : "+query);
			rs.next();
			return rs.getInt(1);
		}catch(Exception e){
			System.out.println("Error in fetching max pay no : ");
			e.printStackTrace();
			return 0;
		}
	}
	
	public boolean isPayCodeExist(String pay_code){
		try{
			query = "SELECT pay_code FROM receive_payment_master where pay_code = '"+pay_code+"'";
			rs = stat.executeQuery(query);
			System.out.println("Check pay code : "+query);
			if(rs.next()){
				return false;
			}
			else
				return true;
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		}
	}
	
	public boolean savePayment(String pay_code, String cust_code, String receive_by, String tot_amt, String rem_amt){
		try{
			query = "insert into receive_payment_master(pay_code, cust_code, tot_amt, rem_amt, date, receive_by)" +
					" values ('"+pay_code+"','"+cust_code+"','"+tot_amt+"','"+rem_amt+"', now(), '"+receive_by+"')";
			System.out.println("Inserting pay : "+query);
			stat.execute(query);
			return true;
		} catch (Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean saveDistributedPayment(String pay_code,String ord_no[],String balance[], String dist_amt[], String[] waived){
		try{
			for(int i=0;i<dist_amt.length;i++){
				if(Float.parseFloat(dist_amt[i]) != 0){
					query = "insert into receive_payment_detail(pay_code, ordre_num, received_amount, remaining_balance, waived_amount) values("+
					"'"+pay_code+"','"+ord_no[i]+"','"+dist_amt[i]+"','"+(Float.parseFloat(balance[i]) - Float.parseFloat(dist_amt[i]))+"','"+waived[i]+"')";
					stat.execute(query);
					System.out.println("No "+i+" : "+query);
					query = "update orders set balance_amt = "+(Float.parseFloat(balance[i]) - Float.parseFloat(dist_amt[i]))+
							" where order_num = '"+ord_no[i]+"'";
					System.out.println("     "+query);
					stat.executeUpdate(query);
				}
			}	
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	public void getRecentPaymentDetail(String cust_code){
		try{
			query = "SELECT * FROM receive_payment_master where cust_code = '"+cust_code+"' order by date desc";
			rs = stat.executeQuery(query);
			System.out.println("Recent payment : "+query);
		}catch(Exception e){
			System.out.println("Error in loading recent payment : ");
			e.printStackTrace();
		}
	}
	public void getPaymentDetail(String pay_code){
		try{
			query = "SELECT * FROM receive_payment_detail where pay_code = '"+pay_code+"'";
			rs = stat.executeQuery(query);
			System.out.println("Recent payment : "+query);
		}catch(Exception e){
			System.out.println("Error in loading recent payment : ");
			e.printStackTrace();
		}
	}
	
	public float getTotalBalane(String cust_code){
		float balance = 0.0f;
		try{
			query = "select sum(balance_amt) FROM orders o where custcode = '" +
					cust_code+"' and balance_amt > 0 and status_code in ('DELIVERED','CLOSED')";
			rs = stat.executeQuery(query);
			rs.next();
			balance = rs.getFloat(1);
			System.out.println("Total Balance : "+query);
		}catch(Exception e){
			System.out.println("Error in loading recent payment : ");
			e.printStackTrace();
		}
		return balance;
	}
	
	public void getDateRangePendingBalance(String from_date, String to_date){
		try{
			query = "select o.balance_amt,c.custcode, c.custname, c.building, c.building_no, c.block, c.wing," +
					" c.add1, c.area, c.station, c.city, c.phone, c.mobile, o.order_num, o.order_date" +
					" from customer_master c, orders o where "+
					" c.custcode = o.custcode " +
					//"and o.order_date > '"+from_date+"' and o.order_date < '"+to_date+"' " +
					"and o.status_code in ('DELIVERED','CLOSED') and o.balance_amt > 0 order by 3,15";
			System.out.println("Recent payment : "+query);
			rs = stat.executeQuery(query);
			System.out.println("Recent payment : "+query);
		}catch(Exception e){
			System.out.println("Error in Getting Pending : ");
			e.printStackTrace();
		}
	}
	
	public boolean saveCommunication(String subject,String feedback,String cust_code,String username,String date){
		try{
			pstmt = conn.prepareStatement("insert into cust_commu (cust_code, subject, feedback, con_by,con_date,commit_date) values (?,?,?,?,now(),?)");
			pstmt.setString(1, cust_code);
			pstmt.setString(2, subject);
			pstmt.setString(3, feedback);
			pstmt.setString(4, username);
			pstmt.setString(5, date);
			pstmt.execute();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public void getLastCommDetail(String cust_code){
		try{
			query = "SELECT con_date, commit_date FROM cust_commu c where cust_code = '"+cust_code+"' order by 1 desc";
			rs = stat.executeQuery(query);
			//System.out.println("getLastCommDetail() : "+query);
		}catch(Exception e){
			System.out.println("Error in getLastCommDetail() : ");
			e.printStackTrace();
		}
	}
}
