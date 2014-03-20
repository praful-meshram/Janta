<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getItemSelected.jsp" />	
</jsp:include>
 --%>
 
 
<%@ page errorPage="ErrorPage.jsp?page=getItemSelected.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<style type="text/css">
a:link {color: #FF0000}
a:visited {color: #00FF00}
a:hover {color: #FF00FF}
a:active {color: #0000FF}
</style>
<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
		int count=0;
		String ItemName="";
		String query="";
		String presentCount="";
		ItemName=request.getParameter("q");
		presentCount = request.getParameter("pCount");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	query="select item_code,item_name from item_master where item_name like '"+ItemName+"%'";
    	rs=stat.executeQuery(query);  
                   	
		while(rs.next()){	
			if(count==0){ 			
%>			
				<select name="itemsSel" style="z-index:1" onchange="selectedItem(<%=presentCount%>)">
				<option>choose</option>
<%
         		count=count+1;
         	}
%>         		
        	<option value="<%=rs.getString(1)%>">
<%
        	out.println(rs.getString(2)); 
           
%>
			</option>
<%
	     
	      }
	      rs.close();
	      stat.close();
	      conn.close();
	      if(count!=0) {
%>	  
        	  </select>
<%
		  }
         
	 }
	 catch(Exception e){
		 	e.getMessage();
			e.printStackTrace();
	    	rs.close();		
	    	stat.close();
	    	conn.close();
	 }
%>                 