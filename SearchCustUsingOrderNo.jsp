<%@page import="customer.ManageCustomer"%>
<%
	ManageCustomer manage = new ManageCustomer("jdbc/js");
	String CustCode = manage.getCuode(request.getParameter("order_number"));
	if(CustCode.equals("")){
		response.sendRedirect("EditTargetReportForm.jsp?call_type=receive_payment&msg=not_found");
	} else {
		response.sendRedirect("ReceivePayment.jsp?cust_code="+CustCode);
	}
	manage.closeAll();
%>