<jsp:include page="header.jsp"></jsp:include>
<%@page import="beans.JasonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.DeliveryStaffDetailsOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>

<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>



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
 <%@ page errorPage="ReportErrorPage.jsp?page=RDeliveryStaff.jsp" %>
 
<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
      

<%
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
<%
		DecimalFormat df = new DecimalFormat("###,###.00");
		staff.ManageStaff c;
		//c = new staff.ManageStaff("jdbc/js");
		c = new staff.ManageStaff("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	
    	String name="";
	    String date1="";
	    String date2="";
	    String d_staffcode="",d_staffname="",fromdate="", todate="";
	    float total_orders=0.0f;
	    float total_comm=0.0f;
	    float paid_amt=0.0f;
	    float balance_amt=0.0f;
	    float last_paid_amt=0.0f;
	    String last_paid_date="";
	    String criteria="";
	    ArrayList<DeliveryStaffDetailsOutputBean> listOutputBean = new ArrayList();
	    JsonOutputBean jsonOutputBean = new JsonOutputBean(); 
    	if(hchckall.equals("1")){
    		System.out.println(" if  ");
    		c.getCommissionDetails("NA","0000-00-00","0000-00-00");
    		criteria ="ALL";
    	}
    	else{
    		System.out.println(" else  ");
	    		
			name=request.getParameter("d_staff");
			if(!name.equals("select")) 
				criteria = name;
			date1=request.getParameter("c_date1");
			date2=request.getParameter("c_date2");	
			
			/* if(date1.equals("")){ date1= "0000-00-00";}
			else { criteria = criteria + "  From :"+date1; }
			
			
			if(date2.equals("")){ date2= "0000-00-00";}
			else { criteria = criteria + " To "+date2; } */
			if(date1!=null){
				criteria = criteria + "  From :"+date1;
				criteria = criteria + "  To :"+date2;
			}
			else{
				 date1= "0000-00-00";
				 date2= "0000-00-00";
			}
			
						
			//criteria=  name+", "+date1+", "+date2;	
			System.out.println(" date 1 "+date1+" date2 "+date2);
			System.out.println(" name  "+name +" @@ ");
			if(name.equals("select")){
				name="NA";
				System.out.println("if   name  "+name +" @@ ");
				
			}
			c.getCommissionDetails(name,date1,date2); 
		}
%>
<br><center><b> Delivary Person Report</center>
       	<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Delivery Staff Details
        <br>	&nbsp	 Criteria &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
        <br>
        <br>
		
	<div id="deliveryStaff" style="display: none;">	
    
<%		    	
		while(c.rs.next()) {
			
		   	d_staffname = c.rs.getString(1);
		   	d_staffcode = c.rs.getString(2);
		   	total_orders = c.rs.getFloat(3);
		   	total_comm = c.rs.getFloat(4);
		   	paid_amt = c.rs.getFloat(5);
		   	balance_amt = c.rs.getFloat(6);
		   	last_paid_amt = c.rs.getFloat(7);
		   	last_paid_date = c.rs.getString(8);
		 	fromdate = c.rs.getString(9);
		 	todate = c.rs.getString(10);
		 	
		 	DeliveryStaffDetailsOutputBean outputBean = new DeliveryStaffDetailsOutputBean();
		 	outputBean.setDeliveryPersonName(d_staffname);
		 	outputBean.setTotalOrders("<a  href=\"CommissionOrderList.jsp?d_staffname="
		 								+c.rs.getString(1)+"&d_staffcode="+c.rs.getString(2)+"&d_report=ALLORDERS&Exp=0&hchckall="+
		 								hchckall+"&hdate1="+fromdate+"&hdate2="+todate+"\">" +total_orders+"</a>"); 
		 	outputBean.setTotalOrders1((total_orders+"").trim());
		 	
		 	outputBean.setTotalEarned((total_comm+"").trim());
		 	outputBean.setTotalPaid((paid_amt+"").trim());
		 	outputBean.setBalance((balance_amt+"").trim());
		 	outputBean.setFromDate(fromdate);
		 	outputBean.setToDate(todate);
		 	listOutputBean.add(outputBean);
		}	
		c.closeAll();
		
		jsonOutputBean.setOutputData(listOutputBean);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Delivery Person Name","DeliveryPersonName","250px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","170px"));
		jqxgridFormat format = new jqxgridFormat("Total Orders","totalOrders1","170px");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Earned","totalEarned","170px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Paid","totalPaid","170px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Balance","balance","170px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("From Date","fromDate","170px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("To Date","toDate"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
	
%>
</div>

<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td><td><input type="button" name="cancel" value="Cancel" onclick="funcancel();"></td></tr></table></div> -->

<div id="deliveryStaffJqwidget"></div>
</body>

<script>
function Pass(){
		document.myform.action="RCommissionList.jsp?Exp=1";
	    document.myform.submit();
}
function funcancel(){
		document.myform.action="HomeForm.jsp";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	// Jqwidgt grid
	var gsonObject = jQuery.parseJSON($('#deliveryStaff').html());
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#deliveryStaffJqwidget").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                  groupable: true,
              	 // columnsresize: true,
                 columns:gsonObject.format 
                 
                 
            });	
	
		$("#saveToExcel").click(function () {
               	$('#deliveryStaffJqwidget').jqxGrid('showcolumn', 'totalOrders1');
				$('#deliveryStaffJqwidget').jqxGrid('hidecolumn', 'totalOrders');
               	
                $("#deliveryStaffJqwidget").jqxGrid('exportdata', 'xls', 'Commision Details');     
                
                $('#deliveryStaffJqwidget').jqxGrid('showcolumn', 'totalOrders');
				$('#deliveryStaffJqwidget').jqxGrid('hidecolumn', 'totalOrders1');
         });	
	
	
}
	window.onload = check;

</script>

</html>