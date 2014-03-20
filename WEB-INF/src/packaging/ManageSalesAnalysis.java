package packaging;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageSalesAnalysis {
	private Connection conn=null;
	private String envLookup;
	private ResultSet rs = null;
	
	public ManageSalesAnalysis() {
		
	}
		
	public ManageSalesAnalysis(String envLook) {
		envLookup = envLook;
		initialize(envLookup);
	}
	
	
	public void  initialize(String env){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(env);
			conn = ds.getConnection();
			System.out.println("connected successfully ...");
			
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
		
	}	
	
	public ResultSet getCompleteSalesAnalysis(String frDate , String toDate) {

		System.out.println("fr date : "+frDate.replace("/", "-"));
		System.out.println("end date : "+toDate.replace("/", "-"));
		frDate = frDate.replace("/", "-");
		toDate = toDate.replace("/", "-");
		
		try {
			
			/*String report1 = "select c.custname,c.building,c.station,i.item_group_desc,i.fmcg_ind,m.item_name,o.order_num,date(o.order_date),"+
							"o.total_value_discount,d.qty,d.price,d.item_discount from orders o, customer_master c, order_detail d, item_master m, item_group i "+
							" where date(o.order_date) between ? and ? and o.custcode=c.custcode and o.order_num=d.order_num "+
							" and d.item_code=m.item_code and m.item_group_code=i.item_group_code ;" ;
			*/
			
			String report1 = "select c.custname,c.building,c.station,i.item_group_desc,i.fmcg_ind,m.item_name,o.order_num,date(o.order_date),"+
							"o.total_value_discount,d.qty,d.price,d.item_discount, sm.site_name " +
							" from orders o, customer_master c, order_detail d, item_master m, item_group i ,site_master sm"+
							" where date(o.order_date) between ? and ? and o.custcode=c.custcode and o.order_num=d.order_num "+
							" and d.item_code=m.item_code and m.item_group_code=i.item_group_code and o.site_id=sm.site_id ;" ;
			
			
			
			
			PreparedStatement cstmt = conn.prepareStatement(report1);
			//cstmt.setString(1,frDate.trim());
			//cstmt.setString(2, toDate.trim());
			
			cstmt.setDate(1,Date.valueOf(frDate));
			cstmt.setDate(2,Date.valueOf(toDate));
			System.out.println("== ppp report_test "+report1);
			 rs = cstmt.executeQuery();
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("error "+e.getMessage() );
		}
		
		return rs;
	}
	
	public ResultSet getSalesAnalysis(String orderNumber) {
		ResultSet resultSet = null;
		System.out.println("order num "+orderNumber); 
		String salesAnalysisQuery = "select c.custname,c.building,c.station,i.item_group_desc,i.fmcg_ind,m.item_name,o.order_num,date(o.order_date),"+
				"o.total_value_discount,d.qty,d.price,d.item_discount, sm.site_name " +
				" from orders o, customer_master c, order_detail d, item_master m, item_group i ,site_master sm"+
				" where o.order_num like '"+orderNumber+"%' and o.custcode=c.custcode and o.order_num=d.order_num "+
				" and d.item_code=m.item_code and m.item_group_code=i.item_group_code and o.site_id=sm.site_id ;" ;
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(salesAnalysisQuery);
			System.out.println("salesAnalysisQuery "+salesAnalysisQuery);
			resultSet = preparedStatement.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		return resultSet;
	}
	
	public void closeAll() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
}
