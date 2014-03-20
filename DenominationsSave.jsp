<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DenominationsSave.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ErrorPage.jsp?page=DenominationsSave.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%@page contentType="text/html"%>


<%	
	Connection conn=null;
	Statement stmt=null,stat=null;
	ResultSet rs=null,rs1=null;
	String strquery = "";
	String[] denomid ; 
	String denomStr="";	
 	denomStr = request.getParameter("hdenomid"); 	

 	denomid  = denomStr.split(","); 
	
	
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		strquery ="update valid_denominations set active_flag='N'";		
		int runsql =stmt.executeUpdate(strquery);							
		for(int i=0; i < denomid.length;i++){
			if(!denomid[i].equals("")){
			 int denom = Integer.parseInt(denomid[i]);	
				strquery ="update valid_denominations set active_flag='Y' where denom_id="+denom;
				int runsql1 =stmt.executeUpdate(strquery);						
			}
		}
		
		
		
		conn.close();
	}catch(Exception e){
		conn.close();
	   System.out.println(e);
	}	
		
%>
<jsp:forward page="HomeForm.jsp"/>
					