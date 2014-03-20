<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="OrderProcessingTransit.jsp" />	
	</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=OrderProcessingTransit.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	 String[] orderno ; 
	 String orderStr="";	
 	 orderStr = request.getParameter("horderArray");
 	 orderno = orderStr.split(","); 
 	 		
 	 String[] orderComm ; 
	 String orderCommStr="";	
 	 orderCommStr = request.getParameter("hcommArray");
 	// System.out.println(" orderCommStr "+orderCommStr);
 	 orderComm = orderCommStr.split(","); 
 	//  System.out.println("  orderComm "+ orderComm);
 	 
 	String subType=request.getParameter("subType");
 	 String[] changeArray ; 
 	 String changeStr="";	
     changeStr=request.getParameter("hchangeArray"); 
     changeArray = changeStr.split(","); 
      
     
     
     
     String d_code="";	
     d_code=request.getParameter("hd_staff"); 
   	 System.out.println(" d_code :"+ d_code);
   	 System.out.println("  orderComm "+ orderCommStr);
     System.out.println("  subType "+ subType);
     System.out.println("  hchangeArray "+ changeStr);
     System.out.println("  horderArray "+ orderStr);
   
     float comm =0.0f;
 	 int deliveryBalance=0,success=0;
 	 Connection conn=null;
	 Statement stmt=null;	
	 order.ManageOrder mo;
	 mo = new order.ManageOrder("jdbc/js");       	
 	 try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			
		
		
			for(int i=0; i < orderno.length;i++){
			    int ordno = Integer.parseInt(orderno[i]);
			   // System.out.println("ordno"+ordno);
			     			 
				float paid = Float.parseFloat(changeArray[i]);	
				mo.updateOrderHistory(ordno,"Delivery Done",0);
				String query = "SELECT payment_type_code FROM orders where order_num = "+orderno[i];
				ResultSet rs1 = stmt.executeQuery(query);
				System.out.print("Getting Payment Type : "+query);
				rs1.next();
				String updSql="";
				if(!rs1.getString(1).equals("CR")){
					updSql="update orders set status_code='DELIVERED', "+
							"paid_amt='"+paid+"', del_datetime=now(),lastmodifieddate=now(), " +
							"action='Delivery Done', balance_amt = 0 where order_num='"+orderno[i]+"'";
				} else {
					updSql="update orders set status_code='DELIVERED', "+
							"paid_amt='"+paid+"', del_datetime=now(),lastmodifieddate=now(), " +
							"action='Delivery Done' where order_num='"+orderno[i]+"'";
				}
					System.out.println("\n update sql "+updSql);
				   int run_sql = stmt.executeUpdate(updSql); 
					if (run_sql==1){ 
						success=1;
						
						for(int k=0; k<orderComm.length;k=k+2){
						  int ord = Integer.parseInt(orderComm[k]);
						 // System.out.println("ordComm"+ord);
						  
							if( ord == ordno){
								int p = k +1;
								comm = Float.parseFloat(orderComm[p]);
								//System.out.println("comm"+comm);
								break;
							}
						}
						mo.setOrderCommission(ordno,d_code,comm,"ADD");
						//System.out.println("Done");
				
          			}
			}					
		
		stmt.close();
		conn.close();
		mo.closeAll();
		}catch (Exception e) {
			System.out.println("Exception occured in OrderProcessingTransit.jsp");
			e.getMessage();
			e.printStackTrace();	
			conn.close();
			mo.closeAll();			
		}
 		 if(success==1){			
%>
             
				<jsp:forward page="TrackingForm.jsp">
					<jsp:param name="Exp" value="0"/>
									
				</jsp:forward>
				
<%
			}
			else if(success==0){
%>  
				<jsp:forward page="TrackingForm.jsp?subValue=<%=subType%>" />
<%
			}
%>
 <input type="hidden" name="hcountorder" value="1">	 
