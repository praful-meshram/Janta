<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.DelivaryReportOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>


	<!-- files for JqxWidget grid  -->
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
	<link rel="stylesheet" href="js/jqwidgets/styles/jqx.ui-redmond.css" type="text/css" />
	
    <script type="text/javascript" src="js/jqwidgets/gettheme.js"></script>
	<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxcalendar.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.pager.js"></script>
     <script type="text/javascript" src="js/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdropdownlist.js"></script>
	<script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 	
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script> 	
	 <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>


<%@ page errorPage="ReportErrorPage.jsp?page=RDeliveryDailyReportSummary.jsp" %>
	<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

<%
	String str1 = "", pageName = "RDelivery", pageType = "Summary", closeResult = "";
	str1 = request.getParameter("Exp");
	closeResult = request.getParameter("closeresult");
	if(str1.equals("1")) {
		response.setContentType("application/vnd.ms-excel");
	} else {
		response.setContentType("text/html");
%>
<style>
#id1 {
	width: 80%;
	border-collapse: collapse;
	font-family: arial;
}
a:link {
	color: blue
}

a:hover {
	background: blue;
	color: white
}

a:active {
	background: blue;
	color: white
}
form{
	font-family: arial;
}
</style>
<center>
	<%
		}
	%>
	<form name="myform" method="post">
		<%
			DecimalFormat df = new DecimalFormat("###,###.00");
			int count = 0;
			report.ManageReports c;
			//c = new report.ManageReports("jdbc/js");
			c = new report.ManageReports("jdbc/re");
			String hchckall = "";
			hchckall = request.getParameter("hchckall");
			String criteria = "";
			String order_date = "";
			int total_orders = 0;
			int grand_total_orders = 0;

			float total_value = 0.0f, expected_value = 0.0f, total_expected = 0.0f;
			float total_change = 0.0f, grand_total_expected = 0.0f;
			float total_paid = 0.0f, total_other_amt = 0.0f, total_collected = 0.0f;
			float total_diff = 0.0f;

			float grand_total_value = 0.0f;
			float grand_total_change = 0.0f;
			float grand_total_paid = 0.0f, grand_total_other_amt = 0.0f, grand_total_total_collected = 0.0f;
			float grand_total_diff = 0.0f;

			if (hchckall.equals("1")){
				System.out.println(" ppp  c_date1111 ");
				c.listDeliveryDailyReportSummary();
				criteria = "All";
			} else {
				String c_date1 = "";
				String c_date2 = "";

				c_date1 = request.getParameter("c_date1");
				c_date2 = request.getParameter("c_date2");
				
				System.out.println(" ppp  c_date1 "+c_date1);
				System.out.println("c_date2 "+c_date2);
				
				criteria = c_date1 + " to " + c_date2;
				c.listDeliveryDailyReportsWithDateSummary(c_date1, c_date2);
		%>

		<input type="hidden" name="c_date1" value="<%=c_date1%>"> 
		<input type="hidden" name="c_date2" value="<%=c_date2%>">

		<%
			}
		%>
		<br>
		<h4>Daily Delivery Report</h4>
		<br> Type: Summary <br> Date Criteria:
		<%=criteria%>
		<div id="delivaryReportInfo" style="display: none;">			 
			<%
				ArrayList<DelivaryReportOutputBean> listOutputBeans = new ArrayList(); 
				while (c.rs.next()) {
					System.out.println("while ");
					order_date = c.rs.getString(1);
					System.out.println(count + order_date);
					if (order_date != null) {
						System.out.println("if 1");
						count++;
						
						total_orders = c.rs.getInt(2);
						total_paid = c.rs.getFloat(3);
						total_diff = c.rs.getFloat(4);
						total_other_amt = c.rs.getFloat(5);
						total_collected = c.rs.getFloat(6);
						total_expected = c.rs.getFloat(7);
						
						
						grand_total_orders = total_orders + grand_total_orders;
						grand_total_paid = total_paid + grand_total_paid;
						grand_total_other_amt = total_other_amt
								+ grand_total_other_amt;
						grand_total_total_collected = total_collected
								+ grand_total_total_collected;
						grand_total_diff = total_diff + grand_total_diff;
						grand_total_expected = total_expected
								+ grand_total_expected;
					}
					if (order_date != null){
						System.out.println("if 2");
						DelivaryReportOutputBean outputBean = new DelivaryReportOutputBean();
						outputBean.setOrderDate("<a href=\"RDeliveryDailyReportDetails.jsp?order_date="+order_date+"\" "+
												"target=\"_blank\">"+(order_date+"").trim()+"</a>");
						outputBean.setOrderDate1((order_date+"").trim());
						outputBean.setTotalOrders("<a href=\"ReportOrderListWithDate.jsp?order_dt="+order_date+"&Exp=0&pageName="+pageName+"\">"+
													(total_orders+"").trim()+"</a>");
						outputBean.setTotalOrders1((total_orders+"").trim());
						outputBean.setTotalPaid(df.format(total_paid));
						outputBean.setTotalDiff("<a href=\"ReportDifferenceListWithDate.jsp?order_dt="+order_date+"&Exp=0,&pageType="+pageType+"&order_type=ALLDIFF&payment_type=ALL\">"+
														df.format(total_diff)+"</a>");
						outputBean.setTotalDiff1(df.format(total_diff));
						outputBean.setTotalOtherAmt(df.format(total_other_amt));
						outputBean.setTotalCollected(df.format(total_collected));
						outputBean.setTotalExpected(df.format(total_expected));
						outputBean.setCheckBox("<input type=\"CHECKBOX\" name=\"chck\"value='"+order_date+"'>");
						listOutputBeans.add(outputBean); 	  	
					}
				}
				c.closeAll();
				System.out.println("close ");
				DelivaryReportOutputBean outputBean = new DelivaryReportOutputBean();
				outputBean.setOrderDate("<a href=\"RDeliveryDailyReportAllDetails.jsp\" target=\"_blank\"><font color=\"red\">ALL Pending</a>");
				outputBean.setOrderDate1("ALL Pending");
				
				outputBean.setTotalOrders("<a href=\"ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALL&payment_type=ALL\">"+			
											+ grand_total_orders+"</a>");
				outputBean.setTotalOrders1((grand_total_orders+"").trim());
				
				outputBean.setTotalPaid(df.format(grand_total_paid));
				
				outputBean.setTotalOtherAmt(df.format(grand_total_other_amt));
				
				outputBean.setTotalDiff("<a href=\"ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALLDIFF&payment_type=ALL\">"+
										+grand_total_diff+"</a>");
				outputBean.setTotalDiff1((grand_total_diff+"").trim());
				
				outputBean.setTotalCollected(df.format(grand_total_total_collected));
				outputBean.setTotalExpected(df.format(grand_total_expected));
				listOutputBeans.add(outputBean); 	  	
				
				JsonOutputBean jsonOutputBean = new JsonOutputBean();
				jsonOutputBean.setOutputData(listOutputBeans);
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Date","orderDate","250px"));
				jqxgridFormat format = new jqxgridFormat("Date","orderDate1","250px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","150px"));
				format = new jqxgridFormat("Total Orders","totalOrders1","150px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","totalPaid","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Other amount","totalOtherAmt","150px"));
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Difference","totalDiff","150px"));
				format = new jqxgridFormat("Differnce","totalDiff1","150px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Expected","totalExpected","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Collected","totalCollected","130px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Close Orders","checkBox","110px"));
				outputBean.setCheckBox("<input type=\"CHECKBOX\" name=\"chck\" value='' style=\"display: none;float:'center'\">");
				System.out.println(new Gson().toJson(jsonOutputBean));
				out.println(new Gson().toJson(jsonOutputBean));
				
			%>
	</div>
	<div id="delivaryReportInfoGrid"></div>



