<%@ page import="payment.*"%>
<%
	String username="";
	try{
		username = session.getAttribute("UserName").toString();
		String subject = request.getParameter("comm_subject");
		String feedback = request.getParameter("comm_feedback");
		String cust_code = request.getParameter("cust_code");
		String date = request.getParameter("c_date");
		ManagePayment mp = new ManagePayment("jdbc/js");
		boolean flag = mp.saveCommunication(subject,feedback,cust_code,username,date);
		mp.closeAll();
		if(flag){
			response.sendRedirect("HomeForm.jsp?cust_code="+cust_code+"&msg=yes");
		//	response.sendRedirect("communicationForm.jsp?cust_code="+cust_code+"&msg=yes");
			
		}
	} catch (Exception e){
		response.sendRedirect("Login.jsp");
	}
	
%>
