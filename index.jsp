<% 
	if (session.getAttribute("user_type_code") != null) {		
%>
	<jsp:forward page="HomeForm.jsp"></jsp:forward>
<%		 
	}else{
%>
	<jsp:forward page="LoginForm.jsp"></jsp:forward>
<%
	}
%>
