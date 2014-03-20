<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ChangePaymentType.jsp" />	
</jsp:include>
<%@page contentType="text/html"%>
<%
		Connection conn=null;
		Statement stmt=null,stat=null,stat1=null;
		ResultSet rs1=null;	
        String orderNo="";
       
        int success=0;	  		
  		orderNo=request.getParameter("horderNo");  
  			  	
  		String status="";
        status=request.getParameter("hstatus");  
        String action="";
        status=request.getParameter("haction");    
              
        String sel_payment="";
       	sel_payment=request.getParameter("sel_payment"); 		
       	
       	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			stat = conn.createStatement(); 
			stat1 = conn.createStatement();
			String updSql1="update order_history set payment_type_code='CR', action='"+action+"' where order_num='"+orderNo+"'";							  
			int run_sql1 = stmt.executeUpdate(updSql1);  
			String updSql="update orders set payment_type_code='"+sel_payment+"', action='Payment Type Change' where order_num='"+orderNo+"'";							  
				int run_sql = stmt.executeUpdate(updSql); 
				if (run_sql==1){ 				
						success=1;
				}
				
		conn.close();			
       	}
		catch (Exception e) {
			conn.close();
			System.out.println("Exception occured in DeliveryDetails.jsp");
			e.getMessage();
			e.printStackTrace();				
		}
			if(success==1){			
%>
<h3><b><br><br> <br><center> Sucessfully Change Payment Type </center></b></h3>

					<jsp:forward page="TrackingForm.jsp" />					
				
<%
			}
			else if(success==0){
%>
				<jsp:forward page="TrackingForm.jsp" />
<%
			}
%>