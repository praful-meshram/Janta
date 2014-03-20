<%@ page import="payment.ManagePayment"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Hashtable" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="cust_orderBill.jsp" />	
</jsp:include>

<%@ page contentType="text/html"%>

    <script src="js/custOrderSummDetails.js"></script> 	
	<link rel="stylesheet" type="text/css" href="stylesheet/menu.css" />
<style type="text/css">
	hr {
		color: gray;
		height: 3px;
	}
	body {
		font-family: Lucida Grande, Arial, sans-serif;
		font-size: 10px;
		text-align: center;
		margin: 0;
		padding: 0;
		color: black;		
	}	
	table
	{
		border: 1px;		
		font-size: 10px;
	}
	tr,
	{
		vertical-align: top;
		height:5px;
	}
	th
	{
		text-align: left;
		background-color:#FFE4C4
	}
	th,
	td
	{
		padding: 0px;
		font-family: Lucida Grande, Arial, sans-serif;
		font-size: 1.2em;
		height: 5px;		
	}	
	a {
		font-weight: bold;
		text-decoration: none;
		color: #f30;
	}
	INPUT{ 
		height: 16px;
	    font-size:9px;  
	    line-height: 9px; 
	}
	input.button{ 
		height: 20px;
	    font-size:20px;  
	    line-height: 20px;
	}	
	a:hover {
		color: #fff;
		background-color: #f30; 
	}	
	#content h1 {
		font-size: 1.6em;
		border-bottom: 1px solid #ccc;
		padding: 5px 0 5px 0;
	}

	#content h2 {
		font-size: 1.2em;
		margin-top: 3em;
	}
</style>			
	
	
<%  String user=(String)session.getAttribute("UserName");
	String custCode="";
  	custCode=request.getParameter("hcuscode");  	
	String backPage="";
  	backPage=request.getParameter("backPage");
	String area="";
  	area=request.getParameter("harea");
  	String add1="";
  	add1=request.getParameter("hadd1");
  	String add2="";
  	add2=request.getParameter("hadd2");
	String siteId="";
	siteId=request.getParameter("hsiteId");
	String siteName="";
	siteName=request.getParameter("hsiteName");
  	String CustName="",CustPhone="";
  	if(request.getParameter("hcustname")!=null){
  		CustName=request.getParameter("hcustname");
  	}
  	if(request.getParameter("hcustphone")!=null){
  		CustPhone=request.getParameter("hcustphone");
  	}
  	
  	String n_msg="",query="";
    Connection conn=null;
	Statement stmt=null;
	
	String url1="";
	String username1="";
	String password1="";
	try {		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		url1 = (String) envContext.lookup("url");		
		username1 = (String) envContext.lookup("username");	
		password1 = (String) envContext.lookup("password");		
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		//System.out.print(url1+"  "+username1+"  "+password1);
	} catch(Exception e){
		System.out.println("Error : "+e);
	}
  	ManagePayment mp = new ManagePayment("jdbc/js");
  	float total_balance = mp.getTotalBalane(custCode);
  	mp.closeAll();

 %>

