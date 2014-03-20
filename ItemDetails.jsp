<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ItemDetails.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=ItemDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script language="javascript" src="js/ItemDetails.js"></script>

<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>
<script type="text/javascript">
var price;
var margin;
var finalPrice;
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
var cashDiscountFlag=0;
function checkField(){
	var d = new Date();
	var curr_hour = d.getHours();
	var curr_min = d.getMinutes();
	var curr_sec = d.getSeconds();
	//alert(curr_hour + " : " + curr_min + " : "+curr_sec);
	//alert(time);
	
	var c_date1 = document.myform.c_date1.value ;
	if(c_date1!="") {	
		var str = "";
		str = str + document.myform.c_date1.value ;
		//str = str + document.myform.frMonth.value;	
		if (validateIndiaDate(str) == false){
			alert("Please enter a valid Create_date1 Date");
			return false;
		}
		//alert(c_date1);				
		document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
		                                document.myform.c_date1.value.substring(3,5) +
		                                "-" + document.myform.c_date1.value.substring(0,2) ;
		document.myform.c_date1.value=document.myform.c_date1.value+" "+curr_hour + ":" +curr_min+":"+curr_sec;                                
		//alert( document.myform.c_date1.value);                               
	}	
		 		 		    
}
function showMsg(){
 	 document.myform.action="HomeForm.jsp";
	 document.myform.submit();
}

