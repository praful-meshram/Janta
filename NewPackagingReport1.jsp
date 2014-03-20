<%@page import="beans.JasonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.BreakdownOutputBean"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="packaging.ManageBreakdown"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ManageItem"%>

<%@ page errorPage="ErrorPage.jsp?page=NewPackagingReport1.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%	
	String call_option = request.getParameter("call_option");
		if(call_option.equals("brekdown_list")){
			String frDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			//ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/re");
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			
			jsonOutputBean.getFormat().add(new jqxgridFormat("Breakdown Number","breakdownNumber","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Bachka Name","bachkaName","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Weight","itemWeight","80px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Loss","loss","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Gain","gain","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Site ","siteName","120px"));
			
			jqxgridFormat format = new jqxgridFormat("Breakdown Date","breakdownDate","130px");
			format.setSortable(false);
			jsonOutputBean.getFormat().add(format);
			jsonOutputBean.getFormat().add(new jqxgridFormat("Entered By","enteredBy","120px"));
			
			%>
		
				
			<%
			ArrayList<BreakdownOutputBean> listOutputBeans = new ArrayList();
			ResultSet rs = manageBreakdown.getBreakdownList(frDate,toDate);
			if(rs.next())
			{
				System.out.println("data available in breakdown header ...");
				do{		
					//bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by 
						int number = rs.getInt(1);
						BreakdownOutputBean outputBean = new BreakdownOutputBean();
						outputBean.setBreakdownNumber(rs.getInt("bd_number"));
						outputBean.setBachkaName(rs.getString("bachka_code"));
						outputBean.setLoss(rs.getFloat("loss_in_breakdown"));
						outputBean.setGain(rs.getFloat("gain_in_breakdown"));
						outputBean.setSiteName(rs.getString("site_name"));
						outputBean.setBreakdownDate(rs.getString("bd_date"));
						outputBean.setEnteredBy(rs.getString("entered_by"));
						outputBean.setItemWeight(rs.getString("item_weight"));
						listOutputBeans.add(outputBean);
					
				} while(rs.next());
			} else {
				
			}
			manageBreakdown.closeAll();
			jsonOutputBean.setOutputData(listOutputBeans);
			
			System.out.println(new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
		} 
			
		else if (call_option.equals("brekdown_details"))
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
					<tr style="background-color: #D8D8D8;"> 
						<td style="width: 10%;" align="center">
							<%=rs.getString(1) %>
						</td>
						<td style="width: 10%;" align="center">
							<%=rs.getString(2) %>
						</td>
						<td style="width: 10%;" align="center">
							<%=rs.getString(3) %>
						</td>
						<%-- <td>
							<%=rs.getString(4) %>
						</td> --%>
																
					</tr>
					
				
				<%
				}while(rs.next());
				manageBreakdown.closeAll();
			%>
				</table>
			<%	
			}
			else{
				System.out.println("else part of breakdown details ");
				
			%><table style="width: 100%;border-collapse: collapse;" border=1>
				<tr>
					<td style="width: 100%;padding: 5px;" colspan="5">
					
						No result matching search criteria...
					</td>
				</tr>
				</table>
			<%
			}
						
		}
		else if (call_option.equals("brekdown_detailsPopUp"))
		{
			System.out.println("else part of breakdown details popUp ");
			String brekdownNumber = request.getParameter("breakDownNumber"); 
			ManageBreakdown  manageBreakdown = new ManageBreakdown("jdbc/re");
			ResultSet resultSet = manageBreakdown.getBreakDownDetailsPopUp(brekdownNumber);
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			
			//jsonOutputBean.getFormat().add(new jqxgridFormat("Breakdown Number","breakdownNumber","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name", "bachkaName","200px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight", "itemWeight"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Mrp", "itemMRP"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate", "itemRate"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Quantity   ", "qty"));
			
			ArrayList<BreakdownOutputBean> listOutputBeans = new ArrayList();
			while(resultSet.next()){
				BreakdownOutputBean outputBean = new BreakdownOutputBean();
				outputBean.setBreakdownNumber(resultSet.getInt("bd_number"));
				outputBean.setBachkaName(resultSet.getString("item_name"));
				outputBean.setItemWeight(resultSet.getString("item_weight"));
				outputBean.setItemMRP(resultSet.getFloat("item_mrp"));
				outputBean.setItemRate(resultSet.getFloat("item_rate"));
				outputBean.setQty(resultSet.getInt("new_qty"));
				
				listOutputBeans.add(outputBean);
				
			}
			
			manageBreakdown.closeAll();
			jsonOutputBean.setOutputData(listOutputBeans);
			System.out.println("breakdown details "+new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
			
		}
		
		 %> 
		
		
		