<form name="myform" method="post" class="ddm1" >
 <center><h4>Enter Order Details</h4></center>
 
 	<b><font color="blue">Order Date : </font></b><input type="text" name="Firstfocus" value=""  size="20" >
 	
  	<br>
 	<hr>
 	<table >
 	 <tr>
 	  <td><b>Site Name :</b></td>
 	  <td style="color:blue"><%=siteName%></td>
 	  <td><b>Customer Code :</b></td>
 	  <td style="color:blue"><%= custCode %></td>
 	  <td>&nbsp;<b>Customer Name :</b></td>
 	  <td style="color:blue"><%= CustName %></td>
 	  <td>&nbsp;<b>Customer Phone :</b></td>
 	  <td style="color:blue"><%= CustPhone %></td>
 	  <td>&nbsp;<b>Total Balance :</b></td>
 	  <td style="color:red;"><u id="balance"><%= total_balance %></u> /- Rs.</td>
 	 </tr>
 	</table>
 	
 	<center>
	<table border="1" align="center">
 	<tr><td colspan=5> 	   
	<table id="ItemTable" border="1" align="center" width="960" height=10 >	
	
	<!-- JSP plugin-->
	<jsp:plugin type="applet" code="applet.CustomerOrderApplet.class" codebase="applet/classes/" archive="mysql-connector-java-5.1.10-bin.jar" name="order"   width="100%" height="300">
	  <jsp:params>
	          
	          <jsp:param
	               name="dburl"
	               value="<%=url1%>"
	          />
	           
	           <jsp:param
	               name="dbusername"
	               value="<%=username1%>"
	          /> 
	       
	           <jsp:param
	               name="dbpassword"
	               value='<%=password1%>'
	          />
	          <jsp:param
	               name="customerCode"
	               value="<%=custCode%>"
	          />
	          <jsp:param
	               name="user"
	               value="<%=user%>"
	          />
	          <jsp:param
	               name="backPage"
	               value="<%=backPage%>"
	          />
	          <jsp:param
	               name="siteId"
	               value="<%=siteId%>"
	          />
		      
	     </jsp:params>

	     <jsp:fallback>
	          <B>Unable to start plugin!</B>
	     </jsp:fallback>
	  
	    

	</jsp:plugin>
	
	
	<!-- applet tag 
	<applet code="applet.CustomerOrderApplet.class" codebase="applet/classes/" 
			archive="mysql-connector-java-5.1.10-bin.jar"
			name="order"  id="orderApp" width="100%" height="300">
	</applet>
	-->
	<input type="hidden" name="horderNo" value="">
	<input type="hidden" name="horderDate" value="">
	<input type="hidden" name="htotalSel">
	<input type="hidden" name="hidCount">
	<input type="hidden" name="htotOrderValue">
	<input type="hidden" name="htotMRPValue">
	<input type="hidden" name="htotPickup" value="0">
	<input type="hidden" name="cusCode" value="<%=custCode%>"> 
	
	<input type="hidden" name="hcuscode" value="<%=custCode%>">
	<input type="hidden" name="hadd1" value=<%=add1%>"">
	<input type="hidden" name="hadd2" value="<%=add2%>">
	<input type="hidden" name="harea" value="<%=area%>">
	<input type="hidden" name="hsiteId" value="<%=siteId%>">
	<input type="hidden" name="hsiteName" value="<%=siteName%>">
	<tr><td>	
	
	<input type="hidden" name="backPage" value="<%=backPage%>">
	<input type="hidden" name="huser" value="<%=user%>">
	
	</td></tr>
	
	</table><br><br>
	<center><hr>
	<table align="right" width="48%">
	 <tr>
	  <td>
	   <div id="txtHint" class="ddm1" >	</div>
	   </td>
	 </tr>
	</table>
	
	<div id="txtHint1" class="ddm1" align="left">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
		   		
	</form>
	</body>
	
	<script type="text/javascript">	
		var newdate = new Date();
		var day= ""+newdate.getDate();
		if(day.length==1)
			day="0"+day;
		var month = ""+(newdate.getMonth()+1);		
		if(month.length==1)
			month="0"+month;
		var year  = newdate.getYear();	
		
		function showTime(){	
			var newTime = new Date();		
			var h=newTime.getHours();
			var m=newTime.getMinutes();
			var s=newTime.getSeconds();
			// add a zero in front of numbers<10
			m=checkTime(m);
			s=checkTime(s);					
			var currenttime	= h+":"+m+":"+s;	
			newdate = day +"/"+ month + "/"+year+", "+currenttime;			
			document.myform.Firstfocus.value= newdate;
			var t= setTimeout("showTime();",1000);
		}
		
		function checkTime(i)
		{
		if (i<10)
		  {
		  i="0" + i;
		  }
		return i;
		}	
		
		//document.myform.Firstfocus.focus();			
		var allowBackspace = false;		
		document.onkeydown = checkKey;
		
		function checkKey() {
			var key = event.keyCode;
			
			if (key==8) {
			if (allowBackspace==false) {
					return false;
				}
				else 
				{
					return true;						
				}
			}
		}
				
		
		window.onbeforeunload = setValue;
	
		window.onload = showTimeFirst();
		function SetFocusOnApplet(){
			
			_showHint1();
			
			//showTime();	
	
		}	
		function showTimeFirst(){
			showTime();
			SetFocusOnApplet();
			
			//callApplet();
		}
		function callApplet(){
			//document.order.focus();
			//var obj = document.order;
			//document.order.selectDefault()
			//alert("" +document.order.selectDefault());
			//
			//alert("2 "+orderApp.selectDefault())
			document.getElementById("orderApp").selectDefault();
		}
		
		function Pass(add1,add2,cuscode,area){		
			var user1 = document.myform.huser.value;
	        var back = document.myform.backPage.value;			
			document.order.start();
		    document.order.assignVar(cuscode, user1, back);
			
			document.myform.hcuscode.value = cuscode;  
		    document.myform.hadd1.value = add1;
	        document.myform.hadd2.value = add2;
	        document.myform.harea.value = area;		    	
			showHint1();
			
		}
			
		function setValue(){			
			opener.parent.childWin = null;			
		}
	function showMsg(){		
		if(window.opener && !window.opener.closed){				
				opener.parent.document.myform.custCode.focus();
		}else{
				alert("Parent window is closed, Please Login again & then create order!");
				self.close();
		}   	   	
	}	
	function dialogBox(){		
		var yourstate=window.confirm("You have not selected any customer, please go to main page to select customer record")
		if (yourstate) {
			showMsg();			
		}
		
	}

	
	 /* document.onkeydown = function(){
		  alert('key pressed '+document.order);
		  document.order.focus();
	  } */
	 

</script>	
	
	</html>