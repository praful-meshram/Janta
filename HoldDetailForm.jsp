<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="HoldDetailForm.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=HoldDetailForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%@page contentType="text/html"%>
<%	
  	String orderNo="";
  	orderNo=request.getParameter("orderNo");
  	System.out.println("orderNo  == "+orderNo);   	
%>
<form name="myform" method="post" class="ddm1">
    <table id="1" border="0" align="center">
	<tr><th colspan="6"><center><b>Customer Information</b></center> </th></tr>
	<tr></tr><TR></TR>
	<tr></tr><TR></TR>
	<tr></tr><TR></TR>
	<tr>
		
		<td><b>Customer Code</b></td>
		<td>: <%=custCode%></td>
		<td>&nbsp&nbsp&nbsp&nbsp</td>
		<td><b>Area</b></td>
		<td>: <%=area%> </td>
		
	</tr>
	<tr>
		
		<td><b>Customer Name</b></td>
		<td>: <%=name%></td>
		<td></td>
		<td><b>Address 1</b></td>
		<td>: <%=add1%></td>
	</tr>
	<tr>
		
		<td><b>Phone</b></td>
		<td>: <%=phno%></td>
		<td></td>
		<td><b>Address 2</b></td>
		<td>: <%=add2%></td>
	</tr>
	</table><br>
	<table align=center >	
		<tr><th colspan="6"><center><b>Order Information</b></center> </th></tr>
		<tr></tr>
		<tr>	
			<td><b>Order Number</b></td>
			<td>: <%=orderNo%></td>
		</tr>
		<tr>	
			<td><b>Order Date</b></td>
			<td>: <%=orderDate%></td>
		</tr>
		<tr>	
			<td><b>Total Items</b></td>
			<td>: <%=totalItems%></td>
		</tr>
		<tr>	
			<td><b>Total Value</b></td>
			<td>: <%=totalValue%></td>
		</tr>
		<tr>	
			<td><b>Change</b></td>
			<td>: <input  type="text" value="<%=(50 -(totalValue % 50))%>" name="change"></td>
		</tr>
		<tr>	
			<td><b>Delivery  Person </b></td>
			<td>:
<%	
	Connection conn=null;
	Statement stmt=null,stat=null;
	ResultSet rs=null,rs1=null;
	try {
		String code,desc,status_code_value="submitted",statusCode="",actionValue="";
		String[] actionValueArray;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();	
		//stat = conn.createStatement();			
		rs = stmt.executeQuery("select dstaff_code, dstaff_name from delivery_staff");
%>
			    
						<SELECT name="d_staff" >
						<OPTION VALUE="" >Select staff
<% 
	
	 	while (rs.next()) {
	 		code = rs.getString(1);
	 		desc = rs.getString(2);
%>
			<OPTION VALUE="<%= code%>" ><%= desc%>
<%
		}	
		rs1 = stmt.executeQuery("SELECT status_code, allow_action FROM status where status_code='"+status_code_value+"'");		
%>		

			</td>
		</tr>

		<tr>	
			<td><b>Allow Action </b></td>
			<td>:		
		
						<SELECT name="allow_action" >
						<OPTION VALUE="" >Select action


<%
		while(rs1.next()){
			statusCode=rs1.getString(1);
			actionValue=rs1.getString(2);
		}
		actionValueArray=actionValue.split(",");
		for(int index=0; index<actionValueArray.length; index++){
%>
			<OPTION VALUE="<%= index%>" ><%= actionValueArray[index]%>	
<%
	}
	    rs.close();
	    rs1.close();
	    stmt.close();
	    conn.close();
	  }
	  catch (Exception e) {
        e.getMessage();
        e.printStackTrace();
      }
	    
%>		
		
		
			</td>
		</tr>
		
		</table><br><br>
	<center><input type="submit" name="Submit"  disabled value="Send <Alt+s>" accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
 	<center><hr><br>
 	<input type="hidden" name="horderNo" value="<%=orderNo%>">
 	<input type="hidden" name="horderDate" value="<%=orderDate%>"> 	
 	<input type="hidden" name="hstatus" value="<%=status%>">
 	<input type="hidden" name="hallowaction" value="">
	<div id="txtHint" class="ddm1">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
	
<script type="text/javascript">		
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;			
		}
		function checkField(){
			var d_staff  = document.myform.d_staff.value;	
			var allow_action = document.myform.allow_action.value;	
			var d_staffnm = document.myform.d_staff[document.myform.d_staff.selectedIndex].text;	
			var allow_actionnm = document.myform.allow_action[document.myform.allow_action.selectedIndex].text;				
			document.myform.hallowaction.value=allow_actionnm;
		alert("allow_actionnm = "+allow_actionnm);
			var change =document.myform.change.value;
			if(d_staff=="") {
					alert("Please Select Delivery Staff");
					document.myform.d_staff.focus();
					return false;
			}
			else if(allow_action=="") {
					alert("Please Select Allow action");
					document.myform.allow_action.focus();
					return false;
			}
			else if(isNaN(change)) {
				alert("Please Enter a number in Change field");
				document.myform.change.value="";
				document.myform.change.focus();
				return false;
			}
			else{	
				var ans=confirm("Do you want to send "+ d_staffnm +" to deliver the order: "+ <%=orderNo%>);			
				if (ans==true){	
					document.myform.action="DeliveryDetails.jsp?subValue=<%=subValue%>";
					document.myform.submit();
				}
				else{
				  	window.refresh; 			  	
				}
			}
		}
		function showMsg(){
		  	 //document.myform.action="SubmittedOrdersDetails.jsp";
			 document.myform.action="TrackingForm.jsp";		  	 
		   	 document.myform.submit();
		}
		window.onload= showHint; 
   	</script>