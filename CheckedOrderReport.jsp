<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.ChekedOrderReportOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="report.ManageReports"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
 	if(request.getParameter("submit")!=null){
 		%>
 		<jsp:include page="header.jsp" /> 
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
 	 	<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />	
 			<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
 		<center><h3>Delayed Orders</h3></center>
 		<div id="chekedOrder" style="display: none;">
 		<%
 		
 	}
 %>       


<%	if(request.getParameter("call").equals("cheked")){
	
	 
	
	ManageReports  manageReports = new ManageReports("jdbc/re");
	ResultSet resultSet = manageReports.getCheckedReportData();	
	ArrayList<ChekedOrderReportOutputBean> listOutputBeans = new ArrayList();
	//int i=0;
	while(resultSet.next()){
			
		ChekedOrderReportOutputBean outputBean = new ChekedOrderReportOutputBean();
		//outputBean.setOrder_num("<a href=\"javascript:passVar(\'"+resultSet.getString("order_num")+"\');\">"+resultSet.getString("order_num")+" </a>");
		outputBean.setOrder_num(resultSet.getInt("order_num"));
		outputBean.setOrder_num1(resultSet.getInt("order_num"));
		outputBean.setCustcode(resultSet.getString("custname"));
		outputBean.setOrder_date(resultSet.getString("order_date"));
		outputBean.setTotal_items(resultSet.getInt("total_items"));
		outputBean.setTotal_value(resultSet.getFloat("total_value"));
		outputBean.setTotal_value_mrp(resultSet.getFloat("total_value_mrp"));
		outputBean.setTotal_value_discount(resultSet.getFloat("total_value_discount"));
		outputBean.setLastmodifieddate(resultSet.getString("lastmodifieddate"));
		outputBean.setStatus_code(resultSet.getString("status_code"));
		
		listOutputBeans.add(outputBean);
		
	}
	
	manageReports.closeAll();
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
	jsonOutputBean.setOutputData(listOutputBeans);
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("Order No.","order_num"));
	jqxgridFormat format = new jqxgridFormat("Order No.","order_num1");
	format.setHidden(true);
	jsonOutputBean.getFormat().add(format);
	jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","custcode"));
	format = new jqxgridFormat("Order Date","order_date");
	jsonOutputBean.getFormat().add(format);
	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","total_items"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","total_value"));
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value MRP","total_value_mrp"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Total value Discount","total_value_discount"));
	format= new jqxgridFormat("Last Modified Date","lastmodifieddate");
	jsonOutputBean.getFormat().add(format);
	jsonOutputBean.getFormat().add(new jqxgridFormat("Status Code","status_code"));
	
	System.out.print(new Gson().toJson(jsonOutputBean));
	out.print(new Gson().toJson(jsonOutputBean));
		
	}	

if(request.getParameter("submit")!=null){
	%>
		
</div>
<div id="chekedOrderGrid"></div>


<div id="popupContact" style="max-height: 450px;width: 730px;overflow: auto; " >
	<a id="popupContactClose"><!-- <input type="button" onclick="Fun_Print();" value="print"> --><img src="images/Background/Button-Close-icon.png"></a>
	<div id ="stack_info">
	</div>	
</div>
<div id="backgroundPopup" style="background-color: transparent;"></div>	

<script type="text/javascript">
$(document).ready(function(){

$(document).keypress(function(e) {
		if (e.keyCode == 27 && popupStatus == 1) {
			disablePopup();
		}
	});
	
	if('<%=request.getParameter("submit")%>'!=null){
	
	$('#chekedOrder').css({'display':'none'});
	$('#chekedOrderGrid').css({'display':'block'});

	var gsonObject = jQuery.parseJSON($('#chekedOrder').html());
	var source =
            {
                localdata:  gsonObject.OutputData,
                datatype: "array"
                
            };
		
			$("#chekedOrderGrid").jqxGrid(
            {
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                filterable: true,
                groupable: true,
                width:'100%',
                // pageable :true,
                //showaggregates: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                columns: gsonObject.format
            });
            
             $("#chekedOrderGrid").jqxGrid('clearselection');  
            $("#chekedOrderGrid").unbind('cellselect');
			$("#chekedOrderGrid").unbind('rowselect');
	     	$("#chekedOrderGrid").bind('rowselect', function (event) {
			var row = $("#chekedOrderGrid").jqxGrid('getrowdata', event.args.rowindex);
					passVar(row.order_num);
				   
			}); 
			$("#chekedOrderGrid").jqxGrid('clearselection');
			
            
               $("#saveToExcel").click(function () {
               
            	$('#chekedOrderGrid').jqxGrid('showcolumn', 'order_num1');
            	$('#chekedOrderGrid').jqxGrid('hidecolumn', 'order_num');
               
                $("#chekedOrderGrid").jqxGrid('exportdata', 'xls', 'Delayed Details');   
                
                $('#chekedOrderGrid').jqxGrid('hidecolumn', 'order_num1');
            	$('#chekedOrderGrid').jqxGrid('showcolumn', 'order_num');
            	        
            });	
    
		}
		
		
		
		
});




var popupStatus = 0;

function loadPopup() {
	if (popupStatus == 0) {
		$("#backgroundPopup").css({
			"opacity" : "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

function disablePopup() {
	if (popupStatus == 1) {
		$("#backgroundPopup").fadeOut("slow");
		$("#popupContact").fadeOut("slow");
		popupStatus = 0;
	}
}

function centerPopup() {
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#popupContact").height();
	var popupWidth = $("#popupContact").width();
	$("#popupContact").css({
		"position" : "absolute",
		"top" : windowHeight / 2 - popupHeight / 2,
		"left" : windowWidth / 2 - popupWidth / 2
	});
	$("#backgroundPopup").css({
		"height" : windowHeight
	});

}


var newUrl ="";
function passVar(code){

	    newUrl="print_orderAjaxPopUp.jsp?backPage=RcustSalesForm.jsp&buttonFlag=Y&orderNo="+code;
	   // alert(newUrl);
	    $.ajax({
			url:newUrl,
			type:'post',
			data:'',
			dataType:'text',
			success:function(ajaxResonse)
			{	
				
				$('#stack_info').html(ajaxResonse);	
				//document.getElementById("stack_info").innerHTML = " ";	
				centerPopup();
				loadPopup();
			
			}
		
		});
 	    
	}

$("#popupContactClose").click(function() {
		disablePopup();
	});
	$("#backgroundPopup").click(function() {
		disablePopup();
	});
	

</script>

	<%
}

%>

