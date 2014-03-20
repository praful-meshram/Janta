<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>

<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="CommissionsDetails.jsp" />	
</jsp:include>

<%
		DecimalFormat df = new DecimalFormat("###,###.00");
		staff.ManageStaff c;
		c = new staff.ManageStaff("jdbc/js");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckallStartWith"); 
    	
    	String name="";
	    String date1="";
	    String date2="";
    	if(hchckall.equals("1")){
    		c.getCommissionDetails("NA","0000-00-00","0000-00-00");
    	}
    	else{
    		
	    		
			name=request.getParameter("nameStartWith");
			if(name.equals("select")) name="NA";
			date1=request.getParameter("date1StartWith");
			if(date1.equals("")) date1= "0000-00-00";
			date2=request.getParameter("date2StartWith");	
			if(date2.equals("")) date2= "0000-00-00";			
				
			c.getCommissionDetails(name,date1,date2); 
%>
			<input type="hidden" name="hname" value="<%=name%>">
			<input type="hidden" name="hdate1" value="<%=date1%>">
			<input type="hidden" name="hdate2" value="<%=date2%>">
<%
		}
%>
		



       <table  id="id1" border="1" class="item3" width="80%">
       	
        	<tr>
				<td width="10%"><b>Name</b></td>
				<td width="5%"><b>Total Orders</b></td>	
				<td width="5%"><b>Total Earned</b></td>
				<td width="5%"><b>Total Paid</b></td>
				<td width="5%"><b>Balance</b></td>
				<td width="5%"><b>Last Paid Amt</b></td>
				<td width="5%"><b>Last Pay Date</b></td>
									
            </tr>
      
<%		    	
		while(c.rs.next()) {
		
 %>
			<tr ><td align="left">    			
<%			
				out.println(c.rs.getString(1));
%>																															
				<td align="right"><a  href="CommissionOrderList.jsp?d_staffname=<%=c.rs.getString(1)%>&d_staffcode=<%=c.rs.getString(2)%>&d_report=ALLORDERS&Exp=0&hchckall=<%=hchckall%>&hdate1=<%=date1%>&hdate2=<%=date2%>">
				
<%             
    			out.println(c.rs.getString(3));
%>
    	 		</a></td><td align="right"><a  href="CommissionOrderList.jsp?d_staffname=<%=c.rs.getString(1)%>&d_staffcode=<%=c.rs.getString(2)%>&d_report=ALLORDERS&Exp=0&hchckall=<%=hchckall%>&hdate1=<%=date1%>&hdate2=<%=date2%>">    			
<%			
				out.println(df.format(c.rs.getFloat(4)));
%>
				</td><td align="right"><a  href="CommissionOrderList.jsp?d_staffname=<%=c.rs.getString(1)%>&d_staffcode=<%=c.rs.getString(2)%>&d_report=ALLPAID&Exp=0&hchckall=<%=hchckall%>&hdate1=<%=date1%>&hdate2=<%=date2%>">    			
<%			
				out.println(df.format(c.rs.getFloat(5)));
				
%>
				</td><td align="right"><a  href="SettelCommissionForm.jsp?d_staffcode=<%=c.rs.getString(2)%>&d_staffname=<%=c.rs.getString(1)%>&totOrders=<%=c.rs.getString(3)%>&totEarned=<%=c.rs.getString(4)%>&totPaid=<%=c.rs.getString(5)%>&balance=<%=c.rs.getString(6)%>&lastpaid=<%=c.rs.getString(7)%>">	
				
				    			
<%		
				out.println(df.format(c.rs.getFloat(6)));
			
%>
				</td><td align="right">    			
<%				
				out.println(df.format(c.rs.getFloat(7)));
				
%>
				</td><td align="right">
<%             
    			out.println(c.rs.getString(8));
%>
			</td></tr>			        	  
<%			    
		}	
		c.closeAll();	
%>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>

</table>
<input type="hidden" name="hchckall" value="<%=hchckall%>">