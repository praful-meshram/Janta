<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<center>
<br><br><br>
<%
Connection con=null;
try{
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/js");
	con=ds.getConnection();
	Statement s = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	con.setAutoCommit(false);
	int count=Integer.parseInt(request.getParameter("count"));
	java.util.ArrayList a=new java.util.ArrayList();
	for(int i=0;i<count;i++){
		if(request.getParameter("chk_"+i+"")!=null){
			if(request.getParameter("operation").equalsIgnoreCase("delete"))
				a.add(s.executeUpdate("delete from sms_detail where msg_id="+Integer.parseInt(request.getParameter("msgid_"+i+""))+""));
			if(request.getParameter("operation").equalsIgnoreCase("stop"))
				a.add(s.executeUpdate("update sms_detail set msg_sent=now(),msg_status='FAILED',msg_remark='Abord by user' where msg_id="+Integer.parseInt(request.getParameter("msgid_"+i+""))+""));
		}
	}			
	if(a.contains(0)){
		con.rollback();
		out.println("<font color='green'><b>Error while operation delete SMS </b></font>");
	}else{
		con.commit();
		out.println("<font color='red'><b>Operation Delete SMS completed successfully</b></font>");
	}
}catch(Exception e){
	e.printStackTrace();
	con.rollback();%>
	<font color="red"><b>Exception : <%=e.getMessage()%></b></font>
<%}finally{
	try{
		con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
</center>