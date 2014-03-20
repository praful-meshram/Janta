<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@page contentType="text/html"%>
<script src="js/custOrderSummDetails.js"></script> 	
<link rel="stylesheet" type="text/css" href="stylesheet/menu.css" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditOrderForm.jsp" />	
</jsp:include> 
 --%>
 <%@ page errorPage="ErrorPage.jsp?page=EditOrderForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<style type="text/css">
	hr {
		color: gray;
		height: 3px;
	}
	body {
		font-family: Lucida Grande, Arial, sans-serif;
		font-size: 10px;
		text-align: center;
		margin: 0;
		padding: 0;
		color: black;		
	}	
	table
	{
		border: 1px;		
		font-size: 10px;
	}
	tr,
	{
		vertical-align: top;
		height:5px;
	}
	th
	{
		text-align: left;
		background-color:#FFE4C4
	}
	th,
	td
	{
		padding: 0px;
		font-family: Lucida Grande, Arial, sans-serif;
		font-size: 1.2em;
		height: 5px;		
	}	
	a {
		font-weight: bold;
		text-decoration: none;
		color: #f30;
	}
	INPUT{ 
		height: 16px;
	    font-size:9px;  
	    line-height: 9px; 
	}
	input.button{ 
		height: 20px;
	    font-size:20px;  
	    line-height: 20px;
	}	
	a:hover {
		color: #fff;
		background-color: #f30; 
	}	
	#content h1 {
		font-size: 1.6em;
		border-bottom: 1px solid #ccc;
		padding: 5px 0 5px 0;
	}

	#content h2 {
		font-size: 1.2em;
		margin-top: 3em;
	}
</style>			
<br><br>
<form name="myform">

<%		Integer siteID = Integer.parseInt(session.getAttribute(
		"GlobalSiteId").toString());
		String user=(String)session.getAttribute("UserName");
		String orderNo="",orderNum="",statusCode="",CustCode="",copyOrder="";	
		orderNo=request.getParameter("horderNo");			
		copyOrder=request.getParameter("hcopy");
		if(copyOrder==null){
			copyOrder="";
		}
		statusCode=request.getParameter("hstatusCode");		
		// This orderNum is passed from tracking.js when this orderNum is holded
		orderNum=request.getParameter("orderNo");
		String holdOrderStr=request.getParameter("holdOrder");			
		if(!orderNum.equals("") && holdOrderStr!=null){
			orderNo = orderNum;
			statusCode=request.getParameter("status_Code");
		}		
		Connection conn=null;
		Statement stat=null;	
		ResultSet rs=null;
		String url1="";
		String username1="";
		String password1="";
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			
			url1 = (String) envContext.lookup("url");		   
			username1 = (String) envContext.lookup("username");			
			password1 = (String) envContext.lookup("password");								
		
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			String query="select custcode from orders where order_num ='"+ orderNo +"'";	
			rs=stat.executeQuery(query);	
			while(rs.next()) {	
				CustCode = rs.getString(1);
			}
			rs.close();
			stat.close();
			conn.close();
		}catch(Exception e){
			System.out.println("Exception in Finding Customer Code "+ e);
			rs.close();
			stat.close();
			conn.close();
		}
%>		 
	
<jsp:plugin type="applet" code="applet.EditCustomerOrderApplet.class" codebase="applet/classes/" 
archive="mysql-connector-java-5.1.10-bin.jar" name="EditOrder"  width="100%" height="300" >
   <jsp:params>
   
          <jsp:param
               name="dburl"
               value='<%=url1%>'
          />
           
           <jsp:param
               name="dbusername"
               value='<%=username1%>'
          /> 
       
           <jsp:param
               name="dbpassword"
               value='<%=password1%>'
          />
          <jsp:param
               name="orderNo"
               value="<%=orderNo%>"
          />        
           
          <jsp:param
               name="user"
               value="<%=user%>"
          />      
          
          <jsp:param
               name="statusCode"
               value="<%=statusCode%>"
          />                
          
          <jsp:param
               name="copyOrder"
               value="<%=copyOrder%>"
          /> 
          <jsp:param
               name="siteID"
               value="<%=siteID%>"
          /> 
          
          
     </jsp:params>

     <jsp:fallback>
          <B>Unable to start plugin!</B>
     </jsp:fallback>

</jsp:plugin>

	
	<input type="hidden" name="orderNo" value="<%=orderNo%>">
	<input type="hidden" name="hcuscode" value="<%=CustCode%>">
	<input type="hidden" name="backPage" value="customer_detailsForm.jsp">
	<input type="hidden" name="printed" value="0">	
	
	<tr><td><br><hr><br>
	<table align="right" width="49%">
	 <tr>
	  <td >
	   <div id="txtHint" class="ddm1" >	</div>
	  </td>
	 </tr>
	</table>
	
	<div id="txtHint1" class="ddm1" align="left">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
		
	
</form>
<script>
	
		window.onload=showHint1;
		var allowBackspace = false;
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			
			var key = event.keyCode;
			if (key==8) {
				if (allowBackspace==false) {
					return false;
				}
				else {
					return true;						
				}
			}
		}	
		
		function showMsg(){				
				document.myform.action="HomeForm.jsp";
			    document.myform.submit();					   
	    }	
	    function showMsgSend(){			
				if(document.myform.printed.value ==1){			    
					document.myform.action="print_order1.jsp";
				    document.myform.submit();					   
				}		
				if(document.myform.printed.value == 0){			    
					document.myform.action="customer_detailsForm.jsp";
				    document.myform.submit();					   
				}					    
	    }
	    	
</script>
</body>
</html>