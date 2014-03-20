<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getOrder_rec_details.jsp" />	
</jsp:include>
 --%>
 
 
<%@ page errorPage="ErrorPage.jsp?page=getOrder_rec_details.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
	String type="";
    type=request.getParameter("type");
    if(type.equals("all")){		
		String order_Number="";
    	String cust_Code="";
    	String customer_Name="";
    	String enteredBy="";
    	String c_date1="";    	
    	String c_date2=""; 
    	
    	int i=2;
    	order_Number=request.getParameter("orderNumberStartWith");
		cust_Code=request.getParameter("custCodeStartWith"); 
		customer_Name=request.getParameter("custNameStartWith");		
		enteredBy=request.getParameter("enterByStartWith");
		c_date1=request.getParameter("c_date1StartWith");		
		c_date2=request.getParameter("c_date2StartWith");
		String selstatus = request.getParameter("selstatus");	
    	order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		mo.listRecOrders(customer_Name,order_Number,cust_Code,enteredBy, c_date1, c_date2, selstatus);		
%>    	
    	<table border="1" id="id1" class="item3">
    	 	<thead>
				<tr id="id2">
					<td  width="10%"><b>OrderNumber</b></td>
					<td width="30%"><b>Order Date</b></td>
					<td width="10%"><b>Customer Code</b></td>
					<td width="20%"><b>Customer Name</b></td>
					<td width="10%"><b>Total Item</b></td>
					<td width="10%"><b>Entered By</b></td>
					<td width="10%"><b>Status</b></td>									
				</tr>
			</thead>
			<tbody>
<%		  	
		
		String orderNo="",orderDate="",custCode="",custName="",entered_By="",status="";
    	while(mo.rs.next()) {
    		orderNo=mo.rs.getString(1);
    		orderDate=mo.rs.getString(2);
        	custCode=mo.rs.getString(3);
        	custName=mo.rs.getString(4);
        	entered_By=mo.rs.getString(5);
        	status=mo.rs.getString(6);        	
%>

<tr>
			<td ><a  href="Javascript:showItemList('<%=orderNo%>','<%=custCode%>')">

<%
			out.println(orderNo);
%>
			</a></td><td>
<%			
			out.println(orderDate);
%>       
						
			</td><td>
<%	
           	out.println(custCode);
%>
			</td><td>
<%	
           	out.println(custName);
%>
			</td><td>
<%	
			out.println(mo.rs.getString(7));
%>
			</td><td>
<%	
			out.println(entered_By);
%>
			</td>
			<td>
<%	
			out.println(status);
%>
			</td>	
</tr>
<%   
	}mo.closeAll();	
%>
    <style type="text/css">
		a:link {color: blue}
		a:hover {background: blue;color: white}
		a:active {background: blue;color: white}
		</style>
	</tbody>
	</table>
<%
	}else if(type.equals("list")){
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query="select a.order_num, a.custcode, a.order_date,count(8), a.order_status,a.enterd_by from orders_rec a, order_detail_rec b  where a.order_num = b.order_num group by b.order_num order by a.order_date Desc";
    	rs=stat.executeQuery(query);
%>    	
    	<table border="1" id="id1" class="item3"  >
    	<tr><th colspan="6"><center><b>Recently updated orders</b></center></th></tr>
			<tr> 
				<td><b>Order No.</b></td>
				<td><b>Cust Code</b></td>
				<td><b>Order Date</b></td>
				<td><b>Items</b></td>	
				<td><b>Status</b></td>				
				<td><b>Enterd By</b></td>
					
		   </tr>
<%		
		while(rs.next()) {
%>
          
             <tr> <td><a href="Javascript:showItemList('<%=rs.getString(1)%>','<%=rs.getString(2)%>')">
<%			
			out.println(rs.getString(1));
%>       
						
			</td><td >
<%	
           	out.println(rs.getString(2));
%>
			</td><td>
<%	
           	out.println(rs.getString(3));
%>	
			</td><td>
<%	
           	out.println(rs.getString(4));
%>	
			</td><td>
<%	
           	out.println(rs.getString(5));
%>	
			</td><td>
<%	
           	out.println(rs.getString(6));
%>	
			</td></tr>
<%		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();
%>	
	</table><input type="button" name="return" value="Close" onclick="funclose();">
	
<%							
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}		
	}else if(type.equals("ItemList")){

	String orderno = request.getParameter("orderno");
	String custcode = request.getParameter("custcode");
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	String custname = mo.getCustomerName(custcode);
	mo.listOrderItemList(orderno);
%>
<h3>Item List</h3>
<table  border="1" id="id1" class="item3">
<b>Order Number : <%=orderno%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Customer Name : <%=custname%>	</b><br>
	<thead>
		<tr>
			<td colspan="11" align="left"></td>
		</tr>
		<tr>
			<td><b>item_code</b></td>
			<td><b>item_name</b></td>
			<td><b>rate</b></td>
			<td><b>qty</b></td>
			<td><b>price</b></td>
			<td><b>item_discount</b></td>
			<td><b>remark</b></td>
			<td><b>mrp</b></td>
			<td><b>entry_no</b></td>
			<td><b>item_taken</b></td>
			<td><b>item_returned</b></td>
		</tr>
	</thead>
	<tbody>
<%
	String order_num, item_code, rate, qty, price, item_discount, remark, mrp, entry_no, item_taken, item_returned,item_name;
	while(mo.rs.next()){
		order_num=mo.rs.getString(1); 
		item_code=mo.rs.getString(2);
		rate=mo.rs.getString(3);
		qty=mo.rs.getString(4);
		price=mo.rs.getString(5);
		item_discount=mo.rs.getString(6);
		remark=mo.rs.getString(7); 
		mrp=mo.rs.getString(8);
		entry_no=mo.rs.getString(9);
		item_taken=mo.rs.getString(10);
		item_returned=mo.rs.getString(11);
		item_name = mo.rs.getString(12);
%>
		<tr>			
			<td><%=item_code%></td>
			<td align="left"><%=item_name%></td>
			<td><%=rate%></td>
			<td><%=qty%></td>
			<td><%=price%></td>
			<td><%=item_discount%></td>
			<td><%=remark%></td>
			<td><%=mrp%></td>
			<td><%=entry_no%></td>
			<td><%=item_taken%></td>
			<td><%=item_returned%></td>			
		</tr>
<%
	}
	mo.closeAll();
%>
	</tbody>
</table>
<input type="submit" value="Create Order" onclick="funcreate('<%=orderno%>','<%=custcode%>');return false;"> <input type="button" value="Cancel" onclick="funclose1();return false;">

<%
	}
%>

							
	