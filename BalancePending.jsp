<jsp:include page="header.jsp"></jsp:include>
<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.BalancePendingOutputBean"%>
<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>

<%-- <jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" /> --%>




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
   <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script>     
<%@ page errorPage="ReportErrorPage.jsp?page=BalancePending.jsp" %>

<style>
div#balance_report table{
	width: 100%;
}
div#balance_report tr{
	width: 100%;
}
div#balance_report td{
	border: 1px solid black; 
}
div#balance_report th{
	border: 1px solid black; 
}
.linkImage{
	cursor: pointer;
}
</style>

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;" class="linkImage"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;" class="linkImage"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;" class="linkImage"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;" class="linkImage"/></td>
		</tr>
		<tr></tr>
	</table>
<center><h3>Balance Pending List</h3></center>
<%

	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");	
	mo.getDeliveryStaffList();
	String code="",desc="";
%>

<form method="post" name="myform">
<td width="50%">
<!-- 	<input id="save" type="button" onclick="TableToExcel()" accesskey="s" value="Export to Excel<Alt+s>"/> -->
	<br>
	<div id="balance_report" style="display: none;">
	<% 
	//ManagePayment mp = new ManagePayment("jdbc/js");
	ManagePayment mp = new ManagePayment("jdbc/re");
	String from_date = "";//request.getParameter("from_date");
	String to_date = "";//request.getParameter("to_date");
	mp.getDateRangePendingBalance(from_date, to_date);
	ArrayList<BalancePendingOutputBean> listOutputBean = new ArrayList();
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
		int counter=0;
		while(mp.rs.next()){
			// <input type="hidden" name="Building" value="<%= mp.rs.getString(4)+", "+ mp.rs.getString(5) "/> 
			
			BalancePendingOutputBean outputBean = new BalancePendingOutputBean();
			outputBean.setCustomerCode(mp.rs.getString(2));
			outputBean.setName(mp.rs.getString(3));
			outputBean.setBalance(mp.rs.getString(1));
			outputBean.setOrderId(mp.rs.getString(14));
			outputBean.setDate(mp.rs.getString(15));
			
			outputBean.setBuilding(mp.rs.getString(4)+","+mp.rs.getString(5));
			//outputBean.setBlock(rs.getString(2));
			outputBean.setBlock(mp.rs.getString(6));
			outputBean.setWing(mp.rs.getString(7));
			outputBean.setAdd1(mp.rs.getString(8));
			
			outputBean.setArea(mp.rs.getString(9));
			outputBean.setStation(mp.rs.getString(10));
			outputBean.setCity(mp.rs.getString(11));
			outputBean.setPhone(mp.rs.getString(12));
			outputBean.setMobile(mp.rs.getString(13));
			
			listOutputBean.add(outputBean);
			counter++;
		}
	mp.closeAll();
	jsonOutputBean.setOutputData(listOutputBean);
	jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Name","name","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Balance","balance","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Order Id","orderId","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Date","date","180px"));
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("Building","building","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Block","block","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Add1","add1","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Station","station","180px"));
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("City","city","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Phone","phone","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Mobile","mobile","180px"));
	
%>	<%=new Gson().toJson(jsonOutputBean)%>
	</div>
	<div id="balance_reportGrid" ></div>
</form>
<script>

window.onload = function(){
	var gsonObject = jQuery.parseJSON($('#balance_report').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#balance_reportGrid").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                  columnsresize: true,
                  groupable: true,
                columns: gsonObject.format
            });	
	
		$("#saveToExcel").click(function () {
               $("#balance_reportGrid").jqxGrid('exportdata', 'xls', 'Balance Pending Report');     // not work for huge data
               
         });	
}



//window.onload=showBalanceReport();
function showBalanceReport(){
	alert("Hi");
	document.getElementById("save").style.display='none';
	document.getElementById("balance_report").innerHTML = "<center><img src=\"images/load.gif\"/></center>";
	//var from_date = document.myform.c_date1.value;
	//var to_date = document.myform.c_date2.value;
	//from_date = from_date.substring(6,10) + "-"+from_date.substring(3,5)+"-" + from_date.substring(0,2);
	//to_date = to_date.substring(6,10) + "-"+to_date.substring(3,5)+"-" + to_date.substring(0,2);
	xmlHttp2 = GetXmlHttpObject()
	if (xmlHttp2 == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "BalancePendingAjax.jsp";
	//url = url + "?from_date="+from_date;
	//url = url + "&to_date=" + to_date;
	alert(url);
	xmlHttp2.onreadystatechange = showPending;
	xmlHttp2.open("GET", url, true);
	xmlHttp2.send(null);
}

function GetXmlHttpObject() {
	var xmlHttp = null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}


function showPending() {
	if (xmlHttp2.readyState == 4) {
		document.getElementById("balance_report").innerHTML = xmlHttp2.responseText;
		document.getElementById("save").style.display='block';
	}
}
function TableToExcel()
{
	document.myform.action="PendingToExcel.jsp";
	document.myform.submit();
}
</script>
</body>
</html>