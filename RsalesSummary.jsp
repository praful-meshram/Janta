<jsp:include page="header.jsp" />
<html>
<head>

<%@page import="beans.Aggregates"%>
<%@page import="beans.JasonObject"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.SalesDetailsOutputBean"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.SalesSummeryOutputBean"%>
<%@page import="beans.SalesAnalysisReportOutputBean"%>
<%@page import="java.sql.Date"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>



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
 	
<%@ page errorPage="ReportErrorPage.jsp?page=RsalesSummary.jsp" %>
</head>
<body>
	<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
	
			
		<%
		System.out.println("request.getParameter(hcondition) "+request.getParameter("hcondition"));
		if(request.getParameter("hcondition").equals("summary"))
		{
			//hcondition=summary
		%>
	<center><h2> Sales Summary Report</h2></center>
	<%
		}
	else{
	%>
		<center><h2> Sales Details Report</h2></center>
	<%
	}
	%>	
	<div id="summery" style="display: none;">
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
  
<%
	System.out.println("Rsales sumery ");
	String custtype="";
	String str1="";
	custtype=request.getParameter("type");
	String query="";
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{	
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		conn = ds.getConnection();
		stat=conn.createStatement();
		
		if(custtype!=null && custtype.equals("all")){		
			
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	System.out.println("excel format ");
		    	response.setContentType("application/vnd.ms-excel");
		    }else{		 
		    	System.out.println("text format ");
		    	response.setContentType("text/html");		    
		    }
%>

<% 		
			DecimalFormat df = new DecimalFormat("###,###.00");
			
			String frDate="",toDate="";
			String hchckall="", hcondition="";
			String custName="",custCode="",area="";
			String status="";
			String criteria ="";
			String type="";
			
			frDate = request.getParameter("frDate").trim().replace("/", "-");		
			toDate = request.getParameter("toDate").trim().replace("/", "-");		
			System.out.println("frdate "+frDate+"\n todate "+toDate);
			hchckall = request.getParameter("hchckall"); 		
			hcondition = request.getParameter("hcondition");
			System.out.println("hchckall "+hchckall);

			if(hcondition.equals("summary")){	
				
				System.out.println(" else part summnery ");
			type="Summary";	
		            if(hchckall.equals("1")){		
		            	System.out.println("if...");
						query="select a.custcode, e.custname, e.area, count(Distinct a.order_num), "+
								"count(*) Total_Items, sum(d.fmcg_ind)*100 / count(*) fmcg, "+
								"sum(d.fmcg_ind) fmcg_items, "+
								"sum(b.price), sum(b.mrp * b.qty),sum((b.mrp * b.qty)-b.price) "+
								"from orders a, order_detail b, "+
								"item_master c, item_group d, customer_master e "+
								"where a.order_num = b.order_num "+
								"and b.item_code = c.item_code "+ 		
								"and c.item_group_code = d.item_group_code "+
								"and a.custcode=e.custcode "+
								//"and a.order_date between '"+frDate+"' and '"+toDate+"' group by a.custcode, e.custname, e.area";
								"and date_format(a.order_date,'%Y-%m-%d') between ? and ? group by a.custcode, e.custname, e.area";
								criteria = "All";
								System.out.println("if...");
					}
					else{
		            	System.out.println("else...");
						
					   custCode = request.getParameter("custCode");
					   custName = request.getParameter("hitem");
					   System.out.println("custName "+custName);
					   area = request.getParameter("area");
					   criteria = custCode+"-"+custName+"-"+area;
					   query="select a.custcode, e.custname, e.area, count(Distinct a.order_num), "+
								"count(*) Total_Items, sum(d.fmcg_ind)*100 / count(*) fmcg, "+
								"sum(d.fmcg_ind) fmcg_items, "+
								"sum(b.price), sum(b.mrp*b.qty),  sum((b.mrp * b.qty)-b.price) "+
								"from orders a, order_detail b, "+
								"item_master c, item_group d, customer_master e "+
								"where a.order_num = b.order_num "+
								"and b.item_code = c.item_code "+ 								
								"and c.item_group_code = d.item_group_code "+
								"and a.custcode=e.custcode "+
								//"and a.order_date between '"+frDate+"' and '"+toDate+"' ";
								"and date_format(a.order_date,'%Y-%m-%d') between ? and ? ";
					  if(custCode!=null && !custCode.equals("")){
			    			query = query + "and a.custcode like'" + custCode + "%'";
			    	   }			   
					   if(custName!=null && !custName.equals("")){						   
					   		String itemname =  request.getParameter("hitemname");
							//String iname =  request.getParameter("hitem");		   
					   		String tempArray1[] = new String[100];					   		
							String itemnamelist="";
							tempArray1 = itemname.split("#");
							for(int i=0; i<tempArray1.length; i++){	
								if(i == 0){
									itemnamelist = "'"+tempArray1[i]+"'";
								}else{
									itemnamelist = itemnamelist +","+"'"+ tempArray1[i]+"'";
								}
							}							
			    			//query = query + " and e.custname in (" + itemnamelist + ")";
			    			query = query + " and e.custname like  '" + custName + "%'";
			    	   }
			    	   if(area!=null){
			    			query = query + " and e.area like'" + area + "%'";
			    	   }
			    	 	query =query +" group by a.custcode, e.custname, e.area";
			    	 	
			    	 	
					}
	
				
			String c_code="";
			String c_name="";
			String c_area="";
			
			int total_orders=0;		
			int total_items=0;		
			int grand_total_orders=0;
			int grand_total_items=0;
			
			float total_value= 0.0f;
			float total_fmcg= 0.0f;
			float total_fmcgitems= 0.0f;
			float total_mrp= 0.0f;
			float total_disc= 0.0f;
			
			float grand_total_value=0.0f;
			float grand_total_fmcg= 0.0f;
			float grand_total_fmcgitems=0.0f;		
			float grand_total_mrp=0.0f;
			float grand_total_disc=0.0f;		
			
			
			//rs=stat.executeQuery(query);
			System.out.println("query "+query);
			System.out.println("ppp  frdate "+ frDate +" \n todate "+toDate+" \n query" +query);
   			PreparedStatement preparedStatement = conn.prepareStatement(query);
   			preparedStatement.setDate(1, Date.valueOf(frDate));
   			preparedStatement.setDate(2, Date.valueOf(toDate));
   			System.out.println("ppp  frdate "+ frDate +" \n todate "+toDate+" \n query" +query);
   			rs= preparedStatement.executeQuery();
			ArrayList<SalesSummeryOutputBean>  gsonOutArrayList = new  ArrayList();
			JsonOutputBean  jsonOutputBean = new JsonOutputBean();
	    	 while(rs.next()) {  
	    	  SalesSummeryOutputBean analysisReportOutputBean = new  SalesSummeryOutputBean();
	    	  
	    		
	    		c_code = rs.getString(1);
	    		c_name = rs.getString(2);		
	    		c_area = rs.getString(3);	
	    		total_orders = rs.getInt(4);		
	    		total_items = rs.getInt(5);	    		
	    		total_fmcg = rs.getFloat(6);
	    		total_fmcgitems = rs.getFloat(7);
	    		total_value = rs.getFloat(8);
	    		total_mrp = rs.getFloat(9);
	    		total_disc = rs.getFloat(10);
	    	
	    		analysisReportOutputBean.setCustomerCode(c_code);
	    		analysisReportOutputBean.setCustomerCode1("<a href=\"javascript:passVar(\'"+c_code+"\');\">"+c_code+" </a>");
	    		
	    		analysisReportOutputBean.setCustomerName(c_name);
	    		analysisReportOutputBean.setCustomerArea(c_area);
	    		analysisReportOutputBean.setTotalOrders(total_orders);
	    		analysisReportOutputBean.setTotalItems(total_items);
	    		
	    		analysisReportOutputBean.setTotalFmcg(total_fmcg);
	    		analysisReportOutputBean.setTotalFmcgItems(total_fmcgitems);
	    		analysisReportOutputBean.setTotalValue(total_value);
	    		analysisReportOutputBean.setTotalMrp(total_mrp);
	    		analysisReportOutputBean.setTotalDisc(total_disc);
	    		
	    		
	    		
	    		
	    		
    			grand_total_orders = total_orders + grand_total_orders;
    			grand_total_items = total_items + grand_total_items;			
				grand_total_fmcg = total_fmcg + grand_total_fmcg;
				grand_total_fmcgitems = total_fmcgitems + grand_total_fmcgitems;	
				grand_total_value = total_value + grand_total_value;
				grand_total_mrp = total_mrp + grand_total_mrp;
				grand_total_disc = total_disc + grand_total_disc;
	    		jsonOutputBean.setOutputData(analysisReportOutputBean);
				
				gsonOutArrayList.add(analysisReportOutputBean);
		
		} 
	    	jsonOutputBean.setOutputData(gsonOutArrayList); 
	    		jqxgridFormat format = new jqxgridFormat("Customer Code","customerCode");
	    		format.setHidden(true);
    			jsonOutputBean.getFormat().add(format);
    			jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode1","150px"));
    			jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","customerName","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Area","customerArea","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems","150px"));
			
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Fmcg","totalFmcg","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Fmcg Items","totalFmcgItems","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","totalValue","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Mrp","totalMrp","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Disc","totalDisc","150px"));
			
	    	System.out.println(new Gson().toJson(jsonOutputBean));
	    	out.println(new  Gson().toJson(jsonOutputBean));	
	
			}else{
				System.out.println(" else part deatails ");
				ArrayList<SalesDetailsOutputBean> gsonList = new ArrayList();
				
				type="Details";
					if(hchckall.equals("1")){		
						//query="select a.order_num, a.custcode, b.custname, b.area, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, a.lastmodifieddate , a.status_code from orders a, customer_master b where a.custcode=b.custcode and order_date between '"+frDate+"' and '"+toDate+"' ";
						query="select a.order_num, a.custcode, b.custname, b.area,trim(date( a.order_date)), a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount,trim(date( a.lastmodifieddate)) , a.status_code from orders a, customer_master b where a.custcode=b.custcode and date_format(order_date,'%Y-%m-%d') between ? and ? ";
						criteria ="All";
						
					}
					else{
						
					   custCode = request.getParameter("custCode");
					   custName = request.getParameter("custName");
					   area = request.getParameter("area");
					    criteria = custCode+"-"+custName+"-"+area;

					  // query="select a.order_num, a.custcode, b.custname, b.area, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, a.lastmodifieddate, a.status_code from orders a, customer_master b where a.custcode=b.custcode and order_date between '"+frDate+"' and '"+toDate+"' ";
					query="select a.order_num, a.custcode, b.custname, b.area, trim(date(a.order_date)), a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount,trim(date(a.lastmodifieddate)), a.status_code from orders a, customer_master b where a.custcode=b.custcode and date_format(order_date,'%Y-%m-%d') between ? and ? ";
					   if(custCode!=null){
			    			query = query + "and a.custcode like'" + custCode + "%'";
			    	   }			   
					   if(custName!=null){
			    			query = query + " and b.custname like'" + custName + "%'";
			    	   }
			    	   if(area!=null){
			    			query = query + " and b.area like'" + area + "%'";
			    	   }
			    	 
					}
					
			String c_code="";
			String c_name="";
			String c_area="";
			String order_date="";
			String last_order_date="";
			
			int order_number=0;		
			int total_items=0;				
			int grand_total_items=0;
			
			float total_value= 0.0f;			
			float total_mrp= 0.0f;
			float total_disc= 0.0f;
			
			float grand_total_value=0.0f;			
			float grand_total_mrp=0.0f;
			float grand_total_disc=0.0f;
			
			System.out.println("query "+query);
			JsonOutputBean  jsonOutputBean =null;
			
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setDate(1, Date.valueOf(frDate));
			preparedStatement.setDate(2, Date.valueOf(toDate));
			
				rs=preparedStatement.executeQuery();
			
			
			jsonOutputBean = new  JsonOutputBean();	
			while(rs.next()) {
				
				System.out.println("data available in sales summery ");	
			
			SalesDetailsOutputBean detailsOutputBean = new SalesDetailsOutputBean();
			    order_number = rs.getInt(1);
			    c_code = rs.getString(2);
	    		c_name = rs.getString(3);		
	    		c_area = rs.getString(4);	
	    		order_date = rs.getString(5);	  			
	    		total_items = rs.getInt(6);	 	    		
	    		total_value = rs.getFloat(7);
	    		total_mrp = rs.getFloat(8);
	    		total_disc = rs.getFloat(9);
	    		last_order_date = rs.getString(10);	    			
	    		status = rs.getString(11);
	    		
	    		detailsOutputBean.setOrderNumber(order_number);
	    		detailsOutputBean.setOrderNumber1("<a href=\"javascript:passVar(\'"+order_number+"\');\">"+order_number+" </a>");
	    		detailsOutputBean.setCustomerCode(c_code);
	    		detailsOutputBean.setCustomerName(c_name);
	    		detailsOutputBean.setCustomerArea(c_area);
	    		detailsOutputBean.setOrderDate(order_date);
	    		
	    		detailsOutputBean.setTotalItems(total_items);
	    		detailsOutputBean.setTotalValue(total_value);
	    		detailsOutputBean.setTotalMrp(total_mrp);
	    		detailsOutputBean.setTotalDisc(total_disc);
	    		detailsOutputBean.setLastOrderDate(last_order_date);
	    		detailsOutputBean.setStatus(status);
	    		
				//jsonOutputBean.setOutputData(detailsOutputBean); 
	    		
    			grand_total_items = total_items + grand_total_items;			
				grand_total_value = total_value + grand_total_value;
				grand_total_mrp = total_mrp + grand_total_mrp;
				grand_total_disc = total_disc + grand_total_disc;
 
 				gsonList.add(detailsOutputBean);
 	
			}	
		
			//set data to json object
			jsonOutputBean.setOutputData(gsonList);
					
					jqxgridFormat format = new jqxgridFormat("Order Number","orderNumber");
					format.setHidden(true);
					jsonOutputBean.getFormat().add(format);
	    			jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNumber1","150px"));
	    			jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Name","customerName","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Area","customerArea","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","orderDate","150px"));
					
					jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","totalValue","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Total Mrp","totalMrp","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Total Disc","totalDisc","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order Date","lastOrderDate","150px"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Status","status","150px"));
				
			System.out.println(new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
		}		

		
	}
		else{
		System.out.println(" else part item ");
			String itemname = request.getParameter("itemnm");
%>
<table border="0" >
		<tr style="background-color:#9797ff"><td><b>Customer Name</b></td><td></td><td><b>Selected Customers</b></tr>
		<tr><td>
		<div class="dropAreasContainer">
		<div id="box" class="dropArea staticDropArea silverDropArea">

<%			String query1 = null;
			String custName = request.getParameter("custName");
			System.out.println("cust name  "+custName);
			if(custName!=null)
				query1="SELECT custname FROM customer_master where custname like '"+custName+"%'";
			else
				query1="SELECT custname FROM customer_master";
			System.out.println("query1 "+query1);
			rs=stat.executeQuery(query1);    
			while(rs.next()) {
%>
			<div class="item silverItem" id="<%=rs.getString(1)%>" align="left"><%=rs.getString(1)%></div>
<%
		}
%>
		<div class="item silverItem lastItem"></div>
		
		</div></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>		
		<td>
		<div id="selbox" class="dropArea staticDropArea goldDropArea">
			<div class="item goldItem lastItem"></div>
		</div>
		</td>
		</tr>
		</table>					
<%
			
	}    
		rs.close();	
        stat.close();
		conn.close();
	}catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>

