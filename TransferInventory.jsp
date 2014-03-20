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
	String status="TRANSFER";
	//String itemstatus="TRANSFER";
	
	Integer siteId = Integer.parseInt(request.getParameter("siteId"));
	Integer desId=Integer.parseInt(request.getParameter("desId"));
	
	String souceName = request.getParameter("sourceSiteName");
	String destName = request.getParameter("destSiteName");
	
	
	Integer totalItems =Integer.parseInt(request.getParameter("grandTotalItems"));
	Integer totalQty = Integer.parseInt(request.getParameter("grandTotalQty"));
	
	String[] itemCode = request.getParameterValues("saveItemCode");
	String[] transferQty = request.getParameterValues("savetransferQty");
	String[] priceVersion = request.getParameterValues("savePriceVersion");
	String[] box_qty = request.getParameterValues("box_qty_save");
	String[] sourceID=request.getParameterValues("sourceID");
	String[] destID=request.getParameterValues("destID");
	System.out.println("so "+sourceID.length);
	for(String s :sourceID){
		System.out.println("so  "+s);
	}
	boolean flag =false;
	ManageInventory mi = new ManageInventory("jdbc/js");
	Integer result =mi.saveInTransferInventory(siteId,desId,totalItems, totalQty,status,userName);
	
	// print price version 
	for(String price :priceVersion){
		System.out.println("price "+price);
	}
	

	if(result != 0){
		for(int i=0; i<itemCode.length; i++){
		
					if(mi.saveInTransferDetails(result,itemCode[i],Integer.parseInt(priceVersion[i]),Integer.parseInt(transferQty[i]),status, sourceID[i])){
						flag = true;
						}
					}
				}
			
	mi.closeAll();
	if(flag){
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		Barcode objBarcode = BarcodeFactory.createCode128C(result+"");
		String ImagePath = (String) envContext.lookup("imagesfile");
		ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+result+".PNG";
		objBarcode.setDrawingText(true);
		File f = new File(ImagePath);  
	    BarcodeImageHandler.savePNG(objBarcode, f);
	    ManageInventory  objMI = new ManageInventory("jdbc/js");
%>
		<center><h1>Transfer Inventory Successfully</h3>
		<div id="content" align="center">
		<br/>
		<img src="images/barcodeImages/<%=result%>.PNG" width="120px;"/><h3>Transfer Inventory</h3>
		<b><table>
			<tr><td>Bill no </td><td>: </td><td> <%=result%> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Form </td><td>: </td><td> <%= souceName%></td></tr>
			<tr><td>User </td><td>: </td><td> <%=userName%> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>To </td><td>: </td><td> <%= destName%></td></tr>
		</table></b>
		<table border="1" style="border-color:black;border-collapse: collapse;">
			<thead>
			<tr>
				<th rowspan="2"> No.</th>
				<th rowspan="2"> Item Name </th>
				<th rowspan="2"> Weight </th>																			
				<th rowspan="2"> MRP </th>
				<th colspan="3" class="hidePrint"> Source Qty </th>
				<th colspan="3"> Transfer Qty </th>
				<th colspan="3" class="hidePrint"> After Tran. Dest. Qty </th>
			</tr>
			<tr>
				<th class="hidePrint">Box</th><th class="hidePrint">Loose</th><th class="hidePrint">Total</th>
				<th>Box</th><th>Loose</th><th>Total</th>
				<th class="hidePrint">Box</th><th class="hidePrint">Loose</th><th class="hidePrint">Total</th>
			</tr>
			</thead>
			<tbody>
			<% 
				for(int i=0;i<itemCode.length;i++){
					System.out.print("\n\n"+box_qty[i]+"\n\n");
					int box_Q=Integer.parseInt(box_qty[i]);
					
					objMI.searchItem1(itemCode[i],Integer.parseInt(priceVersion[i]));
					objMI.rs.next();
					out.print("<tr><td>"+(i+1)+".</td>");
					out.print("<td>"+objMI.getItemName(itemCode[i])+"</td>");
					out.print("<td>"+objMI.getItemWeight(itemCode[i])+"</td>");
					out.print("<td>"+objMI.rs.getDouble(1)+"</td>");
					System.out.print("\n\n transfer inventory priceve version "+priceVersion[i]+"\n\n");
					int qty1=objMI.getSiteQuantity(itemCode[i], siteId, Integer.parseInt(priceVersion[i]));
					int qty2=objMI.getDesQuantityTrans(itemCode[i], desId, Integer.parseInt(priceVersion[i]));
					int trans=Integer.parseInt(transferQty[i]);
					//update dest Qty for display
					int rem=qty2+trans;
					//update source Qty fro display
					//qty1=qty1+trans;
					
					if(box_Q>1){
						out.print("<td class='hidePrint'>"+(int)qty1/box_Q+" ("+box_Q+")</td>");
						out.print("<td class='hidePrint'>"+qty1%box_Q+"</td>");
						out.print("<td class='hidePrint'>"+qty1+"</td>");
						
						out.print("<td>"+(int)trans/box_Q+" ("+box_Q+")</td>");
						out.print("<td>"+trans%box_Q+"</td>");
						out.print("<td>"+trans+"</td>");
						
						out.print("<td class='hidePrint'>"+(int)rem/box_Q+" ("+box_Q+")</td>");
						out.print("<td class='hidePrint'>"+rem%box_Q+"</td>");
						out.print("<td class='hidePrint'>"+rem+"</td></tr>");
					}else{
						out.print("<td colspan=3 class='hidePrint'>"+(int)qty1/box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+qty1%box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+qty1+"</td>");
						
						out.print("<td colspan=3>"+(int)trans/box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+trans%box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+trans+"</td>");
						
						out.print("<td colspan=3 class='hidePrint'>"+(int)rem/box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+rem%box_Q+"</td>");
						out.print("<td style=\"display:none;\">"+rem+"</td></tr>");
					}
					objMI.rs.close();
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
		}else{
%>
	<h3><b><br><br><br><center> Error</center></b></h3>
	<input type="button" value="Back Page" style="width:100" onclick="back();"/>
	<input type="button" value="Home Page" style="width:100" onclick="home();"/>
  <%
	}
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
   window.location="TransferInventoryForm.jsp";
   }
function back(){
	window.location="TransferInventoryForm.jsp";
	}
function home(){
	window.location="HomeForm.jsp";
	}
</script>