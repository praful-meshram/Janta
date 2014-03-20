<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@ page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="create_newCustomerForm.jsp" />	
</jsp:include> --%>

<script src="js/customer_validation.js">
 </script> 
 
 <%@ page errorPage="ErrorPage.jsp?page=create_newCustomerForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
 
 <% 
 			String backPage=""; 
			String custnm="",phno="",build="",buildno="",block="",wing="",
				   add1="",add2="",area="",station="", mno = "";      		
            backPage=request.getParameter("backPage");
        if(backPage==null){
        	System.out.println("====cust name1 :"+custnm);
			
			custnm="";
			
			phno=""; 
			build="";
			buildno="";
			block="";
			wing="";
			add1="";
			add2="";
			area="";
			station="";	
			mno="";
        }
        else if(!(backPage==null)){ 
			custnm=request.getParameter("custnm");
			//System.out.println("cust name2 : "+custnm);
			phno=request.getParameter("phno"); 
			build=request.getParameter("build");
			buildno=request.getParameter("buildno");
			block=request.getParameter("block");
			wing=request.getParameter("wing");
			add1=request.getParameter("add1");
			add2=request.getParameter("add2");
			area=request.getParameter("area");
			station=request.getParameter("station");
			mno = request.getParameter("mobile");
        }               
          
%>
<script type="text/javascript">

	function checkField(){
	    
		var phoneNo=document.myform.phone.value;
		var area1=document.myform.area.value;
		var custName=document.myform.cusName.value;
		if(custName=="") {
				alert("Please Enter Customer Name");
				document.myform.cusName.focus();
				return false;
		}
		else if(isNaN(phoneNo)) {
				alert("Please Enter a number in PhoneNumber field");
				document.myform.phone.value="";
				document.myform.phone.focus();
				return false;
		}
		else if(phoneNo=="") {
				alert("Please Enter your Phone Number");
				document.myform.phone.focus();
				return false;
		}
		else if(area1=="") {
				alert("Please Select Area");
				document.myform.area.focus();
				return false;
		}
		else {
		    document.myform.Submit.disabled = true;
			var ans=confirm("Do you want to create this Customer?");
			if (ans==true){
				
				document.myform.action="create_newCustomer.jsp";				
				document.myform.submit();
				
			}
			else
			 {
			  window.refresh; 
			 }			
		}	
	}	
	function showMsg(){
		var backPage=document.myform.backPage.value;
		if(backPage !="customer_detailsForm.jsp"){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	   	}else{
	   		window.close();
	   	}
	}
	function isNumberKey(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode;
		if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
			return false;
		else
			return true;
	}
</script>
<center>
<div style="width: 700px;">
<h3>Create a New Customer</h3>
<form name="myform" method="post">
	<table border="0" align="center"  style="width:100%;">
		<tr>
			<td style="width:15%;" align="left"><b>Customer Name</b></td>
			<td style="width:1%;">:</td><td  style="width: 30%;" align="left">
				<input style="width: 100%;" type="text" name="cusName"  align="right" value="<%=custnm%>">
			</td>
		</tr>
		<tr>
			<td align="left" style="width:15%;"><b>Mobile Number</b></td>
			<td style="width:1%;">:</td>
			<td style="width:30%;" align="left">
				<input style="width:100%;" type="text" name="mobile"  align="right" value="<%=mno%>" 
				onblur="showHint('mo');" onkeypress="return isNumberKey(event)">
			</td>
			
			<td style="width:8%;"></td>
			
			<td align="left" style="width:15%;"><b>Phone Number</b></td>
			<td style="width:1%;">:</td>
			<td style="width:30%;" align="left">
				<input style="width:100%;" type="text" name="phone" size="22"  value="<%=phno%>" align="right" 
				onblur="showHint('ph');" onkeypress="return isNumberKey(event)">
			</td>
		</tr>
		<tr>
			<td  align="left" style="width:15%;"><b>Building Name</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="building"  align="right" value="<%=build%>" ></b></td>
			
			<td style="width:8%;"></td>
			
			<td  align="left" style="width:15%;"><b>Building No.</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="buildingno"  align="right" value="<%=buildno%>"></b></td>
		</tr>
			<td align="left" style="width:15%;"><b>Wing</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type ="text" name="wing"  value="<%=wing%>"></td>
			
			<td>&nbsp;&nbsp;</td>
			
			<td  align="left" style="width:15%;"><b>Flat No.</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type ="text" name="block"  align="right" value="<%=block%>"></td>
		</tr>
		<tr>
			<td align="left" style="width:15%;"><b>Address1</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type ="text" name="add1" value="<%=add1%>"></td>
			
			<td style="width:8%;"></td>
			
			<td align="left" style="width:15%;"><b>Address2</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type ="text" name="add2" size="22" value="<%=add2%>"></td>
		</tr>
		<tr>
			<td align="left" style="width:15%;"><b>Area</b></td>
			<td style="width:1%;">:</td><td>
