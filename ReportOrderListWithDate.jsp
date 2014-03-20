<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.SalesOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%-- <jsp:include page="sessionBoth.jsp?formName=ReportOrderListWithDate.jsp"/>  --%>


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

    <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsreorder.js"></script>
	<script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script>
	<script type="text/javascript" src="js/jqwidgets/jqxpanel.js"></script>
	 <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<%@ page errorPage="ReportErrorPage.jsp?page=ReportOrderListWithDate.jsp" %>



<%
			String str1="";
			String order_dt="",pageName="";
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
.boldtable, .boldtable TD, .boldtable TH
{
	font-family:arial;
	font-size:10pt;
}
body{
	font-family:arial;
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

	<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

<form name="myform" method="post">
<%
		
		order_dt=request.getParameter("order_dt");	
		String payment_type="";
		payment_type=request.getParameter("payment_type");
		pageName=request.getParameter("pageName");
		String criteria=order_dt;
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
%>
<br><center><h4> Sales Report </h4></center>
		<b><br>	Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: Summary
		<br>	Criteria&nbsp;&nbsp;:  <%=criteria%>
      	</b>
		<input type="hidden" name="order_dt" value="<%=order_dt%>">
		<input type="hidden" name="orderNo" value="">

		<div id="reportOrderWithDate" style="display: none;">
<%
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			DataSource ds = (DataSource)envContext.lookup("jdbc/re");
			conn = ds.getConnection();
			stat=conn.createStatement();
			if(pageName.equals("RCollection")){
				if(payment_type != null){
					query="select  a.order_num, a.custcode, date(a.order_date), a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, date(a.lastmodifieddate) ,a.status_code from orders a, payment_type b where a.payment_type_code=b.payment_type_code and trim(Date(a.order_date))='"+order_dt+"' and a.payment_type_code ='"+payment_type+"' ";				
				}
				else{
				     query="select  a.order_num, a.custcode, date(a.order_date), a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, date(a.lastmodifieddate), a.status_code  from orders a, payment_type b where a.payment_type_code=b.payment_type_code and trim(Date(a.order_date))='"+order_dt+"' ";		
				}
	
		ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		System.out.println("report order list "+query);
		rs=stat.executeQuery(query);    
    	while(rs.next()) {
    		SalesOutputBean outputBean = new SalesOutputBean();
    		outputBean.setOrderNo("<a href=\"Javascript:passVar('"+rs.getString(1)+"');\">"+rs.getString(1)+"</a>");
    		outputBean.setCustomerCode(rs.getString(2));
    		outputBean.setOrder_date(rs.getString(3));
    		outputBean.setTotalItems(rs.getString(4));
    		outputBean.setTotal_value(rs.getString(5));
    		outputBean.setMrp(rs.getString(6));
    		outputBean.setDiscountAmt(rs.getString(7));
    		outputBean.setPaymentType(rs.getString(8));
    		outputBean.setLastModifiedDate(rs.getString(9));
    		outputBean.setStatus(rs.getString(10));
    		listOutputBeans.add(outputBean); 
 		 }		
    		jsonOutputBean.setOutputData(listOutputBeans);
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNo","130px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","140px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","order_date","180px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems","120px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Values","total_value","120px"));
    		
    		jsonOutputBean.getFormat().add(new jqxgridFormat("MRP","mrp","110px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Discount","discountAmt","110px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type","paymentType","140px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Last Modified Date","lastModifiedDate","180px"));
    		jsonOutputBean.getFormat().add(new jqxgridFormat("Status","status","120px"));
    		
    		System.out.println(new Gson().toJson(jsonOutputBean));
    		out.println(new Gson().toJson(jsonOutputBean));
    		//out.println(new Gson().toJson(jsonOutputBean)));
		}else if(pageName.equals("RDelivery")){	
			
				String orderNo="";	
				String custName="";
				String area="";
				String lastModifiedDate="";	
				String totalItems="";
				String totalValue="";
				String discountAmt="";
				String advanceAmt="";
				String balanceAmt="";
				String changeAmt="";
				String paidAmt="";	
				String delchgs="";
			    String payment="";
			    double adamt=0.0f;
			    double expAmt=0.0f;
			    
			    String Phone="";
    
				if(payment_type != null){
					query="select  c.area, a.order_num, c.custname, a.lastmodifieddate, a.total_items, b.payment_type_desc, "+
					"a.total_value, a.advance_amt, a.discount_amt, other_charges, a.balance_amt, a.change_amt, a.paid_amt,c.phone "+
					"from orders a, payment_type b, customer_master c "+
					"where a.payment_type_code=b.payment_type_code and a.status_code='DELIVERED' and a.custcode=c.custcode "+
					"and trim(Date(a.del_datetime))='"+order_dt+"' and a.payment_type_code ='"+payment_type+"' ";									
				}
				else{
				     query="select  c.area, a.order_num, c.custname, a.lastmodifieddate, a.total_items, b.payment_type_desc, "+
					 "a.total_value, a.advance_amt, a.discount_amt, other_charges, a.balance_amt, a.change_amt, a.paid_amt,c.phone "+
					 "from orders a, payment_type b, customer_master c "+
				     "where a.payment_type_code=b.payment_type_code and a.status_code='DELIVERED' and a.custcode=c.custcode and "+
				     "trim(Date(a.del_datetime))='"+order_dt+"' ";											     								  
				     
				}
%>			 
			

<%			
			System.out.println(" deliveary :: "+query);
			ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
			
			rs=stat.executeQuery(query);
			while(rs.next()) {  
    		
    		area = rs.getString(1);
    		orderNo = rs.getString(2);
      		custName = rs.getString(3);
      		lastModifiedDate = rs.getString(4);
      		totalItems = rs.getString(5);
      		payment = rs.getString(6);
      		
      		totalValue = rs.getString(7);
      		advanceAmt = rs.getString(8);      	
      		discountAmt = rs.getString(9);      		
      		delchgs = rs.getString(10);
      		balanceAmt  = rs.getString(11);
      		changeAmt = rs.getString(12);
      		paidAmt = rs.getString(13);
      		Phone=rs.getString(14); 
      			
      			SalesOutputBean outputBean = new SalesOutputBean();
          		outputBean.setArea(area);
          		outputBean.setOrderNo("<a href=\"Javascript:passVar('"+orderNo+"');\">"+orderNo+"</a>");
          		outputBean.setCustName(custName);
          		outputBean.setLastModifiedDate(lastModifiedDate.substring(0,16));
          		outputBean.setTotalItems(totalItems);
          		outputBean.setPayment(payment);
          		outputBean.setTotal_value(totalValue);
          		
          		if(advanceAmt != null && discountAmt != null){
    				adamt = Double.parseDouble(advanceAmt) + Double.parseDouble(discountAmt);
    		    }
          		outputBean.setAdvanceAmt((adamt+"").trim());
          		outputBean.setDiscountAmt(discountAmt);
          		outputBean.setDelchgs(delchgs);
          		outputBean.setBalanceAmt(balanceAmt);
          		outputBean.setChangeAmt(changeAmt);
          		outputBean.setPaidAmt(paidAmt);
          		outputBean.setPhone(Phone);
          		
          		if(balanceAmt != null && changeAmt != null){
    				//expAmt = Double.parseDouble(paidAmt) + Double.parseDouble(changeAmt);
          			//expAmt = Double.parseDouble(totalValue)+Double.parseDouble(delchgs) + Double.parseDouble(changeAmt);
          			expAmt = Double.parseDouble(totalValue)+Double.parseDouble(delchgs)-adamt-Double.parseDouble(discountAmt);
          		}
          		outputBean.setExpectedAmount((expAmt+"").trim());
      			
          		listOutputBeans.add(outputBean);
      		
				
				
    		}
			
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			jsonOutputBean.setOutputData(listOutputBeans);
			
			jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area","170px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Order","orderNo","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","custName","170px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Phone","Phone","130px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","lastModifiedDate","140px"));
			
			jsonOutputBean.getFormat().add(new jqxgridFormat("Items","totalItems","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Payment","payment","100px"));
			
			//Amount
			jqxgridFormat format=  new jqxgridFormat("Total Amount","total_value","120px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			
			format=  new jqxgridFormat("Adv/Dis Amount","advanceAmt","120px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			format=  new jqxgridFormat("DelChags Amount","delchgs","135px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			format=  new jqxgridFormat("Balance Amount","balanceAmt","130px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			format=  new jqxgridFormat("Change Amount","changeAmt","120px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			format=  new jqxgridFormat("Expected Amount","expectedAmount","130px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			format=  new jqxgridFormat("Paid Amount","paidAmt","120px");
			//format.setColumngroup("Amount");
			jsonOutputBean.getFormat().add(format);
			
			
			System.out.println(new Gson().toJson(jsonOutputBean));
    		out.println(new Gson().toJson(jsonOutputBean));
					
		}
		rs.close();	
        stat.close();
		conn.close();	
%>
</div>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>


<%
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>   
</form>
<!-- <div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></div> -->

<div id="reportOrderWithDateGrid"></div>
</body>

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
function check(){
	
	//alert($('#reportOrderWithDate').html());
	
	var jExp=<%=str1%>			
	
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	
	var pagename = '<%=pageName%>';
	if(pagename=='RDelivery1')
	{
		//alert('<%=pageName%>');
		// code for html
		$('#reportOrderWithDate').css({'display':'block'});
		$('#reportOrderWithDateGrid').css({'display':'none'});	
	
	}
	else{
		//alert('<%=pageName%>');
	// code for json
		$('#reportOrderWithDateGrid').css({'display':'block'});
		
		var gsonObject = jQuery.parseJSON($('#reportOrderWithDate').html());
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#reportOrderWithDateGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 400,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //selectionmode: 'singlerow',
                groupable: true,
                columnsresize: true,
                columns:gsonObject.format
               		
               	
                
            });	
            
             $("#saveToExcel").click(function () {
                $("#reportOrderWithDateGrid").jqxGrid('exportdata', 'xls', 'Order list Report');           
            });	
	
	}
	
	

}
	window.onload = check;


</script>


</html>	

