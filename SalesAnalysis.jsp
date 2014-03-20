<%@page import="beans.JsonOutputBean"%>
<%@page import="report.ManageReports"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.SalesAnalysisReportOutputBean"%>
<%@page import="beans.CustomerBean"%>
<%@page import="packaging.ManageSalesAnalysis"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="packaging.ManageBreakdown"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ManageItem"%>
<%	

	String call_option = request.getParameter("call_option");
		if(call_option.equals("analysis_list")){
			String dateRange1 = request.getParameter("dateRange1").trim();
			String dateRange2 = request.getParameter("dateRange2").trim();
			
			System.out.println("dateRange1 "+dateRange1+" dateRange2 "+dateRange2);
			
			
			//ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/js");
			ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/re");
			ArrayList outputList = new ArrayList();
			ResultSet rs =null;
				rs = manageSalesAnalysis.getCompleteSalesAnalysis(dateRange1,dateRange2);
				
			if(rs.next())
			{	float count=0;
				System.out.println("data available in breakdown header ...");
				do{		
					SalesAnalysisReportOutputBean analysisReportOutputBean = new SalesAnalysisReportOutputBean();
					analysisReportOutputBean.setCustomerName(rs.getString(1));
					analysisReportOutputBean.setBulding(rs.getString(2));
					analysisReportOutputBean.setStation(rs.getString(3));
					analysisReportOutputBean.setItemGroupDesc(rs.getString(4));
					analysisReportOutputBean.setFMCG_IND(rs.getInt(5));
					analysisReportOutputBean.setItemName(rs.getString(6));
					//analysisReportOutputBean.setOrderNo("<a href=\"javascript:passVar(\'"+rs.getString(7)+"\');\">"+rs.getString(7)+" </a>");
					analysisReportOutputBean.setOrderNo(rs.getInt(7));
					analysisReportOutputBean.setOrderNo1(rs.getInt(7)); 
					analysisReportOutputBean.setOrderDate(rs.getString(8));
					analysisReportOutputBean.setTotalValueDiscount(rs.getFloat(9));
					analysisReportOutputBean.setQuantity(rs.getInt(10));
					analysisReportOutputBean.setPrice(rs.getFloat(11));
					
					analysisReportOutputBean.setItemDiscount(rs.getFloat(12));
					count+= Float.parseFloat(rs.getString(11));	 
					analysisReportOutputBean.setSiteName(rs.getString(13));
					//System.out.println("data available in breakdown header ..."+i);
										
					outputList.add(analysisReportOutputBean); 
				}while(rs.next());
				System.out.println("total price "+count);
			} else {
				System.out.println("no data available ...");
			}
			manageSalesAnalysis.closeAll();
			
		%>
			
			<%=new Gson().toJson(outputList) %>
		<%
		} 
			
		else if (call_option.equals("brekdown_details"))
		{
			System.out.println("breakdown details block....");
			int brekdown_number = Integer.parseInt(request.getParameter("bd_number"));
			//ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/re");
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
			}
						
		}
		else if (call_option.equals("suggestedOrderNumberList")){
			ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/re");
			System.out.println(" suggested order list ");
			String orderNum = request.getParameter("orderNum");
			ResultSet rs = manageSalesAnalysis.getSalesAnalysis(orderNum);
			ArrayList<SalesAnalysisReportOutputBean>  outputList = new ArrayList();
			while(rs.next()){
				SalesAnalysisReportOutputBean analysisReportOutputBean = new SalesAnalysisReportOutputBean();
				analysisReportOutputBean.setCustomerName(rs.getString(1));
				analysisReportOutputBean.setBulding(rs.getString(2));
				analysisReportOutputBean.setStation(rs.getString(3));
				analysisReportOutputBean.setItemGroupDesc(rs.getString(4));
				analysisReportOutputBean.setFMCG_IND(rs.getInt(5));
				analysisReportOutputBean.setItemName(rs.getString(6));
				//analysisReportOutputBean.setOrderNo("<a href=\"javascript:passVar(\'"+rs.getString(7)+"\');\">"+rs.getString(7)+" </a>");
				analysisReportOutputBean.setOrderNo(rs.getInt(7));
				analysisReportOutputBean.setOrderNo1(rs.getInt(7)); 
				analysisReportOutputBean.setOrderDate(rs.getString(8));
				analysisReportOutputBean.setTotalValueDiscount(rs.getFloat(9));
				analysisReportOutputBean.setQuantity(rs.getInt(10));
				analysisReportOutputBean.setPrice(rs.getFloat(11));
				
				analysisReportOutputBean.setItemDiscount(rs.getFloat(12));
				analysisReportOutputBean.setSiteName(rs.getString(13));
				//System.out.println("data available in breakdown header ..."+i);
									
				outputList.add(analysisReportOutputBean); 
				
			}
			manageSalesAnalysis.closeAll();
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			jsonOutputBean.setOutputData(outputList);
			System.out.print(new Gson().toJson(outputList));
			out.print(new Gson().toJson(outputList));
			
		}
		
		 %> 
		
		
		