<% 

	String name,city1="",state1="",category="",station1="";
	try {
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("select value from code_table where category='AREA' order by value asc");
					
%>
				
						<SELECT name="area" align="left" style="width: 100%;">
						<OPTION VALUE=""> Select Area 
<%
 		while (rs.next()) {
 			name = rs.getString(1);
 			//System.out.println("area :"+area);
 			if(name.equals(area)){	
 %>
 					<OPTION VALUE="<%=name%>" selected> <%= name%> </OPTION>
 <%			}else{
%>
			<OPTION VALUE="<%=name%>"> <%= name%> </OPTION>
<%		}
		}
    	rs.close();
    	ResultSet rs1 = stmt.executeQuery("SELECT category,value FROM code_table where category in('CustDefaultCity','CustDefaultState','CustDefaultStation')");
    	while (rs1.next()){					    	
	    	category = rs1.getString(1);
	    	if (category.equals("CustDefaultCity")) {
	    	   city1 = rs1.getString(2);	    	   					    	    	   
	    	}
	    	if (category.equals("CustDefaultState")) {
	    	   state1 = rs1.getString(2);	    	  
	    	}
	    	if (category.equals("CustDefaultStation")) {
	    	   station1 = rs1.getString(2);	    	  
	    	}						       
        }
        rs1.close();
%>
		</select></td>
		
		<td style="width:8%;"></td>
		
		<td align="left" style="width:15%;"><b>Payment Type</b></td>
		<td style="width:1%;">:</td>
		<td><SELECT name="payment" align="left" style="width: 100%;">
			<OPTION selected VALUE=""> Select Type 
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
	}
%>
		</select></td>			
		</tr>
		<tr>
			<td align="left" style="width:15%;"><b>Station</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="station" value="<%=station1%>"  align="right"></td>
			
			<td style="width:8%;"></td>
			
			<td align="left" style="width:15%;"><b>Pincode</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="pinCode" size="22"  align="right" colspan="2"></td>
			
		</tr>
		<tr>
			<td align="left" style="width:15%;"><b>City</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="city" value="<%=city1%>" readonly align="right"></td>
			
			<td style="width:8%;"></td>
			
			<td align="left" style="width:15%;"><b>State</b></td>
			<td style="width:1%;">:</td>
			<td><input style="width: 100%;" type="text" name="state" value="<%=state1%>" readonly size="22"  align="right" colspan="2"></td>
		</tr>
	</table><br><br> 
	<center><input type="submit" name="Submit" accesskey="s" disabled onClick="checkField();return false;"  value="Submit <Alt+s>">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	<input type="hidden" name="backPage" value="<%=backPage%>">
</form>
</div>
<script type="text/javascript">
      	document.myform.cusName.focus();
      	
      	function check(){
    	document.myform.Submit.disabled=false;
	}
		document.onkeyup = check;
</script>
<center>
</body>
</html>