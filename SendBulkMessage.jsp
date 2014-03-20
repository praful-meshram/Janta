<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SendBulkMessage.jsp" />	
</jsp:include>
 --%>
 
 <%@ page errorPage="LoginForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		if(session==null || session.isNew())
		{
			%>
			<jsp:forward page="LoginForm.jsp?exp=3"/>
			
			<%
		}
		%>

<%

		sms.SMSClient smsc= new  sms.SMSClient(1);
	    String msg="";
	    String ph_no="";
	    int cnt=0, ans=0;
	    String [] phno = null;
	    
	    msg=request.getParameter("textmsg");;
		ph_no=request.getParameter("hmsg");
		cnt=Integer.parseInt(request.getParameter("hcnt"));
		
		
		//while() {
		phno=ph_no.split(",");
		
	 for(int i=0;i<cnt;i++){
       
        //ans= smsc.sendMessage(phno[i],msg);
%>
		<br><center><b>Sucessfully Send Message <font color="blue"> <%=msg%> </font>to <font color="blue"> <%=phno[i]%> , </font><b></center>

  <%
        
        
    }		
    	if(ans>-1){	
		
%>
    		<h3><b><br><br><br><center> Sucessfully send message  </center></b></h3>
<%
		} 
		else{
			//smsc.closeAll();  	
%>  
		

			<jsp:forward page="SendBulkMessageForm.jsp?Exp=1" /> 		
			
<% 		}
		//smsc.closeAll();  	
%>    	
    	