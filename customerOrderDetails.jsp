<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="customerOrderDetails.jsp" />	
</jsp:include>

<%
		String call_from="";
		if(request.getParameter("call_from") != null){
			call_from = request.getParameter("call_from");
		}
		String custCode="";
		custCode=request.getParameter("custCodeStartWith");
		String query="";
		String num="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			query="select  a.order_num, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, "+
					"b.payment_type_desc, a.lastmodifieddate, a.status_code from orders a, payment_type b "+
					"where a.payment_type_code=b.payment_type_code and a.custcode='"+custCode+"'";
	
%> 
		<div style="width: 100%; overflow-y: scroll;">
		<table  border="1" id="id" class="item3" style="width : 96%;max-height: 100px; float: right;">
			<tr style="width: 100%;"><th colspan=9><b>Order Details</b></th></tr>
	      	<tr style="width: 100%;">				
				<td style="width: 7%;"><b>Order</b></td>				
				<td style="width: 27%;"><b>Order Date</b></td>
				<td style="width: 4%;"><b>Items</b></td>
				<td style="width: 7%;"><b>Tot Value</b></td>
				<td style="width: 7%;"><b>MRP</b></td>
				<td style="width: 7%;"><b>Discount</b></td>
				<td style="width: 7%;"><b>Pay Type</b></td>
				<td style="width: 27%;"><b>Last Modified Date</b></td>
				<td style="width: 10%;"><b>Status </b></td>				
			</tr>
		</table>
		</div>
		<div style="width: 100%; max-height: 500px; overflow-y: scroll; ">
		<table  border="1" id="id11" class="item3" style="width : 96%;float: right;">
<%	
		rs=stat.executeQuery(query);  
		int cnt=0;
    	while(rs.next()) {
    		num=rs.getString(1);
    		if(cnt%2==0){
			 %>
				<tr id="tr" style="width: 100%;background-color:#ECFB99;">
			<%
			}else{
			%>
				<tr id="tr" style="width: 100%;background-color:#ECFBB9;">
			<%
			}
    		%>
			<td align="left"  style="width: 7%;">
			<%        
    		if(call_from.equals("comm")){
    		%>
    			<font color="blue" style="cursor: pointer;"  onclick="displayOrderDetail('<%=rs.getString(1)%>','<%=rs.getDate(2) %>')"><u><%=rs.getString(1) %></u></font>
    		<%
    		} else {
				out.println(rs.getString(1));
    		}
			%>
			</td><td align="left" style="width: 27%;">
<%        
    	
			out.println(rs.getString(2));
%>
			</td><td align="left" style="width: 4%;">
<%        
    	
			out.println(rs.getString(3));
%>
			</td><td align="left" style="width: 7%;">
<%        
    	
			out.println(rs.getString(4));
%>
			</td><td align="left" style="width: 7%;">
<%			
			out.println(rs.getString(5));
%>       
			</td><td align="left" style="width: 7%;">
<%			
			out.println(rs.getString(6));
%>       
			</td><td align="left" style="width: 7%;">
<%			
			out.println(rs.getString(7));
%>       
			</td><td align="left" style="width: 27%;">
<%			
			out.println(rs.getString(8));
%>       
			</td><td align="left" style="width: 10%;">
<%			
			out.println(rs.getString(9));
%>       
		
			</td></tr>						        	  
<%		
			cnt++;
    	}	    
		rs.close();	
        stat.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
		
%>
<input type="hidden" name="horder" value="<%=num%>">
</table>
</div>


  