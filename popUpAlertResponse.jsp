
<%@page import="java.sql.ResultSet"%>
<%@page import="packaging.ManageBreakdown"%>
<%@page import="item.ManageItem"%>
<% 		String call_option = request.getParameter("call_option");
		if (call_option.equals("brekdown_details"))
		{
			System.out.println("breakdown details block....");
			int brekdown_number = Integer.parseInt(request.getParameter("bd_number"));
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ResultSet rs = manageBreakdown.getBreakdownDetails(brekdown_number);
			System.out.print("afer result set of breakdown details..");
			%>
			
			<%
			if(rs.next()){
				
				%>
				<table style="border-collapse: collapse;" border=1>
				<tr style="background-color: gray; color: white; "> 
				<!-- <th>Breakdown Number</th>
				<th>Item Code</th>
				 <th>Price Version</th>
				<th>New Quantity</th> -->
				
				<th>Item Name</th>
				 <th>Price Version</th>
				<th>New Quantity</th>
				
				</tr>
				<%
					do{
				%>
				<%-- 	<tr style="background-color: #D8D8D8;"> 
						<td style="width: 10%;" align="center">
							<%=rs.getString(1) %>
						</td>
						<td style="width: 10%;" align="center">
							<%=rs.getString(2) %>
						</td>
						<td style="width: 10%;" align="center">
							<%=rs.getString(3) %>
						</td>
								 --%>
							<tr style="background-color: #D8D8D8;"> 
						<td style="width: 10%;" align="center">
							<%="http://localhost:8080/Janta/popUpAlert.jsp" %>
						</td>
						<td style="width: 10%;" align="center">
							<%="AAAA" %>
						</td>
						<td style="width: 10%;" align="center">
							<%="AAAA" %>
						</td>
								
								 						
					</tr>
					
				
				<%
				}while(rs.next());
			%>
				</table>
		<%	
			}
		}
			%>