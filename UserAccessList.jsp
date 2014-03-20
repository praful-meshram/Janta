<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>



<div style="width:60%;max-height:500px; overflow-y: scroll;">
			<table border=1 class="item3" style="background-color:#FFE4C4 border-collapse: collapse;width: 100%; font-family: arial;" cellspacing=0 cellpadding=0 >
				<tr style="background-color:#ECFB99">
					<td width="40%"><b>Form Name</b></td>
					<td width="40%"><b>Description</b></td>
					<td width="20%"><b>Access Flag</b></td>					
				</tr>
<%
	Connection conn=null,conn1=null;
	Statement stmt=null,stmt1=null;
	ResultSet rs=null,rs1=null;
	int chckcnt=0;
	String user_type, formName, accessFlag, module,sub_module;
	int screen_id=0;
	String user_type_code = request.getParameter("nameStartWith");
	if (request.getParameter("nameStartWith") != null){
    	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			
			
			String selSql = "SELECT b.user_type_code ,a.screen_name, b.access_flag, a.module_name,a.sub_module_name,a.screen_id FROM screen_master a, user_access b ";
			selSql=selSql + " where a.screen_id = b.screen_id and b.user_type_code = '"+request.getParameter("nameStartWith")+"' order by a.screen_id";
			rs = stmt.executeQuery(selSql);
			while(rs.next()){
				user_type = rs.getString(1);
				formName = rs.getString(2);
				accessFlag = rs.getString(3);
				module = rs.getString(4);
				sub_module = rs.getString(5);
				screen_id = rs.getInt(6);
				String desc = module +", "+sub_module;
				
%>
			
				<tr style="background-color:#ECFB99">
					<td><%=formName%></td>
					<td><%=desc%></td>
					<td align="center">
<% 			
						if(accessFlag.equals("Y")){
							
%>
						<input type="radio" name="chckaccess<%=chckcnt%>" checked="checked" value="Y"/>Yes
						<input type="radio" name="chckaccess<%=chckcnt%>" value="N"/>No
						<!--  <input type="checkbox" id="chckaccess<%=chckcnt%>" name="chckaccess<%=chckcnt%>" checked onclick="FunCheck('<%=formName%>',<%=chckcnt%>);">-->
<%
						}else{
 %>
 						<input type="radio" name="chckaccess<%=chckcnt%>" value="Y"/>Yes
						<input type="radio" name="chckaccess<%=chckcnt%>" checked="checked" value="N"/>No
						<!-- <input type="checkbox" id="chckaccess<%=chckcnt%>" name="chckaccess<%=chckcnt%>" onclick="FunCheck('<%=formName%>',<%=chckcnt%>);">-->
 <%
						}
 %>						<input type="hidden" name="page_name_<%=chckcnt%>" value="<%=formName%>"/>
 						<input type="hidden" name="page_id_<%=chckcnt%>" value="<%=screen_id%>"/>
 					</td>
				</tr>
			
			
			
<%
			  chckcnt= chckcnt +1;
			}   
			%>
			<input type="hidden" name="row_count" value="<%=chckcnt%>"/>
			<%      
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
</table>
</div>
