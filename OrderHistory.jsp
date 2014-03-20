<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="OrderHistory.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=OrderHistory.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String startTime="";
    	String orderNo=request.getParameter("orderNoStartWith");
    	String query="select distinct a.version_no,a.status_code, a.record_datetime, "+
					 "a.total_items, a.total_taken, a.total_value, a.action from "+
					 "order_history a where a.order_num = '"+orderNo+"' "+
					 "union select 'Current', status_code, lastmodifieddate, "+
					 "total_items, total_taken, total_value, action from "+
					 "orders where order_num = '"+orderNo+"' ";  	
    	rs=stat.executeQuery(query);   	
%>    	
    	<table style="width:100%; border-collapse: collapse; border-color: black;" border=1  class="item3" bordercolor=black>
    		<tr align="center">
    			<th colspan="7">Order History</th>
    		</tr>
			<tr align="center"> 
				<td style="padding: 3px;"><b>Version No.</b></td>
				<td><b>Status</b></td>
				<td><b>Date Time</b></td>	
				<td><b>Total Items</b></td>		
				<td><b>Total Taken</b></td>	
				<td><b>Total Value</b></td>		
				<td><b>Action</b></td>				
		   </tr>
<%		
		while(rs.next()) {
			java.sql.Timestamp stamp = (java.sql.Timestamp)rs.getObject(3);
			startTime = stamp.toString();
%>
          
             <tr align="center"> 
             <td style="padding: 3px;"><%=rs.getString(1)%></td>
             <td><%=rs.getString(2)%></td>
             <td><%=startTime%></td>
             <td><%=rs.getInt(4)%></td>
             <td><%=rs.getInt(5)%></td>
             <td><%=rs.getFloat(6)%></td>
             <td><%=rs.getString(7)%></td>
             </tr>
<%	
		}	
    	rs.close();
		stat.close();
		conn.close();						
	}catch(Exception e){
		rs.close();
		stat.close();
		conn.close();
		System.out.println(e);
	}		
%>
</table>

