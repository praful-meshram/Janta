<%@page import="payment.ManagePayment" %>
<% 
	String custCode = request.getParameter("custCode");
	ManagePayment mp = new ManagePayment("jdbc/js");
  	out.print(mp.getTotalBalane(custCode));
  	mp.closeAll();
 %>