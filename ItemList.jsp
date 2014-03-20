<%@page import="beans.ItemStockOutputBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.StockIOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ManageItem"%>
<%
	String call_option = request.getParameter("call_option");
		if(call_option.equals("item_list")){
			
			String item_name = request.getParameter("item_name");
			String item_code = request.getParameter("item_code");
			String item_group = request.getParameter("item_group");
			String item_barcode = request.getParameter("item_barcode");
			//ManageItem mi = new ManageItem("jdbc/js");
			ManageItem mi = new ManageItem("jdbc/re");
			mi.getItemList(item_name,item_code,item_group,item_barcode);
			ArrayList<StockIOutputBean> listOutputBean = new ArrayList();
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
			while(mi.rs.next()){
				
				StockIOutputBean outputBean = new StockIOutputBean();
				outputBean.setItemName(mi.rs.getString(1));
				outputBean.setWeight(mi.rs.getString(2));
				outputBean.setRate(mi.rs.getString(3));
				outputBean.setMrp(mi.rs.getString(4));
				outputBean.setQuntity(mi.rs.getString(5));
				outputBean.setItemCode(mi.rs.getString(6));
				listOutputBean.add(outputBean);
				}
			 
			mi.closeAll();
			jsonOutputBean.setOutputData(listOutputBean);
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","itemName"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Weight","weight"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Rate","rate"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Mrp","mrp"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Quantity","quntity"));
					
			System.out.println(new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
		%>
			
			
		<%
		}else if(call_option.equals("item_stock")){
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
		%>
