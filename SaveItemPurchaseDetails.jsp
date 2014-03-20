<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SaveItemPurchaseDetails.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=SaveItemPurchaseDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
	String item_code="",purchase_datetime="",user_name="";
	float item_mrp,purchase_price,margin_pct,scheme_value=0,purchase_qty=0,landing_price,total_price,cash_discount;
	int scheme_code,scheme_on_qty=0,vat_code;
	
	item_code=request.getParameter("i_code");
	purchase_datetime=request.getParameter("c_date1");
	item_mrp= Float.parseFloat(request.getParameter("i_mrp"));
	purchase_price= Float.parseFloat(request.getParameter("i_pp"));
	margin_pct= Float.parseFloat(request.getParameter("i_margin"));
	scheme_code=Integer.parseInt(request.getParameter("scheme_code"));
	if(scheme_code!=4){
		scheme_value= Float.parseFloat(request.getParameter("scheme_val"));
		scheme_on_qty=Integer.parseInt(request.getParameter("l_qty"));
		
	}	
	landing_price=Float.parseFloat(request.getParameter("final_price"));
	total_price=Float.parseFloat(request.getParameter("total_price"));
	scheme_code=Integer.parseInt(request.getParameter("scheme_code"));
	purchase_qty= Float.parseFloat(request.getParameter("p_qty"));
	vat_code=Integer.parseInt(request.getParameter("vat_code"));
	user_name=session.getAttribute("UserName").toString();
	
	System.out.println("val" + request.getParameter("cash_discount"));
	if(request.getParameter("cash_discount").equals("")){
		cash_discount=0;
	}	
	else{
		cash_discount=Float.parseFloat(request.getParameter("cash_discount"));	
	}	
	item.ManageItem mi;
	mi = new item.ManageItem("jdbc/js");
	int insert_val=mi.addPurchaseItemDetails(item_code,item_mrp,purchase_price,margin_pct,scheme_code,scheme_on_qty,scheme_value,purchase_qty,purchase_datetime,user_name,vat_code,landing_price,total_price,cash_discount);
	out.println("Saved Sucessfully");
	
%>	