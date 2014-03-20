package packaging;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageBreakdown {
	private Connection conn=null;
	private String envLookup;
	private ResultSet rs = null;
	
	public ManageBreakdown(String envLook) {
		// TODO Auto-generated constructor stub
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
	
	public ResultSet getBreakdownList(String frDate , String toDate) {
		 //String sql = " select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,DATE_FORMAT(bd_date,'%d-%m-%Y') bd_date,entered_by from breakdown_header where DATE(bd_date) between ? and ?";
		String breakDownQuery = "select b.bd_number, m.item_name as bachka_code,m.item_weight, b.loss_in_breakdown, s.site_name, DATE_FORMAT(b.bd_date,'%d-%m-%Y') bd_date, b.entered_by, b.gain_in_breakdown "+
								"from breakdown_header b, item_master m,site_master s "+
								"where date(bd_date) between ? and ? "+
								"and b.bachka_code=m.item_code "+
								"and b.site_id=s.site_id;";  
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(breakDownQuery);
			pstmt.setDate(1, Date.valueOf(frDate));
			pstmt.setDate(2, Date.valueOf(toDate));
			System.out.println("frDate "+frDate+" toDate "+toDate);
			System.out.println("breakdown sql "+breakDownQuery);
			rs = pstmt.executeQuery();
					
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet getBreakdownDetails(int bd_number) {
		// String sql = "select bd_number,item_code,price_version,new_qty from breakdown_detail where bd_number=?";
		String sql = "select m.item_name,b.price_version,b.new_qty from breakdown_detail b natural join item_master m where b.bd_number=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bd_number);
			rs = pstmt.executeQuery();
			//rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
		
	}
	
	public void closeAll() {
		try {
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	public ResultSet getCompleteBrekdownList() {
		 String sql = " select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from breakdown_header ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("data available in breakdown header in completeBreakdownHeader");
		return rs;
	}
	
	public ResultSet orderByParameter(String param) {
		System.out.println("parameter is "+param); 
		//String sql = " select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from breakdown_header order by "+param+" desc";
		String sql = " select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from breakdown_header order by "+param+" asc";
		 
		  try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			System.out.println(sql);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("data in descending order ");
		return rs;
		
	}
	
	public ResultSet getColumnUniqueValuesList(String param) {
		String sql = "select distinct("+ param +") from breakdown_header";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		System.out.println(sql);
		System.out.println("unique values in column");
		return rs;
	}
	
	public ResultSet getFilteredStartData(String param,String value) {
		System.out.println("in filtered start data "+value);
		String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '"+value+"%'";
		//String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '?%'";
		
		//String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '?%'";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, value);
			System.out.println(sql);
			rs = pstmt.executeQuery();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	return rs;	
	}
	
	public ResultSet getFilteredContainsData(String param,String value) {
		System.out.println("in filtered start data ");
		String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '%"+value+"%'";
		//String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '%?%'";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, value);
			System.out.println(sql);
			rs = pstmt.executeQuery();
			/*if (rs.next()) {
				System.out.println("data avilable in filter");
			}*/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
public ResultSet getFilteredEndData(String param,String value) {
	System.out.println("in filtered start data ");
	String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '%"+value+"'";
	//String sql = "select bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by from js_data.breakdown_header b where "+ param+" like '%?'";
	
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		//pstmt.setString(1, value);
		System.out.println(sql);
		rs = pstmt.executeQuery();
		/*if (rs.next()) {
			System.out.println("data avilable in filter");
		}*/
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();	
	}
	return rs;
	}
	
	public ResultSet  getBreakDownDetailsPopUp(String brekdownNumber ) {
		ResultSet resultSet =null;
		String breakdownDetailsQuery = "select d.bd_number,m.item_name,m.item_weight,p.item_mrp,p.item_rate, d.new_qty "+
										"from  breakdown_detail d , item_master m , item_price p "+
										"where d.item_code=m.item_code "+
										"and d.price_version=p.price_version "+
										"and d.item_code=p.item_code "+
										"and bd_number= ? ; ";
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(breakdownDetailsQuery);
			preparedStatement.setString(1, brekdownNumber);
			System.out.println("breakdown Number "+brekdownNumber);
			System.out.println("breadown detail query  :"+breakdownDetailsQuery);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
		
	} 

}

	


