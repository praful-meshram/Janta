<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.CommisionOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>

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
<%@ page errorPage="ReportErrorPage.jsp?page=RCommissionList.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
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
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	String criteria="";	
    		
        String dstaffname ="", order_date="";	
		float total_balance= 0.0f;
		float total_paid= 0.0f;
		float total_earned= 0.0f;
		float total_lastpaid= 0.0f;
		
		float grand_total_balance=0.0f;
		float grand_total_paid=0.0f;		
		float grand_total_earned=0.0f;
		float grand_total_lastpaid=0.0f;
    	ArrayList<CommisionOutputBean> listCommisonOutput = new ArrayList();
    	JsonOutputBean  jsonOutputBean = new JsonOutputBean();
    	if(hchckall.equals("1")){
    		System.out.println("if .. ");
    		c.listCommissions(); 
    		criteria ="All";
    	}
    	else{
    		String name="";
	    	String amt1="";
	    	String amt2="";
	    	String c_date1="";
	    	String c_date2="";
	    		
			name=request.getParameter("name");
			amt1=request.getParameter("amt1");
			amt2=request.getParameter("amt2");	
			c_date1=request.getParameter("c_date1");
			c_date2=request.getParameter("c_date2");		
			
			System.out.println("c_date1 "+c_date1+" c_date2 "+c_date2);
			
			criteria = 	name +" "+amt1 +"-"+ amt2+" ";
			if(c_date1!=null)
				criteria+=c_date1.replace("-","/") +"-"+ c_date2.replace("-","/");	
			c.listCommissionsWithDate(name,amt1,amt2,c_date1,c_date2); 
%>
			<input type="hidden" name="name" value="<%=name%>">
			<input type="hidden" name="amt1" value="<%=amt1%>">
			<input type="hidden" name="amt2" value="<%=amt2%>">
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
<%
		}
%>

		
     
       <br><center><b> Commission Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Commission
       <br>	&nbsp	 Criteria &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
          	
      <div id="commGrid" style="display: none;">
<%		   		
		
	    	while(c.rs.next()) {
	    	
	    		beans.CommisionOutputBean outputBean = new beans.CommisionOutputBean();
	    		dstaffname = c.rs.getString(2);
	    		total_balance =c.rs.getFloat(3);
	    		total_paid =c.rs.getFloat(4);	 
	    		order_date =c.rs.getString(5);   		
	    		total_lastpaid =c.rs.getFloat(6);
	    		total_earned =c.rs.getFloat(8);
	    		
	    		outputBean.setDstaffName("<a  href=\"RTransactionDetails.jsp?code="+c.rs.getString(1)+"&name="+c.rs.getString(2)+"&Exp=0\">"+dstaffname+"</a>");
	    		outputBean.setDstaffName1(dstaffname);
	    		outputBean.setBalanceToPay((total_balance+"").trim());
	    		outputBean.setTranAmt((total_paid+"").trim()); // total pai
	    		outputBean.setTranDt(order_date); // trans_dt
	    		outputBean.setTranAmt1((total_lastpaid+"").trim());// tranas_amt1
	    		outputBean.setCommAmt((total_earned+"").trim()); //
	    		
	    		grand_total_balance= total_balance+ grand_total_balance;
				grand_total_paid = total_paid + grand_total_paid;
				grand_total_earned = total_earned + grand_total_earned;
				grand_total_lastpaid = total_lastpaid + grand_total_lastpaid;
				
				
				listCommisonOutput.add(outputBean);
    
		}	

		c.closeAll();
		
		jsonOutputBean.setOutputData(listCommisonOutput);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Name","dstaffName"));
		jqxgridFormat format = new jqxgridFormat("Name","dstaffName1");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Balanace","balanceToPay"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Paid","tranAmt"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Earned","commAmt"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Last Paid Date","tranDt"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Last paid Amount","tranAmt1"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		System.out.println("grand_total_balance "+grand_total_balance);
			
%>
</div>
<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<div id="commSummery"></div>
</form>
</body>

<script>
function Pass(){
		document.myform.action="RCommissionList.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
}
	window.onload = function(){
		check();
		
		var gsonObject = jQuery.parseJSON($('#commGrid').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#commSummery").jqxGrid(
            {	
            	theme:'darkblue',
	            height: '340px',
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                showaggregates: true,
                showstatusbar: true,
                  groupable: true,
                 columnsresize: true,
                //selectionmode: 'singlecell',
                columns: [
                		{"text":"Name","datafield":"dstaffName"},
                		{
                		"text":"Balanace","datafield":"balanceToPay",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																				   }] // end of aggregites attribute
						},
                		{"text":"Total Paid","datafield":"tranAmt",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																				   }]},
                		{"text":"Total Earned","datafield":"commAmt",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																				   }]},
                		{"text":"Last Paid Date","datafield":"tranDt",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																				   }]},
                		{"text":"Last paid Amount","datafield":"tranAmt1",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return aggregatedValue + currentValue;
																					                              }
																					                              return aggregatedValue;
																					                 }//end of aggreagite sum function
																				   }]}
                		]
            });	
            
               $("#saveToExcel").click(function () {
               
                $('#commSummery').jqxGrid('hidecolumn', 'dstaffName');
               	$('#commSummery').jqxGrid('showcolumn', 'dstaffName1');
               		 
                $("#commSummery").jqxGrid('exportdata', 'xls', 'Commision Details');     
                
                $('#commSummery').jqxGrid('showcolumn', 'dstaffName');      	
                $('#commSummery').jqxGrid('hidecolumn', 'dstaffName1');   
                      	   
            });	
            
	
	};

</script>

</html>