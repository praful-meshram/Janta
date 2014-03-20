<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewItem.jsp" />	
</jsp:include>
  --%>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>



<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewDeliveryStaffForm.jsp" />	
</jsp:include>   
 
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=NewItem.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 

<script language="javascript" src="js/codethatcalendarstd.js"></script
<script language="javascript" src="js/date_validation.js"></script>
<script type="text/javascript">
   	var flag=true;
   	var checkRecord=false;
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
  

<%@page contentType="text/html"%>

<%
		String backPage="";        		
        backPage=request.getParameter("backPage");
		
		float i_mrp =0.0f;
		float i_rate =0.0f;
		float id_qty =0.0f;
		float id_amt =0.0f;	
		float i_comm =0.0f;	
		
		String ig_code="";
		String i_name="";	
		String i_barcode = "";
		String i_weight ="";
		String id_flag="";
		String id_type="";
		int box_qty;
		String query="";
		String query1="";
		String get1="";
		String itemcode="";
		String item_type;
		int siteId = Integer.parseInt(session.getAttribute("GlobalSiteId").toString());
		ig_code=request.getParameter("iGroupCode");
		i_name=request.getParameter("i_name");
		i_barcode=request.getParameter("i_barcode");
		i_weight=request.getParameter("i_weight");
		i_mrp=Float.valueOf(request.getParameter("i_mrp"));
		i_rate=Float.valueOf(request.getParameter("i_rate"));
		i_comm=Float.valueOf(request.getParameter("i_comm"));	
		id_type=request.getParameter("iDealType");
		System.out.print("'"+request.getParameter("box_qty")+"'");
		box_qty=Integer.parseInt(request.getParameter("box_qty"));
		item_type=request.getParameter("item_type");
		if (!id_type.equals("")){
		    id_flag="Y";
			id_qty=Float.valueOf(request.getParameter("id_qty"));
			id_amt=Float.valueOf(request.getParameter("id_amt"));
		}
		else{
		  id_flag ="N";
		  id_type="";
		  id_qty =0;		 
		  id_amt =0;			  
		}
			
		item.ManageItem mi;
		mi = new item.ManageItem("jdbc/js");
		System.out.println("i_weight "+i_weight);
		int chk1 = mi.CheckItem(ig_code,i_name,i_weight);
		System.out.println("check "+(chk1==1));
		if(chk1 ==2){
			System.out.println("check insert ");
			
			int ans = mi.addItem(ig_code,i_name,i_barcode,i_weight,i_mrp,id_type,id_flag,id_qty,id_amt,i_rate,i_comm,siteId,box_qty,item_type);
    		if(ans==1){
    			out.println("<center><h3><b>Sucessfully Created Item<font color=blue>  "+i_name+"  <a href=\"NewItemForm.jsp\">   Create New Item</a> </center></b></h3>");
		
    		}
		}else if(chk1==1){
			System.out.println("check exist ");
			out.println("<center><h3>Record already exist</h3>	<h3><b><a href=\"NewItemForm.jsp?Exp=1\">Create New Item</a> </center></b></h3>");
			

		}else{
			out.println("<h3><b><center> Sucessfully Created Item<font color=blue>"+i_name+"<a href=\"NewItemForm.jsp\">   Create New Item</a> </center></b></h3>");
	}
		mi.closeAll();  	
%>   


 	