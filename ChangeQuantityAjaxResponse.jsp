<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%
String type=request.getParameter("type");
if(type.equals("list")){
		String itemCode="";		
		Integer siteId=0;
		
		itemCode=request.getParameter("itemCode");
		siteId = Integer.parseInt(request.getParameter("siteId"));
%>
<table border="1" name="t" id="id" class="item3" >      
<tr style="position:relative;top:expression(document.all['searchItemListDiv'].scrollTop);">
	<td width="10%"><b>Item Code</b></td>
	<td width="30"><b>Item  Name</b></td>
	<td width="10%"><b>Site Name</b></td>
	<td width="10%"><b>Price Version</b></td>
	<td width="10%"><b>Item MRP</b></td>
	<td width="10%"><b>Item Rate</b></td>	
	<td width="10%"><b>Quantity</b></td>
</tr>		
<%
 item.ManageItem mi;
mi = new item.ManageItem("jdbc/js");
mi.getListOfItems(itemCode,siteId);
String paramList ="";
while(mi.rs.next()){  
	paramList="setValues('"+mi.rs.getString(3)+"','"
				+mi.rs.getString(4)+"','"
						+mi.rs.getString(7)+"','"
								+mi.rs.getString(8)+"')";
%>
<tr onclick="<%=paramList%>">
	<td><%out.println(mi.rs.getString(1));%></td>
	<td><%out.println(mi.rs.getString(2));%></td>
	<td><%out.println(mi.rs.getString(3));%></td>
	<td><%out.println(mi.rs.getString(4));%></td>
	<td><%out.println(mi.rs.getString(5));%></td>
	<td><%out.println(mi.rs.getString(6));%></td>
	<td><a href="Javascript:<%=paramList%>"><%out.println(mi.rs.getString(7));%></a></td>
</tr>	
<%} mi.closeAll();

}else if(type.equals("save")){	
	String itemCode=request.getParameter("itemCode");	
	Integer priceVersion=Integer.parseInt(request.getParameter("priceVersion"));
	Integer oldQty=Integer.parseInt(request.getParameter("oldQty"));
	Integer newQuantity=Integer.parseInt(request.getParameter("newQuantity"));
	Integer newSiteId=Integer.parseInt(request.getParameter("newSiteId"));
	item.ManageItem mi= new item.ManageItem("jdbc/js");
	int ans = mi.changeQuantity(itemCode,newSiteId,priceVersion,oldQty,newQuantity);
	if(ans != 0){
%>
Success
<%}else{ %>
Error
<%
} mi.closeAll();
}%>