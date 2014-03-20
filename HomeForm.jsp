<%@ page contentType="text/html"%>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="HomeForm.jsp" />
</jsp:include> --%>

<jsp:include page="header.jsp" /> 

<!-- files for JqxWidget grid  -->
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />

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
<%@ page errorPage="ReportErrorPage.jsp?page=HomeForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>



<form name="myform" class="ddm1">
<%
	session.setAttribute("filter", "nofilter");
	String exp=request.getParameter("exp");
	if(exp != null){
		if(exp.equals("5")){
			String formName=request.getParameter("formName");
%>
		<center><br><br><br><h3><font color="red">Permission Denied!</font></h3></center>
        <center><br><br><br><h5><font color="red">Form : <%=formName%></font></h5></center>

<%
		exp = null;
		}
	}
	//System.out.println(exp);
	if(exp==null){
%>	
<center><br><br><br><br>
 <style type="text/css">
     	table {
	     background-color:#ECFB99;
	     width:600px;
	     border-collapse: collapse;
     }    
     td{
     	padding: 5px;
     }
    </style>
<!-- <table border="1" class="item3" cellspacing = 0 cellpadding = 0 style="border-collapse: collapse;" bordercolor=black>
	<thead >
		<td><b>Department</b></td>
		<td><b>Business Entity</b></td>
		<td><b>Action</b></td>
		<td><b>Description</b></td>
	</thead>
	<tbody>
		<tr align="left">
			<th rowspan=7>Reference Data</th>
				<tr>
					<th rowspan=3>Customer</th>
						<tr>
							<td align="left"><a href="create_newCustomerForm.jsp">Create Customer</td>
							<td align="left" width="300px">This helps you to store the details of a new customer</td>
						</tr>
						<tr>
							<td align="left"><a href="EditTargetReportForm.jsp">List/Edit/Delete</td>
							<td align="left" width="300px">This helps you to list the customers based on search criteria and view, print or delete a paticular customer</td>
					    </tr>
				</tr>
				<tr>
					<th rowspan=3>Item</th>
					<tr>
						<td align="left"><a href="NewItemForm.jsp">Create Item</td>
							<td align="left" width="300px">This helps you to store the details of a new item</td>
					</tr>
					<tr>
						<td align="left"><a href="ItemDetailsForm.jsp?flag=1">List/Edit/Delete</td>
							<td align="left" width="300px">This helps you to list the items based on search criteria and view or dit a particular item. This feature also enables view of all the historic changes to a particular item</td>
					</tr>
				</tr>		
		</tr>
		<tr>
			<th rowspan=3>Back Office Billing</th>
				<th rowspan=3>Order</th>
				<tr>
					<td align="left"><a href="customer_detailsForm.jsp">Create Order</td>
						<td align="left" width="300px">This helps you to create a new order</td>
				</tr>
				<tr>
					<td align="left"><a href="order_detailsForm.jsp">List/View/Print</td>
						<td align="left" width="300px">This helps you to list the orders based on search criteria and view or print a particular order</td>
				</tr>
		</tr>
	</tbody>
</table> -->
<div id="outer" style="display: none;">
	
	<h3>Delayed Orders</h3>
	<table style="width: 100%;height: auto;border: 10px;background-color: transparent;">
		<tr style="cursor: pointer;"> 
			<td style="width: 97%;"></td>
			<td></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png" title="Save To Excel" id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
	<div id="cheked">
</div>
</div>
<div id="popupContact" style="max-height: 450px;width: 620px;overflow: auto;" >
	<a id="popupContactClose"><img src="images/Background/Button-Close-icon.png"></a>
	<div id ="stack_info">
	</div>	
</div>
<div id="backgroundPopup" style="background-color: transparent;"></div>	
<%
	}
	
	
%>	





<script type="text/javascript">
window.onload=function(){
	
	$("#popupContactClose").click(function() {
		disablePopup();
	});
	$("#backgroundPopup").click(function() {
		disablePopup();
	});
	$(document).keypress(function(e) {
		if (e.keyCode == 27 && popupStatus == 1) {
			disablePopup();
		}
	});
	
	return;
	
	
	
	$.ajax({
		url:"CheckedOrderReport.jsp",
		type:'post',
		data:'call=cheked',
		dataType:'json',
		success:function(gsonObject)
		{	
		
		 $('#outer').css({'display':'block'});
		  var source =
            {
                localdata:  gsonObject.OutputData,
                datatype: "array"
                
            };
		
			$("#cheked").jqxGrid(
            {
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                filterable: true,
                groupable: true,
                width:'100%',
                 //pageable :true,
                //showaggregates: true,
                //selectionmode: 'singlerow',
                columnsresize: true,
                columns: gsonObject.format
            });
            
			
		} // end of ajax success
	});// 
	
	
	  $("#cheked").jqxGrid('clearselection');  
            $("#cheked").unbind('cellselect');
			$("#cheked").unbind('rowselect');
	     	$("#cheked").bind('rowselect', function (event) {
			var row = $("#cheked").jqxGrid('getrowdata', event.args.rowindex);
					passVar(row.order_num);
				   
			}); 
	
	$("#saveToExcel").click(function () {
               
            	$('#cheked').jqxGrid('showcolumn', 'order_num1');
            	$('#cheked').jqxGrid('hidecolumn', 'order_num');
               
                $("#cheked").jqxGrid('exportdata', 'xls', 'Delayed Details');   
                
                $('#cheked').jqxGrid('hidecolumn', 'order_num1');
            	$('#cheked').jqxGrid('showcolumn', 'order_num');
            	        
            });	       
            
                   	
		
}

var newUrl ="";
function passVar(code){

	    newUrl="print_orderAjaxPopUp.jsp?backPage=RcustSalesForm.jsp&buttonFlag=Y&orderNo="+code;
	    //alert(newUrl);
	    
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

</script>

</html>