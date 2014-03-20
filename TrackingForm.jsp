<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="TrackingForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=TrackingForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="header.jsp" />	
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="js/TrackingForm.js"></script>
<script src="js/ua.js"></script>
<script src="js/ftiens4.js"></script>
<script src="js/demoOrderFramelessNode.js"></script>

<form name="myform" method="post" >
	<table width=100%>
		<tr>
			<TD style='background: #CCCCFF' width="16%" valign="top" align="left">
				<%	
	String code="";
	String desc="";
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");  
	mo.getDeliveryStaffList();
	try {
	 	
	 	while (mo.rs1.next()) {
		 	code = mo.rs1.getString(1);
		 	desc = mo.rs1.getString(2);
			%> <script>
			    auxDP = insFld(aux24, gFld('<%=desc%>', 'javascript:showHint("OrderProcessingTransitForm.jsp?subValue=Transit3&code=<%=code%>&desc=<%=desc%>")'))		    
			    
    		</script> <%
		}
		mo.closeAll();
	}catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
	}
%> <script>initializeDocument()</script></td>

			<td>
				<div id="displayDiv"></div>
			</td>
			<input type="hidden" name="backPage" value="TrackingForm.jsp">
		</tr>
	</table>
</form>	

<%
		String temp=request.getParameter("subValue"); 
		String orderNum=request.getParameter("ordernum");
		String printdeliver=request.getParameter("printdeliver");
		
		if(printdeliver!=null){
			if(printdeliver.equals("1")){		
%>
				<script>func(<%=orderNum%>)</script>
<%
		}
	}
%>
