<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.ItemHistoryOutputBean"%>
<%@page import="beans.ItemMrpRate"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

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
<%@ page errorPage="ReportErrorPage.jsp?page=RDailyModification.jsp" %>

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;" class="linkImage"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;" class="linkImage"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;" class="linkImage"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;" class="linkImage"/></td>
		</tr>
		<tr></tr>
	</table>
<%!
	public ArrayList<ItemMrpRate> getItemDetails(String itemCode , String date ){
	ArrayList<ItemMrpRate> mrpRates = new ArrayList();
	Connection connection = null;
	try{
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		connection  = ds.getConnection();
		Statement statement = connection.createStatement();
		
		 String selectQuery="SELECT item_mrp,item_rate FROM item_master where trim(date(upd_datetime)) = '"+ date +"' "+
					" and item_code ='"+itemCode+"'";	
		
		System.out.println("item master  "+selectQuery);
		
		ResultSet resultSet = statement.executeQuery(selectQuery);		
		while(resultSet.next()){
			ItemMrpRate itemMrpRate = new ItemMrpRate(resultSet.getFloat(1),resultSet.getFloat(2));
			mrpRates.add(itemMrpRate);
			
		}
		connection.close();
	}
	catch(SQLException e){
		e.printStackTrace();
		System.out.println("error in static JSp fnction ");
	}
	catch(Exception exception){
		System.out.println("error in static JSp fnction ");
	}
	
	
	return mrpRates;
}
%>

<%
			String str1="";
			if(request.getParameter("Exp")!=null)
		    	str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
<form name="myform" method="post">
<% 		
	DecimalFormat df = new DecimalFormat("###,###.00");
	
	String Date="";
	String query="";
	
	Date = request.getParameter("Date");	
		
	Connection conn=null;
	Statement stmt=null, stat=null;
	ResultSet rs=null, rs2=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		conn = ds.getConnection();
		stmt = conn.createStatement();	
			
%> 		<center>
		  	
	    <input type="hidden" name="Date" value="<%=Date%>">
		      		
		<br><center><b> Item History Report</center> <br>
     
	<div id="itemHistory" style="display: none">
	<%
				JsonOutputBean jsonOutputBean = new JsonOutputBean();
				jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","itemName","180"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight","itemWeight","90"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Old Item Rate","oldRate","110"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Old Item MRP","oldMRP","110"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Changed Item Rate","changedRate","160"));
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Changed Item MRP","changedMRP","160"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Comm. Amt","commAmt","100"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Update Date","updDatetime","120"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Update Date New","updDatetimeNew","140"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Remark","remark","370"));


			query=	"SELECT "+
				" item_code,version_no,item_group_code,item_weight,item_name,item_rate,item_mrp,"+
				"deal_type,deal_active_flag,deal_on_qty,deal_amount,trim(date(upd_datetime)),comm_amt,"+
				"trim(date(upd_datetime_new)),remark "+
				" FROM item_history where trim(date(upd_datetime_new)) = '"+ Date +"'; ";			
			System.out.println(" item history "+query);
			rs = stmt.executeQuery(query);
			
			ArrayList<ItemHistoryOutputBean> listOutputBeans = new ArrayList();		
			while(rs.next()){
			ArrayList<ItemMrpRate> arrayList = getItemDetails(rs.getString(1), Date);
			ItemHistoryOutputBean outputBean = new ItemHistoryOutputBean();
			outputBean.setItemName(rs.getString(5));
			outputBean.setItemWeight(rs.getString(4));
			outputBean.setOldRate(rs.getString(6));
			outputBean.setOldMRP(rs.getString(7));
			
			outputBean.setChangedRate((arrayList.get(0).getItemRate()+"").trim());
			outputBean.setChangedMRP((arrayList.get(0).getItemMrp()+"").trim());
			outputBean.setCommAmt(rs.getString(13));
			outputBean.setUpdDatetime(rs.getString(12));
			outputBean.setUpdDatetimeNew(rs.getString(14));
			outputBean.setRemark(rs.getString(15));
		listOutputBeans.add(outputBean);
		}
			System.out.println("=======item master  ");

			//rs2.close();	
			rs.close();	
		 	stmt.close();
		 	conn.close();
		 	jsonOutputBean.setOutputData(listOutputBeans); 
		 	System.out.println(new Gson().toJson(jsonOutputBean));
		 	out.println(new Gson().toJson(jsonOutputBean));
	}
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();
    	conn.close();    	
	}	
%>
</div>
<div id="itemHistoryGrid"></div>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>

<% 
	if(!str1.equals("1")){
%>
<div id="div4" style="VISIBILITY:visible">
 <table><tr><td><!-- <a href="Javascript:Pass();">Save to excel</a></td><td> -->
 <input type="button" name="return" value="Return" onclick="funReturn();"></td></tr></table>
 </div>
<% 
	}
%>
<script type="text/javascript">
function Pass(){
		document.myform.action="RDailyModification.jsp?Exp=1";
	    document.myform.submit();
	}
function funReturn(){
		document.myform.action="RDailyModificationForm.jsp";
	    document.myform.submit();
	}

	window.onload = function(){
		//alert($('#itemHistory').html());
		var gsonObject = jQuery.parseJSON($('#itemHistory').html());

		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#itemHistoryGrid").jqxGrid(
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
                  groupable: true,
                  columnsresize: true,
                columns: gsonObject.format
            });	
	
		$("#saveToExcel").click(function () {
               $("#itemHistoryGrid").jqxGrid('exportdata', 'xls', 'Balance Pending Report');     // not work for huge data
               
         });	
	
	}


</script>
<ceneter> <div id="dispdiv" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF"> </div></center>
</form></body>
</html>