
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<%
		String type="";
	    type=request.getParameter("type");
	     item.ManageItem  im = new item.ManageItem("jdbc/js"); 
		if(type.equals("all")){		   	
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
		    
		    String orderdt = request.getParameter("orderdt");
		    String itemcode = request.getParameter("iCode");
		    String itemname = request.getParameter("iName");
		   
		    im.ItemSalesCustInfo(orderdt,itemcode,itemname);	
		    int i=0;	    
		      
%>

		<table   border="1"  >
	      	
		      		
		<br><center><b> Item Sales Report</center> 
     		<thead><tr><td colspan="4"><br> Order Date : <%= orderdt %>
 		
 			Item Name  : <%= itemname %></td>
 		
			
<%
			while(im.rs.next()){
				if(i==0){
					i=i+1;
%>
					<tr style="background-color:#9797ff">				
						<th align="center" ><b>Order Number</b></th>
						<th align="center" ><b>Customer Code</b></th>
						<th align="center" ><b>Customer Name</b></th>
						<th align="center" ><b>Quantity</b></th>													
					</tr></thead><tbody>
					
<%
				}
%>			
			
					<tr>
					<td><% out.println(im.rs.getString(1));%></td>
					<td class='in_cell'><% out.println(im.rs.getString(2));%></td>
					<td><% out.println(im.rs.getString(3));%></td>
					<td><% out.println(im.rs.getString(4));%></td>
					</tr>
<%
			}
			if(i == 0)
			{
%>
			<tr><td> No Records Found</td></tr>
<%
			}
			im.closeAll();
%>			

			
			</tbody></table>
<%			
			if(str1.equals("0")){	

%>
      	<div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass1();">Save to excel</a></td><td><input type="button" name="return" value="Close" onclick="funclose();"></td></tr></table></div>
<%			}
%>    	
		<input type="hidden" name="orderdt" value="<%= orderdt%>">
		<input type="hidden" name="iCode" value="<%= itemcode%>">
		<input type="hidden" name="iName" value="<%= itemname%>">
<%	}else{
		String itemname = request.getParameter("itemnm");
		im.ItemList(itemname);		
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
		while(im.rs.next()){
		//String dispmsg = im.rs.getString(2)+"     [ "+im.rs.getString(3)+" , "+im.rs.getString(4)+" , "+im.rs.getString(5)+"]";
%>
			
				<div class="item silverItem" id="<%=im.rs.getString(2)%>" align="left"><table border="1" width="100%"><tr>
					<td width="30%"><% out.println(im.rs.getString(2));%></td>
					<td width="30%"><% out.println(im.rs.getString(3));%></td>
					<td width="20%"><% out.println(im.rs.getString(4));%></td>
					<td width="20%"><% out.println(im.rs.getString(5));%></td></tr></table></div>
			
<%
		}
%>
		<div class="item silverItem lastItem"></div>
		
		</div></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>		
		<td>
		<div id="selbox" class="dropArea staticDropArea goldDropArea">
			<div class="item goldItem lastItem"></div>
		</div>
		</td>
		</tr>
		</table>
<%
	}
	im.closeAll();
%>

<style type="text/css">
		.dropAreasContainer .silverDropArea, .silverButton {
			float : left;
		}
		.dropAreasContainer .goldDropArea, .goldButton {
			float : right;
		}
</style>