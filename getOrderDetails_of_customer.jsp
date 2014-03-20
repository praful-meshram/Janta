<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<jsp:include page="sessionBoth.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getOrederDetails_of_customer.jsp" />	
</jsp:include>
 --%>
 
 
<%@ page errorPage="ErrorPage.jsp?page=getOrederDetails_of_customer.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
	String customerName="";
	String custCode="";
	String orderNo="";
	String phone="";
	String add1="";
	String add2="";
	String bldg="";
	String block="";
	String wing="";
	String orddate="";
	String enteredby="";
	customerName=request.getParameter("custname");
	custCode=request.getParameter("custcode");
	orderNo=request.getParameter("orderNo");
	phone=request.getParameter("phone");
	add1=request.getParameter("add1");
	add2=request.getParameter("add2");
	bldg=request.getParameter("bldg");
	block=request.getParameter("block");
	wing=request.getParameter("wing");
	orddate=request.getParameter("orddate");
	enteredby=request.getParameter("enteredby");
	
%>	

<script src="js/getOrderDetails_of_customer.js">
</script>
<body onload="showHint()">
	<table id="1">
		<tr>
			<td><b>Customer Code:</b></td>
			<td><b><%=custCode%></b></td>
		</tr>
		<tr>
			<td><b>Customer Name:</b></td>
			<td><b><%=customerName%></b></td>
		</tr>
		<tr>
			<td><b>Phone:</b></td>
			<td><b><%=phone%></b></td>
		</tr>
		<tr>
			<td><b>Address:</b></td>
			<td><b><%=add1%>&nbsp<%=add2%></b></td>
		</tr>
		<tr>
			<td><b>Building:</b></td>
			<td><b><%=bldg%></b></td>
		</tr>
		<tr>
			<td><b>Block:</b></td>
			<td><b><%=block%></b></td>
		</tr>
		<tr>
			<td><b>Wing:</b></td>
			<td><b><%=wing%></b></td>
		</tr>
	</table>

	<form name="myform" action="print_order.jsp" method="post" >
		<h3> Order Details:</h3>
		<table>
			<tr>
				<td><b>Order No:</b></td>
				<td><b><%=orderNo%></b></td>
			</tr>
			<tr>
				<td><b>Order Date:</b></td>
				<td><b><%=orddate%></b></td>
			</tr>
			<tr>
				<td><b>Entered By:</b></td>
				<td><b><%=enteredby%></b></td>
			</tr>
		</table>
		<div id="orders"></div>  
		<br>
		<input type="hidden" name="orderNo" value="<%=orderNo%>">
		<input type="hidden" name="backPage" value="order_detailsForm.jsp">
		<input type="submit" name="Print" value=" Print">&nbsp&nbsp&nbsp   
		
	</form>
</body>
</html>