<%@page import="beans.CancelOrderOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.CancelOrderDAO"%>
<%@page import="beans.CancelOrderInputBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="cancelOrderInputBean" class="beans.CancelOrderInputBean" scope="request">
	<jsp:setProperty property="*" name="cancelOrderInputBean"/>
</jsp:useBean>
	
	<%
	String ajaxOption = request.getParameter("ajaxOption");
	if(ajaxOption.equals("getOrderDetails")){
	%>
	<table border="1" class="item3" style="border-collapse: collapse;max-height: 100%;text-align: center;">
    	 <thead style="">
			<tr style="max-height: 7px;">
				<td width="5%"><b>OrderNumber</b></td>
				<td width="10%%"><b>Order Date</b></td>
				<td width="15%"><b>Customer Name</b></td>
				<td width="10%"><b>Payment Type</b></td>
				<td width="10%"><b>Entered By</b></td>
				<td width="10%"><b>Status</b></td>
				<td width="10%"></td>				
				</tr>
		</thead><tbody style="overflow: auto;max-height: 200px;">
		<%
			CancelOrderDAO cancelOrderDAO = new CancelOrderDAO();
			int i =0;
			ArrayList<CancelOrderOutputBean> listCancelOrderOutputBeans = cancelOrderDAO.getOrderDetails(cancelOrderInputBean);
			for(CancelOrderOutputBean bean : listCancelOrderOutputBeans){
			%>
				
				<tr id="id<%=i%>" style="max-height: 7px;">
				<td  width="5%"><%=bean.getOrderNumber() %></td>
				<td width="10%"><%=bean.getOrderDate() %></td>
				<td width="15%"><%=bean.getCustName() %></td>
				<td width="10%"><%=bean.getPayment_type_desc() %></td>
				<td width="10%"><%=bean.getEnterd_by() %></td>
				<td width="10%"><%=bean.getStatusCode() %></td>
				
				<td width="10%"><button onclick="cancelOrder('<%=bean.getOrderNumber()%>','id<%=i%>');return false;" style="height: inherit; ">Cancel Order </button></td>				
				</tr>
				<%
				i++;
			
			}
			
		%></tbody>
	</table>
	
	<%
	}
	else if(ajaxOption.equals("cancelOrder")){
		String orderNumber = request.getParameter("orderNum");
		CancelOrderDAO cancelOrderDAO = new CancelOrderDAO();
		boolean flag =  cancelOrderDAO.cancelOrder(orderNumber);
		out.print("order cancelled .. ");
		
		
	}
	%>