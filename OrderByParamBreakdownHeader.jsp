<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="packaging.ManageBreakdown"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ManageItem"%>
 <!-- <script type="text/javascript" src="js/PackagingReport.js"></script>
<script type="text/javascript">
function goHome()
{
//alert("go home ...");
//document.myform.action.value="HomeForm.jsp";
//document.myform.action.submit;

 document.myform.action="HomeForm.jsp";
 document.myform.submit();
}
 </script>  -->
 			

	
			<!--  <div style="width: 100%; overflow-y: scroll; overflow-x: hidden;max-height: 50px;"> -->
			<!--   <table style="width: 100%;border-collapse: collapse;" border=1>
				<tr style="background-color: gray; color: white; " >
					<th style="width: 10%;padding: 5px;" align="left" id="th1" name="th1">
						<a href="#" onclick="orderByBreakdownNumber('bd_number');">Breakdown Number</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="#" onclick="orderByBreakdownNumber();">Bachka Code</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="abc.jsp" onclick="orderByBreakdownNumber();">Loss</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="abc.jsp" onclick="orderByBreakdownNumber();">Gain</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="abc.jsp" onclick="orderByBreakdownNumber();">Site ID</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="abc.jsp" onclick="orderByBreakdownNumber();">Breakdown Date</a>
					</th>
					<th style="width: 10%;" align="left">
						<a href="abc.jsp" onclick="orderByBreakdownNumber();">Entered By</a> 
					</th>
				</tr>
		</table>
 			 	<div style="width: 100%; overflow-y: scroll; overflow-x: hidden;max-height: 400px;"> -->
 			 	
			
			
			<%
				String callOption = request.getParameter("callOption");
			System.out.println("callOption :"+callOption);
				if(callOption.equals("breakdownData"))
				{
					%>
					<table style="width: 100%;border-collapse: collapse;" border=1> 
					<%
					String param = request.getParameter("param");
					ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
					ResultSet rs = manageBreakdown.orderByParameter(param);
					if(rs.next())
					{
						System.out.println("data available in breakdown header ...");
						do{		
							int number = rs.getInt(1);
				%>				<tr id="record" style="background-color: #D8D8D8; cursor: pointer;"> 
								<td style="width: 10%;padding: 5px;" align="left" id = "bd">
								<%=number %>
								</td>
								<td style="width: 10%;" align="left">
								<%=rs.getString(2) %>
								</td>
								<td style="width: 10%;" align="left">
								<%=rs.getString(3) %>
								</td>
								<td style="width: 10%;" align="left">
								<%=rs.getString(4) %>
								</td>
								<td style="width: 10%;" align="left">
								<%=rs.getString(5) %>
								</td>
						
								<td style="width: 10%;" align="left">
								<%=rs.getDate(6) %>
								</td>
								<td style="width: 10%;" align="left">
								<%=rs.getString(7) %>
								</td>
											
							</tr>
				<%
					
						} while(rs.next());
				%>
				</table>
				<%
				manageBreakdown.closeAll();
				} 
			}
		
		else if(callOption.equals("popup"))
		{
			
			%>
			 <center>
		  <div style="width:35%;"> 
		  		 <fieldset style="width: 40%;">
			<!--  <h3 align="center">serach result</h3> -->
			<!--  <table style="width: 100%;" cellpadding="3">
			 	<b><tr><a href="#">start with</a></tr></tr><tr></tr>
			 	<tr><a href="#">contains</a></tr></tr></tr><tr></tr>
			 	<tr><a href="#">end with</a></tr></tr></tr><tr></tr></b>
			 </table> -->
			 <%
			 	String param = request.getParameter("param");
			  	System.out.println("===\nparam is "+ param);
			  	/* if(!session.isNew())
					session.setAttribute("param", param); */
			 %>
			 <legend> <h3 align="center">serach result</h3></legend>
			<%--  <p><a href="#" onclick="getPopStart('<%=param%>','startwith');" id="link1">start with</a></p>
			 <p><a href="#" onclick="getPopContains('<%=param%>','contains');" id="link2");">contains</a></p>
			 <p><a href="#" onclick="getPopEnd('<%=param%>','endwith');" id="link3">end with</a></p> --%>

			 <p><a href="#" onclick="getParamPopUp('<%=param%>','startwith');" id="link1">start with</a></p>
			 <p><a href="#" onclick="getParamPopUp('<%=param%>','contains');" id="link2");">contains</a></p>
			 <p><a href="#" onclick="getParamPopUp('<%=param%>','endwith');" id="link3">end with</a></p>
			 
			 
			 <%
			 	System.out.println("else part in script");
			 %>
			 </fieldset>
			</div> 
			 </center>   
			<%	
		}
		else if(callOption.equals("popupParam"))	{
			
			String param = request.getParameter("param");
			String link = request.getParameter("link");
			 System.out.println("param is "+param+" :: link is "+link);
			/*  if(!session.isNew())
			{		session.setAttribute("filter", "filterData");
				
					session.setAttribute("link",link);
					session.setAttribute("param",param);
					System.out.println("session link  "+session.getAttribute("link").toString()+" :: param is  "+param);
			}  */
			%>
			<h3><%=param.toUpperCase()+" " %> <%=link %></h3>
			<center>
						<table cellspacing="5" cellpadding="5"><b>
					<tr>
						<th id="th1"><%=param %></th><th><input type="text" align="right" id="th2" name="th2"></th>
						
					<tr>
					<%-- <tr><th><%=param %></th><th><input placeholder="<%=param %>" name="emailTxt" align="right"/></th></tr>
					 --%></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
					</table>
					
				<%-- 	 <center><button" onclick="submitVal('<%=param %>');return false;">search</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset();" >reset </button></center>
				 --%>
				 	 <center><button onclick="getParamPopUpResult('<%=param%>','<%=link%>');">search</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 	  <button onclick="(document.getElementById('th2').value='');" >reset </button></center>
					
			
			</div>
			</center>
		<%
		}
				
		else if(callOption.equals("popupParamResult")){
			String param = request.getParameter("column");
			String link = request.getParameter("link");
			String value = request.getParameter("value");
			
			System.out.println("==========\nPopup Reult :  column is "+param+" :: link is "+link+" val is :: "+value+"=========\n");
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
 			ResultSet rs = null;
			if(link.equals("startwith"))
				{	
					System.out.println("inside nested start :");
					rs = manageBreakdown.getFilteredStartData(param,value);
				}	
				else if(link.equals("contains"))
				{
					System.out.println("inside nested contains :");
					rs = manageBreakdown.getFilteredContainsData(param, value);
				}	
				else {
					System.out.println("inside nested end :");
					rs = manageBreakdown.getFilteredEndData(param, value);
				}	
		
			%>
			<table style="width: 100%;border-collapse: collapse;" border=1> 
			<%
			if(rs.next())
			{
				System.out.println("data available in breakdown header ...");
				do{		
					int number = rs.getInt(1);
		%>				<tr id="record" style="background-color: #D8D8D8; cursor: pointer;"> 
						<td style="width: 10%;padding: 5px;" align="left" id = "bd">
						<%=number %>
						</td>
						<td style="width: 10%;" align="left">
						<%=rs.getString(2) %>
						</td>
						<td style="width: 10%;" align="left">
						<%=rs.getString(3) %>
						</td>
						<td style="width: 10%;" align="left">
						<%=rs.getString(4) %>
						</td>
						<td style="width: 10%;" align="left">
						<%=rs.getString(5) %>
						</td>
				
						<td style="width: 10%;" align="left">
						<%=rs.getDate(6) %>
						</td>
						<td style="width: 10%;" align="left">
						<%=rs.getString(7) %>
						</td>
									
					</tr>
		<%
			
				} while(rs.next());
			
			%>
			</table>
			<%
		
			}
			manageBreakdown.closeAll();
		}
		
		
		%>	 
		
	
		
		 
		
		
		