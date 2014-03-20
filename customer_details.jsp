<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<link rel="stylesheet" type="text/css" href="stylesheet/scroll-table.css" />
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="customer_details.jsp" />	
</jsp:include>

<%
		int count=0;
		String name="";
    	String phone="";
    	String building="";
    	String block="";
    	String wing="";
    	String add1="";
    	String add2="";
    	String custCode="",cuscode="";
    	String nameString="";
    	String c_date1="";
    	String u_date1="";
    	String c_date2="";
    	String u_date2="";
    	String city="", state="", area="";
    	String building_no="", station="";
    	String mobile="";
    	String ord_num="";
    	boolean flag = false;
    	
		name=request.getParameter("nameStartWith");
		phone=request.getParameter("phStartWith"); 
		building=request.getParameter("bldgStartWith");
		building_no=request.getParameter("bldgnoStartWith");
		block=request.getParameter("blockStartWith");
		wing=request.getParameter("wingStartWith");
		add1=request.getParameter("add1StartWith");
		add2=request.getParameter("add2StartWith");
		custCode=request.getParameter("custCodeStartWith");
		nameString=request.getParameter("nameStringStartWith");
		c_date1=request.getParameter("c_date1StartWith");
		u_date1=request.getParameter("u_date1StartWith");
		c_date2=request.getParameter("c_date2StartWith");
		u_date2=request.getParameter("u_date2StartWith");
		
		area=request.getParameter("areaStartWith");
		station=request.getParameter("stationStartWith");
		
		
		customer.ManageCustomer c;
		c = new customer.ManageCustomer("jdbc/js");
		c.listCustomerWithDate(name, phone, building, building_no, block, wing, add1, add2, custCode, c_date1, c_date2, u_date1, u_date2, nameString, area, station,"","",mobile,"",ord_num); 

%>

<center>
        <div style="width: 100%;overflow-y: scroll;">
		<table border="1" style="width:96%;float: right;background-color: #ECFB99;border-collapse: collapse;" cellspacing = 0 cellpadding = 0 bordercolor=black>
		
       	
        	<tr>
				<td style="width:5%; padding-left: 5px;" align="left"><b>Code</b></td>
				<td style="width:18%; padding-left: 5px;" align="left" align="left"><b>CustName</b></td>
				<td style="width:9%; padding-left: 5px;" align="left"><b>Phone</b></td>
				<td style="width:9%; padding-left: 5px;" align="left"><b>Mobile</b></td>
				<td style="width:17%; padding-left: 5px;" align="left"><b>Building</b></td>
				<td style="width:9%; padding-left: 5px;" align="left"><b>Flat No.</b></td>
				<td style="width:6%; padding-left: 5px;" align="left"><b>Wing</b></td>
				<td style="width:14%; padding-left: 5px;" align="left"><b>Add1</b></td>
				<td style="width:14%; padding-left: 5px;" align="left"><b>Add2</b></td>		
            </tr>
        </table>
        </div>
         <div style="width: 100%;max-height: 500px;overflow-y: scroll;">
        <table border="1" style="width:96%;float: right;background-color: #ECFB99;max-height:100%;border-collapse: collapse;" cellspacing = 0 cellpadding = 0 bordercolor=black>
      
<%		    	
		
	    	while(c.rs.next()) {
	    	add1=c.rs.getString(6);
	    	add2=c.rs.getString(7);
	    	cuscode=c.rs.getString(8);
	    	area=c.rs.getString(11);
	    	count++;
 %> 			
			<tr style="height: 7px;">																																
				<td style="width:5%; padding: 3px 0px 3px 5px;" align="left">
					<a  href="#" id=<%=count%> onclick="Pass('<%=c.rs.getString(6)%>','<%=c.rs.getString(7)%>','<%=c.rs.getString(8)%>','<%=c.rs.getString(11)%>','<%= c.rs.getString(1)%>','<%=c.rs.getString(2)%>'); " >	
  						<%=c.rs.getString(8)%>
    	 			</a>
    	 		</td>
    	 		<td style="width:18%; padding-left: 5px;" align="left">    			
					<%=c.rs.getString(1)%>
				</td>
				<td style="width:9%; padding-left: 5px;" align="left">
					<%=c.rs.getString(2)%> 						
				</td>
				<td style="width:9%; padding-left: 5px;" align="left">
					<%=c.rs.getString(17)%> 						
				</td>
				<td style="width:17%; padding-left: 5px;" align="left">
					<%=c.rs.getString(3)%>
				</td>
				<td style="width:9%; padding-left: 5px;" align="left">
					<%=c.rs.getString(4)%>
				</td>
				<td style="width:6%; padding-left: 5px;" align="left">
					<%=c.rs.getString(5)%>
				</td>
				<td style="width:14%; padding-left: 5px;" align="left">
					<%=c.rs.getString(6)%>
        		</td>
        		<td style="width:14%; padding-left: 5px;" align="left">
					<%=c.rs.getString(7)%>
				</td>
			</tr>			        	  
<%			    
		}	
		c.closeAll();	
%>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
<input type="hidden" name="count" value="<%=count%>">

</table>
</div>
</center>


