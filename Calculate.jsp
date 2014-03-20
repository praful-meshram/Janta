 <%@ page errorPage="ErrorPage.jsp?page=Calculate.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
%>
<jsp:include page="HomeForm.jsp" /> 

<%-- <jsp:include page="sessionAdmin.jsp">	
   <jsp:param name="formName" value="Calculate.jsp" />	
</jsp:include>
 --%>

 
<%@ page contentType="text/html"%>
<%@ page import="java.sql.*,javax.naming.*,javax.sql.*,java.io.*" %>
<%	
	Connection conn=null;
	Statement stat=null;
	
	try{
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	
    	stat.executeQuery("call upd_cust_stats('')");
    		
		
		
        stat.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		
        stat.close();
		conn.close();
	}

%>