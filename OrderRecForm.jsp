<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="OrderRecForm.jsp" />	
	</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=OrderRecForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<script src="js/order_rec_details.js"></script> 
<script type="text/javascript" src="js/popup.js"></script>
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
						return false;
					}
					document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
				                                document.myform.c_date1.value.substring(3,5) +
				                                "-" + document.myform.c_date1.value.substring(0,2);
				
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
	 <td><b>Rec.<font color="blue">O</font>rder Number</b></td><td><input type="text" name="orderNumber" accesskey="o" align="right"></td>
	 <td><b><font color="blue">C</font>ustomer Code</b><td><input type="text" name="customerCode" accesskey="c" align="right" colspan="2"></td>
	</tr>
	<tr>
	 <td ><b>Customer <font color="blue">N</font>ame</b></td>
	 <td><input type="text" name="customerName" accesskey="n" align="right"></b></td>
	 <td><b><font color="blue">E</font>ntered By</b></td><td><input type ="text" name="enteredBy"></td>
	</tr>
	<tr>
	<td><b>Order <font color="blue">S</font>tatus</b></td>
	<td><select name="selstatus" accesskey="s">
		<option selected value="All">All</option>
		<option value="INS">INS</option>
		<option value="EDI">EDI</option>
	</select></td>
	</tr>
	<tr><td colspan=4><fieldset><legend>Date Range</legend><table align="center">		
	<tr>
	 <td><b>Create<font color="blue">D</font>ate</b></td><td><input type ="text" readonly accesskey="d" name="c_date1" size="15"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td> <b>And</b></td><td> <input type ="text" name="c_date2"  size="15"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
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
    	String query="select a.order_num, a.custcode, a.order_date,count(8), a.order_status,a.enterd_by from orders_rec a, order_detail_rec b  where a.order_num = b.order_num group by b.order_num order by a.order_date Desc limit 5";
    	rs=stat.executeQuery(query);
%>    	
    	<table border="1" id="id1" class="item3"  >
    	<tr><th colspan="6"><center><b>Recently updated orders</b></center></th></tr>
			<tr> 
				<td><b>Order No.</b></td>
				<td><b>Cust Code</b></td>
				<td><b>Order Date</b></td>
				<td><b>Items</b></td>	
				<td><b>Status</b></td>				
				<td><b>Enterd By</b></td>
					
		   </tr>
<%		
		while(rs.next()) {
%>
          
             <tr> <td><a href="Javascript:showItemList('<%=rs.getString(1)%>','<%=rs.getString(2)%>')">
<%			
			out.println(rs.getString(1));
%>       
						
			</td><td >
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
           	out.println(rs.getString(6));
%>	
			</td></tr>
<%		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();
%>
	<tr><td colspan="6" align="right"><a href="Javascript:showList();">More</a></td></tr>
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
<ceneter> <div id="dispdiv" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF"> </div></center>
<ceneter> <div id="dispdiv1" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF;width:600px;overflow:auto;"> </div></center>

	<br><br>
	<input type="submit" name="search" title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" value="Clear <Alt+c>" tabindex="1" title="Press <Alt+c>" accesskey="c" onclick='document.getElementById("txtHint").innerHTML="";'>
	<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();">
	<hr>Suggestions: <div id="txtHint" class="ddm1"></div>
	<br><br>
	<p><h1><center><div id="waitMessage"></center></div></h1></p>
	<script type="text/javascript">
		  document.myform.orderNumber.focus();
		  //document.myform.phonenumber.focus();
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