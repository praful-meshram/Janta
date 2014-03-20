<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditUser.jsp" />	
</jsp:include>  --%>

<%@ page errorPage="ErrorPage.jsp?page=EditUser.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%
	Connection conn=null,conn1=null;
	Statement stmt=null,stmt1=null;
	ResultSet rs=null,rs1=null;
	if (request.getParameter("nameStartWith") != null){
    	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			String selSql = "select * from user";
			selSql=selSql + " where username='"+request.getParameter("nameStartWith")+"'";
			rs = stmt.executeQuery(selSql);
			while(rs.next()){
%>
			<br>
			<table>
				<tr>
					<td align="left"><b>User Name</b></td><td>: </td>
			    	<td><input name="userName" id="userName"  type="text" maxlength="20" value="<%=rs.getString(1)%>" readonly  onClick="Warn();"><br></td>
				</tr>
				<tr></tr>
				<tr>
					  <td align="left"><b><font color="blue">P</font>assword</td><td>: </td>
			    	<td><input name="userPasswd" id="userPasswd"  accesskey="p" type="password"  maxlength="20" value="<%=rs.getString(2)%>" ><br></td>
				</tr>
				<tr></tr>
				<tr>
					<td align="left"><b><font color="blue">T</font>ype Of User</td><td>: </td>
<% 
						try {
							String name,desc;
						  	int rowcount;
							Context initContext1 = new InitialContext();
							Context envContext1  = (Context)initContext1.lookup("java:/comp/env");
							DataSource ds1 = (DataSource)envContext1.lookup("jdbc/js");
							conn1 = ds1.getConnection();
							stmt1 = conn1.createStatement();
				          	rs1 = stmt1.executeQuery("select user_type_code, user_type_desc from user_type");
%>
							<td align="left">
							<SELECT name="userType" style="width:11em">
<% 							
			 				while (rs1.next()) {
				 				name = rs1.getString(1);
						    	desc = rs1.getString(2);
						    	if(name.equals(rs.getString(5))){			 				
				 				
%>
	
 									<OPTION VALUE="<%=name%>" selected ><%=desc%></OPTION>
<% 
								}
								else {
%>
									<OPTION VALUE="<%=name%>" ><%=desc%></OPTION>
<%
								} 
							
								
							}	
						   
					   		rs1.close();
					    	stmt1.close();
					    	conn1.close();
						}
						catch (Exception e) {
			        		e.getMessage();
			            	e.printStackTrace();
			            	rs1.close();
					    	stmt1.close();
					    	conn1.close();
			          	}
%>
						</select>
					</td>		
				</tr>
				<tr></tr>   
			    <tr>
					<td align="left"><b><font color="blue">E</font>mail Id</td><td>: </td>
			  		<td><input name="eEmail" id="eEmail" type="text" maxlength=40 value="<%=rs.getString(7)%>" accesskey="e"><br></td>
				</tr>
				<tr></tr>
				<tr>
					<td align="left"><b><font color="blue">C</font>ontact No</td><td>: </td>
			    	<td><input name="contactNo" id='contactNo' type="text" size=20 maxlength=20 value="<%=rs.getString(8)%>" accesskey="c"><br></td>
				</tr>
			</table><br><br>
			<center><INPUT type="submit" name="Submit" value="Update <Alt+u>" accesskey="u" disabled  onClick="Operation1();">&nbsp;&nbsp;&nbsp;
	        <INPUT type="button" value="Delete <Alt+d>" accesskey="d" onClick="Operation2();">&nbsp;&nbsp;&nbsp;
	        <INPUT type="reset" value="Reset <Alt+r>" accesskey="r">&nbsp;&nbsp;&nbsp;
	        <INPUT type="button" value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	      

			
<%
			}         
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
	}
%>

