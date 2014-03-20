  <%@page contentType="text/html"%>   
   <%@ page import="java.sql.*" %>
   <%@ page import="javax.naming.*" %>
   <%@ page import="javax.sql.*" %>
   <jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewDeliveryStaff.jsp" />	
</jsp:include>
   
 --%>
 
 
<%@ page errorPage="ErrorPage.jsp?page=NewDeliveryStaff.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

 
<%
	if (request.getParameter("dsName") != null){
	   	String dsName="";
	    String stDate="";
	    int dsBalance=0;
	    dsName=request.getParameter("dsName");
	    stDate=request.getParameter("stDate");
		dsBalance=Integer.parseInt(request.getParameter("dsBalance"));	
    	
    	staff.ManageStaff ms;
		ms = new staff.ManageStaff("jdbc/js");
		int ans = ms.addStaff(dsName,stDate,dsBalance);
    	if(ans==1){	
		
%>
    		<h3><b><br><br><br><center> Sucessfully Created Staff <font color=blue><%=dsName%> </center></b></h3>
<%
		} 
		else if(ans==2){
		
%>  
			<jsp:forward page="NewDeliveryStaffForm.jsp?Exp=1" /> 		
			
<%
		}
 		else{
%>  
			<h3><b><br><br><br><center> Error </center></b></h3>
			
<%
		}
		ms.closeAll();  	
	
	}
	
%>
</body>