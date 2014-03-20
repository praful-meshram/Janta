<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.SalesOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
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
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>	
 
<%@ page errorPage="ReportErrorPage.jsp?page=ReportDifferenceListWithAllDate.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>

<head>
<title>Sales... </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
body{
	font-family: arial;
	}
.boldtable, .boldtable TD, .boldtable TH
{
	font-family:arial;
	font-size:10pt;
}
#id{
	border-collapse: collapse;
}
#id td{
	padding: 3px 0px 3px 0px;
}
#header{
	background-color: gray;
	color: white;
}
#one{
	background-color: #FAFAFA;
}
#two{
	background-color: #D8D8D8;
}
</style>
</head>
<body>

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
</table>

<form name="myform" method="post">
<%	
	report.ManageReports mo;
	mo = new report.ManageReports("jdbc/re");
	
	String order_dt="",del_datetiem="",pageType="",order_type="";
	//order_dt=request.getParameter("order_dt");
	String payment_type="";
	payment_type=request.getParameter("payment_type");	
	pageType=request.getParameter("pageType");
	order_type=request.getParameter("order_type");
	
	mo.listDeliveryDailyReportAllDetailsNew(payment_type,order_type);
	
	String criteria="ALL";
	String orderNo="";
	String custCode="";
	String custName="";
	String buildingNo="";
	String block="";
	String wing="";
	String building="";
	String area="";
	String orderDate="";
	String lastModifiedDate="";
	String totalItems="";
	String totalValueMrp="";
	float totalValuePrice=0.0f;
	String discountAmt="";
	String advanceAmt="";
	float balanceAmt=0.0f;
	float changeAmt=0.0f;
	float paidAmt=0.0f;
	float expectedAmt=0.0f;
	String deliveryStaffName="";
	String statusCode="";
    float delchgs=0.0f;
    String payment="";
    double adamt=0.0f;  
    float diffamt=0.0f;  
    float grand_total_value=0.0f;
    double grand_total_adamt=0.0f;
    float grand_total_del=0.0f;
    float grand_total_bal=0.0f;
	float grand_total_change=0.0f;	
	float grand_total_exp=0.0f;	
	float grand_total_paid=0.0f;	
	float grand_total_diff=0.0f;
	
	DecimalFormat df = new DecimalFormat("###,###.0");	
%>

<%     
	if(!order_type.equals("ALL")){
%>
		<br><center><b> Difference Report</center> 
<%
	   }else{
%>
		<br><center><b> All Order Details</center> 
<%
		}
%>
		<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=pageType%>
		<br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
      
		<input type="hidden" name="order_dt" value="">
		<input type="hidden" name="orderNo" value="">
	<div id="reportDiffAll" style="display: none;">
	<%
		int i=0;
		int cnt=0;
		ArrayList<SalesOutputBean> lisOutputBeans = new ArrayList();
		
      	while(mo.rs.next()) {
	      	i++;
      		orderNo = mo.rs.getString("order_num");
      		custCode = mo.rs.getString("custcode");
      		custName = mo.rs.getString("custname");
      		buildingNo = mo.rs.getString("building_no");
      		block = mo.rs.getString("block");
      		wing = mo.rs.getString("wing");
      		building = mo.rs.getString("building");
      		area = mo.rs.getString("area");
      		orderDate = mo.rs.getString("order_date");
      		lastModifiedDate = mo.rs.getString("lastmodifieddate");
      		totalItems = mo.rs.getString("total_items");
      		totalValueMrp = mo.rs.getString("total_value_mrp");
      		totalValuePrice = mo.rs.getFloat("total_value");
      		discountAmt = mo.rs.getString("discount_amt");
      		advanceAmt = mo.rs.getString("advance_amt");
      		balanceAmt = mo.rs.getFloat("balance_amt");
      		changeAmt = mo.rs.getFloat("change_amt");
      		paidAmt = mo.rs.getFloat("paid_amt");
      		expectedAmt = mo.rs.getFloat("expected_amt");
      		deliveryStaffName = mo.rs.getString("dstaff_name");
      		statusCode = mo.rs.getString("status_code");
      		delchgs = mo.rs.getFloat("delv_charges");
      		payment = mo.rs.getString("payment_type_desc");
      		
      			grand_total_value = totalValuePrice + grand_total_value;
      			grand_total_del= delchgs + grand_total_del;
      			grand_total_bal= balanceAmt +grand_total_bal;      			
      			grand_total_change= changeAmt  +grand_total_change;      			
	    		grand_total_paid=paidAmt+grand_total_paid;	    		
	    		grand_total_exp = expectedAmt + grand_total_exp;
	 
	    		SalesOutputBean outputBean = new SalesOutputBean();
	      		outputBean.setOrderNo("<a title=\""+mo.rs.getString(12)+","+mo.rs.getString(13)+","+mo.rs.getString(14)+","+mo.rs.getString(15)+","+mo.rs.getString(8)+"\""+
							"href=\"Javascript:passVar('"+orderNo+"');\">"+orderNo+"</a>");
	      		outputBean.setOrderNo1(orderNo);
	      		outputBean.setCustomerCode(custCode);
	      		outputBean.setCustName(custName);
	      		outputBean.setBuildingNo(buildingNo);
	      		outputBean.setBlock(block);
	      		outputBean.setWing(wing);
	      		outputBean.setBuilding(building);
	      		outputBean.setArea("<span align=\"center\" title=\""+mo.rs.getString(12)+","+mo.rs.getString(13)+","+mo.rs.getString(14)+","+mo.rs.getString(15)+","+mo.rs.getString(8)+"\">"+ area+"</span>");
	      		outputBean.setArea1(area);
	      		outputBean.setOrder_date(order_dt);
	      		outputBean.setLastModifiedDate(lastModifiedDate);
	      		outputBean.setTotalItems(totalItems);
	      		outputBean.setTotalValueMrp(totalValueMrp);
	      		outputBean.setTotalValuePrice((totalValuePrice+"").trim());
	      		outputBean.setDiscountAmt(discountAmt);
	      		if(advanceAmt != null && discountAmt != null){
					adamt = Double.parseDouble(advanceAmt) - Double.parseDouble(discountAmt);
					grand_total_adamt= adamt + grand_total_adamt;	
			    }
	      		outputBean.setAdvanceAmt((adamt+"").trim());
	      		
	      		outputBean.setBalanceAmt((balanceAmt+"").trim());
	      		outputBean.setChangeAmt((changeAmt+"").trim());
	      		outputBean.setPaidAmt((paidAmt+"").trim());
	      		outputBean.setExpectedAmount((expectedAmt+"").trim());
	      		outputBean.setDeliveryStaffName(deliveryStaffName);
	      		outputBean.setStatus(statusCode);
	      		outputBean.setDelchgs((delchgs+"").trim());
	      		outputBean.setPayment(payment);
	      		
	      		diffamt = expectedAmt;// - paidAmt;
				grand_total_diff = diffamt + grand_total_diff;
				outputBean.setDiffamt((diffamt+"").trim());
				lisOutputBeans.add(outputBean);
	    		
		cnt++;
		
      	}
      	mo.closeAll();
      	
      	
      	JsonOutputBean jsonOutputBean = new JsonOutputBean();
      	jsonOutputBean.setOutputData(lisOutputBeans);
      	

 	 	System.out.println(new Gson().toJson(jsonOutputBean));
 	 	out.println(new Gson().toJson(jsonOutputBean));
