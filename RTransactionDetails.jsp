<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.TransactionDetailsOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<!-- files for JqxWidget grid  -->
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />

    
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
<%@ page errorPage="ReportErrorPage.jsp?page=RTransactionDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%-- <jsp:include page="sessionBoth.jsp?formName=RTransactionDetails.jsp"/>  --%>

<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
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
<form name="myform" method="post">
<%
		staff.ManageStaff c;
		//c = new staff.ManageStaff("jdbc/js");
		c = new staff.ManageStaff("jdbc/re");
    	
    		
	    	String code="";
	    	String name="";
	    	code=request.getParameter("code");
			name=request.getParameter("name");						
			
			c.listCommissionsWithCode(code); 
%>
			<input type="hidden" name="name" value="<%=name%>">
			<input type="hidden" name="code" value="<%=code%>">			

<div id="transactionDetails" style="display: none;">   
      
<%		
		JsonOutputBean jsonOutputBean = new  JsonOutputBean(); 
		ArrayList<TransactionDetailsOutputBean> listOutputBeans = new ArrayList();
 	    	while(c.rs.next()) {
 	    	TransactionDetailsOutputBean outputBean = new TransactionDetailsOutputBean();
 	    	outputBean.setTran_id(c.rs.getString(1));
 	    	outputBean.setTran_type(c.rs.getString(2));
 	    	outputBean.setTran_dt(c.rs.getString(3));
 	    	outputBean.setTran_amt(c.rs.getString(4));
 	    	outputBean.setOld_balance_amt(c.rs.getString(5));
 	    	outputBean.setNew_balance_amt(c.rs.getString(6));
			listOutputBeans.add(outputBean);	
 	    }	
 	    	
 	    jsonOutputBean.setOutputData(listOutputBeans);	
 	    jsonOutputBean.getFormat().add(new jqxgridFormat("Transaction Id","tran_id","200px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Type ","tran_type","200px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Transaction Date","tran_dt","250px"));
	    jsonOutputBean.getFormat().add(new jqxgridFormat("Amount ","tran_amt","200px"));
	 	jsonOutputBean.getFormat().add(new jqxgridFormat("Old Balance","old_balance_amt","200px"));
	 	jsonOutputBean.getFormat().add(new jqxgridFormat("New Balance","new_balance_amt"));
	 	c.closeAll();	
	 	System.out.println(new Gson().toJson(jsonOutputBean));
	 	out.println(new Gson().toJson(jsonOutputBean));
	 	
%>
</div>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>

<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<div id="transactionDetailsGrid"></div>
<script>
function Pass(){
		document.myform.action="RTransactionDetails.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	
	var gsonObject = jQuery.parseJSON($('#transactionDetails').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#transactionDetailsGrid").jqxGrid(
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
                //selectionmode: 'singlecell',
                columnsresize: true,
                  groupable: true,
                columns: gsonObject.format
            });	
            
            
             $("#saveToExcel").click(function () {
               // alert("excel ");
                $("#transactionDetailsGrid").jqxGrid('exportdata', 'xls', 'Sales Details');     
           
            });	
	
	
}
	window.onload = check;

</script>
</form>
</body>
</html>