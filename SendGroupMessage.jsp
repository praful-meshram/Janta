<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="beans.MessageBean"%>
<%@page import="sms.ManageMessage"%>

<%@ page errorPage="ErrorPage.jsp?page=SaveGroupMessage.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%  
            String message=request.getParameter("message");
            String cust_code [] =request.getParameterValues("custcode");
            String cust_phone [] =request.getParameterValues("custphone");
            String user = session.getAttribute("UserName").toString();
            
            ManageMessage MsgObj = new ManageMessage("jdbc/js");
            
            for(int i=0;i<cust_code.length;i++){
            	out.println(cust_code[i] + "    "+cust_phone[i]);
            	MessageBean msg = new MessageBean();
            	msg.setMessage(message);
            	msg.setCust_code(cust_code[i]);
            	msg.setMobile_no(cust_phone[i]);
            	msg.setSent_by(user);
            	MsgObj.insertMsgData(msg);
            }
            MsgObj.closeAll();
%>

<%
response.sendRedirect("SendGroupMessage.jsp");
%>