%>
</div>
<div id="reportDiffAllGrid"></div>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
	  
<!-- <div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<script>
function passVar(code){
    	document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
	    document.myform.submit();
}
function Pass(){
		document.myform.action="ReportOrderListWithDate.jsp?Exp=1";
	    document.myform.submit();
}


$(document).ready(
	function(){
		
		var gsonObject = jQuery.parseJSON($('#reportDiffAll').html());
		
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
            
         	$("#reportDiffAllGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 400,
                source: source,
                sortable: true,
                filterable: true,
                width:'950px',
                pageable :true,
                groupable: true,
                showaggregates: true,
                showstatusbar: true,
                selectionmode: 'singlecell',
               // pagesize: 20,
                //columnsresize: true,
                //columns:gsonObject.format
                columns :
                [
                	{"text":"Order No","datafield":"orderNo" ,width:'180px'},
                	{"text":"Order No","datafield":"orderNo1" ,width:'180px',hidden:true},
	                //{"text":"Area","datafield":"area",width:'250px'},{"text":"Area","datafield":"area1",width:'250px',hidden:true},
	                {"text":"Customer Name","datafield":"custName",width:'220px'},
	                //{"text":"Phone","datafield":"Phone",width:'150px'},
	                //{"text":"Order Date","datafield":"order_date",width:'150px'},
	                {"text":"Items","datafield":"totalItems",width:'150px'},
	                //{"text":"Payment","datafield":"payment",width:'150px'},
	                 /*
	                {"text":"Total Amounts ","datafield":"total_value",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                },
	                */
	                {"text":"Advance/Discount","datafield":"advanceAmt",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                },/*
	                {"text":"Del Chags","datafield":"delchgs",width:'200px' ,aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                },
	               */
	                {"text":"Balance","datafield":"balanceAmt",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                },
	               /*
	               	 {"text":"Change Amount","datafield":"changeAmt",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                },
	                {"text":"Expected","datafield":"expectedAmount",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                
	                },
	                {"text":"Paid","datafield":"paidAmt",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
	                
	                },
	                {"text":"Difference","datafield":"diffamt",width:'200px',aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																		   }]
					}
	               */
                ]
               
               });// closing on JQgrid
               
               
               
             
             $("#saveToExcel").click(function () {
             
             	$('#reportDiffAllGrid').jqxGrid('hidecolumn', 'area');
            	$('#reportDiffAllGrid').jqxGrid('showcolumn', 'area1');
            	
            	$('#reportDiffAllGrid').jqxGrid('hidecolumn', 'orderNo');
            	$('#reportDiffAllGrid').jqxGrid('showcolumn', 'orderNo1');
             	
                $("#reportDiffAllGrid").jqxGrid('exportdata', 'xls', 'Diffrence Report');    
                
                $('#reportDiffAllGrid').jqxGrid('showcolumn', 'area');
            	$('#reportDiffAllGrid').jqxGrid('hidecolumn', 'area1');
            	
            	$('#reportDiffAllGrid').jqxGrid('showcolumn', 'orderNo');
            	$('#reportDiffAllGrid').jqxGrid('hidecolumn', 'orderNo1');
                
            	      
            });	//end of excel function  
               
         }); // end of ready function
            
            	
			


</script>

</form>
</body>
</html>	

