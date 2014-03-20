<%@page import="inventory.ManageSite"%>
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
<%@page import="inventory.ManageInventory"%>
<style type="text/css">
div#content
{
border:2px solid black;
border-radius:2em;
}

</style>
<%


	String userName = session.getAttribute("UserName").toString();
	
 	Integer siteId = Integer.parseInt(request.getParameter("siteId"));
	Integer desId=Integer.parseInt(request.getParameter("desId"));
	
	String souceName = request.getParameter("sourceName");
	String destName = request.getParameter("destName");
	
	int transfer_id = Integer.parseInt(request.getParameter("ItrnsNumber"));
	String barCode = request.getParameter("Ibarcode"); 
	String[] itemCode = request.getParameterValues("IitemCode");
	String[] itemName = request.getParameterValues("Iitemname");
	String[] itemWeight = request.getParameterValues("Iitemweight"); 
	String [] itemRate = request.getParameterValues("Iitem_rate");
	String itemMrp[] = request.getParameterValues("Iitem_mrp");
	String sourceQty[] = request.getParameterValues("Isource_qty");
	String destQty [] = request.getParameterValues("Ides_qty"); 
	String[] transferQty = request.getParameterValues("Itransfer_qty");
	String [] acceptQty = request.getParameterValues("Iaccept_qty");
	String[] priceVersion = request.getParameterValues("priceversion");
	String [] Status = request.getParameterValues("Istatus"); 
	//String[] box_qty = request.getParameterValues("box_qty_save");
	//String [] status = request.getParameterValues("IStatus");
	String IdestQty11[] = request.getParameterValues("Ides_qty");
	
	
	Integer totalItems =Integer.parseInt(request.getParameter("grandTotalItems"));
	//Integer totalQty = Integer.parseInt(request.getParameter("grandTotalQty"));
	int totalQty = 0;
	System.out.println("======\n\\n item code "+itemCode.length+"\n item name length "+IdestQty11.length);
	
	for(String transfer :acceptQty){
		System.out.println("== transfer "+transfer);
		totalQty = totalQty + Integer.parseInt(transfer);
		
		
	}
	
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	ManageInventory  objMI = new ManageInventory("jdbc/js");
	Barcode objBarcode = BarcodeFactory.createCode128C(transfer_id+"");
	String ImagePath = (String) envContext.lookup("imagesfile");
	ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+transfer_id+".PNG";
	objBarcode.setDrawingText(true);
	File f = new File(ImagePath);            	
    BarcodeImageHandler.savePNG(objBarcode, f);
   
%>
	<center><h1>Received Inventory Successfully</h3>
	<div id="content" align="center">
	<br/>
	<img src="images/barcodeImages/<%=transfer_id%>.PNG" width="120px;"/><h3>Received Inventory</h3>
	<b><table style="border-collapse: collapse;">
		<tr><td>Bill no </td><td>: </td><td> <%= transfer_id %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>From </td><td>: </td><td><%= souceName%></td></tr>
		<tr><td>User </td><td>: </td><td> <%= userName %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>To </td><td>: </td><td><%= destName%></td></tr>
	</table></b>
	<table border="1" style="border-collapse: collapse;border-left:1px;border-top:1px; ">
		<tr>
			<th style="width:40">No.</th>
			<th style="width:280"> Item Name </th>
			<th style="width:80"> Weight </th>																			
			<th style="width:70"> MRP </th>
			<th style="width:80"> JS price </th>
			<th style="width:80"> Source Qty </th>
			<th style="width:80"> Dest.Qty </th>
			<th style="width:80"> Acc.Qty </th>
			<!-- <th style="width:80"> Remain Qty </th>
			<th style="width:80"> After Trans. Qty </th> -->
			<th style="width:80"> Status </th>
		</tr>
		<% 
			String inventoryStatus =null;
			for(int i=0;i<itemCode.length;i++){
				if(Status[i].equals("CHNGQTY-RCVD LESS"))
					inventoryStatus="Receive Less";
				else if(Status[i].equals("CHNGQTY-RCVD MORE"))
					inventoryStatus= "Receive More";
				else if(Status[i].equals("NOT TRANSFER"))
					inventoryStatus= "Not Receive ";
				else if(Status[i].equals("TRANSFER"))
					inventoryStatus= "Receive ";
				
				System.out.println("item code "+itemCode[i]+"\n objMI.getItemName(itemCode[i]) "+objMI.getItemName(itemCode[i]));
				
				out.print("<tr><td>"+(i+1)+".</td>");
				out.print("<td>"+objMI.getItemName(itemCode[i])+"</td>");
				out.print("<td>"+itemWeight[i]+"</td>");
				out.print("<td>"+itemMrp[i]+"</td>");
				out.print("<td>"+itemRate[i]+"</td>");
				
				/* out.print("<td>"+transferQty[i]+"</td>"); */
				/* out.print("<td>"+(Integer.parseInt(sourceqty[i])-Integer.parseInt(transferqty[i]))+"</td>");
				out.print("<td>"+(Integer.parseInt(sourceQty[i])+Integer.parseInt(acceptQty[i]))+"</td>");
				out.print("<td>"+(Integer.parseInt(IdestQty11[i])-Integer.parseInt(acceptQty[i]))+"</td>");*/
		
				out.print("<td>"+sourceQty[i]+"</td>");
				out.print("<td>"+IdestQty11[i]+"</td>");
				
				out.print("<td>"+acceptQty[i]+"</td>");
				/* out.print("<td>"+sourceQty[i]+"</td>");
				out.print("<td>"+IdestQty11[i]+"</td>"); */
				out.print("<td>"+Status[i]+"</td></tr>");
			}
				
			 %>
			 </tbody>
			</table>
			<br/>
			</div>
			<br/>
			<input type="button" value="Print" style="width:100" onclick="printPage('content');"/>
			<input type="button" value="Back Page" style="width:100" onclick="back();"/>
			<input type="button" value="Home Page" style="width:100" onclick="home();"/>
			</center>
	    		
<%
	objMI.closeAll();
%>


<script type="text/javascript">
function printPage(id){
	var html="<html> <style> .hidePrint{display:none;}</style>";
    html+= document.getElementById(id).innerHTML;

   var printWin = window.open('','','left=3,top=4,width=700,height=600,toolbar=0,scrollbars=2,status  =0');
   printWin.document.write(html);
   printWin.document.close();
   printWin.focus();
   printWin.print();
   printWin.close();
   window.location="EditTransferInventoryForm.jsp";
   }
function back(){
	window.location="EditTransferInventoryForm.jsp";
	}
function home(){
	window.location="HomeForm.jsp";
	}
</script>