<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="GItemMonthlySales.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=GItemMonthlySales.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<% 		
		String type="";
	    type=request.getParameter("type");
	    item.ManageItem  i = new item.ManageItem("jdbc/js"); 
		if(type.equals("all")){		
		
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }		
			String orderDate="";
			String name="",desc="";
			String itemCode="";
			String chckcnt = "";
			orderDate = request.getParameter("Date");	
		
			itemCode = request.getParameter("iCode");	
			String itemName = request.getParameter("iName");		
			chckcnt = request.getParameter("chckcnt");
			
			if(chckcnt.equals("Item")){
				
				i.ItemSalesGraph(itemCode,"","00-00-0000",orderDate); 	
				int ii =0;
%> 
			<table  border="1" id="id" >
				<br><center><b> Item Sales Monthly Report</center> 
     	
	 			<tr>
	 				<td colspan="6"> Order Date : <%= orderDate %>
	 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				Item Name : <%= itemName  %> </td>
	 			</tr>
<%   		
				while(i.rs.next()){
				  if(ii==0){
						ii=ii+1;
%>
					<tr style="background-color:#9797ff">				
						<td align="center"><b>Order Date</b></td>
						<td align="center"><b>Item Code</b></td>
						<td align="center"><b>Item Name</b></td>
						<td align="center"><b>Item Group Name</b></td>
						<td align="center"><b>Item Weight</b></td>
						<td align="center"><b>Total Quantity</b></td>										
					</tr> 	 
<%					
					}
					int cnt=1;
					String i_date = i.rs.getString(cnt++);
					String i_code = i.rs.getString(cnt++);
					String i_name = i.rs.getString(cnt++);
					String ig_code = i.rs.getString(cnt++);
					String ig_name = i.rs.getString(cnt++);
					String i_weight = i.rs.getString(cnt++);
					String i_qty = i.rs.getString(cnt++);				
%>  	
		
					<tr>					
						<td><%out.println(i_date);%></td>	
						<td><%out.println(i_code);%></a></td>
						<td><%out.println(i_name);%></td>	
						<td><%out.println(ig_name);%></td>	
						<td align="right"><%out.println(i_weight);%></td>			    
						<td align="right"><%out.println(i_qty);%></td>	 	 
					</tr>  
		
<%			 
				  }	
				  if(ii == 0)
				 {
%>
					<tr><td> No Records Found</td></tr>
<%
				 }	
				 i.closeAll();			
%>
			  </table>
<%
			}else if(chckcnt.equals("Customer")){		
			i.ItemSalesMonthlyCustInfo(orderDate,itemCode); 
			int ic=0;
%>
		<table  border="1" id="id" >  		
		<br><center><b> Item Sales Monthly Report</center>      	
 			<tr>
 				<td colspan="4"> Order Date : <%= orderDate %>
 					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				Item Name : <%= itemName  %> </td>
 			</tr>
 			<%
			while(i.rs.next()){
				if(ic==0){
					ic=ic+1;
%>
					<tr style="background-color:#9797ff">				
						<td align="center"><b>Order Number</b></td>
						<td align="center"><b>Customer Code</b></td>
						<td align="center"><b>Customer Name</b></td>
						<td align="center"><b>Quantity</b></td>													
					</tr>
<%
				}
%>			
			
					<tr>
					<td><% out.println(i.rs.getString(1));%></td>
					<td><% out.println(i.rs.getString(2));%></td>
					<td><% out.println(i.rs.getString(3));%></td>
					<td><% out.println(i.rs.getString(4));%></td>
					</tr>
<%
			}
			if(ic == 0)
			{
%>
			<tr><td> No Records Found</td></tr>
<%
			}
%></table><%
			i.closeAll();
		}
%>			

			
			
<%			
			if(str1.equals("0")){	

%>
      		<div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass1();">Save to excel</a></td><td><input type="button" name="return" value="Close" onclick="funclose();"></td></tr></table></div>
<%			}
%>    		

		<input type="hidden" name="Date" value="<%=orderDate%>">
		<input type="hidden" name="iCode" value="<%=itemCode%>">
		<input type="hidden" name="iName" value="<%=itemName%>">
		<input type="hidden" name="chckcnt" value="<%=chckcnt%>">
		
<%	}else{
		String itemname = request.getParameter("itemnm");
		i.ItemList(itemname);		
%>
		<table border="0" >
		<tr style="background-color:#9797ff"><td><b>Item Name</b></td><td></td><td><b>Selected Items</b></tr>
		<tr><td><table border="1" style="background-color:#cfc5c5" width="100%">
			<tr><td width="30%"><b>Name</b></td>
			<td width="30%"><b>Weight</b></td>
			<td width="20%"><b>Rate</b></td>
			<td width="20%"><b>MRP</b></td>			
			</tr>		
		</table>
		</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td><table border="1" style="background-color:#cfc5c5" width="100%">
			<tr><td width="30%"><b>Name</b></td>
			<td width="30%"><b>Weight</b></td>
			<td width="20%"><b>Rate</b></td>
			<td width="20%"><b>MRP</b></td>			
			</tr>		
		</table>
		</td></tr>	
		</tr>
		<tr><td>
		<div class="dropAreasContainer">
		<div id="box" class="dropArea staticDropArea silverDropArea">
	
<%
		while(i.rs.next()){
%>
			
				<div class="item silverItem" id="<%=i.rs.getString(2)%>" align="left"><table border="1" width="100%"><tr>
					<td width="30%"><% out.println(i.rs.getString(2));%></td>
					<td width="30%"><% out.println(i.rs.getString(3));%></td>
					<td width="20%"><% out.println(i.rs.getString(4));%></td>
					<td width="20%"><% out.println(i.rs.getString(5));%></td></tr></table></div>
			
<%
		}
%>
		<div class="item silverItem lastItem"></div>
		</div></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
		<div id="selbox" class="dropArea staticDropArea goldDropArea">
			<div class="item goldItem lastItem"></div>
		</div>
		</td>
		</tr>
		</table>
<%
	}
	i.closeAll();
%>