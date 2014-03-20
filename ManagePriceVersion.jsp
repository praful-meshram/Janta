<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Janta : Manage Prices</title>
<script type="text/javascript" src="js/ManagePriceVersion.js"></script>
<link rel="stylesheet" type="text/css" href="css/ManagePriceVersion.css" />
</head>
<body style="font-family: arial;">
	<jsp:include page="header.jsp"></jsp:include>
<%@ page errorPage="ErrorPage.jsp?page=ManagePriceVersion.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
	
	<br />
	<div id="main_div">
		<%
		String arr[]={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","@","0-9"," ","*"};
		%>
		<table style="width: 100%;">
			<tr>
			<%
			for(int i=0;i<arr.length;i++){
				out.print("<td id=\"button_td\" onclick=\"firstChar('"+arr[i]+"');\" align=\"center\">"+arr[i]+"</td>");
			}
			%>
			</tr>
		</table>
		<table style="width: 100%;">
			<tr>
			<%
			for(int i=0;i<arr.length;i++){
				out.print("<td id=\"button_td\" onclick=\"secondChar('"+arr[i]+"');\" align=\"center\">"+arr[i]+"</td>");
			}
			%>
			</tr>
		</table>
		<div id="search_string">
		Item Name : <input type="text" name="item_name" id="item_name_id"/>
		<input type="button" accesskey="s" value="Search<Alt+s>" onclick="disp();"/>
		Items Start With : "<label id="first">A</label><label id="second">A</label>..."</div>
		<div id="item_detail"></div>
	</div>
</body>
</html>