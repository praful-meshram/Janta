<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionAdmin.jsp">	
   <jsp:param name="formName" value="UserAccessForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=UserAccessForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<script src="js/UserAccessList.js"></script> 


<form  name="myform" method="post" action="UserAccess.jsp" > 

	
<%
	Connection conn,conn1;
	Statement stmt,stmt1;
	ResultSet rs,rs1;
	try {
		String name,user_type_code;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select user_type_desc,user_type_code from user_type order by user_type_desc");%>
			<font size="3" color="red">Select Group  : </font><SELECT name="EditUserName" onchange="showHint();return false;">
				<OPTION VALUE=""> Select
<%
		 		while (rs.next()) {
		 			name = rs.getString(1);
		 			user_type_code = rs.getString(2);
		 			%>
					<OPTION VALUE="<%=user_type_code%>"> <%= name%> 
<%
				}
		    	rs.close();
		    	stmt.close();
		    	conn.close();
		}
		catch (Exception e) {
	       	e.getMessage();
	        e.printStackTrace();	        
		}
%>
		</select>
		<br>
		<div id="txtHint"></div>

		
	<input type="submit" value="save" disabled="disabled" id = "submit_button"/>
	<input type="reset" value="Clear"/>
 </form>
</body>
</html>