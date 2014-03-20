<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditDeliveryStaff.jsp" />	
</jsp:include> --%>
<%@ page errorPage="ErrorPage.jsp?page=EditDeliveryStaff.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
	String dsCode="";
  	String dsName="";
  	
  	dsCode=request.getParameter("dsCode");
  	dsName=request.getParameter("dsName");

  	
  		staff.ManageStaff c;
		c = new staff.ManageStaff("jdbc/js");
		int ans = c.editStaff(dsCode,dsName); 
				
		if (ans==1)
		{
%>
				<br><br><br><br><br><br><br><br><center><h3>
				 Successfully update Delivery Staff Member <font color="blue"><%=dsName%></font>
				</h3>               
				</center>
				</body>
              	</html>
<%               
		}
		else{
%>
				<br><br><br><br><br><br><br><br><center><h3>
				Error
				</h3>               
				</center>
<%
		c.closeAll();
		}
		
%>	
	