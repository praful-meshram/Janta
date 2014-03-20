<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveryDetails.jsp" />	
</jsp:include>

<%@page contentType="text/html"%>
<%
		Connection conn=null;
		Statement stmt=null,stat=null,stat1=null;
		ResultSet rs1=null;	
        String orderNo="";
        String subValue="";
        int deliveryBalance=0,success=0;
	  	subValue=request.getParameter("subValue");  	
  		orderNo=request.getParameter("horderNo");  	  	
  		String status="";
        status=request.getParameter("hstatus");         
        String d_code="";
       	d_code=request.getParameter("d_staff");         	
       	String allowActionValue="";  
       	allowActionValue=request.getParameter("hallowaction");    
       	float change=0.0f;
       	change=Float.valueOf(request.getParameter("change"));       
       	float comm=0.0f;
       	comm=Float.valueOf(request.getParameter("comm"));  
       	int versionNo=0;  
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");       	
       	
       	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			stat = conn.createStatement(); 
			stat1 = conn.createStatement(); 
			
			System.out.println(" allowActionValue :"+allowActionValue);
			
			if(!allowActionValue.equals("Hold")){
				deliveryBalance=deliveryBalance+(int)comm;	
				String query="SELECT status_code FROM orders o where order_num = "+orderNo;						
				ResultSet rs2 = stmt.executeQuery(query); 
				rs2.next();
				System.out.print("Order status : "+rs2.getString(1));
				String status_code = rs2.getString(1);
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);			
				String updSql="update orders set status_code='TRANSIT',dstaff_code='"+d_code+"', "+
				"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
				"action='"+allowActionValue+"' where order_num='"+orderNo+"'";		
				System.out.println(" updSql :"+updSql);
				int run_sql = stmt.executeUpdate(updSql);
				
				if (run_sql==1){ 			
					if(!status_code.equals("CHECKED")){
						query = "select od.item_code, od.qty, od.price_version, o.site_id from order_detail od, orders o "+
							"where o.order_num = od.order_num and od.order_num = '"+orderNo+"'";
						System.out.println("query "+query);
						ResultSet rs = stmt.executeQuery(query);
						int count = 0;
						while(rs.next()){
							Statement st = conn.createStatement();
							String query1 = "update item_master set item_qty = item_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"'";
							System.out.println("Master :"+query1);
							st.executeUpdate(query1);
							query1 = "update item_price set item_pv_qty = item_pv_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"' "+ 
									" and price_version  = "+rs.getInt(3);
							System.out.println("Price :"+query1);
							st.executeUpdate(query1);
							
							/* Inventory already updated while creating order   */
							
							/* 
							query1 = "update item_site_inventory set item_site_qty = item_site_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"' "+
									"and price_version  = "+rs.getInt(3)+" and site_id = "+rs.getInt(4);
							System.out.println("Site :"+query1);
							st.executeUpdate(query1);
							
							*/
						}
					}
				}
				
				
			}
			else if(allowActionValue.equals("Hold")){	
				//deliveryBalance=deliveryBalance-(int)comm;
				String updSql="";
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);
				if(!d_code.equals("") ){
					updSql="update orders set status_code='HOLD',dstaff_code='"+d_code+"', "+
					"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
					"action='"+allowActionValue+"' where order_num='"+orderNo+"'";
				}
				else if(d_code.equals("") ){
					updSql="update orders set status_code='HOLD', "+
					"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
					"action='"+allowActionValue+"' where order_num='"+orderNo+"'";
				}
				int run_sql = stmt.executeUpdate(updSql); 			
					if (run_sql==1) 
						success=1;			
		  	}	
			
			conn.close();
			mo.closeAll();
       	}
		catch (Exception e) {
			conn.close();	
			mo.closeAll();
			System.out.println("Exception occured in DeliveryDetails.jsp");
			e.getMessage();
			e.printStackTrace();				
		}
			if(success==1){			
%>
				<jsp:forward page="TrackingForm.jsp">
					<jsp:param name="subValue" value="<%=subValue%>"/>
					<jsp:param name="printdeliver" value="<%=success%>" />
					<jsp:param name="ordernum" value="<%=orderNo%>" />
				</jsp:forward>
<%
			}
			else if(success==0){
%>
				<jsp:forward page="TrackingForm.jsp">
					<jsp:param name="subValue" value="<%=subValue%>"/>
				</jsp:forward>
<%
			}
%>