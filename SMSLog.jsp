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
	ResultSet rs=s.executeQuery("SELECT sum(case when msg_status='CREATED' then 1 else 0 end),sum(case when msg_status='SENT' then 1 else 0 end),sum(case when msg_status='FAILED' then 1 else 0 end) FROM sms_detail where msg_create between '"+request.getParameter("from1")+"' and '"+request.getParameter("to1")+"'");
	if(rs.next()){%>
		<table width="30%" border="1">
			<thead><tr><th>SMS Created</th><th>SMS Sent</th><th>SMS Failed</th></tr></thead>
			<tbody>
				<tr>
					<%rs.beforeFirst();rs.next();%>
						<td onclick="getRecord('created')" align="center"><u><%=rs.getInt(1)%></u></td>
						<td onclick="getRecord('sent')" align="center"><u><%=rs.getInt(2)%></u></td>
						<td onclick="getRecord('failed')" align="center"><u><%=rs.getInt(3)%></u></td>
				</tr>
			</tbody>
		</table>
		<br><br>
		<div id="smsrecord"></div>
	<%}else{%>
		<font color="red"><b>No SMS to send...</b></font>
	<%}
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{
		con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>