<%@ page import="payment.*" %>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript" src="js/communication.js"></script>
<script type="text/javascript" src="js/ReceivePayment.js"></script>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
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
</script>
<style>
#div1{
	margin: 1%; 
	border: 1px solid black; 
	width: 96%; 
	padding-left: 1%; 
	padding-right: 1%; 
	height: 280px;
	border-radius: 10px;
	background-color: #BEF781;
}
#div2{
	border: 1px solid black; 
	padding: 1%; 
	max-height: 550px;
	border-radius: 10px;
	background-color: #BEF781;
	margin-left: 0.3%;
	width: 97%;"
}
#id11 tr:hover td{
background-color: #BEF781;
}
</style>
<%
	String cust_code = request.getParameter("cust_code");
	String msg = request.getParameter("msg");
	ManagePayment manage = new ManagePayment("jdbc/js");
	manage.getCustInfo(cust_code);
	if(manage.rs.next()){
%>
<center>
<table style="width: 95%; border-collapse: collapse; " cellpadding=0 cellspacing=0>
	<tr>
		<td style="width: 30%;" align="left">
			<div id="div1" >
<Font size="3pt" face="consolas"><b> Customer Detail For Communication :</b></Font><br/>
<pre style="font-family: consolas;"><b>Name    :</b><%= manage.rs.getString(1) %>  <b>Phone : </b> <%= manage.rs.getString(9)+", "+ manage.rs.getString(10) %>
<b>Address :</b><%= manage.rs.getString(2)+" Building,"+manage.rs.getString(3)+" Block,"%>
         <%=manage.rs.getString(4)%><%=" Wing," %><%= manage.rs.getString(5)+","+manage.rs.getString(6)%>
         
<b>Station :</b><%= manage.rs.getString(7) %></pre>
<%
	}
	manage.closeAll();
