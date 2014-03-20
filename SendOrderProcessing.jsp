<%@page import="com.sun.corba.se.spi.orbutil.fsm.State"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="SendOrderProcessing.jsp" />
</jsp:include>

<%
	 String[] orderno ; 
	 String orderStr="";	
 	 orderStr = request.getParameter("horderArray"); 	 
 	 orderno = orderStr.split(","); 		
 
 	 String d_code="";
 	 d_code = request.getParameter("d_staff"); 	
 	 
 	 String[] changeArray ; 
 	 String changeStr="";	
     changeStr=request.getParameter("hchangeArray");   
     changeArray = changeStr.split(","); 
     
     //d_code=request.getParameter("hd_staff"); 
   	 System.out.println(" d_code :"+ d_code);
       
     System.out.println("  hchangeArray "+ changeStr);
     System.out.println("  horderArray "+ orderStr);
     
 	 int deliveryBalance=0,success=0;
 	 float change =0.0f;
 	 Connection conn=null;
	 Statement stmt=null,stat=null,stat1=null;
	 ResultSet rs1=null;	
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
			String balquery="SELECT balance_to_pay FROM delivery_staff d where dstaff_code='"+d_code+"';";	
			System.out.println("  balquery "+ balquery);
			     
			rs1=stat1.executeQuery(balquery);
			while(rs1.next()){
				deliveryBalance=rs1.getInt(1);
			}
			deliveryBalance=deliveryBalance;
			//sms.SMSRecords sms_sender=new sms.SMSRecords();
		
			for(int i=0; i < orderno.length;i++){
			    if(!changeArray[i].equals(""))			 
					change = Float.parseFloat(changeArray[i]);	
			    String query="SELECT status_code FROM orders o where order_num = "+orderno[i];		
			    System.out.println("  balquery "+ query);
				ResultSet rs2 = stmt.executeQuery(query); 
				rs2.next();
				System.out.print("Order status : "+rs2.getString(1));
				String status_code = rs2.getString(1);
				mo.updateOrderHistory(Integer.parseInt(orderno[i]),"Send for delivery",0);			
				String updSql="update orders set status_code='TRANSIT',dstaff_code='"+d_code+"', "+
					"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
					"action='Send for delivery' where order_num='"+orderno[i]+"'";	
					System.out.println("update  1 "+updSql);		
					int run_sql = stmt.executeUpdate(updSql); 
					if (run_sql==1){ 
						query="update delivery_staff set balance_to_pay='"+deliveryBalance+"' where dstaff_code='"+d_code+"'";	
						System.out.println("update2  : "+query); 
						int runsql =stmt.executeUpdate(query);						
						if (runsql==1){
							success=1;
          				}
						if(!status_code.equals("CHECKED")){
							query = "select od.item_code, od.qty, od.price_version, o.site_id from order_detail od, orders o "+
								"where o.order_num = od.order_num and od.order_num = '"+orderno[i]+"'";
							System.out.println(" query "+query);
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
								// item site inventory already updated 
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
							
		rs1.close();
		stmt.close();
		conn.close();
		mo.closeAll();
		}catch (Exception e) {
			System.out.println("Exception occured in SendOrderProcessing.jsp");
			e.getMessage();
			e.printStackTrace();
			conn.close();
			mo.closeAll();				
		}
 	 	String subValue=request.getParameter("subValue");
 		 if(success==1){		
 			
%>

<jsp:forward page="print_delivered_order.jsp">
	<jsp:param name="backPage" value="TrackingForm.jsp" />
	<jsp:param name="orderNo" value="<%=orderStr%>" />
</jsp:forward>

<%
			}
			else if(success==0){
%>
<jsp:forward page="TrackingForm.jsp?subValue=<%=subValue%>" />
<%
			}
%>
<input type="hidden" name="hcountorder" value="1">
