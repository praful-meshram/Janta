<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getItemList.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=getItemList.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>





<%
		DecimalFormat df = new DecimalFormat("###,###.00");			
					
		
		
		float itemRate=0.0f;
		float itemQty=0.0f;
		float itemTotPrice=0.0f;
		float itemMRP=0.0f;
		float totalValueMRP=0.0f;
		float savings=0.0f;
		float totalValueDis=0.0f;
		float itemTotDis=0.0f;
		
		String itemName="";
		String itemWeight="";
		
		long item_taken=0;
	    int i=0;
	    int count=0;
		String orderNo="";		
		orderNo=request.getParameter("orderNo");
			 
		String query="";
		String outString="";
		Connection conn=null;
		Statement stmt=null, stat=null;
		ResultSet rs=null, rs2=null;
		
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();	
			
			query="select b.item_code,d.item_name, d.item_weight,b.rate, b.qty, b.price, b.mrp, b.item_taken, d.deal_active_flag, d.deal_on_qty, d.deal_amount,b.item_discount, b.remark " + 				  	
				  	"from orders a, order_detail b, customer_master c, item_master d ,payment_type e " +
					"where a.order_num = b.order_num " +
					"and a.custcode = c.custcode " +
					"and b.item_code = d.item_code " +
					"and a.payment_type_code = e.payment_type_code "+
					"and a.order_num = '" + orderNo + "' "+
					"order by b.entry_no";					
										
			rs=stat.executeQuery(query);	
					
			while(rs.next()) 
			{
				if(count==0)
				{ 			
					outString = "['" + rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+
								"','" + rs.getFloat(4)+"','"+rs.getFloat(5)+"','"+rs.getFloat(6)+"','"+
								rs.getFloat(7)+"','"+rs.getLong(8)+"','"+rs.getString(9)+"','"+rs.getString(10)+"','"+rs.getFloat(11)+"','"+rs.getFloat(12)+"','"+rs.getString(13)+"']";
					count=count+1;
	         	}
	         	else
	         	{
	         		
					outString = outString + ",['" + 
								rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+
								"','" + rs.getFloat(4)+"','"+rs.getFloat(5)+"','"+rs.getFloat(6)+"','"+
								rs.getFloat(7)+"','"+rs.getLong(8)+"','"+rs.getString(9)+"','"+rs.getString(10)+"','"+rs.getFloat(11)+"','"+rs.getFloat(12)+"','"+rs.getString(13)+"']";	}
	     	}
	     	out.println("[" + outString + "]");
		rs.close();
	    stat.close();
	    conn.close();
	    
	}
         
	catch(Exception e){
		System.out.println(e);
		rs.close();
	    stat.close();
	    conn.close();
	}

%>                 
				
				
				
				