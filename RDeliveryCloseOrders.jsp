<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp?formName=RDeliveryCloseOrders.jsp"/>
<%
		String str1="",pageName="",del_date="";
		String dateArray[]=null;
		int success=0;
		pageName=request.getParameter("page");		    		    
		del_date=request.getParameter("hiddatearray");
		System.out.println("Hidden Array of Date = "+request.getParameter("hiddatearray"));
 		dateArray=del_date.split(",");    
		String query="",updSql="";
		Connection conn=null,conn11=null, conn1=null;
		Statement stat=null,stmt=null, stat1=null,stat11=null;
		ResultSet rs=null,rs1=null,rs11=null;	
		String closedate="";
		String userstr = session.getAttribute("UserName").toString();
				   
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			DataSource ds = (DataSource)envContext.lookup("jdbc/re");
			conn = ds.getConnection();
			stat=conn.createStatement();
			stmt=conn.createStatement();
			query="select now()";				 	   							 	   
			rs=stat.executeQuery(query);
			while(rs.next()){
			    closedate = rs.getString(1);
			}
 			for(int i=0; i<dateArray.length; i++){
				if(!dateArray[i].equals("")){
					 query="select order_num, custcode,payment_type_code from orders "+
					 	   "where trim(Date(del_datetime))='"+dateArray[i]+"'";
					 System.out.println("select order  "+query);
				 	   rs=stat.executeQuery(query);
				 	   while(rs.next()){
				 	   		updSql="update orders set status_code='CLOSED',lastmodifieddate='"+closedate+"', closed_datetime='"+closedate+"' ,close_status='BULK_"+dateArray[i]+"'"+
				 	   		" where order_num='"+rs.getString(1)+"'";
				 	   		System.out.println("updSql="+updSql);
							int a=stmt.executeUpdate(updSql);
							//System.out.println("value of a="+a);
							success=1;																 	   					 	   				 	   				 	   					 	   					 	   				 	   
				 	   }
	 	 
 				 }
 			}//EOF for			
			
			int secans=0;
			if(success==1){
				String order_num="", custcode="", order_date="", payment_type_code="",total_value="",paid_amt="",balance_amt="";
					
				for(int i=0; i<dateArray.length; i++){
					if(!dateArray[i].equals("")){					
						 query="select order_num, custcode, order_date, payment_type_code,total_value,paid_amt,balance_amt from orders "+
						 	   "where trim(Date(del_datetime))='"+dateArray[i]+"'";				 	   							 	   
					 	    System.out.println(query);
					 	   rs=stat.executeQuery(query);
					 	  
					 	   while(rs.next()){
					 	   		order_num=rs.getString(1);
					 	   		custcode=rs.getString(2);
					 	   		order_date = rs.getString(3);
					 	   		payment_type_code = rs.getString(4);
					 	   		total_value = rs.getString(5);
					 	   		paid_amt  = rs.getString(6);
					 	   		balance_amt = rs.getString(7);
					 	   		
					 	   		/*DataSource ds1 = (DataSource)envContext.lookup("jdbc/js_rec");
								conn1 = ds1.getConnection();
								stat1=conn1.createStatement();
								String query11 ="replace into order_recovery(order_num, custcode, order_date, payment_type_code, closed_datetime, close_status, total_value, paid_amt, balance_amt, lastmodifieddate, lastmodifiedby) "+
											" values('"+order_num+"', '"+custcode+"','"+order_date+"', '"+payment_type_code+"','"+closedate+"','BULK_"+dateArray[i]+"','"+total_value+"','"+paid_amt+"','"+balance_amt+"','"+closedate+"','"+userstr+"')";				 	   							 	   
								 System.out.println(query11);
								secans = stat1.executeUpdate(query11);	
								conn1.close();*/
					 	   	secans=1;
							}
		 	 		 }
 				}//EOF for	 				
 			}
			
			conn.close();
 			System.out.println("connection close after close order ");
 			if(secans ==1){
%>
				<jsp:forward page="RDeliveryDailyReportSummary.jsp?Exp=0&closeresult=1" />	
<%					
			success=0;
			}			
			else{
%>
		<jsp:forward page="RDeliveryDailyReportSummary.jsp?Exp=0&closeresult=0" />	
<%				
			}
 			
 		} 	
 	catch(Exception e){
	 	success=0;
	 	System.out.println("Exception occured....");
	 	e.printStackTrace();
 	}
 	
%> 
