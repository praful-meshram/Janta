<%@page import="beans.ItemBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
	
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditItem.jsp" />	
</jsp:include> 
	


<%
		ItemBean ib = new ItemBean();
		
		ib.setI_code(request.getParameter("i_code"));
		ib.setIg_code(request.getParameter("iGroupCode"));
		ib.setI_name(request.getParameter("i_name"));
		ib.setI_barcode(request.getParameter("i_barcode"));
		ib.setI_weight(request.getParameter("i_weight"));
		System.out.print("====\nitem_type "+request.getParameter("item_type"));
		
		ib.setItem_type(request.getParameter("item_type"));
		ib.setI_mrp(Float.valueOf(request.getParameter("i_mrp")));
		ib.setI_rate(Float.valueOf(request.getParameter("i_rate")));
		ib.setI_comm(Float.valueOf(request.getParameter("i_comm")));
		ib.setId_type(request.getParameter("iDealType"));
		ib.setId_chck(request.getParameter("hCheckValue"));
		ib.setI_tickflag(request.getParameter("i_tickflg"));
		
		System.out.println("============\nin editItem.jsp box_qty  "+request.getParameter("box_qty"));
		
		ib.setBox_qty(Integer.parseInt(request.getParameter("box_qty")));
			
		if(request.getParameter("hidd_Remark")!=null){
			ib.setRemark(request.getParameter("hidd_Remark"));
		}
		
		if (ib.getId_chck().equals("1")){
			ib.setId_flag("Y");
			ib.setId_qty(Float.valueOf(request.getParameter("id_qty")));
			ib.setId_amt(Float.valueOf(request.getParameter("id_amt")));	
		}
		else{
			ib.setId_flag ("N");
			ib.setId_type("");
			ib.setId_qty (0);		 
			ib.setId_amt (0);		  
		}
		
		item.ManageItem mi;
		mi = new item.ManageItem("jdbc/js");
    	
		
			int ans = mi.editItem(ib);
	    	if(ans==1){	
				%>
	    	    	<h3><b><br><br><br><center> Sucessfully Updated Item   <font color="blue"> <br><br><%=ib.getI_code()%>, <%=ib.getI_name()%> </font> </center></b></h3>
				<%
	    	}
			else{
			%>
							alert("Error");
			<%		}
		
    	mi.closeAll();
    	
%>  
		