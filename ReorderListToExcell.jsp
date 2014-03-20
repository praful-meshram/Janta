<%
response.setContentType("application/vnd.ms-excel");
out.print(request.getParameter("data"));
%>