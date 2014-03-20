<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%
Connection con=null;
try{	
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/js");
	con=ds.getConnection();
	Statement s = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet rs=s.executeQuery("SELECT msg_order_num, custcode,msg_type, trim(date(msg_create)),trim(date(msg_sent)), msg_remark, msg_text, to_number,msg_id FROM sms_detail where msg_status='"+request.getParameter("t").toUpperCase()+"'");
	if(rs.next()){%>
		<table width="80%">
			<tr>
			<%if(request.getParameter("t").equalsIgnoreCase("created")){%>
				<td width="85%" align="right"><font color="red"><a href="#" onclick="stopSMS('stop')">Stop SMS </a></font></td>
				<td width="5%">&nbsp;</td>
				<td width="10%" align="left"><font color="red"><a href="#" onclick="stopSMS('delete')">Delete SMS </a></font></td>
			<%}%>
			<%if(request.getParameter("t").equalsIgnoreCase("failed")){%>
				<td width="10%" align="right"><font color="red"><a href="#" onclick="stopSMS('delete')">Delete SMS </a></font></td>
			<%}%>
			</tr>
		</table>
				
		<table width="80%" border="1">
			<thead>
				<%if(request.getParameter("t").equalsIgnoreCase("created")){%>
					<tr><td colspan="8" align="left">Message Status : <%=request.getParameter("t").toUpperCase()%></td></tr>
				<%}else if(request.getParameter("t").equalsIgnoreCase("failed")){%>
					<tr><td colspan="10" align="left">Message Status : <%=request.getParameter("t").toUpperCase()%></td></tr>
				<%}else{%>
					<tr><td colspan="8" align="left">Message Status : <%=request.getParameter("t").toUpperCase()%></td></tr>
				<%}%>
				<tr>
					<th>Order No</th>
					<th>Customer Code</th>
					<th>Type</th>
					<th>Created Date</th>
					<%if(!request.getParameter("t").equalsIgnoreCase("created")){%>					
						<th>Sent Date</th>
						<th>Remark</th>
					<%}%>
					<th>Text</th>
					<th>Mobile No</th>
					<%if(request.getParameter("t").equalsIgnoreCase("failed")||request.getParameter("t").equalsIgnoreCase("created")){%>
						<th><input type="checkbox" name="chkall" onclick="chkallit(this)"></th>
					<%}%>
				</tr>
			</thead>
			<tbody>
					<%rs.beforeFirst();
					int count=0;
					while(rs.next()){%>
						<tr>
							<td><%=rs.getString(1)%></td>
							<td><%=rs.getString(2)%></td>
							<td><%=rs.getString(3)%></td>
							<td><%=rs.getString(4)%></td>
							<%if(!request.getParameter("t").equalsIgnoreCase("created")){%>					
								<td><%=rs.getString(5)%></td>
								<td><%=rs.getString(6)%></td>
							<%}%>
							<td align="left"><%=rs.getString(7)%></td>
							<td>&nbsp;<%=rs.getString(8)%></td>
							<%if(request.getParameter("t").equalsIgnoreCase("failed")||request.getParameter("t").equalsIgnoreCase("created")){%>
								<td><input type="checkbox" name="chk_<%=count%>"></td>
								<td><input type="hidden" name="msgid_<%=count++%>" value="<%=rs.getInt(9)%>"></td>
							<%}%>
						</tr>
					<%}%>
			</tbody>
		</table>
		<input type="hidden" name="count" value="<%=count%>">
		<br><br>
		<div id="smsrecord"></div>
	<%}else{%>
		<font color="red"><b>No SMS to send...</b></font>
	<%}
}catch(Exception e){
	e.printStackTrace();%>
	<font color="red"><b>Exception : <%=e.getMessage()%></b></font>
	<%
}finally{
	try{
		con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>