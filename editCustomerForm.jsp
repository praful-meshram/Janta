<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editCustomerForm.jsp" />	
</jsp:include> --%>
<%@ page errorPage="ErrorPage.jsp?page=editCustomerForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%@page contentType="text/html"%>
<script type="text/javascript"  src="js/customerOrderDetails.js"></script>
<script type="text/javascript" src="js/codethatcalendarstd.js"></script>
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}

</style>
<%
		String customerName="";
	  	customerName=request.getParameter("name");
	  	String telephone="";
	  	telephone=request.getParameter("tele");
	  	String building="";
	  	building=request.getParameter("bldg");
	  	String building_no="";
	  	building_no=request.getParameter("building_no");
	  	String block="";
	  	block=request.getParameter("block");
		String wing="";
	 	wing=request.getParameter("wing");
		String add1="";
	 	add1=request.getParameter("add1");
	 	String add2="";
		add2=request.getParameter("add2");
		String custCode="";
		custCode=request.getParameter("cuscode");
		String area="";
	    area=request.getParameter("area");
	    String station="";
		station=request.getParameter("station");
	    String pincode="";
		pincode=request.getParameter("pincode");
		String city="";
		city=request.getParameter("city");
		String state="";
		state=request.getParameter("state");
		String payment = request.getParameter("payment");
		String mobile = request.getParameter("mobile");
					
%>  
		
<script type="text/javascript">
	var caldef1 = {
	firstday:0,
	dtype:'dd/MM/yyyy',
	width:250,
	windoww:300,
	windowh:200,
	border_width:0,
	border_color:'#0000d3',
	dn_css:'clsDayName',                        
	cd_css:'clsCurrentDay',
	wd_css:'clsWorkDay',
	we_css:'clsWeekEnd',
	wdom_css:'clsWorkDayOtherMonth',
	weom_css:'clsWeekEndOtherMonth',
	headerstyle: {
	type:"comboboxes",
	css:'clsWorkDayOtherMonth',
	yearrange:[1940,2050]
	},
	monthnames :["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	daynames : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
	};
	var c1 = new CodeThatCalendar(caldef1);
	
	
	function validateIndiaDate( strValue ) {
		var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
		//check to see if in correct format
		if(!objRegExp.test(strValue))
		    return false; //doesn't match pattern, bad date
		else{
			var strSeparator = strValue.substring(2,3) //find date separator
		    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
		    //create a lookup for months not equal to Feb.
		    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
			'08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
		    var intDay = parseInt(arrayDate[0],10);
		    //check if month value and day value agree
			if(arrayLookup[arrayDate[1]] != null) {
		      	if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
					return true; //found in lookup table, good date
		    	}
		  //check for February
		  var intYear = parseInt(arrayDate[2],10);
		  var intMonth = parseInt(arrayDate[1],10);
		  if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
		  	return true; //Feb. had valid number of days
		  }
		  return false; //any other values, bad date
	}
	
	
function checkField(){


		var phoneNo=document.myform.phone.value;
		var custName=document.myform.custName.value;
		if(custName=="") {
				alert("Please Enter Customer Name");
				return false;
		}
		else if(isNaN(phoneNo)) {
				alert("Please Enter a number in PhoneNumber field");
				return false;
		}
		else if(phoneNo=="") {
				alert("Please Enter your Phone Number");
				return false;
		}
			var hchck = document.myform.hchckall.value ;
		 if(hchck != "0"){
			var c_date1 = document.myform.c_date1.value ;
			var c_date2 = document.myform.c_date2.value ;
			var u_date1 = document.myform.u_date1.value ;			
		   if(c_date1!="" ){		
		    		var str = "";
					str = str + document.myform.c_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid From Date");
						return false;
					}
					document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
				                                document.myform.c_date1.value.substring(3,5) +
				                                "-" + document.myform.c_date1.value.substring(0,2);
				
		    }
		    if(c_date2!="" ){
		    		var str = "";
					str = str + document.myform.c_date2.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid From Date");
						return false;
					}
					document.myform.c_date2.value = document.myform.c_date2.value.substring(6,10) + "-" +
				                                document.myform.c_date2.value.substring(3,5) +
				                                "-" + document.myform.c_date2.value.substring(0,2);
				
		    }
		    if(u_date1!=""){
		    		var str = "";
					str = str + document.myform.u_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date1 Date");
						return false;
					}
		   			 document.myform.u_date1.value = document.myform.u_date1.value.substring(6,10) + "-" +
				                                document.myform.u_date1.value.substring(3,5) +
				                                "-" + document.myform.u_date1.value.substring(0,2);
			} 
		}  
		
		var ans=confirm("Do you really want to save  the changes?");
	 	if (ans==true){
	  		document.myform.action="editCustomer.jsp";
		    document.myform.submit();
	 	}
	 	else {
	  		document.myform.action="HomeForm.jsp"; 	    
	 	}	
	}
	
	function optionDelete(){
	    var order = document.myform.horder.value;
	    if(order!= "") {
	    	alert("You  Can't Delete This Customer");
	    	return false;
	    }
		var ans=confirm("Do you really want to Delete  this Customer?");
	 	if (ans==true){
	 		document.myform.hoption.value=1;	 		
	  		document.myform.action="editCustomer.jsp";
		    document.myform.submit();
	 	}
	 	else {
	  		window.refresh;	    
	 	}	
	 }
	function showMsg(){
		document.myform.action="EditTargetReportForm.jsp";
	 	document.myform.submit();
	 }
	 
	function Warn(){
		alert("You  Can't Change The Customer Code");
	}
