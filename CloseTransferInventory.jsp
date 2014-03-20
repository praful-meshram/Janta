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
	String itemstatus="Closed";
    Integer  transferId = Integer.parseInt(request.getParameter("trnsnumbr"));
    String[] itemCode = request.getParameterValues("IitemCode");
	String[] barCode = request.getParameterValues("Ibarcode");
	String[] itemweight = request.getParameterValues("Iitemweight");
	String[] itemrate = request.getParameterValues("Iitem_rate");
	String[] itemmrp = request.getParameterValues("Iitem_mrp");
	String[] itemqty = request.getParameterValues("Iitem_qty");
	String[] transferqty = request.getParameterValues("Itransfer_qty");
	String[] acceptqty = request.getParameterValues("Itransfer_qty");
	String[] Status = request.getParameterValues("IStatus");
	String[] remark= request.getParameterValues("IRemark");
	String matserRemark="";
	boolean flag =false,nflag=false;
	ManageInventory mi = new ManageInventory("jdbc/js");
	for(int i=0;i<itemCode.length; i++){
		mi.updateCloseDetailsInventory(itemCode[i],remark[i],transferId);
		if(Status[i].equals("TRANSFER") ){
			flag = true;
		}else if (Status[i].equals("NOT TRANSFER")) {					
			nflag =true;					
		}else if (Status[i].equals("CHNGQTY-RCVD MORE")) {					
			nflag =true;					
		}else if (Status[i].equals("CHNGQTY-RCVD LESS")) {					
			nflag =true;					
		}
	}
	
	if(flag == true && nflag == false){
		matserRemark = "TRANSFER";
	}else{
		matserRemark = "CHANGE";
	}
	mi.updatetrnsInventory(itemstatus,transferId,matserRemark);
	
	mi.closeAll();
	System.out.println("flag "+flag);
	if(flag){
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		ManageInventory  objMI = new ManageInventory("jdbc/js");
		Barcode objBarcode = BarcodeFactory.createCode128C(transferId+"");
		String ImagePath = (String) envContext.lookup("imagesfile");
		ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+transferId+".PNG";
		objBarcode.setDrawingText(true);
		File f = new File(ImagePath);            	
	    BarcodeImageHandler.savePNG(objBarcode, f);
		 //ManageInventory mi1 = new ManageInventory("jdbc/js");
%>
		<center><h1>Inventory Transfer Close Successfully</h1>
		<div id="content" align="center">
		<br/>
		<img src="images/barcodeImages/<%=transferId%>.PNG" width="120px;"/><h3>Close Inventory(Transfer)</h3>
		<table>
			<tr><td>Bill no </td><td>: </td><td> <%= transferId %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
			<tr><td>User </td><td>: </td><td> <%= userName %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
		</table>
		<table border="1">
			<tr>
				<th style="width:40">No.</th>
				<th style="width:280"> Item Name </th>
				<th style="width:80"> Weight </th>																			
				<th style="width:70"> MRP </th>
				<th style="width:80"> JS price </th>
				<th style="width:80"> Item Qty </th>
				<th style="width:80"> Trans. Qty </th>
				<th style="width:80"> Accept Qty </th>
				<th style="width:80"> Status </th>
				<th style="width:80"> Remark </th>
			</tr>
			<% 
				for(int i=0;i<itemCode.length;i++){
					out.print("<tr><td>"+(i+1)+".</td>");
					out.print("<td>"+objMI.getItemName(itemCode[i])+"</td>");
					out.print("<td>"+itemweight[i]+"</td>");
					out.print("<td>"+itemmrp[i]+"</td>");
					out.print("<td>"+itemrate[i]+"</td>");
					out.print("<td>"+itemqty[i]+"</td>");
					out.print("<td>"+transferqty[i]+"</td>");
					out.print("<td>"+acceptqty[i]+"</td>");
					out.print("<td>"+Status[i]+"</td>");
					out.print("<td>"+remark[i]+"</td></tr>");
				}
			 %>
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
   window.location="CloseTransferInventoryForm.jsp";
   }
function back(){
	window.location="CloseTransferInventoryForm.jsp";
	}
function home(){
	window.location="HomeForm.jsp";
	}
</script>
