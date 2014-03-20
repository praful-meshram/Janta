   <%@page contentType="text/html"%>   
   <%@ page import="java.sql.*" %>
   <%@ page import="javax.naming.*" %>
   <%@ page import="javax.sql.*" %>
   <jsp:include page="header.jsp" />
   <%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewUser.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=NewUser.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
if (request.getParameter("userName") != null){
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		String selSql = "select username from user";
		selSql=selSql + " where username='"+request.getParameter("userName")+"'";
		rs = stmt.executeQuery(selSql);
		if(rs.next()){  
		rs.close();	
        stmt.close();
		conn.close(); 
%>  
			<jsp:forward page="NewUserForm.jsp?Exp=1" /> 		
			
<%
		}
 		else{
            String insSql = "insert into user values ('" + request.getParameter("userName") + "', '" +
			request.getParameter("userPasswd") + "', now() , DATE_ADD(now(), INTERVAL 10 year)," + 
			request.getParameter("userType")+", sysdate(), '" + request.getParameter("eEmail") + "','"+ request.getParameter("contactNo")+"')";
			int run_sql = stmt.executeUpdate(insSql);
			String name=request.getParameter("userName");
		
			if (run_sql == 1){   
				
%>  
								<h3><b><br><br> <br><center> Sucessfully Created User <b><h3><font color="Blue"><%=name%> </font></h3></b> </center></b></h3>
<%	
			}
		}
		rs.close();	
        stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		rs.close();	
        stmt.close();
		conn.close();
	}
}
	
%>
</body>
</html>