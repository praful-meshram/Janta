<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SettelCommissions.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ErrorPage.jsp?page=SettelCommissions.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%		
		String d_code="";	
		float d_bal=0.0f;	
		float payamt =0.0f;
			
		d_code = request.getParameter("d_code");
		d_bal = Float.valueOf(request.getParameter("balance"));
		payamt =Float.valueOf(request.getParameter("payamt"));
		
		staff.ManageStaff mi;
		mi = new staff.ManageStaff("jdbc/js");
    	
    	
		int ans = mi.addTransaction(d_code, d_bal, payamt);
    	if(ans==1){	
%>
    	    	<h3><b><br><br><br><center> Transaction completed Successfully </center></b></h3>
<%
    	}
    	mi.closeAll();
    	
%>  
		