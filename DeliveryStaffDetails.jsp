<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveryStaffDetails.jsp" />	
</jsp:include>

<%
		staff.ManageStaff ms;
		ms = new staff.ManageStaff("jdbc/js");
		String hchckall="";
		hchckall=request.getParameter("hchckallStartWith"); 
		
		if(hchckall.equals("1")){
			ms.listStaff();		 
	    }
	    else{	
			String dsCode="";
	    	String dsName="";
	    	String c_date1="";
	    	String bal1="";
	    	String c_date2="";
	    	String bal2="";
	    	
	    	int i=2;
			dsCode=request.getParameter("dsCodeStartWith");
			dsName=request.getParameter("dsNameStartWith"); 
			c_date1=request.getParameter("c_date1StartWith");
			c_date2=request.getParameter("c_date2StartWith");
			bal1=request.getParameter("bal1StartWith");
			bal2=request.getParameter("bal2StartWith");			 		
	    	
			ms.listStaff(dsCode,dsName, c_date1, c_date2, bal1, bal2);
		}		
%>    	
    	<table border="1" id="id1" class="item3">
    	 	<thead>
				<tr id="id2">
					<td  width="20%"><b>Delivery Staff Member Code</b></td>
					<td width="20%"><b>Member Name</b></td>
					<td width="20%"><b>Start Date</b></td>
					<td width="20%"><b>Balance To Pay</b></td>
					
				</tr>
			</thead>
			<tbody>
<%		  	
		

    	while(ms.rs.next()) {
%>

  			<tr><td  ><a  href="EditDeliveryStaffForm.jsp?dsCode=<%=ms.rs.getString(1)%>&dsName=<%=ms.rs.getString(2)%>&stDate=<%=ms.rs.getString(3)%>&dsBalance=<%=ms.rs.getString(4)%>">

<%
			out.println(ms.rs.getString(1));
%>
			</a></td><td>
<%			
			out.println(ms.rs.getString(2));
%>       
						
			</td><td>
<%	
           	out.println(ms.rs.getString(3));
%>
			</td><td>
<%	
           	out.println(ms.rs.getString(4));
%>			
			</td></tr>
<%   }
	ms.closeAll();
%>
    <style type="text/css">
		a:link {color: blue}
		a:hover {background: blue;color: white}
		a:active {background: blue;color: white}
		</style>
	</tbody>
	</table>