<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>


<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="CommissionsDetailsForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=CommissionsDetailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		
		%>


<script src="js/commissionsDetails.js"> </script>    
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
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
	yearrange:[1987,2050]
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
		var c_date1 = document.myform.c_date1.value ;
		var c_date2 = document.myform.c_date2.value ;		
		if(c_date1!="" && c_date2 !="") {	
				var str = "";
				str = str + document.myform.c_date1.value ;
				//str = str + document.myform.frMonth.value;	
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid Create_date1 Date");
					return false;
				}
				str = "";
				str = str + document.myform.c_date2.value ;
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid Create_date2 Date");
					return false;
				}
				
				document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
			                                document.myform.c_date1.value.substring(3,5) +
			                                "-" + document.myform.c_date1.value.substring(0,2);
			
			 	document.myform.c_date2.value  = document.myform.c_date2.value.substring(6,10) + "-" +
			                                                document.myform.c_date2.value.substring(3,5) +
			                                                "-" + document.myform.c_date2.value.substring(0,2);						
				
	    }
	    else if(c_date1!=""){
	    		var str = "";
				str = str + document.myform.c_date1.value ;
				//str = str + document.myform.frMonth.value;	
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid From Date");
					document.myform.c_date1.value = "";
					return false;
				}
				document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
			                                document.myform.c_date1.value.substring(3,5) +
			                                "-" + document.myform.c_date1.value.substring(0,2);
			
	    }	
	  
	   showHint();
	    
	}
</script>
<%

	
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");	
	mo.getDeliveryStaffList();
	String code="",desc="";
%>

<form method="post" name="myform">
	<h3><center>Commissions Details </center></h3>
	
	<center><b><font color="blue">&nbsp;A</font>ll &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" >		
		<table border="0" align="center">	
		<tr>	
				<td></td>
				<td align="center"><b><font size=2 color="red">Delivery Person :</b></font></td>
				<td>
			<SELECT name="d_staff" >
				<OPTION VALUE='select' >Select staff
<% 	
	        while (mo.rs1.next()) {
		 		code = mo.rs1.getString(1);
		 		desc = mo.rs1.getString(2);
%>
				<OPTION VALUE="<%= code%>" ><%= desc%>
<% 	
			}		
%>		
		</td></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan=4><fieldset><legend>Range</legend><table align="center">					
					<tr></tr>
					<tr></tr>
					<tr>
							<td><b>From<font color="blue">D</font>ate</b></td><td><input type ="text" accesskey="d" name="c_date1" size="10"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td><font color="blue"> T</font>oDate</td><td> <input type ="text" name="c_date2"  size="10"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
					</tr>
					<tr></tr>
					<tr></tr>
					</table></fieldset></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">
	<center><input type="submit" name="Submit" value="Search <Alt+s>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	
	<br><br><hr>Suggestions: <div id="txtHint" class="ddm1"></div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
	
</form>
<script>
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.hchckall.value=1;					
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
	
	window.onload=Clear;
		
		function Clear(){			
			document.myform.chckall.checked=true;				
		}
</script>
</body>
</html>