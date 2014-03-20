
<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.ReorderListOutputBean"%>
<%@page import="item.ManageItem"%>
<%
	String site_id = request.getParameter("site_id");
	String site_name = request.getParameter("site_name");
	//ManageItem mi = new ManageItem("jdbc/js");
	ManageItem mi = new ManageItem("jdbc/re");
	mi.getReorderList(site_id);
	int cnt = 0;
	
	ArrayList<ReorderListOutputBean> listOutputBeans = new ArrayList();
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
	if(mi.rs.next()){
		
		do{
			cnt++;
			ReorderListOutputBean outputBean = new ReorderListOutputBean();
			outputBean.setItemCode(mi.rs.getString(1));
			outputBean.setItemName(mi.rs.getString(2));
			outputBean.setItemWeight(mi.rs.getString(3));
			outputBean.setReorderQty(mi.rs.getString(4));
			outputBean.setStoreQty(mi.rs.getString(5)); 
			listOutputBeans.add(outputBean); 
			
		}while(mi.rs.next());
	} else {
	}
	
	jsonOutputBean.setOutputData(listOutputBeans); 
	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Code","itemCode","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","itemName","280px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight","itemWeight","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Reorder Qty","reorderQty","180px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat(site_name+" Qty","StoreQty"));
	
	//jsonOutputBean.getFormat().add(new jqxgridFormat("",""));
	out.print(new Gson().toJson(jsonOutputBean));
	System.out.print(new Gson().toJson(jsonOutputBean));
	
	mi.closeAll();
%>

