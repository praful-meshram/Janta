<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 

<%@ page errorPage="ErrorPage.jsp?page=PrintDcForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="sessionBoth.jsp?formName=PrintDcForm.jsp"/>
<script src="js/PrintDcForm.js">
</script> 

<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
#txtHint{
	background-color: transparent;
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
			var u_date1 = document.myform.u_date1.value ;
			var u_date2 = document.myform.u_date2.value ;
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
						return false;
					}
					document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
				                                document.myform.c_date1.value.substring(3,5) +
				                                "-" + document.myform.c_date1.value.substring(0,2);
				
		    }
		    if(u_date1!="" && u_date2 !="") {	
					var str = "";
					str = str + document.myform.u_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date1 Date");
						return false;
					}
					str = "";
					str = str + document.myform.u_date2.value ;
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date2 Date");
						return false;
					}
					
					document.myform.u_date1.value = document.myform.u_date1.value.substring(6,10) + "-" +
				                                document.myform.u_date1.value.substring(3,5) +
				                                "-" + document.myform.u_date1.value.substring(0,2);
				
				 	document.myform.u_date2.value  = document.myform.u_date2.value.substring(6,10) + "-" +
				                                                document.myform.u_date2.value.substring(3,5) +
				                                                "-" + document.myform.u_date2.value.substring(0,2);						
					
		    }
		    else if(u_date1!=""){
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
		    showHint();		
		    
	}
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
</script>
<b>Please Enter Order Details to Search  </b>

<form name="myform" method="post" class="ddm1">
<table align="center" width="100%" tabindex="2">
	<tr>
	<td>
	<table border="0" align="left">
		<tr>
			<td><b><font color="blue">O</font>rder Number</b></td><td><input type="text" name="orderNumber" accesskey="o" align="right"></td>
			<td><b><font color="blue">C</font>ustomer Code</b><td><input type="text" name="customerCode" accesskey="c" align="right" colspan="2"></td>
		</tr>
		<tr>
			<td ><b>Customer <font color="blue">N</font>ame</b></td>
			<td><input type="text" name="customerName" accesskey="n" align="right"></b></td>
			<td><b><font color="blue">E</font>ntered By</b></td><td><input type ="text" name="enteredBy"></td>
		</tr>
		<tr><td colspan=4><fieldset><legend>Date Range</legend><table align="center">		
		<tr>
			<td><b>Create<font color="blue">D</font>ate</b></td><td><input type ="text" readonly accesskey="d" name="c_date1" size="15"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td> <b>And</b></td><td> <input type ="text" name="c_date2"  size="15"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
		</tr>
		<tr>
			<td><b><font color="blue">U</font>pdate Date</b></td><td><input type ="text" readonly accesskey="u" name="u_date1" size="15"><input type="button" onClick="c1.popup('u_date1');" value="..."/></td><td><b>And</b></td><td> <input type ="text" name="u_date2" size="15"><input type="button" onClick="c1.popup('u_date2');" value="..."/></td>
		</tr>
		</table></fieldset></td></tr>
  </table>
 </td>
  <td>
<%
    Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query="select a.order_num, a.custcode, a.order_date,a.total_items,a.total_value, b.custname ,b.phone,a.status_code,a.enterd_by "+
    					"from orders a, customer_master b  where a.status_code not like 'SUBMITTED' and a.custcode = b.custcode order by a.lastmodifieddate Desc limit 5";
    	rs=stat.executeQuery(query);
%>    	
    	<table style="border-collapse: collapse;" border="1" id="id1" class="item3"  >
    	<tr><th colspan="7"><center><b>In Transit/Delivered/Closed Orders </b></center></th></tr>
			<tr> 
				<td><b>Order No.</b></td>
				<td><b>Cust Code</b></td>
				<td><b>Order Date</b></td>
				<td><b>Items</b></td>	
				<td><b>Order Value</b></td>	
				<td><b>Enterd By</b></td>	
				<td><b>Status</b></td>		
		   </tr>
<%		
		while(rs.next()) {
%>
          
             <tr> <td><a href="PrintDc.jsp?orderNo=<%=rs.getString(1)%>&buttonFlag=Y&statusCode=<%=rs.getString(8)%>" target="_blank">
<%			
			out.println(rs.getString(1));
%>       
						
			</td><td title="<%=rs.getString(6)%>,<%=rs.getString(7)%>">
<%	
           	out.println(rs.getString(2));
%>
			</td><td>
<%	
           	out.println(rs.getString(3));
%>	
			</td><td>
<%	
           	out.println(rs.getString(4));
%>	
			</td><td>
<%	
           	out.println(rs.getString(5));
%>	
			</td><td>
<%	
           	out.println(rs.getString(9));
%>	
			</td><td>
<%	
           	out.println(rs.getString(8));
%>	
			</td></tr>
<%		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();
%>
	</table>
</td>
</tr>
<%							
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}		
%>

</table>  
</table> 
	<br><br>
<div style="text-align: left; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="search" title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" value="Clear <Alt+c>" tabindex="1" title="Press <Alt+c>" accesskey="c" onclick='document.getElementById("txtHint").innerHTML="";'>
	<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();"></div>
	<hr>Suggestions: <div id="txtHint" class="ddm1" style="overflow: auto;max-height: 360px;"></div>
	<br><br>
	<p><h1><center><div id="waitMessage" ;" ></center></div></h1></p>
	<script type="text/javascript">
		  document.myform.orderNumber.focus();
		  var currentFld = 0;
		  function getKey(){
				var key = event.keyCode;
				if (key == 38 || key == 40){
					if (key == 38) currentFld--; //up arrow
					else currentFld++; //down
					if (!document.myform.elements[currentFld]) {
						tref = document.getElementById("id1");
						ahref = tref.getElementsByTagName("A");
						ahref[currentFld-13].focus();
					}
					else
						document.myform.elements[currentFld].focus();
				}
		    }
			document.onkeydown = getKey;      	
   	</script>
	 
</form>
</body>
</html>