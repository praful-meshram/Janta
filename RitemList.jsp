<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.ItemListOutputBean"%>
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
 	<script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
 	 <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script>  
<%@ page errorPage="ReportErrorPage.jsp?page=RitemList.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
	
	<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td ><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;" /></td>
		</tr>
		<tr></tr>
	</table>
	
	<center><h3>Item Details</h3><center>
 
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
    String hchckall= request.getParameter("hchckall"); 

	DecimalFormat df = new DecimalFormat("###,###.00");
	
	item.ManageItem mi;
	//mi = new item.ManageItem("jdbc/js");
	mi = new item.ManageItem("jdbc/re");
    JsonOutputBean jsonOutputBean = new JsonOutputBean();
    ArrayList<ItemListOutputBean>  itemListOutputBeans = new ArrayList(); 
	if(hchckall.equals("1")){	
			mi.listItems();
	}
	else{	
		String i_code="";
		String ig_code="";
		String i_name="";
		String i_mrp="";
		String i_mrp2="";
		String i_rate="";
		String i_rate2="";	
		
		i_code=request.getParameter("i_code");
		ig_code=request.getParameter("ig_code");
		i_name=request.getParameter("i_name");
		i_mrp=request.getParameter("i_mrp1");
		i_rate=request.getParameter("i_rate1");
		i_mrp2=request.getParameter("i_mrp2");
		i_rate2=request.getParameter("i_rate2");	
%>
			<input type="hidden" name="i_code" value="<%=i_code%>">
			<input type="hidden" name="ig_code" value="<%=ig_code%>">
			<input type="hidden" name="i_name" value="<%=i_name%>">
			<input type="hidden" name="i_mrp1" value="<%=i_mrp%>">
			<input type="hidden" name="i_mrp2" value="<%=i_mrp2%>">
			<input type="hidden" name="i_rate1" value="<%=i_rate%>">
			<input type="hidden" name="i_rate2" value="<%=i_rate2%>">
<%	
		
		String notflag ="";
		System.out.println("before method ");
	    mi.listItem(i_code,ig_code,i_name,i_mrp,i_mrp2,i_rate,i_rate2,notflag,"",0);
	   
	  }  	
	       
	   %>
	   	<div id="itemListGrid" style="display:none;">
	   <%   	while(mi.rs.next()) {
	      		
            	ItemListOutputBean OutputBean = new ItemListOutputBean();
            	OutputBean.setItemCode(mi.rs.getString(1));
            	OutputBean.setItemGroupCode(mi.rs.getString(7));
            	OutputBean.setItemName(mi.rs.getString(3));
            	OutputBean.setItemWeight(mi.rs.getString(4));
            	OutputBean.setItemMrp(mi.rs.getString(5));
            	OutputBean.setItemRate(mi.rs.getString(6));
            	
            	//OutputBean.setDealActiveFlag(mi.rs.getString(9));
            	//OutputBean.setItemHistory(mi.rs.getString(8));

                String msg1= mi.rs.getString(9); 
                if(msg1.equals("N")){   
           			//out.println("No");
           			OutputBean.setDealActiveFlag("No");
           			
           		}
           		else{
           			OutputBean.setDealActiveFlag("Yes");
           		}

                String msg= mi.rs.getString(8); 
                if(!msg.equals("NH")){                      
         		
					OutputBean.setItemHistory("<a href=\"RitemHistory.jsp?icode="+mi.rs.getString(1)+"&Exp=0\"> history</td>");
                }
                
                itemListOutputBeans.add(OutputBean);
                
 }
	   jsonOutputBean.setOutputData(itemListOutputBeans);
	   
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Code","itemCode","100px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Group Code","itemGroupCode","180px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","itemName","220px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight","itemWeight","120px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Mrp","itemMrp","100px"));
	   
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","itemRate","120px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Deal_active_flag","dealActiveFlag","180px"));
	   jsonOutputBean.getFormat().add(new jqxgridFormat("Item History","itemHistory"));
	   
	  
	   
	   out.print(new Gson().toJson(jsonOutputBean));
	   System.out.print(new Gson().toJson(jsonOutputBean));
		mi.closeAll();			  
%>
		</div>
			 <style type="text/css">
			 a:link {color: blue}
			 a:hover {background: blue;color: white}
			 a:active {background: blue;color: white}
			 </style>

<input type="hidden" name="hchckall" value="<%=hchckall%>">

<div id="itemListGridJqwidget"></div>

<script>
function Pass(){
		document.myform.action="RitemList.jsp?Exp=1";
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
		
			var gsonObject = jQuery.parseJSON($('#itemListGrid').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#itemListGridJqwidget").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
              	groupable: true,
                //selectionmode: 'singlecell',
                //autoresizecolumns :true;
                columnsresize: true,
                columns: gsonObject.format
            });	
            
        	 $("#saveToExcel").click(function () {
        	 	$('#itemListGridJqwidget').jqxGrid('hidecolumn', 'itemHistory');
                $("#itemListGridJqwidget").jqxGrid('exportdata', 'xls', 'Item Details');
              $('#itemListGridJqwidget').jqxGrid('showcolumn', 'itemHistory');
                           
            });	
		
		
	}
</script>
</form>
</body>
</html>	
			
    	