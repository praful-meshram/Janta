<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page contentType="text/html"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*"%>

<script src="js/TestForm.js"></script> 
<form name="myform" onclick="return false;">
<%	String orderNo = request.getParameter("OrderNo");
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
<br><br>
<div style="visibility:hidden;overflow: auto;height: 40px;width:80%;" id = "lastRecordDiv">
	<table id ="lastRecordTable" width="98%" bgcolor="#ECFB99">
		<tr class="item2">
			<td></td>
			<td></td>
			<td></td>
		</tr>		
	</table>
</div>
<br>
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
					while(rs.next()) {
			  %> 
			  <tr class="item1">
			    	<td><input type="text" name="itemCode" value="<%=rs.getString(5)%>"/><input type="hidden" name="<%=rs.getString(1)%>" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" /> </td>
				    <td><input type="text" name="itemName" value="<%=rs.getString(2)%>"/></td>
				    <td><input type="text" name="itemPrice" value="<%=rs.getString(3)%>"/></td>
				    <td><input type="text" name="orderQty" value="<%=rs.getString(4)%>" readonly="readonly"/></td>
				    <td><input type="text" name="accountedQty"/></td>
			  </tr>
			  <%		
					}	    	  
			    	rs.close();
					stat.close();
					conn.close();
			  %>
		</TBODY>						
	</table>
</div>
<br>
<br>
<br><br>

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
