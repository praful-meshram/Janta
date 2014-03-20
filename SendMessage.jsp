<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<jsp:include page="sessionBoth.jsp?formName=SendMessage.jsp"/> 

<%
	    String msg="";
	    String ph_no="";
	    msg=request.getParameter("msg");
		ph_no=request.getParameter("ph_no");
		
		int i= 0;
    	
       sms.SMSClient smsc= new  sms.SMSClient(4);
    	
		 
		int ans= smsc.sendMessage(ph_no,msg);;
		System.out.println("ans : "+ ans);
    	if(ans==0){	
		
%>
    		<h3><b><br><br><br><center> Sucessfully send message  </center></b></h3>
<%
		} 
		else{
			//smsc.closeAll();  	
%>  
		

			<jsp:forward page="SendMessageForm.jsp?Exp=1" /> 		
			
<% 		}
		//smsc.closeAll();  	
%>    	
    	