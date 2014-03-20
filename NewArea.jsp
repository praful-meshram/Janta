   <%@page contentType="text/html"%>   
   <%@ page import="java.sql.*" %>
   <%@ page import="javax.naming.*" %>
   <%@ page import="javax.sql.*" %>
   <jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewArea.jsp" />	
</jsp:include>
  	 --%>
<%@ page errorPage="ErrorPage.jsp?page=NewArea.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
  	 
<%	
if (request.getParameter("area")!= null){
	Connection conn=null;
	Statement stmt,stmt1;
	ResultSet rs,rs1;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		String selSql = "select value from code_table where category='AREA'";
		selSql=selSql + " and value='"+request.getParameter("area")+"'";
		rs = stmt.executeQuery(selSql);
		if(rs.next()){  
		rs.close();	
        stmt.close();
		conn.close(); 
%>  
			<jsp:forward page="NewAreaForm.jsp?Exp=1" /> 		
			
<%
		}
 		else{
 			String areaCode=""; 
 			String defualt="AREA";			
 			String name=request.getParameter("area");
 			String desc=request.getParameter("desc");
 			stmt1 = conn.createStatement();
 			String selSql1 = "select count(code) from code_table where category='AREA' group by category";
 			
			rs1 = stmt1.executeQuery(selSql1);		
			if(rs1.next()){  
				areaCode = rs1.getString(1);				
			}	
			int aCode=Integer.parseInt(areaCode);
			aCode = aCode + 1;			
            String insSql = "insert into code_table values ('"+defualt+"', "+aCode+",'"+request.getParameter("area")+"','"+request.getParameter("desc")+"')";
       		int run_sql = stmt.executeUpdate(insSql);	
			if (run_sql == 1){   
				
%>  
								<h3><b><br><br> <br><center> Sucessfully Created Area <b><h3><font color="Blue"><%=name%> </font></h3></b> </center></b></h3>
<%	
			}
			rs1.close();	
        	stmt.close();
			conn.close();
		}
		
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
		
	}
}
	
%>
</body>
</html>