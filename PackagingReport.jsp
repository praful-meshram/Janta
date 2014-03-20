<%@page import="packaging.ManageBreakdown"%>
<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<script src="js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="js/singleItemStock.js" type="text/javascript"></script>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
 <script type="text/javascript" src="js/PackagingReport.js"></script>
<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />

<%@ page errorPage="ReportErrorPage.jsp?page=PackagingReport.jsp" %>
<script type="text/javascript">
 function onTextFiled()
 {	
 	var count = 1;
 	var hid =document.myform.hiddenValue1.value;
	 var hid1 = document.getElementById("hid1").value; 
	alert(hid+" :: "+hid1);
	if((hid==""||hid==null)){
		alert("if  ");
		return;
	}	
	else{alert("else  ");
		document.myform.action= "PackagingReport.jsp?filter=filterData&value="+hid;
		document.myform.hiddenValue1.value="";
		count=0;
		document.myform.submit;
		
	}
 }
 
function setTheVal(valFromPopup){
  //this function will be called from the popup and the value passed in (valFromPopup).
  //Value of someElement in someForm in this page will be set to valFromPopup.
  document.myform.hiddenValue1.value=valFromPopup;
  //document.myform.hiddenValue1.focus();
}	

//window.onload = onTextFiled;
//window.onfocus = windowRefresh1;



</script> 

<center>
	<div><fieldset>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
		%>

<td width="50%" valign="top" style="font-family: arial;">
	<!-- <h2 style="float: center;">Date wise Sales Analysis Report</h2> -->
	
