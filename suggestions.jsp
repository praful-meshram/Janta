<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="suggestions.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ErrorPage.jsp?page=suggestions.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
		int count=0;
		String ItemName="";
		String query="";
		String presentCount="";
		String itemStr="";
		String itemCode="";
    	String itemDetails="";
    	
		
		ItemName=request.getParameter("letters");
		//presentCount = request.getParameter("pCount");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	query="select item_code,concat(item_name,'#',item_weight,'#',item_rate,'#',item_mrp) from item_master where item_name like '"+ItemName+"%' order by item_name";
    	rs=stat.executeQuery(query);  
    	     	
    	                  
		while(rs.next()){
		
		itemCode = rs.getString(1);
    	itemDetails = rs.getString(2);
    		
			
			if(count==0){ 			
			
				itemStr = "|NA###Item Name#Wgt#Rate#MRP|" + itemCode + "###" + itemDetails;
        //		itemStr = itemCode + "###" + itemDetails;
				count=count+1;
         	}
         	else
         	{
         	
         		itemStr = itemStr + "|" + itemCode + "###" + itemDetails;
         	}
	     }
	    out.println(itemStr);     			
	    rs.close();
	    stat.close();
	    conn.close();
	}
         
	catch(Exception e){
		System.out.println(e);
		rs.close();
	    stat.close();
	    conn.close();
	}

%>                 