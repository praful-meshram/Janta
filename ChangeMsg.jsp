<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />

<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ChangeMsg.jsp" />	
</jsp:include>

<%       String n_msg="",query="";
		 Connection conn=null;
	     Statement stmt=null;
	   
		 n_msg=request.getParameter("n_msg");
		 try {				
				Context initContext = new InitialContext();
				Context envContext  = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/js");
				conn = ds.getConnection();
				stmt = conn.createStatement();
				query="update code_table set value='"+n_msg+"' where category='BILLMSG'";
           		int run_sql= stmt.executeUpdate(query);
    	   		if(run_sql==1){
%>
		    		<h3><b><br><br><br><center> Sucessfully Updated Message <br><font color="blue"><%=n_msg%></font></center></b></h3>
		    		</h3>               
		            </center>
		            </body>
		            </html>
<%
				}
				stmt.close();
				conn.close(); 
		              	 
		 }
		 catch(Exception e){
		 		System.out.println(e);
		 		stmt.close();
				conn.close(); 
		 }
%>	
					