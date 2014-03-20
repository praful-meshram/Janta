<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditArea.jsp" />	
</jsp:include>

<%
	String code="";
  	String area="";
  	String desc="";
  	String query="";
  	code=request.getParameter("hcode");
  	area=request.getParameter("area");
  	desc=request.getParameter("desc");
  	
  	Connection conn=null;
	Statement stmt=null;	
	try{
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt=conn.createStatement();
			
		query="update code_table set value='"+area+"',code_desc='"+desc+"' where category='AREA' and code='"+code+"'";
		int run_sql=stmt.executeUpdate(query);			
		if (run_sql==1)
		{
%>
				<br><br><br><br><br><br><br><br><center><h3>
				you Successfully update Area <font color="blue"><%=area%></font>
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
	
	