<form name="myform" action="PackagingReport.jsp">
<!--  <input type="text" name = "hiddenValue1" id = "hid1" value="" onblur="windowRefresh1();">  -->
<!-- <input type = "button" value="button" onclick="windowRefresh();"> -->
			<h3 align="center">Search Result</h3>
			<center>
			<div style="width: 100%; overflow-y: scroll; overflow-x: hidden;max-height: 500px;"> 
			<table style="width: 100%;border-collapse: collapse;" border=1>
			<tr style="background-color: gray; color: white; " >
			 		<th style="width: 10%;padding: 5px; color: blue" align="left">
					
						<u onclick="orderByBreakdownNumber('bd_number');">Breakdown Number</u>
						<!--  &nbsp;&nbsp;&nbsp;&nbsp; <img src="images/filter1.jpg" onclick="getPopup('bd_number');"/>  -->
						 <a href="#" onclick="getPopup('bd_number');" id="filter" title="filter data" onclick="getPopup('bd_number');"><img src="images/filter1.jpg" /></a>
						
					</th> 
											
					<th style="width: 10%; color: blue" align="left">
						<u onclick="orderByBreakdownNumber('bachka_code');">Bachka Code</u>
						<a href="#" onclick="getPopup('bachka_code');" id="filter" title="filter data"><img src="images/filter1.jpg"/></a>
					</th>
					<th style="width: 10%; color: blue" align="left">
						<u onclick="orderByBreakdownNumber('loss_in_breakdown');">Loss</u>
						<a href="#" onclick="getPopup('loss_in_breakdown');" id="filter" title="filter data"><img src="images/filter1.jpg"/></a>
					</th>
					<th style="width: 10%; color: blue" align="left">
						<u onclick="orderByBreakdownNumber('gain_in_breakdown');">Gain</u>
						<a href="#" onclick="getPopup('gain_in_breakdown');" id="filter" title="filter data"><img src="images/filter1.jpg" /></a>
					</th>
					<th style="width: 10%; color: blue" align="left" >
						<u onclick="orderByBreakdownNumber('site_id');">Site ID</u>
						<a href="#" onclick="getPopup('site_id');" id="filter" title="filter data"><img src="images/filter1.jpg"/></a>
					</th>
					<th style="width: 10%;color: blue" align="left" >
						<u onclick="orderByBreakdownNumber('bd_date');">Breakdown Date</u>
						<a href="#" onclick="getPopup('bd_date');" id="filter" title="filter data"><img src="images/filter1.jpg"/></a>
					</th>
					<th style="width: 10%;color: blue" align="left" >
						<u onclick="orderByBreakdownNumber('entered_by');">Entered By</u>
						<a href="#" onclick="getPopup('entered_by');" id="filter" title="filter data"><img src="images/filter1.jpg"/></a> 
					</th>
				</tr>
				 </table> 
			
			<div style="width: 100%;max-height: 400px;" id="tableData">
		  	 <table style="width: 100%;border-collapse: collapse;" border=1 > 
	 		<%
	 			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
	 			ResultSet rs = null;
	 			/*System.out.println("filter  :"+request.getParameter("filter"));
	 			System.out.println("filter link :"+request.getParameter("link"));
	 			 System.out.println("filter column :"+request.getParameter("column"));
	 			System.out.println("filter value :"+request.getParameter("value"));
	 			
	 				if(request.getParameter("filter")!=null){
	 					System.out.println("inside filter data :");
	 					String link = request.getParameter("link");
	 					String param = request.getParameter("column");
	 					//String value = request.getParameter("value");
	 					String value = request.getParameter("value");
	 					 
	 					//String value = javascript:document.myform.hiddenValue1.value;
	 					 
	 					System.out.println("session link :"+link);
	 					System.out.println("session param :"+param);
	 					System.out.println("session value :"+value);
	 					
		 					
	 					if(link.equals("startwith"))
		 				{	
	 						System.out.println("inside nested start :");
		 					rs = manageBreakdown.getFilteredStartData(param,value);
		 				}	
	 					else if(link.equals("contains"))
	 					{
	 						System.out.println("inside nested contains :");
		 					rs = manageBreakdown.getFilteredContainsData(param, value);
	 					}	
	 					else {
	 						System.out.println("inside nested end :");
		 					rs = manageBreakdown.getFilteredEndData(param, value);
	 					}
	 					
	 				} 
	 			else{ 
	 			System.out.println("else part..");  */
	 			
				rs = manageBreakdown.getCompleteBrekdownList();
				
	 	 	// } 
			if(rs.next())
			{
				System.out.println("data available in breakdown header ...");
				do{		
						int number = rs.getInt(1);
				%>		<tr style="background-color: #D8D8D8; cursor: pointer;"> 
						<td style="width: 10%;padding: 5px;" align="left" id = "bd">
							<%=number %>
						</td>
						<td style="width: 10%;" align="left">
							<%=rs.getString(2) %>
						</td>
						<td style="width: 10%;" align="left">
							<%=rs.getString(3) %>
						</td>
						<td style="width: 10%;" align="left">
							<%=rs.getString(4) %>
						</td>
						<td style="width: 10%;" align="left">
							<%=rs.getString(5) %>
						</td>
						
						<td style="width: 10%;" align="left">
							<%=rs.getDate(6) %>
						</td>
						<td style="width: 10%;" align="left">
							<%=rs.getString(7) %>
						</td>
											
					</tr>
				<%
					
				} while(rs.next());
			
			manageBreakdown.closeAll();
			}
			
		%>
		</div>	
		
			</table>
		 
		  
		 	
		 
		    </div> 
		
		
		 </table><center>
		 <!-- <input type="button" value="Refesh" onclick="window.location.reload();">
		  --><input type="button" value="Refesh" onclick="windowRefresh();">
		 
		<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="goHome();"/>
		
		</center></div> 		
		 </form>
	
<div id="popupContact">
	<!-- <b>Search Result </b> -->
	<a id="popupContactClose" onclick="closePopup();">x</a> 
	<br/><br/>
	<div id = "breakdown_info">
	</div>	
		
</div>
<div id="backgroundPopup"></div>

<!-- <div id="popupContact" >
	
	<a id="popupContactClose" onclick="closePopup()">x</a>
	<br/><br/> -->
	
	</div>	
</div>	

</body>
</html>