function checkPurchasePrice(){
	if(document.myform.i_pp.value==""){
		alert("please enter purchase price");	
		document.myform.i_pp.focus();
		return false;	
	}
}
function checkPrice(){
	if(eval(document.myform.l_qty.value)==0){
		alert("landing qty should be greater than zero");
		document.myform.l_qty.value="";	
		document.myform.l_qty.focus();
		return false;	
	}
	if(!document.myform.scheme_code.options[0].selected){
		if(document.myform.scheme_val.value!="0"){
			calculatePrice();
			calculateFinalPrice();
			calculateTotalPrice();
		}
	}
}
function checkCashDiscount(){
	document.myform.vat_code.value =0;
	document.myform.cd_price.value="";
	document.myform.final_price.value="";
	calculateCashDiscountPrice();
}
function calculatePrice(){
	if(document.myform.scheme_code.options[0].selected){
		alert("please choose scheme");
		document.myform.scheme_code.focus();
		return false;
	}
		
	for (i=0;i<document.myform.scheme_code.options.length;i++){
		if (document.myform.scheme_code.options[i].selected){
			if (document.myform.l_qty.value=="" && document.myform.scheme_code.options[i].value!="4"){
				alert("please enter landing quantity ");
				document.myform.l_qty.focus();	
				return false;
			}
		}		
		if (document.myform.scheme_code.options[i].selected){
			if (document.myform.scheme_code.options[i].value=="1"){
				price=(document.myform.i_pp.value*document.myform.l_qty.value)/((eval(document.myform.l_qty.value)+eval(document.myform.scheme_val.value)));
				document.myform.price.value=price;
			}
			else if (document.myform.scheme_code.options[i].value=="2"){
				price=eval(document.myform.i_pp.value)-(eval(document.myform.i_pp.value)*(eval(document.myform.scheme_val.value)/100));
				document.myform.price.value=price;
			}
			else if (document.myform.scheme_code.options[i].value=="3"){
				price=((document.myform.i_pp.value*document.myform.l_qty.value)-document.myform.scheme_val.value)/document.myform.l_qty.value;
				document.myform.price.value=price;
			}
			else if (document.myform.scheme_code.options[i].value=="4"){
				document.myform.price.value=document.myform.i_pp.value;
			}
					
		}	
	}	
	//calculateCashDiscountPrice();
	if (document.myform.cd_price.value!=""){
		calculateCashDiscountPrice();
	}	
	if(!document.myform.vat_code.options[0].selected==true){
		 calculateFinalPrice();
	}
	if(document.myform.p_qty.value!="" && document.myform.final_price!=""){
		calculateTotalPrice();
	}	
	document.myform.vat_code.focus();
}		
function calculateFinalPrice(){
	if(document.myform.cash_discount.value==""){
		document.myform.cd_price.value=document.myform.price.value;
	}	
	if(document.myform.vat_code.options[0].selected){
		document.myform.final_price.value="";
	}	
	if(document.myform.vat_code.value != "0"){
		var vatPrice =  document.forms[0].vat_code.options[document.forms[0].vat_code.selectedIndex].text;
		finalPrice=eval(document.myform.cd_price.value)+ ((eval(vatPrice)/100)*eval(document.myform.cd_price.value));
		document.myform.final_price.value=finalPrice;		
	}
	if(document.myform.p_qty.value!=""){
		calculateTotalPrice();
	}	
}
function calculateCashDiscountPrice(){
	if(document.myform.scheme_code.options[0].selected){
		alert("please choose scheme");
		document.myform.scheme_code.focus();
		return false;
	}
	
	for (i=0;i<document.myform.scheme_code.options.length;i++){
		if (document.myform.scheme_code.options[i].selected){
			if (document.myform.l_qty.value=="" && document.myform.scheme_code.options[i].value!="4"){
				alert("please enter landing quantity ");
				document.myform.l_qty.focus();	
				return false;
			}
		}		
		if (document.myform.scheme_code.options[i].selected){
			if (document.myform.scheme_code.options[i].value=="1"){
				price=(document.myform.i_pp.value*document.myform.l_qty.value)/((eval(document.myform.l_qty.value)+eval(document.myform.scheme_val.value)));
				
				if(document.myform.cash_discount.value=="" || document.myform.cash_discount.value=="0"){		
					document.myform.cd_price.value=price;
				}
				else{
					document.myform.cd_price.value=price-(eval(document.myform.cash_discount.value)/100*price);
				}	
			}
			else if (document.myform.scheme_code.options[i].value=="2"){
				price=eval(document.myform.i_pp.value)-(eval(document.myform.i_pp.value)*(eval(document.myform.scheme_val.value)/100));
				if(document.myform.cash_discount.value=="" || document.myform.cash_discount.value=="0"){		
					document.myform.cd_price.value=price;
				}
				else{
					document.myform.cd_price.value=price-(eval(document.myform.cash_discount.value)/100*price);
				}	
			}
			else if (document.myform.scheme_code.options[i].value=="3"){
				price=((document.myform.i_pp.value*document.myform.l_qty.value)-document.myform.scheme_val.value)/document.myform.l_qty.value;
				if(document.myform.cash_discount.value=="" || document.myform.cash_discount.value=="0"){		
					document.myform.cd_price.value=price;
				}
				else{
					document.myform.cd_price.value=price-(eval(document.myform.cash_discount.value)/100*price);
				}	
			}
			else if (document.myform.scheme_code.options[i].value=="4"){
				if(document.myform.cash_discount.value=="" || document.myform.cash_discount.value=="0"){		
					document.myform.cd_price.value=document.myform.i_pp.value;
				}
				else{
					document.myform.cd_price.value=eval(document.myform.i_pp.value)-eval(document.myform.cash_discount.value)/100*eval(document.myform.i_pp.value);
				}
								
			}
					
		}	
	}	
	document.myform.vat_code.focus();
}		

function calculateTotalPrice(){
	if(eval(document.myform.p_qty.value)==0){
		alert("purchase quantity should be greater than zero");
		document.myform.p_qty.value="";
		document.myform.p_qty.focus();
		return false;
	}	
	if(document.myform.final_price.value!=""){
		document.myform.total_price.value=eval(document.myform.p_qty.value)*eval(document.myform.final_price.value);
	}
	else{
		alert("please firstly calculate final price");
		document.myform.total_price.value;
		return false;
	}
}					
function validate(){
	var qty_flag=0,scheme_val_flag=0;
	for (i=0;i<document.myform.scheme_code.options.length;i++){
		if (document.myform.scheme_code.options[i].selected && document.myform.scheme_code.options[i].value=="4"){
			qty_flag=1;
			scheme_val_flag=1;
		}
	}	
	if(document.myform.i_pp.value==""){
		alert("Please enter purchase price");
		return false;
	}
	else if(qty_flag=="0" && document.myform.l_qty.value==""){	
			alert("please enter landing quantity ");
			return false;
	}
	else if(document.myform.scheme_code.options[0].selected){
			alert("please choose scheme");
			return false;
	}	
	else if (scheme_val_flag=="0" && document.myform.scheme_val.value==""){
		alert("please enter scheme value");
		return false;
	}
	else if (document.myform.vat_code.options[0].selected){
		alert("please choose vat");
		return false;
	}
	else if(document.myform.price.value==""){
		alert("please enter values which manipulate price");
			return false;
	}
	else if(document.myform.final_price.value==""){
		alert("please enter values which manipulate final price");
			return false;
	}
	else if(document.myform.p_qty.value==""){
		alert("please enter purchase quantity");
		return false;
	}
	checkField();
	
}					
			
