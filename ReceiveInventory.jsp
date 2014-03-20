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
    //String itemstatus="Receive";
    Integer  transferId = Integer.parseInt(request.getParameter("transfernum"));
    Integer siteId = Integer.parseInt(request.getParameter("siteId"));
   	Integer desId=Integer.parseInt(request.getParameter("desId"));
   	
   	String sourceName = request.getParameter("sourceName");
   	String destName = request.getParameter("destName");
   	
	String[] priceversion=request.getParameterValues("priceversion");
	String[] itemCode = request.getParameterValues("IitemCode");
	String[] barCode = request.getParameterValues("Ibarcode");
	String[] itemweight = request.getParameterValues("Iitemweight");
	String[] itemrate = request.getParameterValues("Iitem_rate");
	String[] itemmrp = request.getParameterValues("Iitem_mrp");
	String[] sourceqty = request.getParameterValues("Isource_qty");
	String[] desqty = request.getParameterValues("Ides_qty");
	String[] transferqty = request.getParameterValues("Itransfer_qty");
	String[] acceptqty = request.getParameterValues("Iaccept_qty");
	String[] Status = request.getParameterValues("IStatus");
	String itemStatus= request.getParameter("hItemStatus");
	String[] Remark = request.getParameterValues("Remark");
	int grandAcceptQty =0;

	System.out.println("==== itemStatus "+itemStatus);
	
	String matserRemark =null;
	String itemstatus="Closed";
	boolean flag =false,nflag=false;
	boolean updateTransferInvDetails = false;
	int sourceQtyDisplay[] =new int[sourceqty.length];
	ManageInventory mi = new ManageInventory("jdbc/js");
	//mi.updatetrnsferInventory(itemStatus,transferId );
	mi.conn.setAutoCommit(false);
	System.out.println( "item code length "+ itemCode.length);
	
		for(String accQty :acceptqty){
			grandAcceptQty+=Integer.parseInt(accQty); 
			
		}
		
	for(int i=0;i<itemCode.length; i++){
		System.out.println(i + " === loop  item code "+ itemCode[i]+"\n priceversion "+priceversion[i]+"\n sourceqty[i] "+sourceqty[i]+"\n transferqty[i] "+transferqty[i]+
				"\n dest qty[i] "+desqty[i]);
		
/* 		int srcQty = Integer.parseInt(sourceqty[i])-Integer.parseInt(transferqty[i]);
		int desQty = Integer.parseInt(desqty[i])+Integer.parseInt(transferqty[i]); */

		//int srcQty = Integer.parseInt(sourceqty[i])-Integer.parseInt(acceptqty[i]);
		int srcQty =0;
		if(Integer.parseInt(transferqty[i])>Integer.parseInt(acceptqty[i])){
			srcQty=Integer.parseInt(transferqty[i])-Integer.parseInt(acceptqty[i]);
			srcQty  =Integer.parseInt(sourceqty[i])+srcQty;
			
			
		}else{
			srcQty=Integer.parseInt(acceptqty[i])-Integer.parseInt(transferqty[i]);
			srcQty  =Integer.parseInt(sourceqty[i])-srcQty;
			
		}
		sourceQtyDisplay[i]=srcQty;
		int desQty = Integer.parseInt(desqty[i])+Integer.parseInt(acceptqty[i]);
		
		System.out.println(" accept  "+acceptqty[i]); 
		
		updateTransferInvDetails =  mi.updatetrnsInventorydetails(Status[i],itemCode[i],transferId,Remark[i],siteId,desId,priceversion[i],srcQty,desQty,acceptqty[i]);
		//updatetrnsInventorydetails(String itemStatus,String itemcode, Integer transferid,String Remark,int siteId,int desID,String priceversion,int srcQty,int destQty,String transferQty)
		if(updateTransferInvDetails){
			if(Status[i].equals("TRANSFER") ){
				flag = true;
			}else if (Status[i].equals("NOT TRANSFER")) {					
				nflag =true;					
			}else if (Status[i].equals("CHNGQTY-RCVD MORE")) {					
				nflag =true;					
			}else if (Status[i].equals("CHNGQTY-RCVD LESS")) {					
				nflag =true;					
			}
			
			if(flag == true && nflag == false){
				matserRemark = "TRANSFER";
			}else{
				matserRemark = "CHANGE";
			}
			
		}
				
		
		// Updating transfer inventory set status and remark and closing transfer 
		System.out.println(itemstatus+" status[i] "+Status[i]+"grand total Qty "+grandAcceptQty);
		if(updateTransferInvDetails){
			flag =  mi.updatetrnsferInventory(itemstatus,transferId,matserRemark,grandAcceptQty,userName);
		}
		
	}
	mi.closeAll();
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
		<center><h1>Received Inventory Successfully</h1>
		<div id="content" align="center">
		<br/>
		<img src="images/barcodeImages/<%=transferId%>.PNG" width="120px;"/><h3>Received Inventory</h3>
		<b><table style="border-collapse: collapse;">
			<tr><td>Bill no </td><td>: </td><td> <%= transferId %> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>From </td><td>: </td><td><%= sourceName%></td></tr>
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
				<!-- <th style="width:80"> Trans. Qty </th> 
				<th style="width:80"> Remain Qty </th>-->
				
				<th style="width:80"> Dest.Qty </th>
				<th style="width:80"> Acc.Qty </th>
				<!-- <th style="width:80"> After Trans. Qty </th> -->
				<th style="width:80"> Status </th>
			</tr>
			<% 	String inventoryStatus = null;
				for(int i=0;i<itemCode.length;i++){
					if(Status[i].equals("CHNGQTY-RCVD LESS"))
						inventoryStatus="Receive Less";
					else if(Status[i].equals("CHNGQTY-RCVD MORE"))
						inventoryStatus= "Receive More";
					else if(Status[i].equals("NOT TRANSFER"))
						inventoryStatus= "Not Receive ";
					else if(Status[i].equals("TRANSFER"))
						inventoryStatus= "Receive ";
					
					System.out.println("Status "+Status[i]);	
					out.print("<tr><td>"+(i+1)+".</td>");
					out.print("<td>"+objMI.getItemName(itemCode[i])+"</td>");
					out.print("<td>"+itemweight[i]+"</td>");
					out.print("<td>"+itemmrp[i]+"</td>");
					out.print("<td>"+itemrate[i]+"</td>");
				/* 	out.print("<td>"+sourceqty[i]+"</td>"); */
					out.print("<td>"+sourceQtyDisplay[i]+"</td>");	
					
				/* 	out.print("<td>"+transferqty[i]+"</td>"); */
					/* out.print("<td>"+(Integer.parseInt(sourceqty[i])-Integer.parseInt(transferqty[i]))+"</td>");
					out.print("<td>"+(Integer.parseInt(sourceqty[i])-Integer.parseInt(acceptqty[i]))+"</td>"); */
					
					out.print("<td>"+(Integer.parseInt(desqty[i])+Integer.parseInt(acceptqty[i]))+"</td>");
					out.print("<td>"+acceptqty[i]+"</td>");
					/* out.print("<td>"+(Integer.parseInt(desqty[i])+Integer.parseInt(acceptqty[i]))+"</td>"); */
					out.print("<td>"+inventoryStatus+"</td></tr>");
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
		
		
<script type="text/javascript">
function printPage(id){
   var html="<html>";
   html+= document.getElementById(id).innerHTML;
   html+="</html>";

   var printWin = window.open('','','left=3,top=4,width=700,height=600,toolbar=0,scrollbars=2,status  =0');
   printWin.document.write(html);
   printWin.document.close();
   printWin.focus();
   printWin.print();
   printWin.close();
   window.location="ReceiveInventoryForm.jsp";
   }
function back(){
	window.location="ReceiveInventoryForm.jsp";
	}
function home(){
	window.location="HomeForm.jsp";
	}
</script>

