 <%@page contentType="text/html"%>   
    <%@page import="java.sql.*" %>
    <%@page import="javax.naming.*" %>
    <%@page import="javax.sql.*" %>
 <jsp:include page="header.jsp" />
<%--  <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="Edition.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=Edition.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


 
<% 
    
	if(request.getParameter("Operation").equals("0")){
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement(); 
			String updSql="update user set username='"+request.getParameter("userName")+
			"',password='"+request.getParameter("userPasswd")+
			"',start_dt='"+request.getParameter("frDate")+
			"',end_dt='"+request.getParameter("toDate")+
			"', user_type_code='"+request.getParameter("userType")+
			"',email_addr='"+request.getParameter("eEmail")+
			"',contact_no='"+request.getParameter("contactNo")+
			"'where username='"+request.getParameter("userName")+"' ";
			int run_sql = stmt.executeUpdate(updSql); 
			String name=request.getParameter("userName");
			if (run_sql==1){ 			
%>  
			<h3><b><br><br> <br><center>Sucessfully Updated User <b><h3><font color="Blue"><%=name%> </font></h3></b> </center></b></h3>
<%	
			}
			stmt.close();
			conn.close();
		  	}
			catch (Exception e) {
				e.getMessage();
				e.printStackTrace();				
			}
	}
	else if(request.getParameter("Operation").equals("1")){
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement(); 
			String delSql="delete  from user where username='"+request.getParameter("userName")+"' ";
			int run_sql= stmt.executeUpdate(delSql); 
			String name=request.getParameter("userName");
			if (run_sql==1){ 
				
%>  
			<h3><b><br><br> <br><center>Sucessfully Deleted User <b><h3><font color="Blue"><%=name%> </font></h3></b></center></b></h3>
<%	
			}
			stmt.close();
			conn.close();
	  	}
		catch (Exception e) {
			e.getMessage();
			e.printStackTrace();			
		}
	}	
%>
</body>
</html>