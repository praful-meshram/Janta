<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="Edit_ProfileForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=Edit_ProfileForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
	
<script language="JavaScript">
<!--


function showMsg(){
   document.profile.action="Main.jsp";
   document.profile.submit();
 }
 
	function checkPass()  {
		var newpass;
		newpass=document.profile.newpassword.value
		var confpassword;
		confpassword=document.profile.confpassword.value
		if(newpass!=confpassword){
			alert("please confirm your password")
       		document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
    	}
    	if(document.profile.newpassword.value!=""){
    	var len;
    	len=document.profile.newpassword.value.length;
    		if(len<3||len>20) {
    	 		alert("please enter password between 3 to 20 characters")
    	 		document.profile.action="Edit_ProfileForm.jsp";
       			document.profile.submit();
    	 	}        
    	 }
   }
	function remove_XS_whitespace(item) {
		var tmp = "";
  		var item_length = item.value.length;
  		var item_length_minus_1 = item.value.length - 1;
  		for (index = 0; index < item_length; index++) {
    		if (item.value.charAt(index) != ' ') {
      			tmp += item.value.charAt(index);
   			}
    		else {
      			if (tmp.length > 0) {
        			if (item.value.charAt(index+1) != ' ' && index != item_length_minus_1) {
          				tmp += item.value.charAt(index);
        			}
      			}
    		}
  		}
 		item.value = tmp;
	}
function echeck(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID")
		   document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID")
		   document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID")
		    document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID")
		    document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID")
		    document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID")
		    document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID")
		    document.profile.action="Edit_ProfileForm.jsp";
       		document.profile.submit();
		    return false
		 }

 		 return true					
	}

function ValidateForm(){
	var emailID=document.profile.eEmail
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please Enter your Email ID")
		emailID.focus()
		document.profile.action="Edit_ProfileForm.jsp";
       	document.profile.submit();
		return false
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return false
	}
	return true
 }

//-->
</script>   	
<% 
	String username="";
	String email="";
	String phoneNo="";
	String query="";
   	username=session.getAttribute("UserName").toString();
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
	    Statement stmt=conn.createStatement();
	    query="select email_addr,contact_no from user where username='"+username+"'";
	    ResultSet rs=stmt.executeQuery(query);
		if(rs.next()) {
			email=rs.getString(1);
			phoneNo=rs.getString(2);			
			if(phoneNo==null){
				phoneNo="";
			}
		
		}
		rs.close();
    	stmt.close();
    	conn.close();
	}catch(Exception e){
  		System.out.println(e);
  	}
%>  
<br><br>
<form name="profile"   action="profile.jsp" onSubmit="checkPass()">
	<center><h3>User Profile </h3></center>
	<table align="center" id="1">
		<tr>
			<td><b>UserName</b></td>
			<td><INPUT TYPE=text name="username" maxlength="20" value="<%=username%>" disabled></td>
		</tr>
		<tr></tr>
		<tr>
			<td><b><font color="blue">E</font>mail Address</b></td>
			<td><INPUT name="eEmail" id="eEmail" TYPE="text" maxlength=40 value="<%=email%>" accesskey="e"></td>
		</tr>
		<tr></tr>
		<tr>
			<td><b><font color="blue">C</font>ontact No</b></td>
			<td><input name="contactNo" id='contactNo' type="text" size=20 maxlength=20 value="<%=phoneNo%>" accesskey="c"><br></td>
		</tr>
	</table>
	<br><br>
	<center><h3><b>Password Details</b></h3></center>
	<br><center><b>(If you want to change your password)</b></center><br>
	<table align="center" id=2>
		<tr>
			<td><b><font color="blue">N</font>ew Password</b></td>
			<td><input type=password name="newpassword" maxlength="20" value="" accesskey="n"></td>
		</tr>
		<tr></tr>
		<tr>
			<td><b>Confirm <font color="blue">P</font>assword</b></td>
			<td><input type=password name="confpassword" maxlength="20" value="" accesskey="p"></td>
		</tr>
		<tr></tr>
	</table>
	<br><center><INPUT type="submit" name="Submit"  disabled value="Save" accesskey="s" onclick="remove_XS_whitespace(newpassword)"&&"remove_XS_whitespace(confpassword);return false">&nbsp; <INPUT type="reset" value="Clear" accesskey="r">&nbsp&nbsp<INPUT type=BUTTON value="Cancel" accesskey="c" onClick="showMsg();"></center>
	<script>
		function check(){
    		document.profile.Submit.disabled=false;
	}
	document.onkeyup = check;
	</script>
	</form>
</body>
</html>