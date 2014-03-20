<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="customer_detailsForm.jsp" />
</jsp:include> --%>


 <%@ page errorPage="ErrorPage.jsp?page=customer_detailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
	%>

<head>
<style>
hr {
	color: #f00;
	background-color: #f00;
	height: 5px;
}
</style>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
 <link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
	

<script src="js/customer_details.js"></script>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	
		
	
	function checkField(){
		  
		var c_date1 = $('#c_date1').val();
		var c_date2 = $('#c_date2').val();
		var u_date1 = $('#u_date1').val();
		var u_date2 = $('#u_date2').val();
		
		if(c_date1!="" && c_date2==""){
			alert("enter create to_date ");
			return false;
		}
		if(c_date2!="" && c_date1==""){
			alert("enter create from_date ");
			return false;
		}
		if(u_date1!='' && u_date2==''){
			alert("enter update to_date ");
			return false;
		}
		if(u_date2!='' && u_date1==''){
			alert("enter update from_date ");
			return false;
		}
		   showHint();
		 		    
	}
	
	</script>
</head>
<form name="myform" method="post" class="ddm1" onsubmit="return false;">
	<table style="width:100%" tabindex="2">
		<tr>
			<td style="width: 50%;" align="left">
				<table  style="width: 90%;">
					<tr>
						<td colSpan="4"><b>Please Enter Customer Details to
								Search:</b></td>
					</tr>
					<tr>
						<td><b><font color="blue">C</font>ustomer Code</b></td>
						<td><input type="text" name="custCode" accesskey="c"
							onfocus="NextPage();"></td>
						<td><b><font color="blue">P</font>hone Number</b></td>
						<td><input type="text" name="phonenumber" size="22"
							align="right" colspan="2" accesskey="p"></td>
					</tr>
					<tr>
						<td><b>Customer <font color="blue">N</font>ame
						</b></td>
						<td><input type="text" name="cusName" align="right"
							accesskey="n"></td>
						<td><b>Na<font color="blue">m</font>e String
						</b></td>
						<td><input type="text" name="nameString" size="22"
							align="right" accesskey="m" colspan="2"></td>
					</tr>
					<tr>
						<td><b><font color="blue">B</font>uilding</b></td>
						<td><input type="text" name="Building" accesskey="b"
							align="right"></b></td>
						<td><b>Building <font color="blue">N</font>o.
						</b></td>
						<td><input type="text" name="Building_no" size="22"
							accesskey="n"></b></td>
					</tr>
					<tr>
						<td><b><font color="blue">W</font>ing</b></td>
						<td><input type="text" name="wing" accesskey="w"></td>
						<td><b><font color="blue">F</font>lat No.</b></td>
						<td><input type="text" name="block" size="22" accesskey="f"
							align="right">
					</tr>
					<tr>
						<td><b><font color="blue">A</font>ddress1</b></td>
						<td><input type="text" accesskey="a" name="add1"></td>
						<td><b>A<font color="blue">d</font>dress2
						</b></td>
						<td><input type="text" accesskey="d" name="add2" size="22"></td>
					</tr>
					<tr>
						<td><b>A<font color="blue">r</font>ea
						</b></td>
						<td><input type="text" accesskey="r" name="area"></td>
						<td><b><font color="blue">S</font>tation</b></td>
						<td><input type="text" size="22" accesskey="s" name="station"></td>
					</tr>
					<tr>
						<td colspan=4>
						<fieldset style="width: 90%;">
							<legend>Date Range</legend>
							<table align="center">
								<tr>
									<td><b>Create<font color="blue">D</font>ate
									</b></td>
									<td><input type="text" accesskey="d" name="c_date1" value=""
										size="15" id = "c_date1" readonly="readonly"/></td>
									<td><b>And</b></td>
									<td><input type="text" name="c_date2" size="15" id = "c_date2" value="" readonly="readonly"/></td>
								</tr>
								<tr>
									<td><b><font color="blue">U</font>pdate Date</b></td>
									<td><input type="text" accesskey="u" name="u_date1" value="" readonly="readonly"
										size="15" id = "u_date1"/></td>
									<td><b>And</b></td>
									<td><input type="text" name="u_date2" size="15" id = "u_date2" value="" readonly="readonly"/></td>
								</tr>
							</table>
						</fieldset></td>
					</tr>
					<tr>
						<td align="center" colspan=4><input type="submit"
							name="search" title="Press <Enter>" value="Search <Enter>"
							onclick="checkField();return false;"> <input type="reset"
							name="clear" title="Press <Alt+ c>" tabindex="1"
							value="Clear <Alt +c>" accesskey="c"
							onclick="document.getElementById('txtHint').innerHTML='';"> <INPUT
								type=BUTTON value="New Customer <Alt+ o>" tabindex="1"
							accesskey="o" onClick="newCustomer();"> <input type="hidden"
								name="appletMax" value=""> <input type="hidden"
								name="printed" value="0"></td>
					</tr>
				</table>
			</td>
			<td align="right">
				<div id="OrderList" class="ddm1" style="width: 90%;"></div>
				<br/>
				<div id="SubmittedOrderList" class="ddm1" style="width: 90%;"></div>
			</td>
		</tr>

	</table>
	<input type="hidden" name="hcuscode" value=""> <input
		type="hidden" name="hcusname" value=""> <input type="hidden"
		name="hcusphone" value=""> <input type="hidden"
		name="backPage" value=""> <input type="hidden" name="hadd1"
		value=""> <input type="hidden" name="hadd2" value="">
	<input type="hidden" name="harea" value="">

	<hr>
	Suggestions: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select
		name="siteId">
		<%
			try {
				Connection conn = null;
				Statement stmt, stmt1;
				ResultSet rs, rs1;
				Context initContext = new InitialContext();
				Context envContext = (Context) initContext
						.lookup("java:/comp/env");
				DataSource ds = (DataSource) envContext.lookup("jdbc/js");
				conn = ds.getConnection();
				stmt = conn.createStatement();
				String selSql = "SELECT site_id, site_name FROM site_master";
				rs = stmt.executeQuery(selSql);
				String siteName;
				Integer siteId;
				Integer GlobalSiteId = Integer.parseInt(session.getAttribute(
						"GlobalSiteId").toString());
				while (rs.next()) {
					siteId = rs.getInt(1);
					siteName = rs.getString(2);
					if (GlobalSiteId == siteId) {
		%>
		<option value="<%=siteId%>" selected><%=siteName%></option>
		<%
			} else {
		%>
		<option value="<%=siteId%>"><%=siteName%></option>
		<%
			}
				}
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				System.out.print("Ok 1");
				e.getMessage();
				e.printStackTrace();
				System.out.println(e);

			}
		%>
	</select> <br>
	<br>
	<center>
	<div id="txtHint" class="ddm1" style="width: 90%; background-color: #fff;"></div>
	</center>

	<p>
	<h1>
		<center>
			<div id="waitMessage" style="cursor: sw-resize"></div>
		</center>
	</h1>
	</p>