<input type="hidden" name="hchckall" value="<%=hchckall%>">
<input type="hidden" name="hiddatearray" value="">
<input type="hidden" name="hcount" value="<%=count%>">	
<br/>
	<%
	if (count > 0) {
	%>
	<!-- <input type="submit" name="Submit" value="Save to excel <Alt+ e>" accesskey="e" onClick="Javascript:Pass();return false;"> -->
	<%
		}
	%> <input type=BUTTON name="Submit"  accesskey="s" onClick="save();return false;" value="Save <Alt+ s>">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+ r>">
	<%
		if (count == 0) {
	%>
	<!-- <table align="center" bgcolor="#ECFB99" width=40% height=20%>
		<tr>
			<td align="center"><font color="red" size="5">No Records Available</font></td>
		</tr>
	</table> -->
	<%
		}
	%>


<%
	if (closeResult != null) {
		if (closeResult.equals("1")) {
%> 	
		<script>
			alert("Order status set to closed");
		</script>
<%
		}
	}
%>



<script>
	function Pass() {
		if (document.myform.hcount.value == 0)
			alert("No records available to save in excel");
		else if (document.myform.hcount.value > 0) {
			document.myform.action = "RDeliveryDailyReportSummary.jsp?Exp=1";
			document.myform.submit();
		}
	}

	function check() {
		var jExp=<%=str1%>
	if (jExp == 1) {
			document.getElementById('divexcel').style.visibility = "hidden";
		}
		
	}
	var checkCount = 0;
	function save() {
		if (document.myform.chck.checked == false) {
			alert("No orders selected to close");
			checkCount = 0;
		} else if (document.myform.chck.checked == true) {
			//alert("CHECKED");
			checkCount = 1;
		}
		if (document.myform.chck.value == null) {
			for (i = 0; i < document.myform.chck.length; i++) {
				if (document.myform.chck[i].checked == true) {
					checkCount = checkCount + 1;
				}
			}
			if (checkCount == 0)
				alert("No orders selected to close");
		}
		if (document.myform.hcount.value == 0)
			alert("No records available to save");
		else if (document.myform.hcount.value > 0 && checkCount > 0) {
			checkSelectedDate();

			var ans = confirm("Do you want to change the status to Closed? ");
			if (ans == true) {
				document.myform.action = "RDeliveryCloseOrders.jsp?page=Summary";
				document.myform.submit();
			} else {
				window.refresh;
			}
		}
	}

	function checkSelectedDate() {
		var date = '$$$$';
		var arr = new Array();

		if (document.myform.chck.checked == true) {
			arr = document.myform.chck.value;
			checkCount = checkCount + 1;
		} else if (document.myform.chck.checked == false) {
		}

		if (document.myform.chck.value == null) {
			for (i = 0; i < document.myform.chck.length; i++) {
				if (document.myform.chck[i].checked == true) {
					arr[i] = document.myform.chck[i].value;
				}
			}
		}
		document.myform.hiddatearray.value = arr;
	}
	
	window.onload = function(){
		check();
		
		var gsonObject = jQuery.parseJSON($('#delivaryReportInfo').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData[0].orderDate1);
		//alert(gsonObject.format.orderDate1.textfield);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#delivaryReportInfoGrid").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                filterable: true,
                width:'90%',
               // pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                  groupable: true,
                columns: gsonObject.format
            });	
            
            
             $("#saveToExcel").click(function () {
               // alert("excel ");
               
               
               $('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'orderDate');
            	$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalOrders');
               	$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalDiff');
               	$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'checkBox');
               
               // $('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'orderDate1');
            	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalOrders1');
               	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalDiff1');
               
               
               
               $("#delivaryReportInfoGrid").jqxGrid('exportdata', 'xls', 'Daily  Delivary Report');   
               
                
                $('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'orderDate1');
            	$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalOrders1');
               	$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalDiff1');
               	
               	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'orderDate');
            	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalOrders');
               	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalDiff');
               	$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'checkBox');
                
                     
            });	
		
	}
</script>
</form>
</body>
</html>