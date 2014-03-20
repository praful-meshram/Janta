<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getOrderno_of_OrederDetails.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=getOrderno_of_OrederDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
	   
		String orderNumber="";
		String query="";
		int totalItems=0;
		int jantaPrice=0;
		int total=0;
		orderNumber=request.getParameter("orderNumberStartWith");
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stat=conn.createStatement();
		query="select a.custcode,b.rate,b.qty,c.item_name,c.item_weight,c.item_mrp from orders a,order_detail b,item_master c where a.order_num ='" +orderNumber+ "' and a.order_num=b.order_num and b.item_code=c.item_code";
		
		rs=stat.executeQuery(query);
%>
		<table border="1">
			<tr>
				<th colspan="7"><center><b>Order Details</b></center></th>
			</tr>
			<tr>
				<td><b>Item</b></td>
				<td><b>Rate</b></td>
				<td><b>weight</b></td>
				<td><b>Qty</b></td>
				<td colspan="2"><b><center>Price</center></b></td>
				<td></td>
			</tr>
			<tr>
				<td colspan=4>&nbsp;</td>
				<td><b>Janta's Price</b></td>
				<td ><b>MRP</b></td>
				<td></td>
			</tr>
<%		
			while(rs.next()){
			totalItems=totalItems+1;
			jantaPrice=rs.getInt(2)*rs.getInt(3);
			total=total+jantaPrice;
%>
			<tr>
				<td>
<%	
				out.println(rs.getString(4));
%>				
				</td><td>
<%
				out.println(rs.getInt(2));
%>
				</td><td>
<%
				out.println(rs.getString(5));
%>
				</td><td>
<%
				out.println(rs.getInt(3));
%>
				</td><td>
<%
				out.println((rs.getInt(2))*(rs.getInt(3)));
%>
				</td><td>
<%
				out.println(rs.getString(6));
%>
				</td>
			</tr>									
<%		
			}
%>
			<tr>
				<td colspan=4>Total selected items =<%=totalItems%> </div></td>  
				<td colspan=2>Total =<%=total%></div></td>
				<td></td>
			</tr>
		</table>
<%		
		rs.close();
		stat.close();
		conn.close();
	}
	catch(Exception e){
		e.getMessage();
		e.printStackTrace();
    	rs.close();		
    	stat.close();
    	conn.close();
	}
%>								  				