<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditItemGroup.jsp" />	
</jsp:include>  --%>


<%@ page errorPage="ErrorPage.jsp?page=EditItemGroup.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>



<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
	    String ig_code="";
	    String ig_desc="";
		int fmcg_flag=0,ig_number=0;
	    String query1="";
	    ig_code=request.getParameter("ig_code");
		ig_desc=request.getParameter("ig_desc");
		fmcg_flag=Integer.parseInt(request.getParameter("hfmcg_flag"));
		ig_number = Integer.parseInt(request.getParameter("ig_number"));
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	
    	query1="update item_group set item_group_desc='"+ig_desc+"', fmcg_ind='"+fmcg_flag+"', item_group_number="+ig_number+" where item_group_code='"+ig_code+"'";     	
    	int run_sql=stat.executeUpdate(query1);
    	
		if(run_sql==1){
%>
    	    	<h3><b><br><br><br><center> Sucessfully Updated Item Group    <font color="blue"> <br><br><%=ig_code%>, <%=ig_desc%> </font> </center></b></h3>
<%
    	}
    	
    	stat.close();    	
    	conn.close();
   
    }catch(Exception e){
    	e.getMessage();
		e.printStackTrace();    	
    	stat.close();    	
    	conn.close();
    }	
%>  
	