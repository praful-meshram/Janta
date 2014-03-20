<%@page import="beans.ItemStockOutputBean"%>
<%@page import="beans.SalesSummeryOutputBean"%>
<%@page import="beans.TransferDetailsOutputBean"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.PurchaseDetailsOutputBean"%>
<%@page import="item.ManageItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.StockStatusReportOutputBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="report.ManageReports"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String ajaxCall = request.getParameter("ajaxCall");
System.out.println(" ajaxCall "+ajaxCall);
if(ajaxCall.equals("suggestedItemDetails")){
			String itemName = request.getParameter("item_name");
			ManageReports manageReports = new ManageReports("jdbc/re");
			ResultSet resultSet = manageReports.getSuggestedItemList(itemName);
			
			ArrayList<StockStatusReportOutputBean> listOutputBeans = new ArrayList();
			int i=0;
			
			%>
				<table border="1" style="border-collapse: collapse;width: 100%;height: auto;">
				<tr><th>Suggested Item</th></tr>
			<%
			while(resultSet.next()){
				System.out.println(" item_code "+resultSet.getString("item_code"));
				%>
					<tr style="cursor: pointer;" onmouseover="currentRowOver(this);" onmouseout="currentRowOut(this);"
					onclick="getStock('<%=resultSet.getString("item_code") %>','<%=resultSet.getString("item_name") %>',
					'<%=resultSet.getString("item_weight") %>','<%=resultSet.getString("item_qty")%>');">
					<td><%=resultSet.getString("item_name")+"  ("+(resultSet.getString("item_weight"))+")" %></td>
					</tr>
				<%
				
 			}
			%>
				</table>
			<%
			manageReports.closeAll();
				
		}
else if(ajaxCall.equals("item_stock")){
	ManageItem mi = new ManageItem("jdbc/re");
	JsonOutputBean jsonOutputBean = mi.getCurrentStock(request.getParameter("item_code"));
	
	ResultSet resultSet = mi.getSiteNameList();
	jsonOutputBean.getFormat().add(new jqxgridFormat("PV   ","itemPV"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("MRP   ","itemMRP"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Rate   ","itemRate"));
		while(resultSet.next()){
			System.out.println("#"+resultSet.getString("site_name")+"# site"+resultSet.getInt("site_id"));
			jsonOutputBean.getFormat().add(new jqxgridFormat(resultSet.getString("site_name"),"site"+resultSet.getInt("site_id")));
		}	
		
		mi.closeAll();
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
	
	}
	else if(ajaxCall.equals("purchaseDetails")){
	
		String item_code = request.getParameter("item_code");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		ManageReports manageReports = new ManageReports("jdbc/re");
		ResultSet resultSet = manageReports.getPurchaseDetails(item_code,fromDate,toDate);
		ArrayList<PurchaseDetailsOutputBean> listOutputBean = new ArrayList();	
		while(resultSet.next()){
			PurchaseDetailsOutputBean outputBean = new PurchaseDetailsOutputBean();
			outputBean.setPo_number(resultSet.getInt("po_number"));
			outputBean.setBill_number(resultSet.getString("bill_number"));
			outputBean.setVendor_name(resultSet.getString("vendor_name"));
			outputBean.setSite_name(resultSet.getString("site_name"));
			//outputBean.setItem_name(resultSet.getString("item_name"));
			outputBean.setItem_mrp(resultSet.getFloat("item_mrp"));
			outputBean.setItem_rate(resultSet.getFloat("item_rate"));
			outputBean.setTotal_items(resultSet.getInt("total_items"));
			outputBean.setPo_date(resultSet.getString("po_date"));
			outputBean.setNew_qty(resultSet.getInt("new_qty"));
			outputBean.setEnteredby(resultSet.getString("enteredby"));
			listOutputBean.add(outputBean);
		}
		manageReports.closeAll();
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBean);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("PO Number","po_number"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Bill Number","bill_number"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Vendor Name","vendor_name"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Site Name","site_name"));
		//jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","item_name"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Mrp","item_mrp"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","item_rate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","total_items"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("PO Date","po_date"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("New Qty","new_qty"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Entered By","enteredby"));
		
		System.out.println("purchase "+new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
	} 
	else if(ajaxCall.equals("transferDetails")){
		String item_code = request.getParameter("item_code");
		ManageReports manageReports = new ManageReports("jdbc/re");
		ResultSet resultSet = manageReports.getTransferDetails(item_code);
		ArrayList<TransferDetailsOutputBean> listOutputBean = new ArrayList();
		while(resultSet.next()){
			TransferDetailsOutputBean outputBean = new TransferDetailsOutputBean();
			outputBean.setTransfer_id(resultSet.getInt("transfer_id"));
			outputBean.setItem_mrp(resultSet.getFloat("item_mrp"));
			outputBean.setItem_rate(resultSet.getFloat("item_rate"));
			outputBean.setTransfer_qty(resultSet.getInt("transfer_qty"));
			outputBean.setItem_trans_status(resultSet.getString("item_trans_status"));
			outputBean.setRemark(resultSet.getString("remark"));
			outputBean.setSource(resultSet.getString("source"));
			outputBean.setDest(resultSet.getString("dest"));
			
			listOutputBean.add(outputBean);
		}
		
		manageReports.closeAll();
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBean);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Transfer ID","transfer_id"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Source ","source"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Dest    ","dest"));
		jqxgridFormat format = new jqxgridFormat("Transfer Qty","transfer_qty");
		jsonOutputBean.getFormat().add(format);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item MRP","item_mrp"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","item_rate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Trans Status","item_trans_status"));
		
		//jsonOutputBean.getFormat().add(new jqxgridFormat("Remark","remark"));
		
		System.out.print("transefer "+new Gson().toJson(jsonOutputBean));
		out.print(new Gson().toJson(jsonOutputBean));
	}

	else if(ajaxCall.equals("salesDetails")){
		
		String item_code = request.getParameter("item_code");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		//System.out.println("sales reort JSp  item code "+item_code+"\n frdate "+fromDate+"\n todate "+toDate);
		ManageReports manageReports = new ManageReports("jdbc/re");
		ResultSet resultSet = manageReports.getSalesReport(item_code, fromDate, toDate);
		ArrayList<SalesSummeryOutputBean> listOutputBeans = new ArrayList(); 
		while(resultSet.next()){
			SalesSummeryOutputBean analysisReportOutputBean = new  SalesSummeryOutputBean();
				
			analysisReportOutputBean.setOrderNumber(resultSet.getInt("order_num"));
			analysisReportOutputBean.setOrderDate(resultSet.getString("order_date"));
			analysisReportOutputBean.setTotalQty(resultSet.getInt("qty"));
			analysisReportOutputBean.setItemRate(resultSet.getFloat("rate"));
			analysisReportOutputBean.setTotalItemValue(resultSet.getFloat("price"));
			
			//analysisReportOutputBean.setTotalItemValue(resultSet.getInt("total_value"));
			//analysisReportOutputBean.setItemMRP(resultSet.getString("price"));
			listOutputBeans.add(analysisReportOutputBean); 
		}
				
		manageReports.closeAll();
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBeans);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNumber"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","orderDate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","itemRate"));
		//jsonOutputBean.getFormat().add(new jqxgridFormat("Item MRP","itemMRP"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Qty      ","totalQty"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","totalItemValue"));
		
			
		System.out.println("\n sales  "+new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
	}

	%>