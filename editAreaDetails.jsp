<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editAreaDetails.jsp" />	
</jsp:include> --%>
<%@ page errorPage="ErrorPage.jsp?page=editAreaDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%	
    	
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{
			String area="";
	    	String desc="";	
	    	String hchckall="";	
	    	String query="";
			area=request.getParameter("areaStartWith");
			desc=request.getParameter("descStartWith");
			hchckall=request.getParameter("hchckallStartWith");
			
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			
			if(hchckall.equals("1")){
				 query="select code,value,code_desc from code_table where category='AREA'";
	    	}
	    	else{	
				query="select code,value,code_desc from code_table where category='AREA'";
		    	
		    	if(area!=null){
		    		query = query + " and value like'" + area + "%'";
		    	}
				if(desc!=null){
		    		query = query + " and code_desc like'" + desc + "%'";
		    	}
		    }
		    query =query + "order by value";		    	
	    	rs=stat.executeQuery(query);   	
    	
%>		
    	
 		
       <table  border="1" id="id" class="item3">
      
			<tr>				
				<td width="10%"><b>Area</b></td>
				<td width="10%"><b>Description</b></td>
				
			</tr>
      
<%		    
    	while(rs.next()) {
 %>
			<tr id="tr">	
		
				<td align="left"><a  href="editAreaForm.jsp?code=<%=rs.getString(1)%>&area=<%=rs.getString(2)%>&desc=<%=rs.getString(3)%>"  >	
<%        
    	
			out.println(rs.getString(2));
%>
			</td><td align="left">
<%			
			out.println(rs.getString(3));
%>       
			</td></tr>			        	  
<%		}	    
		rs.close();	
        stat.close();
		conn.close();
	
		
%>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>
<%
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>
