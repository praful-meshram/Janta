<%@page contentType="text/html"%>
   <%@ page import="java.sql.*" %>
   <%@ page import="javax.naming.*" %>
   <%@ page import="javax.sql.*" %>
<jsp:include page="header.jsp" /> 
<script>
	<%
	String errMsg="";
	errMsg=request.getParameter("Exp");
	%>
	var jExp=<%=errMsg%>
       
	function trimString(str){
	
    	return str.replace(/^\s+|\s+$/g, '');
    	
  	}

	function validateString(field, errmsg, lenmsg, min, max, required) { 
	
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
	function validateOnload(){
	var jExp=<%=errMsg%>

 		if(jExp==1){
   			alert("Enter correct name and password")
  		}
   		else if(jExp==2){
  			alert("You are not activated yet")
  		}
 	 	else if(jExp==3){
  			alert("Your Date has been expired")
  		}
  		else if(jExp==5){
  			alert("Permission Denied!")
  		}
	}
	
</script>


<form method="post" name="LoginForm" action="Login.jsp"  onSubmit="return (validateString(this.username, 'Please enter your name', 'Name must be between 3 and 20 characters', 3, 20, true) && validateString(this.password,'Enter Password','password length should be 6 char or more',6,32,true));">
 <br><br><br><br> 
<center>
 <table>
  	<tr>
  		<td align="left">User Name</td>
  		<td> : </td>
		<td colSpan=2 >
			<INPUT name="username" accesskey="u" maxlength="100" value="">
		</td>
		</td>
  	</tr>
  	<tr>
		<td align="left"> Password</td>
		<td> : </td>
		<td colSpan=2 >
			<INPUT TYPE=password name="password" maxlength="32" accesskey="p"value=""> </td>
		</td>
  	</tr>
  	<tr>
		<td align="left"> Site Name</td>
		<td> : </td>
		<td colSpan=2 >
			<select name="siteId" style="width:11em">
<%
				try {
					Connection conn=null;
					Statement stmt,stmt1;
					ResultSet rs,rs1;
					Context initContext = new InitialContext();
					Context envContext  = (Context)initContext.lookup("java:/comp/env");
					DataSource ds = (DataSource)envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					String selSql = "SELECT site_id, site_name FROM site_master";					
					rs = stmt.executeQuery(selSql);
					String  siteName;
					Integer siteId;
					while(rs.next()){  
						siteId = rs.getInt(1);
						siteName = rs.getString(2);					
%>	
						<option value="<%=siteId%>"><%=siteName%></option>
<%				
					}
					rs.close();	
			        stmt.close();
					conn.close(); 
				}
			catch (Exception e) {
				e.getMessage();
				e.printStackTrace();
				System.out.println(e);
				
			}
%>
			</select> 
		</td>
  	</tr>
  	<tr>
		<td></td>
    	<td></td>
		<td align="left">
			<INPUT TYPE=image image src="images/submit.gif" name="submit"> </td>
		</td>
  	</tr>
 </table>
</center>
</form>
<script type="text/javascript">
window.onload = function(){
 alert("Session Expired....");
 }

</script>
</body>
</html>

