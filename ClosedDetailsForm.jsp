<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ClosedDetailsForm.jsp" />	
</jsp:include> --%>

<%@page contentType="text/html"%>
<script src="js/lastOrderDetails.js"></script>

<%@ page errorPage="ErrorPage.jsp?page=ClosedDetailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		%>

<%
	String dstaffCode="",dstaffName="",status_code_value="CLOSED",statusCode="",
		   prevStaffCode="",prevStaffName="";
	String[] actionValueArray=null;
  	String action1="",action2="",actionValue="";
  	String subValue="";
  	String custCode="";
  	String name="";
  	String phno="";
  	String area="";
  	String add1="";
  	String add2="";
  	String orderNo=""; 	  
	orderNo=request.getParameter("orderNo"); 
  	String orderDate="";   	
  	String status="";	
  	String totalItems="";	  	
  	float totalValue=0.0f;
  	float balance=0.0f;
  	float advance=0.0f;
  	float discount=0.0f;
  	
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	mo.getOrderDetails(orderNo);
	
	while(mo.rs.next()){		
		custCode = mo.rs.getString("custcode");
	  	name = mo.rs.getString("custname");
	  	phno = mo.rs.getString("phone");
	  	area = mo.rs.getString("area");
	  	add1 = mo.rs.getString("add1");
	  	add2 = mo.rs.getString("add2");
	  	balance = mo.rs.getFloat("balance_amt");
	  	advance = mo.rs.getFloat("advance_amt");
	  	discount = mo.rs.getFloat("discount_amt");
		orderDate = mo.rs.getString("order_date");
	  	status=mo.rs.getString("status_code");
	  	totalItems = mo.rs.getString("total_items");
	  	totalValue = mo.rs.getFloat("total_value");		
	}
	mo.closeAll();
  	
%>

<form name="myform" method="post" class="ddm1">
	<table align=center >
	<tr bgcolor="light GRAY">
    	<td bgcolor="orange"><b><font color="blue" size ="2">Current Status :</font><b></td>
    	<td bgcolor="pink">&nbsp;&nbsp;<b><font color="black" size ="1.9"><label id='status' ></label></label></font>&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;&nbsp;;<b></td>
    	<td colspan=5 bgcolor="white"></td>
    	<td bgcolor="orange"><b><font color="blue" size ="2">Next Action :</font></b></td>
    	<td bgcolor="pink">&nbsp;&nbsp;<b><font color="black" size ="1.9"><label id='action' ></label></font><b></td>  	
    </tr>
	</table>
	<table width="100%">
	<tr><td colspan=8></td><td>
    <table id="1"  width="100%">
	<tr><th colspan="6"><center><b>Customer Information</b></center> </th></tr>
	<tr></tr><TR></TR>
	<tr></tr><TR></TR>
	<tr>
		
		<td><b>Customer Code</b></td>
		<td>: <%=custCode%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
	<table width="100%">	
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
			<td>: <%=(50 -(totalValue % 50))%></td>
		</tr>
		<tr>	
			<td><b>Delivery  Person </b></td>
			<td>:<label id='dperson' ></label></label>
<%	
	Connection conn=null;
	Statement stmt=null,stat=null;
	ResultSet rs=null,rs1=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();	
		//stat = conn.createStatement();	
		rs =stmt.executeQuery("SELECT o.dstaff_code, d.dstaff_name FROM orders o,delivery_staff d where o.order_num='"+orderNo+"' and o.dstaff_code=d.dstaff_code");
		while(rs.next()){
			prevStaffCode=rs.getString(1);
			prevStaffName=rs.getString(2);
		}
		String query="SELECT d.dstaff_code,d.dstaff_name FROM delivery_staff d, "+
					 "orders o where o.order_num=289 and o.dstaff_code=d.dstaff_code";
		rs = stmt.executeQuery(query);
	
	 	while (rs.next()) {
	 		dstaffCode = rs.getString(1);
	 		dstaffName = rs.getString(2);
		}	
		
		rs1 = stmt.executeQuery("SELECT status_code, allow_action FROM status where status_code='"+status_code_value+"'");		
%>		

			</td>
		</tr>
		<%if(!prevStaffCode.equals("") && !prevStaffName.equals("")){%>
			<tr><td><font color=#FF00CC sixe=2><b>This order was delivered by <%=prevStaffName%></b></font></td></tr>
		<%}%>
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
		
		</table>
		</td><br>	
		<td valign=top align=right>			
			<div id="OrderHistory" class="ddm1"> </div> 
		</td>
		</tr>
		</table>
		<tr><td align="center" colspan=4>		
	<center>		
	<input type="submit" name="Submit"  disabled value="Save <Alt+s>" accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	</center>
</td></tr><hr>
 	<input type="hidden" name="horderNo" value="<%=orderNo%>">
 	<input type="hidden" name="horderDate" value="<%=orderDate%>"> 	
 	<input type="hidden" name="hstatus" value="<%=status%>">
 	<input type="hidden" name="hallowaction" value="">
	<input type="hidden" name="hpagename" value="DeliveryDetailsForm"> 	 	
	<div id="txtHint" class="ddm1">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>

<script type="text/javascript">		
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;			
		}
		function checkField(){
			var allow_action = document.myform.allow_action.value;				
			var allow_actionnm = document.myform.allow_action[document.myform.allow_action.selectedIndex].text;			
			document.myform.hallowaction.value=allow_actionnm;
			var change =document.myform.change.value;
			if(d_staff=="" && allow_actionnm=="Send for delivery") {
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
				if(allow_action==0){
					var ans=confirm("Do you want to send "+ d_staffnm +" to deliver the order: "+ <%=orderNo%>);			
					if (ans==true){	
						document.myform.action="DeliveryDetails.jsp?subValue=<%=subValue%>";
						document.myform.submit();
					}
					else{
					  	window.refresh; 			  	
					}
				}
				else if(allow_action==1){
					var ans=confirm("Do you want to hold the order: "+ <%=orderNo%>);			
					if (ans==true){	
						document.myform.action="DeliveryDetails.jsp?subValue=<%=subValue%>";
						document.myform.submit();
					}
					else{
					  	window.refresh; 			  	
					}
				}
			}
		}
		function showMsg(){
		  	 //document.myform.action="SubmittedOrdersDetails.jsp";
			 document.myform.action="TrackingForm.jsp";		  	 
		   	 document.myform.submit();
		}
		//window.onload= showHint; 		
		window.onload= func
		function func(){
			showHistory(); 
			document.getElementById("status").innerHTML="<%=status%>";
			document.getElementById("action").innerHTML="<%=actionValue%>";
			document.getElementById("dperson").innerHTML="<%=dstaffName%>";  
		}
   	</script>
   	