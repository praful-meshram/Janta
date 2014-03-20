<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewItemGroup.jsp" />	
</jsp:include>

 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=NewItemGroup.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	    String ig_desc="";
	    int fmcg_flag=0,ig_number=0;
	    ig_desc=request.getParameter("ig_desc");
		fmcg_flag=Integer.parseInt(request.getParameter("hfmcg_flag"));
		ig_number = Integer.parseInt(request.getParameter("ig_number"));
		
    	
    	item.ManageItem mi;
		mi = new item.ManageItem("jdbc/js");
		int ans = mi.addItemGroup(ig_desc,fmcg_flag,ig_number);
    	if(ans==1){	
		
%>
    		<h3><b><br><br><br><center> Sucessfully Created Item group <font color=blue><%=ig_desc%> </center></b></h3>
<%
		} 
		else{
			mi.closeAll();  	
%>  
			<jsp:forward page="NewItemGroupForm.jsp?Exp=1" /> 		
			
<% 		}
		mi.closeAll();  	
%>    	
    	