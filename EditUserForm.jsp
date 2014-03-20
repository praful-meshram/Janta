<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditUserForm.jsp" />	
</jsp:include>  --%>


<%@ page errorPage="ErrorPage.jsp?page=EditUserForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

 
<script src="js/editUser_details.js"></script> 
<style>
form fieldset {
	border: 1px solid #21221A;
	width: 400px; 
	height:auto;
	background-color:white;
}
</style>
<form  name="myform" method="post" action="Edition.jsp" onsubmit="return(validateString(this.userPasswd, 'Please enter Password', 'Passwd Length should Be Six Chars Or More', 6, 20, true) && validateEmail(this.eEmail, 'Please enter a valid email address', true)) ;"> 
	<h2><center>Select User For Edit</center></h2>
	<center><fieldset><legend align="center">
<%
	Connection conn,conn1;
	Statement stmt,stmt1;
	ResultSet rs,rs1;
	try {
		String name;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select username from user order by username");%>
			<SELECT name="EditUserName" onchange="showHint();return false;">
			<OPTION VALUE="Select">Select</OPTION>
<%
		 		while (rs.next()) {
		 			name = rs.getString(1);%>
					<OPTION VALUE="<%=name%>"> <%= name%> </OPTION>
<%
				}
		    	rs.close();
		    	stmt.close();
		    	conn.close();
		}
		catch (Exception e) {
	       	e.getMessage();
	        e.printStackTrace();	        
		}
%>
		</select></legend>
		<br>	
		<div id="txtHint"></div>

		<center><input name="Operation" type="hidden" value="" ></center>
		<center><input name="frDate" type="hidden" ></center>
		<center><input name="toDate" type="hidden"  ></center>
        </fieldset></center>
</form>
<script>
	function check(){
	    document.myform.Submit.disabled=false;
	}
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	var endyear = year + 10;
	var frDate1 =  year+"/"+month+"/"+day ;
	var toDate1=  endyear+"/"+month+"/"+day ;
	document.myform.frDate.value=frDate1;
	document.myform.toDate.value=toDate1;
	document.onkeyup = check;
</script>
</body>
</html>