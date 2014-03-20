<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />     
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewUserForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=NewUserForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script type="text/javascript">
<%
		String str1="";
	    str1=request.getParameter("Exp");
%>
	var jExp=<%=str1%>
	
	function trimString(str){
	  	return str.replace(/^\s+|\s+$/g, '');
	}
	
	function validateString(field, errmsg, lenmsg, min, max, required){
		if (!field.value && !required){
		    return true;
		  }
		if (!field.value){
		   	alert(errmsg);
		  	field.focus(); 
		  	field.select(); 			  
			return false;
		 }
		if (trimString(field.value).length < min || field.value.length > max){
		  	alert(lenmsg);
		  	field.focus(); 
		  	field.select(); 
		  	return false;
		 }
		return true; 
	}
	
	function validateEmail(email, msg, required){ 
		if (!email.value && !required){ 
			return true; 
	  	 } 
		var regEx = /^[\w-\.\+]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$/; 
		if (!regEx .test(email.value)){ 
			alert(msg); 
			email.focus(); 
			email.select(); 	
			return false; 
		} 
		return true; 
	}
	
	function showMsg(){
		 	 document.NewUserForm.action="HomeForm.jsp";
			 document.NewUserForm.submit();
    }
	
	function ClearAll(){
		document.NewUserForm.userName.value="";
		document.NewUserForm.userPasswd.value="";
		document.NewUserForm.eEmail.value = "";
		document.NewUserForm.contactNo.value = "";
		return false;
	 }
	
	if(jExp==1){
		alert("User Name already exists !!!");
	}

</script>
<style>
form fieldset {
	border: 1px solid #21221A;
	width: 400px; 
	height:auto;
	background-color:white;
}
</style>
<p>
 <br><br>
		<center>
	 	<br>
<form method="post" name="NewUserForm" action="NewUser.jsp"  onSubmit="return(validateString(this.userName, 'Please enter your name', 'Name must be between 3 and 20 characters', 3, 20, true)&& validateString(this.userPasswd, 'Please enter Password', 'Passwd Length should Be Six Chars Or More', 6, 20, true) && validateEmail(this.eEmail, 'Please enter a valid email address', true) ) ;">
	 	<fieldset><legend><font size="4"><b> New user creation </b></font></legend>
	 	<br/>
	 	<table align="center">
	 	    <tr>
			     <td align="left"><b><font color="blue">U</font>ser Name </td><td> : </td>
			     <td><input name="userName" id="userName"  type="text" maxlength="20" value="" accesskey="u"><br></td>
			</tr>
			<tr></tr>
			<tr>
			      <td align="left"><b><font color="blue">P</font>assword</td><td> : </td>
			      <td><input name="userPasswd" id="userPasswd"  type="password"  maxlength="20" value=""  accesskey="p"></td>
			</tr>
			<tr></tr>
			<tr>
			      <td align="left"><b><font color="blue">T</font>ype Of User</td><td> : </td>
<%
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	try {
		String name,desc;
		int rowcount;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select user_type_code, user_type_desc from user_type");
%>
			      	<td>
						<SELECT name="userType"  maxlength="20" accesskey="t" style="width:11em">
<% 
		rowcount = 0;
	 	while (rs.next()) {
	 		name = rs.getString(1);
	 		desc = rs.getString(2);
	 		if (rowcount==0) { 
 %>
							<OPTION VALUE="<%= name%>" ><%= desc%></OPTION>
<%
  			}
   			else {
%>
								<OPTION VALUE="<%= name%>" ><%= desc%></OPTION>
<%
			} 
			rowcount++;
		}
		rowcount=0;
	    rs.close();
	    stmt.close();
	    conn.close();
    }
	catch (Exception e) {
        e.getMessage();
        e.printStackTrace();
        rs.close();
    	stmt.close();
    	conn.close();
   }
%>
					</td>
					</SELECT>
				</TR>
				<tr></tr>
			    <tr>
					<td align="left"><b><font color="blue">E</font>mail Id</td><td> : </td>
				   	<td><input name="eEmail" id="eEmail" type="text" maxlength=40 value="" accesskey="e"></td>
				</tr>
				<tr></tr>
				<tr>
					<td align="left"><b><font color="blue">C</font>ontact No</td><td> : </td>
				    <td><input name="contactNo" id='contactNo' type="text" size=20 maxlength=20 accesskey="c"></td>
				</tr>
			</table><br><br>
			<center><input name="Operation" type="hidden" value="" ></center>
			<center><INPUT type="submit" value="Submit" name="Submit" disabled accesskey="s">&nbsp; <INPUT type="reset" value="Clear" accesskey="r" onClick="ClearAll();return false;">&nbsp&nbsp<INPUT type=BUTTON value="Cancel" accesskey="s" onClick="showMsg();"></center>
   
</fieldset></form></center>
<script>
	document.NewUserForm.userName.focus();
	function check(){
    	document.NewUserForm.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
</body>

</html>