</div>
<div id="salesSummery" style="border-top:15px;border-top-width :1px;"></div>
</body>

<script type="text/javascript">
var hcondition = "";
var newUrl ="";
function passVar(code){

	url =  window.location.href;
	//alert(url.substr(url.search(".jsp")+5));
	if(hcondition=="summary"){
	
		newUrl= "RsalesDetails.jsp?"+url.substr(url.search(".jsp")+5)+"&orderNo="+code;
		//alert(newUrl);
	    window.location.assign(newUrl);
	  
	   // window.location.replace(newUrl); 
	    
	    
	    
	}
	else{
		//document.myform.orderNo.value=code;
		//document.myform.action="print_order.jsp??&backPage=RcustSalesForm.jsp&buttonFlag=Y";
	    //document.myform.submit();
	    newUrl="print_order.jsp?backPage=RcustSalesForm.jsp&buttonFlag=Y&orderNo="+code;
	   // alert(newUrl);
	    window.location.assign(newUrl);
	    //window.location.replace(newUrl); 
	    
	}
	
}
	function Pass(){
	
		document.myform.action="RsalesSummary.jsp?Exp=1&type=all";
	    document.myform.submit();
	}

function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
}

	window.onload = function(){
		
			url = window.location.href;
		//alert(url);
		
		//alert(url.substr(url.search('hcondition=')+'hcondition='.length)); 
		hcondition=url.substr(url.search('hcondition=')+'hcondition='.length);
		  check();
		
		
		var gsonObject = jQuery.parseJSON($('#summery').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#salesSummery").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
               // pageable :true,
                groupable: true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                columnsresize: true,
                columns: gsonObject.format
            });	
            
            
             $("#saveToExcel").click(function () {
            	
            	
            	$('#salesSummery').jqxGrid('hidecolumn', 'customerCode1');
            	$('#salesSummery').jqxGrid('showcolumn', 'customerCode');
            	
            	$('#salesSummery').jqxGrid('hidecolumn', 'orderNumber1');
            	$('#salesSummery').jqxGrid('showcolumn', 'orderNumber');
            	
            	
                $("#salesSummery").jqxGrid('exportdata', 'xls', 'Sales Details');   
              
                $('#salesSummery').jqxGrid('showcolumn', 'customerCode1');
            	$('#salesSummery').jqxGrid('hidecolumn', 'customerCode');
            	
            	$('#salesSummery').jqxGrid('showcolumn', 'orderNumber1');
            	$('#salesSummery').jqxGrid('hidecolumn', 'orderNumber');
                     
            });	
            
        	
          
	}
	

</script>

</html>