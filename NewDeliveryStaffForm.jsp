<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />  

<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewDeliveryStaffForm.jsp" />	
</jsp:include>   
 
 --%>
<%@ page errorPage="ErrorPage.jsp?page=NewDeliveryStaffForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 

<script language="javascript" src="js/codethatcalendarstd.js"></script
<script language="javascript" src="js/date_validation.js"></script>
<script type="text/javascript">
   	var flag=true;
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
		var stDate=document.myform.stDate.value;
		
		if(stDate!="") {	
				var str = "";
				str = str + document.myform.stDate.value ;					
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid Start Date");
					return false;
				}
								
				document.myform.stDate.value = document.myform.stDate.value.substring(6,10) + "-" +
			                                document.myform.stDate.value.substring(3,5) +
			                                "-" + document.myform.stDate.value.substring(0,2);
						 	
	    }
		else{
			alert("Select Start Date");
			return false;
				
 		}
 		var ans=confirm("Do you want to create this Delivery Staff ?");
			if (ans==true){
				document.myform.dsBalance.value = 0;
				
				document.myform.action="NewDeliveryStaff.jsp";
	    		document.myform.submit();
			}
			else
			 {
			  window.refresh; 
			 }		
 			 		
	}	

<%
		String str1="";
	    str1=request.getParameter("Exp");
%>
	var jExp=<%=str1%>	
	function trimString(str){
	  	return str.replace(/^\s+|\s+$/g, '');
	}
		
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
	
	function ClearAll(){
		document.myform.dsName.value="";
		document.myform.stDate.value="";
		document.myform.dsBalance.value = "";
	
		return false;
	 }
	
	if(jExp==1){
		alert("Member Name already exists !!!");
	}

</script>
<p>
<form method="post" name="myform">
	    <br><br>
		<center><h3> New Staff Creation</h3></center>
	 	<br>
	 	<table align="center">
	 	    <tr>
			     <td><b><font color="blue">S</font>taff Name </td>
			     <td><input name="dsName" id="dsName"  type="text" maxlength="20" value="" accesskey="s"><br></td>
			</tr>
			<tr></tr>
			<tr>
			<td ><b><font color="blue">S</font>tart Date</b></td><td align=left><INPUT name="stDate" size=15> <input type="button" accesskey="f" onClick="c1.popup('stDate');" value="..."/> </TD>
			</tr>	
			<tr></tr>
			    <tr>
					<td><b><font color="blue">B</font>alance to Pay&nbsp&nbsp </td>
				   	<td><input name="dsBalance" readonly type="text"  value="0" accesskey="b" size="15"></td>
				</tr>
				<tr></tr>
			</table><br><br>			
			<center><input type="submit" name="Submit"  title="Press <Enter>" value="Save <Enter>" accesskey="s" onclick="flag=true;checkField();return false;">
			<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="ClearAll(); return false;">
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
			
</form>   
<script>
	
	function check(){
    	document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
</body>

</html>
