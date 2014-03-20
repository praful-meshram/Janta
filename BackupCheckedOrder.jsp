<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page contentType="text/html"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<html>
<head>
<title>Retail Management-Janta Stores</title>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="BackupCheckedOrder.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=BackupCheckedOrder.jsp" %>	
	
<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
		%>

<script src="js/OrderCheck.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
</head>

<body>
<form name="myform" onclick="return false;">
<%	String orderNo = request.getParameter("orderNo");
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query=" SELECT b.barcode,b.item_name,a.price,a.qty,a.item_code "+
						 " from order_detail a,item_master b "+
						 " where a.item_code=b.item_code and a.order_num='"+orderNo+"'";
    	System.out.println("Form query : "+query);
    	rs=stat.executeQuery(query);
%>
<br/>
<div id="topdiv" style="width: 100%;">
	<table align="left" >
		<tr>
			<td>Order no: </td>
			<td><%=orderNo%><input type="hidden" name="hOrderNo" value="<%=orderNo%>"/></td>
		</tr>
		<tr>
			<td>Item Barcode : </td>
			<td><input type="text"  style="text-transform: uppercase" name="itemBarcode" size="35" /> 
			<input type="submit" name="search" value="Search" onclick="funCheckBarcode();"></td>
		</tr>
	</table>
</div>
<br>
<div style="visibility:hidden;overflow: auto;height: 40px;width:80%;" id = "lastRecordDiv">
	<table id ="lastRecordTable" width="98%" bgcolor="#ECFB99">
		<tr class="item2">
			<td></td>
			<td></td>
			<td></td>
		</tr>		
	</table>
</div>
<br></br>
<div id="itemTableDiv" style="overflow: auto;height: 150px;width:80%;">
	<table id="itemTable" border="1" width="98%" cellPadding="0"  cellSpacing="0" >
		<THEAD>
		  <tr style="position:relative;top:expression(document.all['itemTableDiv'].scrollTop);">
			    <th width="20%" align="center">Item Code </th>
			    <th width="20%">Item Name </th>
			    <th width="20%">Price </th>
			    <th width="20%">Order Quantity</th>
			    <th width="20%">Accounted Quantity</th>
		  </tr>
		  </THEAD>
		  <TBODY>
			  <%	
			  		int cnt =0;
					while(rs.next()) {
			  %>
			  <tr class="item1">
			    	<td><%=rs.getString(5)%> <input type="hidden" name="hBarcode<%=cnt%>" value="<%=rs.getString(1)%>"/> </td>
				    <td><%=rs.getString(2)%></td>
				    <td><%=rs.getString(3)%></td>
				    <td><input type="text" readonly="readonly" name="accountQty" value="<%=rs.getString(4)%>"/></td>
				    <td><input type="text" name="realqty"/></td>
			  </tr>
			  <%		
			  cnt++;
					}	    	  
			    	rs.close();
					stat.close();
					conn.close();
			  %>
		</TBODY>						
	</table>
</div>
<br>
<input align="left" type="button" name="ShowOrderDetails" value="Show Item Details" onclick="ShowOrder();"/>
<input align="left" type="button" name="HideOrderDetails" value="Hide Item Details" onclick="HideOrder();" style="visibility:hidden;display:none;"/>
<input align="left" type="button" name="CheckedOrder" value="Check Order" onclick="SaveOrder();"/>
<br><br><br>
<div id="checkedItemDiv" style="visibility: hidden;width:80%;overflow: auto;height: 100px;">
<table id="checkedItemTable" border="1" width="98%" align="left" cellPadding="0"  cellSpacing="0" >
		<THEAD>
		 <tr style="position:relative;top:expression(document.all['checkedItemDiv'].scrollTop);">
			    <th>Item Code </th>
			    <th>Item Name </th>
			    <th>Price </th>
			    <th>Order Quantity</th>
		  </tr>
		  </THEAD>
		  <TBODY>
		  </TBODY>
</table>
</div>
<br>
<div id="SwapItemDetailsDiv" style="visibility: hidden;width:80%;overflow: auto;height: 80px;">
<table width="98%">
<tr><td width="50%">
<table id="swapNewItemTable"border="1" width="100%" align="Left" cellPadding="0"  cellSpacing="0" >
		<THEAD>
		 <tr>
			    <th colspan="4" align="center">New Items</th>			    
		  </tr>
		 <tr>
			    <th>Item Code </th>
			    <th>Item Name </th>
			    <th>Price </th>
			    <th>Order Quantity</th>
		  </tr>
		  </THEAD>
		  <TBODY>
		  </TBODY>
</table>
</td><td width="50%">
<table id="swapOldItemTable" border="1" width="100%" align="right" cellPadding="0"  cellSpacing="0" >
		<THEAD>
		 <tr>
			    <th colspan="4" align="center">Old Items </th>			    
		  </tr>
		 <tr>
			    <th>Item Code </th>
			    <th>Item Name </th>
			    <th>Price </th>
			    <th>Order Quantity</th>
		  </tr>
		  </THEAD>
		  <TBODY>
		  </TBODY>
</table>
</td></tr>
</table>
</div>
<br>


<div id="baseDiv" style="position: absolute;top:0px;" align="center" ></div>
<div id="swapItemDiv" style=" height :150px ;border:1px solid black; background-color:#99ccff; /*padding:25px;*/ font-size:150%; text-align:center; display:none;">
	<table id ="swapItemTable" border="1" >
		<tr>
			<td colspan="6" align="right"><img src="images/close-16.png" alt="No Image" onclick="funCloseDiv();"/></td>			
		</tr>
		<tr bgcolor="LightBlue">
			<td></td>
			<td><b>Item Name</b></td>
			<td><b>Weight</b></td>
			<td><b>Rate</b></td>
			<td><b>Quantity</b></td>
			<td><b>Total Price</b></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td><input type="text" name="swapItemQty" onchange="setTotalPrice(this.value);" value=""/></td>
			<td><input type="text" name="targetTotalPrice" value=""/></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>		
		<tr>			
			<td colspan="6" align="center"><input type="button" value="Swap Item" onclick="funSwapItems();"/></td>
			
		</tr>
	</table>
</div>

<%		
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}		
%>
</form>
</body>
</html>