</script>
<h3><center>Edit Customer</h3></center>
<form name="myform">
	<table  align="center" style="width: 700px;">
		<tr style="width: 100%;">
		    <td style="width: 15%;"><b>Customer Code</b></td>
		    <td style="width: 1%">:</td>
		    <td style="width: 30%"><input style="width: 100%;" type="text"  name="custCode"  align="right"  readonly="readonly" value="<%=custCode%>"  onClick="Warn();"></td>
		    
		    <td style="width: 8%"></td>
		     
		    <td style="width: 15%;"><b>Mobile Number</b></td>
		    <td style="width: 1%">:</td>
		    <td style="width: 30%"><input style="width: 100%;" type="text"  name="mobileNum"  align="right" value="<%=mobile%>"></td>
		</tr>
		<tr>    
			<td><b>Customer Name</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="custName"  align="right" value="<%=customerName%>"></td>
			
			<td style="width: 8%"></td>
			 
			<td><b>Phone Number</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="phone" size="22"  align="right" colspan="2" value="<%=telephone%>"></td>
		</tr>
		<tr>
			<td ><b>Building</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="building"  align="right" value="<%=building%>"></b></td>
			
			<td style="width: 8%"></td>
			
			<td ><b>Building No.</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="buildingno"  align="right" value="<%=building_no%>"></b></td>
		</tr>
		<tr>	
		    <td><b>Wing</b></td>
		    <td style="width: 1%">:</td>
		    <td><input style="width: 100%;" type ="text" name="wing"  value="<%=wing%>"></td>
		    
		    <td style="width: 8%"></td>
		    
     		<td><b>Flat_no</b></td>
     		<td style="width: 1%">:</td>
     		<td><input style="width: 100%;" type ="text" name="block"  align="right" value="<%=block%>"></td>
			
		</tr>
		<tr>
			<td><b>Address1</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type ="text" name="add1" value="<%=add1%>"></td>
			
			<td style="width: 8%"></td>
			
			<td><b>Address2</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type ="text" name="add2" size="22" value="<%=add2%>"></td>
		</tr>
		<tr>
			<td><b>Area</b></td>
			<td style="width: 1%">:</td>
			<td>
<% 
                String name="";
                Connection conn=null;
				Statement stmt=null;
				ResultSet rs=null;
				try {
					
					Context initContext = new InitialContext();
					Context envContext  = (Context)initContext.lookup("java:/comp/env");
					DataSource ds = (DataSource)envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					
					rs = stmt.executeQuery("select value from code_table where category='AREA' order by value asc");
					
%>
					<center>
						<SELECT name="area" align="left" style="width: 100%;">
						<OPTION VALUE="<%=area%>"> <%= area%> 
<%
                           
					 		while (rs.next()) {
					 			name = rs.getString(1);
					 			
%>
								<OPTION VALUE="<%=name%>"> <%= name%> 
<%
							}
					    	%>
		</select></td>	
		
		<td style="width: 8%"></td>
		
		<td><b>Payment Type</b></td>
		<td style="width: 1%">:</td>
		<td><SELECT name="payment" align="left" style="width: 100%;">
		<% if(payment.equals("")){%>
			<OPTION selected VALUE="">Select Type
		<%}else{%>
<%   
		String q ="SELECT payment_type_desc FROM payment_type where payment_type_code = '"+payment+"'";
		ResultSet rs3 = stmt.executeQuery(q);
    	while (rs3.next()){	
%>
			<OPTION selected VALUE="<%=payment%>"> <%=rs3.getString(1)%>
			<% }rs3.close();} %>
<%
        ResultSet rs2 = stmt.executeQuery("SELECT payment_type_code, payment_type_desc FROM payment_type");
    	while (rs2.next()){	
%>

		<OPTION VALUE="<%=rs2.getString(1)%>"> <%= rs2.getString(2)%> </option>

<%	
        }
        rs2.close();
					    	stmt.close();
					    	conn.close();
					}
					catch (Exception e) {
				       	e.getMessage();
				        e.printStackTrace();  
				        rs.close();
					    stmt.close();
					    conn.close();
				    }      
%>			
		</select></td>
				
		</tr>
		<tr>
			<td><b>Station</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="station"  align="right" value="<%=station%>"></td>	
			
			<td style="width: 8%"></td>
					
			<td><b>Pincode</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="pincode" size="22"  align="right" colspan="2" value="<%=pincode%>"></td>
				
		</tr>
		<tr>
			<td><b>City</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="city"  align="right" value="<%=city%>"></td>
			
			<td style="width: 8%"></td>
			
			<td><b>State</b></td>
			<td style="width: 1%">:</td>
			<td><input style="width: 100%;" type="text" name="state"  size="22"  align="right" colspan="2" value="<%=state%>"></td>
		</TR>
		<TR>
		
			<td align="left" colspan="4"><input type="checkbox" name="chckall" onclick="showCustAtt();">
			<font color="blue"><b>Additional Information</b></td>
		</tr>
		
		<tr></tr>
	</table> <br>	
	<table align="center"><tr><td><div id="divcustatt"> </div></td></tr></table>
	<br>
	<center><input type="hidden" name="hcustCode" value="<%=custCode%>">
	<input type="hidden" name="hoption" value="0">
	<input type="submit" name="Submit" value="Submit <Alt+s>" accesskey="s"  disabled  onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
		<INPUT type="button" value="Delete <Alt+d>" accesskey="d" onClick="optionDelete();">
	<INPUT type="button" value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	<input  type="hidden" name="hchckall" value="0">
	</center>
<hr><br><br> 
<center><div id="txtHint" class="ddm1" style="width: 70%"></div></center>
<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>



<script type="text/javascript">
	document.myform.custName.focus();
	function check(){
    	document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
	document.onclick = check;
	window.onload=showHint;
	
	
	
</script>
</form>
</body>
</html>