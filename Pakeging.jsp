<%@ page contentType="text/html"%>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="net.sourceforge.barbecue.*"%>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<style type="text/css">
div#content
{
border:2px solid black;
width:800px;
border-radius:2em;
}
</style>

 
<%@ page errorPage="ErrorPage.jsp?page=Packaging.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%@page import="inventory.ManageInventory"%>
<%
	String userName = session.getAttribute("UserName").toString();
	Integer siteId = Integer.parseInt(request.getParameter("siteId"));
	String[] itemCode = request.getParameterValues("saveItemCode");
	// checking for item code 
	System.out.println("===========================");
	System.out.print("item code in packaging :"+itemCode.length);
	for(String s:itemCode)
	{
		System.out.println("item code :"+s);
	}
	System.out.println("===========================");
	
	
	String[] itemMrp = request.getParameterValues("saveMrp");
	String[] itemRate = request.getParameterValues("saveRate");
	String[] newQty = new String[itemMrp.length];
	String[] newQty_box = request.getParameterValues("saveNewQty_box");
	//String[] oldQty_box = request.getParameterValues("saveOldQty_box");
	//String[] totalQty_box = request.getParameterValues("saveTotalQty_box");
	String[] newQty_loose = request.getParameterValues("saveNewQty");
	String[] oldQty_loose = request.getParameterValues("saveOldQty");
	//String[] totalQty_loose = request.getParameterValues("saveTotalQty");
	String[] box_qty = request.getParameterValues("box_qty");
	String[] new_flag = request.getParameterValues("new_flag");
	
	// retriving loss or gain from previos page
	float loss_in_breakdown=Float.parseFloat(request.getParameter("loss_in_breakdown"));
	float gain_in_breakdown=Float.parseFloat(request.getParameter("gain_in_breakdown"));

	
	String b_code=request.getParameter("selected_bachka_code");
	int break_count = Integer.parseInt(request.getParameter("break_count"));
	int price_version = Integer.parseInt(request.getParameter("selected_bachka_pv"));
	System.out.println("Bachka to breakdown : "+break_count);
	System.out.println("Bachka price Version : "+price_version);
	for(int i=0;i<newQty_box.length;i++){
		if(newQty_box[i].equals("")){
			newQty_box[i]="0";
		}
		if(newQty_loose[i].equals("")){
			newQty_loose[i]="0";
		}
		newQty[i]=(Integer.parseInt(newQty_box[i])*Integer.parseInt(box_qty[i]))+Integer.parseInt(newQty_loose[i])+"";
		//oldQty[i]=(Integer.parseInt(oldQty_box[i])*Integer.parseInt(box_qty[i]))+Integer.parseInt(oldQty_loose[i])+"";
		//totalQty[i]=(Integer.parseInt(totalQty_box[i])*Integer.parseInt(box_qty[i]))+Integer.parseInt(totalQty_loose[i])+"";
	}
	
	String[] priceVersion = request.getParameterValues("savePriceVersion");
	boolean flag =false;
	ManageInventory mi = new ManageInventory("jdbc/js");
	//Integer result =mi.saveInBreakDownHeader(b_code,loss_in_breakdown,siteId,userName);
	
	System.out.println("before brekdown function ");
	
	Integer result =mi.saveInBreakDownHeader(b_code,loss_in_breakdown,gain_in_breakdown,siteId,userName);
	System.out.println("after brekdown function ");
	
	if(result != 0){
		for(int i=0; i<itemCode.length; i++){
			if(mi.saveBreakDownDetails(result,itemCode[i],Integer.parseInt(priceVersion[i]),Integer.parseInt(newQty[i]))){
				if(mi.saveInItemMaster(itemCode[i],itemRate[i],itemMrp[i],Integer.parseInt(newQty[i]))){
					if(mi.saveInItemPrice(itemCode[i],itemRate[i],itemMrp[i],Integer.parseInt(newQty[i]),Integer.parseInt(priceVersion[i]))){
						if(mi.saveInItemSiteInventory(itemCode[i],siteId,Integer.parseInt(newQty[i]),Integer.parseInt(priceVersion[i]))){
							flag = true;
							System.out.println("\nUpadated\n");
						}
					}
				}
			}
		}
		if(flag){
			
			System.out.println("breakcount  = " + break_count);
			mi.setBaachkaCount(break_count,b_code,siteId,price_version);
		}
	}
	mi.closeAll();
	if(flag){
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	ManageInventory  objMI = new ManageInventory("jdbc/js");
	Barcode objBarcode = BarcodeFactory.createCode128C(result+"");
	String ImagePath = (String) envContext.lookup("imagesfile");
	ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+result+".PNG";
	objBarcode.setDrawingText(true);
	File f = new File(ImagePath);            	
    BarcodeImageHandler.savePNG(objBarcode, f);
%>		<center><h1>Inventory saved Successfully</h3>
		<div id="content" align="center">
		<br/>
		<img src="images/barcodeImages/<%= result %>.PNG" width="120px;"/><h3>BreakDown Details</h3>
		<b><table>
			<tr>
				<td>Slip no </td><td>: </td><td> <%= result %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Type </td><td>: </td><td>BreakDown</td>
			</tr>
			<tr>
				<td>User </td><td>: </td><td> <%= userName %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Site Name </td><td>: </td><td><%= new ManageInventory("jdbc/js").siteName(siteId)%></td>
			</tr>
				<tr><td></td><td> </td><td></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>Date </td><td>: </td><td><%= new ManageInventory("jdbc/js").bdDate(result)%></td>
			</tr>
		</table></b>
		<table border="1">
			<thead>
			<tr>
				<th rowspan="2">No.</th>
				<th rowspan="2"> Item Name </th>
				<th rowspan="2"> Weight </th>																			
				<th rowspan="2"> MRP </th>
				<th colspan="3"> Quantity </th>
			</tr>
			<tr>
				<th>Box</th>
				<th>Loose</th>
				<th>Total</th>
			</tr>
			</thead>
			<tbody>
			<% 
			double total=0;
			for(int i=0;i< itemCode.length;i++) {
				int box_Q=Integer.parseInt(box_qty[i]);
				int new_Q=Integer.parseInt(newQty[i]);
				out.print("<tr><td>"+(i+1)+".</td>");
				out.print("<td>"+objMI.getItemName(itemCode[i])+"</td>");
				out.print("<td align=center>"+objMI.getItemWeight(itemCode[i])+"</td>");
				if(new_flag[i].equals("O"))
					out.print("<td align=right>"+itemMrp[i]+"</td>");
				else
					out.print("<td align=right>("+new_flag[i]+") "+itemMrp[i]+"</td>");
				if(box_Q>1){
					out.print("<td align=right>"+(int)new_Q/box_Q+" ("+box_Q+")</td>");
					out.print("<td align=right>"+new_Q%box_Q+"</td>");
					out.print("<td align=right>"+new_Q+"</td>");
				}else{
					out.print("<td colspan=3 align=right>"+(int)new_Q/box_Q+"</td>");
					out.print("<td style=\"display:none;\">"+new_Q%box_Q+"</td>");
					out.print("<td style=\"display:none;\">"+new_Q+"</td>");
				}
					
			}
			 %>
			 </tbody>
			</table>
			<BR/>
			</div>
			<br/>
			<input type="button" value="Print" style="width:100" onclick="printPage('content');"/>
			<input type="button" value="Back Page" style="width:100" onclick="back();"/>
			<input type="button" value="Home Page" style="width:100" onclick="home();"/>
			</center>
	    		
<% 
objMI.closeAll();
}else{
%>
	<center>
		<h3><b><br><br><br> Error in Accept inventory</b></h3>
		<input type="button" value="Back Page" style="width:100" onclick="back();"/>
		<input type="button" value="Home Page" style="width:100" onclick="home();"/>
	</center>
    		
<%
	}
%>
<script>
function printPage(id){
   var html="<html>";
   html+= document.getElementById(id).innerHTML;
   html+="</html>";

   var printWin = window.open('','','left=3,top=4,width=5,height=2,toolbar=0,scrollbars=2,status  =0');
   printWin.document.write(html);
   printWin.document.close();
   printWin.focus();
   printWin.print();
   printWin.close();
   window.location="PakegingForm.jsp";
   }
function back(){
	window.location="PakegingForm.jsp";
	}
function home(){
	window.location="HomeForm.jsp";
	}
</script>