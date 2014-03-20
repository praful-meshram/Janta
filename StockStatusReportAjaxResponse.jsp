<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.StockStatusReportOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="report.ManageReports"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

	<%
		String ajaxCall = request.getParameter("ajaxCall");
		if(ajaxCall.equals("itemName")){
			ManageReports manageReports = new ManageReports("jdbc/re");
			ResultSet resultSet = manageReports.getItemList();
			%>
				<select id="itemName" onchange="getItemDetails();">
					<option value="">Select</option>
					<%
						while(resultSet.next()){
							
							%>
								<option value="<%=resultSet.getString(2)%>"><%=resultSet.getString(1)%></option>
							<%
						}
					%>
					
				</select>
			
			<%
			manageReports.closeAll();
		}
		
		else if(ajaxCall.equals("itemDetails")){
			ManageReports manageReports = new ManageReports("jdbc/re");
			ResultSet resultSet = null;
			
			String itemCodeArray []= request.getParameter("itemCodeArray").split(",");
			resultSet =  manageReports.getItemDetails1(itemCodeArray);
			ArrayList<StockStatusReportOutputBean> listOutputBeans = new ArrayList();
			while(resultSet.next()){
				StockStatusReportOutputBean outputBean = new StockStatusReportOutputBean();
				outputBean.setItem_name(resultSet.getString("item_name"));
				outputBean.setItem_group_desc(resultSet.getString("item_group_desc"));
				outputBean.setItem_rate(resultSet.getString("item_rate"));
				outputBean.setItem_mrp(resultSet.getString("item_mrp"));
				outputBean.setSite_name(resultSet.getString("site_name"));
				outputBean.setItem_site_qty(resultSet.getString("item_site_qty"));
				listOutputBeans.add(outputBean);
			}	
			
			manageReports.closeAll();
			
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			jsonOutputBean.setOutputData(listOutputBeans);
			
			jsonOutputBean.getFormat().add(new jqxgridFormat("Site Name","site_name","180"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","item_name","280"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Group Desc","item_group_desc","250"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate","item_rate","170"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item MRP","item_mrp","170"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Site Qty","item_site_qty","120"));
			
			//System.out.println(new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
		}
		else if(ajaxCall.equals("suggestedItemDetails")){
			String itemName = request.getParameter("item_name");
			ManageReports manageReports = new ManageReports("jdbc/re");
			ResultSet resultSet = manageReports.getSuggestedItemList(itemName);
			
			ArrayList<StockStatusReportOutputBean> listOutputBeans = new ArrayList();
			int i=0;
			while(resultSet.next()){
				StockStatusReportOutputBean outputBean = new  StockStatusReportOutputBean();
				outputBean.setItem_name(resultSet.getString("item_name"));
				outputBean.setCheckBox("<input id='checkBox"+(i++)+"' type=\"checkbox\" onclick=\"addStock(this,'"+resultSet.getString("item_code")+"');\">");
				listOutputBeans.add(outputBean);
				
 			}
			manageReports.closeAll();
			
				JsonOutputBean jsonOutputBean = new JsonOutputBean();
				jsonOutputBean.setOutputData(listOutputBeans);
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","item_name"));
				jsonOutputBean.getFormat().add(new jqxgridFormat(" ","checkBox"));
				
				out.println(new Gson().toJson(jsonOutputBean));
				
		}
	%>