</script>		
<form name="myform" method="post" action="SaveItemPurchaseDetails.jsp">
<%	
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/js");
	int scheme_code=0,vat_code=0;
	String scheme_desc=null,vat_desc=null,sysDate=null;
	float vat_value;
	String icode=request.getParameter("icode");
	String igcode=request.getParameter("igcode");
	String iname=request.getParameter("iname");
	String iweight=request.getParameter("iweight");
	String imrp=request.getParameter("imrp");
%>		
	<table border="0" align="center">
		<tr>
		    <td><b>Item <Font color="blue">C</font>ode</b></td><td><input type="textbox"  style="border:0px solid #000000;" accesskey="c" name="i_code" value="<%=icode%>" readOnly ></td>
			<td><b>Item <Font color="blue">G</font>roup</b></td><td><input type="text" style="border:0px solid #000000;" accesskey="g" name="ig_code" value="<%=igcode%>" readOnly></td>
		</tr>
		<tr>	
			<td><b>Item <Font color="blue">N</font>ame</b></td><td><input type="text" style="border:0px solid #000000;" accesskey="n" name="i_name" size="35" value="<%=iname%>" readOnly ></td>
			<td><b>Item <Font color="blue">W</font>eight</b></td><td><input type="text" style="border:0px solid #000000;" accesskey="n" name="i_weight" value="<%=iweight%>" readOnly ></td>
		</tr>
		
 		<tr>	
			<td><b>M<Font color="blue">R</font>P</b></td><td colspan="3"><input type="text" style="border:0px solid #000000;" accesskey="r" name="i_mrp" size="5" value="<%=imrp%>" readOnly></td>
			
		</tr>
		<tr >	
			<td><b>Purchase<Font color="blue">P</font>rice</b></td><td colspan="3"><input type="text" accesskey="p" name="i_pp" size="5"   onBlur="checkPurchasePrice();return false;" onChange="calculateMargin();"></td>
			
		</tr>
		<tr >	
			<td><b>Ma<Font color="blue">r</font>gin %</b></td><td colspan="3"><input type="text" style="border:0px solid #000000;" accesskey="r" name="i_margin" size="5" readOnly></td>
			
		</tr>
	</table>
	<hr>
	<table border="0" align="center">
		<tr>
		<td>
 			<fieldset><legend><font color="blue"><b>Landing Prices</b></font></legend>
  			<table>
		  		<tr>
		  			<td><b>Qty:</b></td><td><input type="text" size="5" name="l_qty"   onClick="return checkPurchasePrice();" onKeyUp="checkPrice();return false;"></td>
		  		</tr>	
		  		<tr>
		  			<td><b>Scheme:</b></td>
					<td><SELECT name="scheme_code"  onChange="checkScheme();">
							<OPTION VALUE="0">SELECT</OPTION>
