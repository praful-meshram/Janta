<jsp:include page="header.jsp"></jsp:include>
<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.CommisionOrderListOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>




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
 
 <%@ page errorPage="ReportErrorPage.jsp?page=CommissionOrderList.jsp" %>
 
<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
	
	<center><h3>Commission Order List </h3></center>
      
<%
			String str1="";
		    str1=request.getParameter("excel");		    
		    if(str1!=null){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
	<form method="post" name="myform">
<%
		DecimalFormat df = new DecimalFormat("###,###.00");
		staff.ManageStaff c;
		//c = new staff.ManageStaff("jdbc/js");
		c = new staff.ManageStaff("jdbc/re");
    	
    	String staffName="";
		staffName=request.getParameter("d_staffname");	
    	String code="";
    	code=request.getParameter("d_staffcode");
    	String report="";
    	report=request.getParameter("d_report");
    	
    	String hchckall = request.getParameter ("hchckall");
    	ArrayList<CommisionOrderListOutputBean> listOutputBeans = new ArrayList();
    	JsonOutputBean jsonOutputBean = new JsonOutputBean();
    	if(hchckall.equals("1")){
    		c.getCommissionSubDetails(report,code,"0000-00-00","0000-00-00"); 
    	}
    	else{
    		//String hname = request.getParameter ("hname");
    		String hdate1 = request.getParameter ("hdate1");
    		if(hdate1.equals("")) hdate1= "0000-00-00";
    		String hdate2 = request.getParameter ("hdate2");
    		if(hdate2.equals("")) hdate2= "0000-00-00";	
    		c.getCommissionSubDetails(report,code,hdate1,hdate2); 
    	}
		
		
		if(report.equals("ALLORDERS")){
%>
		<b>Delivery Staff Name: <%=staffName%></b>
     
<%		
		while(c.rs.next()) {
		
			String orderNo="";
			String custCode="";
			String custName="";
			String area="";
			String phno="";
			String orderDate="";
			String lmd="";
			String totItems="";
			String totTaken="";			
			float commAmt=0.0f;
			String status="";
			
			orderNo= c.rs.getString("order_num");
			custCode= c.rs.getString("custcode");
			custName= c.rs.getString("custname");
			area= c.rs.getString("area");
			phno= c.rs.getString("phone");
			orderDate= c.rs.getString("order_date");
			lmd= c.rs.getString("upd_datetime");
			totItems= c.rs.getString("total_items");
			totTaken= c.rs.getString("total_taken");
			commAmt = c.rs.getFloat("comm_amt");
			status= c.rs.getString("status_code");
			
			CommisionOrderListOutputBean outputBean = new CommisionOrderListOutputBean();
			outputBean.setOrderNumber(orderNo);
			outputBean.setCustomerCode(custCode);
			outputBean.setCustomerName(custName);
			outputBean.setArea(area);
			outputBean.setPhoneNumber(phno);
			outputBean.setOrderDate(orderDate);
			outputBean.setLastModifiedDate(lmd);
			outputBean.setTotalItems(totItems);
			outputBean.setTotalTaken(totTaken);
			outputBean.setCommissionAmount((commAmt+"").trim());
			outputBean.setStatus(status); 
			
			listOutputBeans.add(outputBean);
		    
		}	
	}else{
%>		
	<b>Delivery Staff Name: <%=staffName%></b>
      
<%		    	
		while(c.rs.next()) {
		
			String d_staff_name="";
			String tras_date="";
			float transAmt=0.0f;
			float oldBal=0.0f;
			float newBal=0.0f;
			
			d_staff_name= c.rs.getString("dstaff_name");
			tras_date= c.rs.getString("tran_dt");
			transAmt= c.rs.getFloat("tran_amt");
			oldBal= c.rs.getFloat("old_balance_amt");
			newBal= c.rs.getFloat("new_balance_amt");
			
			/* CommisionOrderListOutputBean outputBean = new CommisionOrderListOutputBean();
			outputBean.setDeliveryStaffName(d_staff_name);
			outputBean.setTransactionDate(tras_date);
			outputBean.setTransactionAmount((transAmt+"").trim());
			outputBean.setOldBalance((oldBal+"").trim());
			outputBean.setNewBalance((newBal+"").trim());
			listOutputBeans.add(outputBean);  */
		}
	}	
		jsonOutputBean.setOutputData(listOutputBeans);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNumber","100px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","100px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","customerName","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area","150px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Phone Number","phoneNumber","120px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","orderDate","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Last Modified Date","lastModifiedDate","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems","100px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Token","totalTaken","100px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Commission Amount","commissionAmount","150px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Status","Status","90px"));
		
	c.closeAll();	
%>
 <div id='commOrderList' style="display: none;"><%=new Gson().toJson(jsonOutputBean) %></div>
 
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>
<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td><td><input type="button" name="cancel" value="Cancel" onclick="funcancel();"></td></tr></table></div> -->
<div id="commOrderListGrid"></div>
<script>
function Pass(){
		document.myform.action="CommissionOrderList.jsp?Exp=1";
	    document.myform.submit();
}
function funcancel(){
		document.myform.action="CommissionsDetailsForm.jsp";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
		var gsonObject = jQuery.parseJSON($('#commOrderList').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#commOrderListGrid").jqxGrid(
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
                columns: gsonObject.format
            });	
	
		$("#saveToExcel").click(function () {
               $("#commOrderListGrid").jqxGrid('exportdata', 'xls', 'Commission Order Report');     // not work for huge data
             
              // url = window.location.href+"&excel=true";      
               //alert(url);
               //window.location.assign(url);
         });	
	
}
	window.onload = check;

</script>

</form>
</body></html>