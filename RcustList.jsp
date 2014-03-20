<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.CustomerListOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>

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
	<script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
	 <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
	 
<%@ page errorPage="ReportErrorPage.jsp?page=RcustList.jsp" %>
	
	<%
	//session.getAttribute("UserName").toString();
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
<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
<center><h3>Customer List</h3></center>
<form name="myform" method="post">
<%
        String hchckall= request.getParameter("hchckall"); 

		System.out.println(" hchckall  "+hchckall);
		customer.ManageCustomer c;
		//c = new customer.ManageCustomer("jdbc/js");
		c = new customer.ManageCustomer("jdbc/re");
		ResultSet resultSet =null;
		if(hchckall.equals("1")){	
			
			resultSet = c.listCustomers();
		 
			System.out.println(" if  ");
		}
		else{
			String name="";
	    	String phone="";
	    	String building="";
	    	String block="";
	    	String wing="";
	    	String add1="";
	    	String add2="";
	    	String custCode="";
	    	String nameString="";
	    	String c_date1="";
	    	String c_date2="";
	    	String u_date1="";
	    	String u_date2="";
	    	String city="", state="", area="";
	    	String building_no="", station="";
	    	
			name=request.getParameter("custName");
			phone=request.getParameter("phonenumber"); 
			building=request.getParameter("Building");
			building_no=request.getParameter("Building_no");
			block=request.getParameter("block");
			wing=request.getParameter("wing");
			add1=request.getParameter("add1");
			add2=request.getParameter("add2");
			custCode=request.getParameter("custCode");
			nameString=request.getParameter("nameString");
			c_date1=request.getParameter("c_date1");			
			c_date2=request.getParameter("c_date2");		
			u_date1=request.getParameter("u_date1");			
			u_date2=request.getParameter("u_date2");			
			area=request.getParameter("area");
			station=request.getParameter("station");
			
			System.out.println(" c_date1 "+c_date1+"\n c_date2 "+c_date2);
			System.out.println(" u_date1 "+u_date1+"\n u_date2 "+u_date2);
%>
			<input type="hidden" name="custCode" value="<%=custCode%>">
			<input type="hidden" name="custName" value="<%=name%>">
			<input type="hidden" name="phonenumber" value="<%=phone%>">
			<input type="hidden" name="Building" value="<%=building%>">
			<input type="hidden" name="Building_no" value="<%=building_no%>">
			<input type="hidden" name="block" value="<%=block%>">
			<input type="hidden" name="wing" value="<%=wing%>">
			<input type="hidden" name="add1" value="<%=add1%>">
			<input type="hidden" name="add2" value="<%=add2%>">
			<input type="hidden" name="nameString" value="<%=nameString%>">
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
			<input type="hidden" name="u_date1" value="<%=u_date1%>">
			<input type="hidden" name="u_date2" value="<%=u_date2%>">
			<input type="hidden" name="area" value="<%=area%>">
			<input type="hidden" name="station" value="<%=station%>">		
<%
			System.out.println(" before method call ");
			//c.List();
			//c.listCustomer(name, phone, building, building_no, block, wing, add1, add2, custCode, c_date1,  u_date1, nameString, area, station);
			 resultSet = c.listCustomer1(name, phone, building, building_no, block, wing, add1, add2, custCode, c_date1, c_date2, u_date1, u_date2,nameString, area, station);
			System.out.println(" after method call ");
			
				
			}
%>
	<div id="custDetails" style="display: none;">
<%		
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
		ArrayList<CustomerListOutputBean> customerListOutputBeans = new ArrayList();
	    while(resultSet.next()) {
	    	//System.out.println(" customer list "+customerListOutputBeans.size());
	    	CustomerListOutputBean outputBean = new CustomerListOutputBean();
	    	
	    	outputBean.setCustomerName(resultSet.getString(1));
	    	outputBean.setPhone(resultSet.getString(2));
	    	outputBean.setBuilding(resultSet.getString(3));
	    	outputBean.setBlock(resultSet.getString(4));
	    	outputBean.setWing(resultSet.getString(5));
	    	
	    	outputBean.setAdd1(resultSet.getString(6));
	    	outputBean.setAdd2(resultSet.getString(7));
	    	outputBean.setCustomerCode(resultSet.getString(8));
	    	outputBean.setCreateDatetime(resultSet.getString(9));
	    	outputBean.setUpdateDatetime(resultSet.getString(10));
	    	
	    	outputBean.setArea(resultSet.getString(11));
	    	outputBean.setPinCode(resultSet.getString(12));
	    	outputBean.setCity(resultSet.getString(13));
	    	outputBean.setState(resultSet.getString(14));
	    	outputBean.setBuildingNo(resultSet.getString(15));
	    	
	    	outputBean.setStation(resultSet.getString(16));
	    	outputBean.setMobile(resultSet.getString(17));
	    	outputBean.setPaymentTypeCode(resultSet.getString(18));
	    	customerListOutputBeans.add(outputBean);
	    	
		}	 
	    jsonOutputBean.setOutputData(customerListOutputBeans);
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","120px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","customerName","190px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Phone","phone","130px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Building","building","200px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Flat No","block","80px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Wing","wing","80px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Add1","add1","270px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Add2","add2","270px"));
	    c.closeAll();
	    
	    out.print(new Gson().toJson(jsonOutputBean));
	    System.out.print(new Gson().toJson(jsonOutputBean));
%>
</div>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
<input type="hidden" name="hchckall" value="<%=hchckall%>">
</form>

<div id="custListGrid"> </div>	
	

</body>
<script>
function Pass(){
		document.myform.action="RcustList.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById("divexcel").style.display='none';		
	}
}
	// display grid on Onload 
	window.onload = function(){
		check();
		
		
			var gsonObject = jQuery.parseJSON($('#custDetails').html());
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#custListGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                groupable: true,
                selectionmode: 'singlecell',
                columnsresize: true,
                columns:gsonObject.format
                
            });	
			
			$("#saveToExcel").click(function () {
                $("#custListGrid").jqxGrid('exportdata', 'xls', 'Customer Details');           
            });
		
	} ;

</script>


</html>	