</form>
</body>
<script type="text/javascript">
	function NextPage(){
		if(document.myform.printed.value ==1){	
			var max = document.myform.appletMax.value;	
			document.myform.action="print_order1.jsp?backPage=customer_detailsForm1.jsp&orderNo=" + max +"";
			document.myform.target='_blank';		
			window.open(myform.action,myform.target,'fullscreen=yes');			
			document.myform.printed.value = 0;
			document.myform.custCode.focus();
			
		 }
	}
    function newCustomer(){
    		var custnm=document.myform.cusName.value
			var phno=document.myform.phonenumber.value
			var build=document.myform.Building.value
			var block=document.myform.block.value
			var wing=document.myform.wing.value
			var add1=document.myform.add1.value
			var add2=document.myform.add2.value
			
			var buildno=document.myform.Building_no.value
			var area=document.myform.area.value
			var station=document.myform.station.value
	
		 	 document.myform.action="create_newCustomerForm.jsp?backPage=customer_detailsForm.jsp&custnm="+custnm+"&phno="+phno+"&build="+build+"&block="+block+"&buildno="+buildno+"&add1="+add1+"&add2="+add2+"&wing="+wing+"&area="+area+"&station="+station+"";
		 	 document.myform.target="_blank";
		 	 window.open(myform.action,myform.target,"fullscreen=yes");
			 //document.myform.submit();
    }
<%String errMsg = "";
			String OrderNo = "";
			errMsg = request.getParameter("Exp");
			OrderNo = request.getParameter("OrderNo");%>
   var jExp=<%=errMsg%>
   var jOrderNo=<%=OrderNo%>
   var linkId=1;
 //document.myform.custCode.focus();
   document.myform.phonenumber.focus();
 
   if(jExp==1){
   			alert("You Successfully created Order No: " + jOrderNo);
   			window.refresh;
   			jExp=jExp+1;
   			
   }
   window.onload = function(){
	   showHint1();
	   
	  /*  var c_date1 = document.myform.c_date1.value ;
		var c_date2 = document.myform.c_date2.value ;
		var u_date1 = document.myform.u_date1.value ;
		var u_date2 = document.myform.u_date2.value ; */
	   
	   $( "#c_date1" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			maxDate:new Date(),
			//numberOfMonths: 3,
			onClose: function( selectedDate ) {
				$( "#c_date2" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$( "#c_date2" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			//numberOfMonths: 3,
			maxDate:new Date(),
			
			onClose: function( selectedDate ) {
				$( "#c_date1" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
		 $( "#u_date1" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				maxDate:new Date(),
				//numberOfMonths: 3,
				onClose: function( selectedDate ) {
					$( "#u_date2" ).datepicker( "option", "minDate", selectedDate );
				}
			});
			$( "#u_date2" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				//numberOfMonths: 3,
				maxDate:new Date(),
				
				onClose: function( selectedDate ) {
					$( "#u_date1" ).datepicker( "option", "maxDate", selectedDate );
				}
			});
	   
	   
   }
   window.onfocus =showHint1; 
   
   function getKey(){	  
		var key = event.keyCode;
		if (key == 9){
 			if(document.getElementById("txtHint").innerHTML!=''){	
					if(linkId>document.myform.count.value)
						linkId=1;
					else{
							document.getElementById(linkId).focus();	
							linkId=linkId+1;
						}
					}			
			}
	}
	document.onkeyup= getKey;      	

</script>
</html>