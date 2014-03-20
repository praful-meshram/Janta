<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="profile.jsp" />	
	</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=profile.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
	String username="";
	String email="";
  	String contactNo="";
  	String newPassword="";
  	String cnfPassword="";
  	String query="";
  	username=session.getAttribute("UserName").toString();
  	email=request.getParameter("eEmail");
  	contactNo=request.getParameter("contactNo");
  	newPassword=request.getParameter("newpassword");
  	cnfPassword=request.getParameter("confpassword");
  	
  	Connection conn=null;
	Statement stmt=null;	
	try{
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt=conn.createStatement();
			if(cnfPassword==""){
				query="update user set email_addr='"+email+"',contact_no='"+contactNo+"' where username='"+username+"'";
				stmt.executeUpdate(query);				
%>
				<center><br><br><br><br><br><br><br><br><h3>
 				You Successfully updated your email and contactno
			  	</h3>               
              	</center>
              	</body>
              	</html>
<%           }	
			else if(cnfPassword!=""){
				query="update user set password='"+newPassword+"',email_addr='"+email+"',contact_no='"+contactNo+"' where username='"+username+"'";
				stmt.executeUpdate(query);					
%>
				<br><br><br><br><br><br><br><br><center><h3>
				you Successfully changed your password 
				</h3>               
				</center>
				</body>
              	</html>
<%               
			}
	stmt.close();
	conn.close();
			
              	 
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();    		
    	stmt.close();
    	conn.close();
	}
%>	
	
	