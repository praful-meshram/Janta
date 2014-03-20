<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getItemDetails.jsp" />	
</jsp:include>  --%>


<%@ page errorPage="ErrorPage.jsp?page=getItemDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
	   
		String ItemName="";
		String query="";
		String allRteQty="";
		ItemName=request.getParameter("ItemName");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stat=conn.createStatement();
		query="select item_rate,item_weight,item_mrp, deal_active_flag, deal_on_qty, deal_amount from item_master where item_code = '"+ItemName+"'";
		rs=stat.executeQuery(query);
		if(rs.next()){
        	allRteQty=rs.getString(1)+","+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4)+","+rs.getFloat(5)+","+rs.getFloat(6);
        	out.println(allRteQty); 
        }
        stat.close();
        rs.close();
        conn.close();
     }
     
     catch(Exception e){
     	e.getMessage();
		e.printStackTrace();
    	rs.close();		
    	stat.close();
    	conn.close();
	}
	
%>       