<%
	try{
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select scheme_code,scheme_desc from scheme");
		while(rs.next()){
			scheme_code=rs.getInt(1);
			scheme_desc=rs.getString(2);
%>		  			
	
					<OPTION VALUE="<%=scheme_code%>"><%=scheme_desc%>
<%	
		}
		rs.close();
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
			</SELECT></td>
			<td>
			<input type="text" size="5" name="scheme_val" value="" onChange="calculatePrice();" >
			</td></tr>
			<tr><td><b>Price:</b></td>
				<td><input type="text" style="border:0px solid #000000;" name="price" readOnly ></td>
			</tr>
			<tr><td><b>Cash Discount % :</b></td>
					<td><input type="text" name="cash_discount"  value="" onBlur="checkCashDiscount();" ></td>
			</tr>
			<tr><td><b>Price After Cash Discount:</b></td>
				<td><input type="text" style="border:0px solid #000000;" name="cd_price" readOnly ></td>
			</tr>
			<tr><td><b>VAT:</b></td>
				<td><SELECT name="vat_code" onClick="return checkPurchasePrice();" onChange="calculateFinalPrice()";>
						<OPTION VALUE="0">SELECT</OPTION>
<%
	try{
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select vat_code,vat_value,vat_desc,date_format(sysdate(),'%d/%m/%Y') from vat");
		while(rs.next()){
			vat_code=rs.getInt(1);
			vat_value=rs.getFloat(2);
			vat_desc=rs.getString(3);
			sysDate=rs.getString(4);
		
%>		  			
	
					<OPTION VALUE="<%=vat_code%>"><%=vat_value%>
<%	
		}
		rs.close();
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
			</SELECT></td></tr>			
	<tr><td><b>Final Price :</b></td>
		<td><input type="text" style="border:0px solid #000000;" name="final_price" size="5" readOnly></td></tr>
	</table></fieldset>
	</td>
	<td>
 		<fieldset><legend><font color="blue"><b>Purchase Details</b></font></legend>
  			<table>
		  		<tr>
		  			<td><b>Qty:</b></td><td><input type="text" size="5" name="p_qty" onChange="calculateTotalPrice();"></td>
		  		</tr>
		  		<tr>
		  			<td><b>Date:</b></td><td><input type="text" name="c_date1" value="<%=sysDate%>" size="20"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td>
				</tr>
				<tr><td><b>Total Price:</b></td>
				<td><input type="text" name="total_price" style="border:0px solid #000000;" size="5" readOnly></td>
			</tr>	
		  	</table>
		  	</fieldset>
	</td>
	</tr>	  			
</table>	
<center><input type="submit" name="Submit" value="Submit" accesskey="s" onclick=" return validate(); " >

	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" >
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">	
<hr>
<div id="txtHint" class="ddm1"></div>	

<script>
window.onload=showHint;
function calculateMargin(){
	if(document.myform.i_pp.value==""){
		document.myform.i_margin.value="";
	}	
	if(eval(document.myform.i_pp.value)==0){
		document.myform.i_pp.value="";
		alert("purchase price should not be zero");
		document.myform.i_pp.focus();
		return false;
	}
	else{	
		margin=((document.myform.i_mrp.value-document.myform.i_pp.value)*100)/document.myform.i_mrp.value;
		document.myform.i_margin.value=margin;
		document.myform.l_qty.value="";
		document.myform.scheme_code.options[0].selected=true;
		document.myform.scheme_val.value="";
		document.myform.price.value="";
		document.myform.cash_discount.value="";
		document.myform.cd_price.value="";
		document.myform.vat_code.options[0].value=0;
		document.myform.final_price.value="";
		document.myform.p_qty.value="";
		document.myform.c_date1.value="<%=sysDate%>";
		document.myform.total_price.value="";
		document.myform.l_qty.focus();	
	}
	
}
function checkScheme(){
	
	for (i=0;i<document.myform.scheme_code.options.length;i++){
		
		if (document.myform.scheme_code.options[i].selected && document.myform.scheme_code.options[i].value=="4"){
			document.myform.l_qty.value="";
			document.myform.scheme_val.value="";
			document.myform.l_qty.disabled=true;
			document.myform.scheme_val.disabled=true;
			document.myform.vat_code.options[0].selected="true";
			document.myform.final_price.value="";
			calculatePrice();
		}
		else if(document.myform.scheme_code.options[i].selected && document.myform.scheme_code.options[i].value!="4"){
			if(document.myform.l_qty.disabled==true){
				document.myform.l_qty.disabled=false;
			}
			if(document.myform.scheme_val.disabled==true){
				document.myform.scheme_val.disabled=false;
			}	
			document.myform.scheme_val.value="";
			document.myform.price.value="";
			document.myform.vat_code.options[0].selected="true";
			document.myform.final_price.value="";
			document.myform.cash_discount.value="";
			document.myform.cd_price.value="";
			document.myform.p_qty.value="";
			document.myform.c_date1.value="<%=sysDate%>";
			document.myform.total_price.value="";
		}	
			
	}			
}	
//document.myform.i_pp.focus();
</script>													