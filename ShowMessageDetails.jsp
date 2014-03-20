<%@page import="java.awt.Checkbox"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.CustomerBean"%>
<%@page import="customer.ManageCustomer"%>
<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>

<style>

#resulttable{
background-color: #ECFB99;
width:100%;
border-collapse: collapse;
}

#uline{
text-decoration: underline;
color: blue;
}

</style>

<%
	String callfor = request.getParameter("callfor");
	System.out.print(callfor);
	if (callfor != null) {
		if (callfor.equals("arealist")) {
			String name;
			try {

				Context initContext = new InitialContext();
				Context envContext = (Context) initContext
						.lookup("java:/comp/env");
				DataSource ds = (DataSource) envContext
						.lookup("jdbc/js");
				Connection conn = ds.getConnection();
				Statement stmt = conn.createStatement();

				ResultSet rs = stmt
						.executeQuery("select value from code_table where category='AREA' order by value asc");
%>

<SELECT name="area" style="width:150px">
	<OPTION VALUE="">Select Area</OPTION>
	<%
		while (rs.next()) {
						name = rs.getString(1);
	%>
	<OPTION VALUE="<%=name%>">
		<%=name%>
	</OPTION>
	<%
		}
	%>
</SELECT>
<%
	rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.getMessage();
				e.printStackTrace();
			}
		}
		else if (callfor.equals("customerlist")){
			
		CustomerBean bean = new CustomerBean();
		bean.setCustcode(request.getParameter("cust_code"));
		bean.setCustname(request.getParameter("cust_name"));
		bean.setBuilding(request.getParameter("cust_building"));
		bean.setBuilding_no(request.getParameter("building_no"));
		bean.setBlock(request.getParameter("cust_block"));
		bean.setWing(request.getParameter("cust_wing"));
        bean.setAdd1(request.getParameter("cust_address1"));
		bean.setAdd2(request.getParameter("cust_address2"));
		bean.setArea(request.getParameter("cust_area"));
		bean.setStation(request.getParameter("cust_station"));
		bean.setPhone(request.getParameter("cust_phonenumber"));
		/*if(!request.getParameter("cust_phonenumber").equals("")){
			//bean.setPhone(Long.parseLong(request.getParameter("cust_phonenumber")));
		//}*/
		ManageCustomer objCust = new ManageCustomer("jdbc/js");
		ArrayList<CustomerBean> beanList = objCust.getCustomerList(bean);
		%>
		
			
		<table id="resulttable" border="1" style="border-collapse: collapse;border-color: 1px solid black;">
		<thead>
		<tr style="background-color:#ECFB99; ">
	    <th>Customer Code</th>
		<th>Customer Name</th>
		<th>Address</th>
		<th>Phone No.</th>
		</tr>
		</thead>
	    <tbody>
		<% 
		for(int i = 0; i< beanList.size();i++){
			
			CustomerBean tbean=beanList.get(i);
			
			
			//out.print("<tr id=\"rowcount"+i+"\" style=\"cursor:pointer\"  onclick=\"onCustomerSelect('"+tbean.getCustcode()+"','"+tbean.getCustname()+"','"+tbean.getPhone()+"',"+i+")\">");
			//out.print("<td>");
			//out.print("<input type=\"checkbox\" name=\"check\"/>");
			//out.print("</td>");
			out.print("<tr id=\"rowcount"+i+"\" style=\"cursor:pointer;padding:2px;\">");
			out.print("<td onclick=\"onCustomerSelect('"+tbean.getCustcode()+"','"+tbean.getCustname()+"','"+tbean.getPhone()+"',"+i+")\">");
			out.print(tbean.getCustcode());
			out.print("</td>");
			
			out.print("<td onclick=\"onCustomerSelect('"+tbean.getCustcode()+"','"+tbean.getCustname()+"','"+tbean.getPhone()+"',"+i+")\">");
			out.print(tbean.getCustname());
			out.print("</td>");
			
			out.print("<td onclick=\"onCustomerSelect('"+tbean.getCustcode()+"','"+tbean.getCustname()+"','"+tbean.getPhone()+"',"+i+")\">");
			out.print("Building: "+ tbean.getBuilding() + " , Building No: " + tbean.getBuilding_no() + " , Flat No: " + tbean.getBlock() + " , Wing:  " + tbean.getWing() + " , Area: "+ tbean.getArea() + " , Station: " + tbean.getStation());
			out.print("</td>");
			
		
			out.print("<td id=\"uline\" onclick=\"popupopen('"+tbean.getCustname()+"','"+tbean.getCustcode()+"','"+tbean.getPhone()+"')\">");
			//out.print(tbean.getPhone()+ "<img src=\"images/messageicon.png\" style=\"float:right; margin:5px; \" width=\"10\" height=\"10\" id=\"imgid\">");
			out.print(tbean.getPhone());
			out.print("</td>");
			out.print("</tr>");
			//out.print("</tbody>");
		
		}
		
		
		objCust.closeAll();
	}
		%>
		
		
		</tbody></table>
		
		<%
	}

	
	
 %>
 









