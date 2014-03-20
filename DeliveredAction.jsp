<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveredAction.jsp" />	
</jsp:include>


<%@page contentType="text/html"%>
<%
      	ResultSet rs=null;
       	Statement stmt=null;
       	Connection conn=null;  
       	int success=0;
       	float comm=0.0f;
       	String allowActionValue="",orderNo="";
  		orderNo=request.getParameter("horderNo");   			
       	double totalValue=0.0f,paidAmt=0.0f,changeAmt=0.0f;
       	allowActionValue=request.getParameter("hallowaction");  	       	
		totalValue=Double.parseDouble(request.getParameter("htotalValue"));  	       	
		paidAmt=Double.parseDouble(request.getParameter("hpaidamt"));  	       	
		changeAmt=Double.parseDouble(request.getParameter("hchange"));  
		comm=Float.parseFloat(request.getParameter("hcomm"));  
       	totalValue=totalValue+changeAmt;
       	order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js"); 
       	
       	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
		
			String updSql="";	
			System.out.println("allowActionValue "+allowActionValue);
			if(allowActionValue.equals("Close") && totalValue==paidAmt){
				updSql="update orders set status_code='CLOSED',action='"+allowActionValue+"',lastmodifieddate=now() where order_num='"+orderNo+"'";						
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);	
				int run_sql = stmt.executeUpdate(updSql); 
				if (run_sql==1)
					success=1;				
			}
			else if(allowActionValue.equals("Hold")){
				updSql="update orders set status_code='HOLD',action='"+allowActionValue+"',lastmodifieddate=now() where order_num='"+orderNo+"'";				
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);	
				int run_sql = stmt.executeUpdate(updSql); 
				if (run_sql==1)
					success=1;
			}
		//rs.close();
			stmt.close();
			conn.close();
			mo.closeAll();
		  	}
			catch (Exception e) {
				stmt.close();
				conn.close();
				mo.closeAll();				
				System.out.println("Exception occured in DeliveryAction.jsp");
				e.getMessage();
				e.printStackTrace();				
			}		
			if(success==1){
%>
				<jsp:forward page="TrackingForm.jsp" />
<% 	
			}else if(success==0){
%>
				<jsp:forward page="TrackingForm.jsp" />
<%
			}
%>