<%@page import="java.sql.ResultSet"%>
<%@page import="packaging.ManageBreakdown"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <!-- <script type="text/javascript" src="js/PackagingReport.js"></script> -->
<!--  <script language="javascript" src="js/PackagingReport.js"></script> -->
<script type="text/javascript">
 function submitVal(val){
     var myObj=window.dialogArguments;
      var th2 = document.myform.th2.value;
      myObj.setTheVal(th2); //calls the js method in the main page.
      window.close();
 }
</script>
	<%
		String param = request.getParameter("param");
		String link = request.getParameter("link");
		System.out.println("param is "+param+" :: link is "+link);
		if(!session.isNew())
		{		session.setAttribute("filter", "filterData");
			
				session.setAttribute("link",link);
				session.setAttribute("param",param);
				System.out.println("session link  "+session.getAttribute("link").toString()+" :: param is  "+param);
		}
	
		
		%>
	<title><%=param.toUpperCase()+" " %> <%=link %></title>
		<center>
		<div>
			<h3></h3>
			<form action="" name="myform" method=post> 
							<table cellspacing="5" cellpadding="5"><b>
				<tr>
					<th id="th1"><%=param %></th><th><input type="text" value=" " align="right" id="th2" name="th2"></th>
					
				<tr>
				<%-- <tr><th><%=param %></th><th><input placeholder="<%=param %>" name="emailTxt" align="right"/></th></tr>
				 --%></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
				</table>
				<%-- <center><input type="button" value="search" onclick="getPopStartResult('<%=param %>');return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value ="reset"> </center> --%>
				 <center><input type="button" value="search" onclick="submitVal('<%=param %>');return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value ="reset"> </center>
				
				<%--  <center><button" onclick="submitVal('<%=param %>');return false;">search</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset();" >reset </button></center>
				 --%>
			</form>
		
		</div>
		</center>