%>
				<form name="myform" action="saveCommunication.jsp" method="post">
				<table style="width: 100%; border-collapse: collapse;" cellpadding=0 cellspacing=0>
					<tr>
						<td style="width: 30%; font-family: consolas;" align="right"> Subject :</td>
						<td style="width: 60%;"><input type="text" name="comm_subject" style="width: 95%;" id="comm_subject_id" value=""/></td>
						<td rowspan="3" style="width: 10%;" valign="bottom">
							<input type="submit" value="Save" style="width: 100%;" onclick=" return validate()"/>
							<input type="reset" value="Clear"/>
						</td>
					</tr>
					<tr>
						<td style="width: 30%; font-family: consolas;" valign="top" align="right"> Commit date :</td>
						<td style="width: 60%;">
							<input type ="text" accesskey="d" name="c_date" size="15" style="width: 79%;" id="c_date_id" readonly="readonly"/>
							<input type="button" onClick="c1.popup('c_date');" value="..." style="width: 15%;"/>
						</td>
					</tr>
					<tr>
						<td style="width: 30%; font-family: consolas;" valign="top" align="right"> Feedback :</td>
						<td style="width: 60%;">
							<textarea name="comm_feedback" style="width: 95%;" rows="3" id="comm_feedback_id"></textarea>
							<input type="hidden" name="cust_code" value="<%=cust_code%>" id="cust_code_id"/>
						</td>
					</tr>
					
				</table>
				</form>
				<br/>
			</div>
		</td>
		<td style="width: 35%;" align="left" >
			<div id="div1">
			<%
				ManagePayment manage1 =  new ManagePayment("jdbc/js");
				manage1.getCommHistory(cust_code);
				if(manage1.rs1.next()){
					%>
					<font size="3pt" face="consolas"><b>Communication History :</b></font>
					<div style="width: 100%; overflow-y:scroll;max-height: 60px;">
						<table style="width: 96%;float: right;" border=1 cellpadding=0 cellspacing=0>
							<tr>
								<th style="width: 20%;">Date</th>
								<th style="width: 15%;">Con By</th>
								<th style="width: 20%;">Commitment</th>
								<th style="width: 45%;">Feedback</th>
							</tr>
						</table>
					</div>
					<div style="width: 100%; overflow-y:scroll; max-height: 150px;">
						<table id="id11" style="width: 96%;float: right; border-collapse: collapse;" border=1 cellpadding=0 cellspacing=0>
					<%
					int cnt=0;
					do{
						if(cnt%2==0){
						%>
						<tr style="width: 100%;background-color:#ECFBB9;">
						<%
						} else {
						%>
						<tr style="width: 100%;background-color:#ECFB99;">
						<%
						}
						%>
							<td style="width: 20%;"><%=manage1.rs1.getDate(6) %></td>
							<td style="width: 15%;"><%=manage1.rs1.getString(5) %></td>
							<td style="width: 20%;"><%=manage1.rs1.getString(7)%></td>
							<td style="width: 45%;"><%=manage1.rs1.getString(4) %></td>
						</tr>
						<%	
						cnt++;
					}while(manage1.rs1.next());
					%>
						</table>
					</div>
					<%
				}else{
					out.print("<h3> No Previous communication history</h3>");
				}
				manage1.closeAll();
			%>
			</div>
		</td>
		<td style="width: 30%;" align="left" >
			<div id="div1">
			<%
			manage = new ManagePayment("jdbc/js");
			manage.getRecentPaymentDetail(cust_code);
			%>
			<font size="3pt" face="consolas"><b>Payment History :</b></font>
			<div style="width: 100%; overflow-y:scroll;max-height: 60px; overflow-x: hidden; ">
				<table style="width: 96%;float: right;border-collapse: collapse;" border=1 cellspacing=0 cellpadding=0>
					<tr style="width: 100%;">
						<th style="width: 33%;">Date</th>
						<th style="width: 33%;">Amount</th>
						<th style="width: 33%;">Rec By</th>
					</tr>
				</table>
			</div>
			<div style="width: 100%; overflow-y:scroll; max-height: 150px; overflow-x: hidden;">
						<table id="id11" style="width: 96%;float: right; border-collapse: collapse;" border=1 cellspacing=0 cellpadding=0>
			<%
			int count = 0;
			if(manage.rs.next()){
			do{
				if(count%2==0){
					%>
						<tr style="width: 100%;background-color:#ECFBB9;">
					<%
					}else{
					%>
						<tr style="width: 100%;background-color:#ECFB99;">
					<%
					}
				%>
						<td style="width: 33%;padding-left: 10px;" align="left" onclick="loaadDetailSinglePayment1('<%=manage.rs.getString(2)%>','<%= manage.rs.getString(4) %>','<%= manage.rs.getString(7) %>','<%= manage.rs.getDate(6) %>');">
							<font color=blue style="cursor: pointer;">
								<u><%= manage.rs.getDate(6) %></u>
							</font>
						</td>
						<td style="width: 33%;padding-left: 10px;" align="left"><%= manage.rs.getString(4) %>&nbsp;Rs.</td>
						<td style="width: 33%;padding-left: 10px;" align="left"><%= manage.rs.getString(7) %></td>
					</tr>
				
			<%
			count++;
			}while(manage.rs.next());
			}else{
			%>
			<tr style="width: 100%;background-color:#ECFBB9;"><td colspan="3">No Previous Payment</td></tr>
			<%
			}
			%>
			</table>
			</div>
			<%
			manage.closeAll();
			%>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<div id="div2"></div>
		</td>
	</tr>
</table>
<div id="baseDiv" style="top: 0px;">
		<div id="popupItemDiv"
			style="max-height: 400px; width: 60%; border: 2px solid black; background-color: #BEF781; 
			 display: none; font-size: 100%; margin: 150px 0px 0px 250px;overflow-y: auto;">
			 <div style="float: right; width: 20px;height: 20px; overflow: auto; cursor: pointer;" onclick="funCloseDiv()">
			 <img  src="images/close.png"/>
			 </div>
			 <div id="order_detail_popup" style=" width:100%; max-height: 89%;margin-top: 5%; overflow: auto; font: consolas;"></div>
			 <br/>
		</div>
</div>
<script type="text/javascript">
	window.onload = showHint('<%=cust_code%>');
</script>
