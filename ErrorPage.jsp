<%@page import="bachka.BachkaMapping"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page isErrorPage="true" %>
    <%@ page errorPage="LoginForm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	

System.out.println("============Error Page");
System.out.println("============"+request.getParameter("page"));
System.out.println("object "+exception.toString());
System.out.println("mesaage "+exception.getMessage());
String exceptionpage = request.getParameter("page");
String exception1 = exception.toString();
String message = exception.getMessage();
BachkaMapping bachkaMapping = new BachkaMapping(); 
boolean update = bachkaMapping.insertExceptionDetails(exceptionpage, exception1, message);
if(update)
	System.out.println("exception details inserted ");
else
	System.out.println(" exception occured while insering exception details.. ");
bachkaMapping.closeAll();

response.sendRedirect("LoginForm.jsp");
%>


</body>
</html>