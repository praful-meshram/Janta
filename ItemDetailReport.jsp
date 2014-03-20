<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%
String call_option = request.getParameter("call_option");
if(call_option.equals("item_sales")){
	String to_date = request.getParameter("to_date");
	String from_date = request.getParameter("from_date");
	String name = request.getParameter("name");
	String item_code = request.getParameter("item_code");
	String d1[]=from_date.split("/");
	String d2[]=to_date.split("/");
	String from = d1[2]+"-"+d1[1]+"-"+d1[0];
	String to = d2[2]+"-"+d2[1]+"-"+d2[0];
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		String query = "select o.order_date,sum(od.qty),sum(od.price) "+
				"from order_detail od, orders o, item_master im "+
				"where od.item_code = '"+item_code+"' and date(o.order_date) between '"+from+"' and '"+to+"' "+
				"and o.order_num=od.order_num and od.item_code=im.item_code group by date(o.order_date)";
		rs = stmt.executeQuery(query);
		//System.out.println(query);
		int cnt=0;
		%>
		<br/>
		<center><b><%=name %></b> Sale report Between <b><%=from_date %></b> to <b><%=to_date %></b></center>
		<br/>
		<div id="head">
			<table style="width: 100%; border-collapse: collapse;" cellpadding=0 cellspacing=0 border=1>
				<tr class="popup_header">
					<th style="padding: 3px 0px 3px 5px; width: 33%;" align="left">Date</th>
					<th style="padding: 3px 0px 3px 5px; width: 33%;" align="left">Quantity</th>
					<th style="padding: 3px 0px 3px 5px; width: 34%;" align="left">Amount</th>
				</tr>
			</table>
		</div>
		<div id="body">
			<table style="width: 100%; border-collapse: collapse;" cellpadding=0 cellspacing=0 border=1>
			<%
			if(rs.next()){
				do{
			%>
				<tr align="left">
					<td style="padding: 3px 0px 3px 5px; width: 33%;" align="left">
						<label id="detail" onclick="getDetailForItem('<%=name%>','<%=item_code%>','<%=rs.getDate(1)%>');">
							<%=rs.getDate(1) %>
						</label>
					</td>
					<td style="padding: 3px 0px 3px 5px; width: 33%;" align="left"><%=rs.getInt(2) %></td>
					<td style="padding: 3px 0px 3px 5px; width: 34%;" align="left"><%=rs.getFloat(3) %></td>
				</tr>
			<%
				cnt++;
				}while(rs.next());
			} else {
			%>
				<tr align="left">
					<td align="center" colspan="3">No Data to Display</td>
				</tr>
			<%
			}
			%>
			</table>
		</div>
		<label id="count"><%=cnt %></label> Records
		<%
	} catch(Exception e){
		System.out.println("Error in ItemDetailReport.jsp");
		e.printStackTrace();
	}
	conn.close();
} else if(call_option.equals("item_sales_detail")){
	%>
	<style>
		body{
			font-family: arial;
		}
		td,th{
			padding: 3px 0px 3px 5px;
		}
		.popup_header{
			color: white;
			background-color: gray;
		}
		#detail:HOVER{
			font-weight: bold;
		}
	</style>
	<script>
	var xmlHttp;
	function GetXmlHttpObject() {
		var xmlHttp = null;
		try {
			// Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
	function displayOrderDetail(ord_num){
		xmlHttp = GetXmlHttpObject()
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		
		var url="print_order.jsp";
		url=url+"?orderNo="+ord_num;
		url=url+"&callfrom=receive_payment_page";
		url=url+"&sid="+Math.random();		
		xmlHttp.onreadystatechange = showOrderDetailsPopup;
		xmlHttp.open("GET", url, true);
		xmlHttp.send(null);
	}

	function showOrderDetailsPopup(){
		var msg = xmlHttp.responseText;
		if (xmlHttp.readyState == 4) {
			document.getElementById("order_div").innerHTML = msg;
			document.getElementById("order_div").style.display='block';
			displayPopup();
		}
	}
	</script>
	<%
	String date = request.getParameter("date");
	String name = request.getParameter("name");
	String item_code = request.getParameter("item_code");
	%>
	<center>
	List Of orders on <%=date %> which contains <%=name %>
	<br/>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		String query = "select o.order_num,im.custname,im.phone, im.mobile,im.building,im.building_no,im.block,im.wing, "+
				"im.area,im.station,im.city,o.total_items,o.total_value from orders o,order_detail od,customer_master im "+
				"where date(o.order_date) = '"+date+"' and od.item_code = '"+item_code+"' and o.order_num = od.order_num and o.custcode = im.custcode";
		rs = stmt.executeQuery(query);
		%>
		<br/>
		
			<table style="width: 90%; border-collapse: collapse;" cellpadding=0 cellspacing=0 border=1 bordercolor=black>
				<tr class="popup_header" align="left" valign="top">
					<th>Order No</th>
					<th>Customer Name</th>
					<th>Phone</th>
					<th>Mobile</th>
					<th>Address</th>
					<th>Total Items</th>
					<th>Total</th>
				</tr>
			<%
			if(rs.next()){
				do{
			%>
				<tr align="left" valign="top">
					<td>
						<label id="detail" style="color: blue; cursor: pointer;"
							  onclick="displayOrderDetail('<%=rs.getString(1)%>','<%=date %>')">
							 	<u><%=rs.getString(1) %></u>
						</label>
					</td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %> Building no <%=rs.getString(6) %> , <%=rs.getString(7) %> Block, <%=rs.getString(8) %> Wing, 
						<%=rs.getString(9) %>, <%=rs.getString(10) %>, <%=rs.getString(11) %></td>
					<td><%=rs.getInt(12) %></td>
					<td><%=rs.getFloat(13) %></td>
				</tr>
			<%
				}while(rs.next());
			} else {
			%>
				<tr align="center">
					<td colspan="4">No Data to Display</td>
				</tr>
			<%
			}
			%>
			</table>
		<br/>
		<div style="width: 90%; overflow: auto; max-height: 400px; border: 1px solid black; display: none;" id="order_div">
		</div>
		<%
		System.out.println(query);
	}catch(Exception e){
		System.out.println("Error in ItemDetailReport.jsp");
		e.printStackTrace();
	}
	conn.close();
}
%>