<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
 <jsp:include page="header.jsp" /> 
<%@ page errorPage="ErrorPage.jsp?page=UserAccess.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	String user_id =request.getParameter("EditUserName");
	int rows = Integer.parseInt(request.getParameter("row_count"));
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/js");
	Connection conn = ds.getConnection();
	Statement stmt=null;
 	ResultSet rs1=null;
	for(int i=0;i<rows;i++){
		 try {
			stmt = conn.createStatement(); 			
			String updSql="update user_access set access_flag='"+ request.getParameter("chckaccess"+i) +"' "+
				 		" where user_type_code = "+user_id+" and screen_id = '"+request.getParameter("page_id_"+i)+"'";		
			stmt.executeUpdate(updSql); 
			System.out.println(updSql);
			}catch (Exception e) {	
				System.out.println(i + " :  "+e.toString()  );
			}
	}
	conn.close();
%>
<h3><b><br><br> <br><center>Sucessfully Updated User Access Permissions </center></b></h3>
 
