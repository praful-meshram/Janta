<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.ItemHistoryOutputBean"%>
<%@page import="beans.ItemHistoryOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.JsonOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>



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


<%@ page errorPage="ReportErrorPage.jsp?page=RitemHistory.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
	<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="home" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
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
	DecimalFormat df = new DecimalFormat("###,###.00");
	
	String i_code="";
	i_code=request.getParameter("icode");
	//item.ManageItemHistory mih=new item.ManageItemHistory("jdbc/js");
	item.ManageItemHistory mih=new item.ManageItemHistory("jdbc/re");
	mih.listItemHistory(i_code);
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
	ArrayList<ItemHistoryOutputBean> listOutputBean = new ArrayList(); 
		
		
%>
        <center><h3>Item History</h3><br>
        <input type="hidden" name="icode" value="<%=i_code%>">
        <div id="itemHistory" style="display: none;">
      	
<%	
		int i=0;
      	while(mih.rs.next()) {
      		
      		
      		ItemHistoryOutputBean historyOutputBean = new ItemHistoryOutputBean();
      		historyOutputBean.setItemCode(mih.rs.getString(1));
      		historyOutputBean.setVersionNo(mih.rs.getString(2));
      		historyOutputBean.setItemGroupDesc(mih.rs.getString(3));
      		historyOutputBean.setItemName(mih.rs.getString(4));
      		historyOutputBean.setItemWeight(mih.rs.getString(5));
      		
      		historyOutputBean.setItemMrp(mih.rs.getString(6));
      		historyOutputBean.setItemRate(mih.rs.getString(7));
      		historyOutputBean.setDealType(mih.rs.getString(8));
      		historyOutputBean.setDealOnQty(mih.rs.getString(9));
      		
      		historyOutputBean.setDealAmount(mih.rs.getString(10));
      		historyOutputBean.setUpdDatetime(mih.rs.getString(11));
      		//historyOutputBean.setUpdDatetime(mih.rs.getString(12));
      		listOutputBean.add(historyOutputBean);
      		
	}
      	jsonOutputBean.setOutputData(listOutputBean);
      	
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Code","itemCode","100px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Version No","versionNo","130px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Group","itemGroupDesc","150px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","itemName","220px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight","itemWeight","120px"));
      	
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Mrp","itemMrp","110px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","itemRate","110px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Deal Type","dealType","150px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Deal On Qty","dealOnQty","150px"));
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Deal On Amount","dealAmount","150px"));
      	
      	jsonOutputBean.getFormat().add(new jqxgridFormat("Update Date / Time","updDatetime","250px"));
      	
      	System.out.println(new Gson().toJson(jsonOutputBean));
      	out.println(new Gson().toJson(jsonOutputBean));
      	
      	
		mih.closeAll();
%>
</div></center>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>						

<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<div id="itemHistoryJqwidget"></div>

<script>
function Pass(){
		document.myform.action="RitemHistory.jsp?Exp=1";
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
		
			var gsonObject = jQuery.parseJSON($('#itemHistory').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#itemHistoryJqwidget").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //selectionmode: 'singlecell',
                //autoresizecolumns :true;
                columns: gsonObject.format
            });	
            
        	 $("#saveToExcel").click(function () {
        	 
                $("#itemHistoryJqwidget").jqxGrid('exportdata', 'xls', 'Item History Details');           
            });	
	}
</script>
</form>
</body>
</html>	
			
    				
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	