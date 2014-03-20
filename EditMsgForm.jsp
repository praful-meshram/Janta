<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@ page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditMsgForm.jsp" />	
</jsp:include>  --%>


<%@ page errorPage="ErrorPage.jsp?page=EditMsgForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>



<script type="text/javascript">
<!--
	function checkField(){
		var msg=document.myform.n_msg.value;
		if(msg=="") {
				alert("Please Enter New Message");
				document.myform.n_msg.focus();
				return false;
		}
		else {
		    var ans=confirm("Do you want to Save new Message?");
			if (ans==true){
			   	document.myform.action="ChangeMsg.jsp";
				document.myform.submit();
			}
			else{
			  window.refresh; 
			 }			
		}	
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
</script>	

<% 
                String name="";
                Connection conn=null;
				Statement stmt=null;
				ResultSet rs=null;
				try {
					
					Context initContext = new InitialContext();
					Context envContext  = (Context)initContext.lookup("java:/comp/env");
					DataSource ds = (DataSource)envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					rs = stmt.executeQuery("select value from code_table where category='BILLMSG' ");
					while (rs.next()) {
					 	name = rs.getString(1);
					}
					rs.close();
					stmt.close();
					conn.close();
    			}
    			catch(Exception e){
    				e.getMessage();
					e.printStackTrace();
    				rs.close();		
    				stmt.close();
    				conn.close();	
    			}	
%>	
					

	
<br><Br><center><h3>Change Bill  Message</h3></center><br>
<form name="myform" action="HomeForm.jsp">
	<table  align="center">
		<tr>
			<td><b>Current Bill Message &nbsp&nbsp</b></td>
			<td><b>: </b>&nbsp;<input type="text" name="c_msg" size="50" disabled value="<%=name%>"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>	
			<td><b>New Bill <font color="blue">M</font>essage</b></td><td><b>: </b>&nbsp;<input type="text" name="n_msg" size="50"></td>
		</tr>
	</table>
	<br><br>
    <center><input type="submit" name="Submit" value="Submit <Alt+s>" disabled accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	
</form>
<script type="text/javascript">
    document.myform.n_msg.focus();
    function check(){
    		document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
</body>
</html>