package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


import beans.CancelOrderInputBean;
import beans.CancelOrderOutputBean;

public class CancelOrderDAO {
	
	public Connection getConnection() {
		Connection connection =null;
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource dataSource = (DataSource)envContext.lookup("jdbc/js");
			connection = dataSource.getConnection();
			
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
		return connection;
	}
	
public ArrayList<CancelOrderOutputBean> getOrderDetails(CancelOrderInputBean cancelOrderInputBean){	
		Connection connection = getConnection(); 
		ResultSet resultSet=null;
		ArrayList<CancelOrderOutputBean> listCancelOrderOutputBeans = new ArrayList<CancelOrderOutputBean>(); 
		try{
						
			// Order list for cacel before sent
			
			 String query = "select a.order_num,a.order_date,p.payment_type_desc,a.enterd_by,a.status_code, b.custname"+
							" from orders a,customer_master b ,payment_type p"+
							" where a.custcode=b.custcode"+
							" and a.payment_type_code=p.payment_type_code"+
							" and a.status_code in ('SUBMITTED','CHECKED','HOLD')";
			if(cancelOrderInputBean.getPhoneNumber()!=null){
	    		query = query + " and b.phone like '" + cancelOrderInputBean.getPhoneNumber() + "%'";
	    	}
			if(cancelOrderInputBean.getCustName()!=null){
	    		query = query + " and b.custname like '" + cancelOrderInputBean.getCustName() + "%'";
	    	}
	    	if(cancelOrderInputBean.getOrderNumber()!=null){
	    		query = query + " and a.order_num like '" + cancelOrderInputBean.getOrderNumber() + "%'";
	    	}
	    	if(cancelOrderInputBean.getCustomerCode()!=null){
	    		query = query + " and b.custcode like '" + cancelOrderInputBean.getCustomerCode() + "%'";
	    	}
	    	if(cancelOrderInputBean.getCreateFromDate()!=null && cancelOrderInputBean.getCreateToDate()!=null){
	    	    query = query + " and trim(date(a.order_date)) between  '" + cancelOrderInputBean.getCreateFromDate() + "' and  '" + cancelOrderInputBean.getCreateToDate() + "'";
	    	}
	    		    	   		
	    	if(cancelOrderInputBean.getUpdateFromDate()!=null && cancelOrderInputBean.getUpdateToDate()!=null){
	    		query = query + " and trim(date(a.lastmodifieddate))  between '" + cancelOrderInputBean.getUpdateFromDate() + "' and '" + cancelOrderInputBean.getUpdateToDate() + "'";
	    	}
	    	
	    	if(cancelOrderInputBean.getEnterBy()!=null){
	    		query = query + " and enterd_by like '" + cancelOrderInputBean.getEnterBy() + "%'";
	    	}
	    	query=query + " order by(a.order_date)";	  
	    	System.out.println(query);
	    	PreparedStatement preparedStatement =connection.prepareStatement(query);
	    	resultSet = preparedStatement.executeQuery(query);
	    	while (resultSet.next()) {
	    		CancelOrderOutputBean cancelOrderOutputBean = new CancelOrderOutputBean();
	    		cancelOrderOutputBean.setOrderNumber(resultSet.getString("order_num"));
	    		cancelOrderOutputBean.setOrderDate(resultSet.getString("order_date"));
	    		cancelOrderOutputBean.setCustName(resultSet.getString("custname"));
	    		cancelOrderOutputBean.setPayment_type_desc(resultSet.getString("payment_type_desc"));
	    		cancelOrderOutputBean.setEnterd_by(resultSet.getString("enterd_by") );
	    		cancelOrderOutputBean.setStatusCode(resultSet.getString("status_code"));
	    		
	    		listCancelOrderOutputBeans.add(cancelOrderOutputBean);				
			}
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in display list of orders " + e);
				
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
		return listCancelOrderOutputBeans;
	}

// update Order ,orderDetal,Transaction and item_site_invenory after cancel order 
public boolean cancelOrder(String orderNumber) {
	Connection connection =getConnection();
	boolean flag = false;
	try {
			connection.setAutoCommit(false);
			String orderDetailQuery =" select d.item_code,d.price_version,d.qty ,o.site_id "+
									 " from  orders o , order_detail d "+
									 " where o.order_num = ? "+
									 " and o.order_num =  d.order_num;";
			
			PreparedStatement preparedStatement = connection.prepareStatement(orderDetailQuery);
			preparedStatement.setString(1, orderNumber);
			System.out.println(" orderDetailQuery "+orderDetailQuery);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				String updateSiteInventoryQuery = " update item_site_inventory "+
												"set item_site_qty = item_site_qty+? "+
												"where item_code = ? "+
												"and price_version = ? "+
												"and site_id = ?; ";
				preparedStatement = connection.prepareStatement(updateSiteInventoryQuery);
				preparedStatement.setInt(1, resultSet.getInt("qty"));
				preparedStatement.setString(2, resultSet.getString("item_code"));
				preparedStatement.setString(3, resultSet.getString("price_version"));
				preparedStatement.setString(4, resultSet.getString("site_id"));
				System.out.println("updateSiteInventoryQuery "+updateSiteInventoryQuery);
				System.out.println("item code "+resultSet.getString("item_code") +"\t price_version "+resultSet.getString("price_version")+
						"\t item Qty "+resultSet.getInt("qty")+"\tsite_id "+resultSet.getString("site_id"));
				int count = preparedStatement.executeUpdate();
				if(count>0)
					System.out.println("inventory updated ");
				
			}
			
			CallableStatement callableStatement = connection.prepareCall("CALL cancelOrder(?,?)");
			callableStatement.setString(1, orderNumber);
			callableStatement.registerOutParameter(2, Types.BOOLEAN);
			System.out.println("CALL cancelOrder(?,?) \norderNum  " +orderNumber);
			callableStatement.execute();
			System.out.println("callableStatement.getBoolean(2) "+callableStatement.getBoolean(2));
			flag = callableStatement.getBoolean(2);
			connection.commit();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		try {
			connection.rollback();
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
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
	return flag;
	
}


}
