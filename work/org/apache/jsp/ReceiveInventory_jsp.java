/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-03-19 05:02:48 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.awt.image.BufferedImage;
import net.sourceforge.barbecue.*;
import javax.imageio.ImageIO;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;
import java.awt.*;
import java.util.*;
import java.text.*;
import inventory.ManageInventory;

public final class ReceiveInventory_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<style type=\"text/css\">\n");
      out.write("div#content\n");
      out.write("{\n");
      out.write("border:2px solid black;\n");
      out.write("border-radius:2em;\n");
      out.write("}\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("\n");

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

      out.write("\n");
      out.write("\t\t<center><h1>Received Inventory Successfully</h1>\n");
      out.write("\t\t<div id=\"content\" align=\"center\">\n");
      out.write("\t\t<br/>\n");
      out.write("\t\t<img src=\"images/barcodeImages/");
      out.print(transferId);
      out.write(".PNG\" width=\"120px;\"/><h3>Received Inventory</h3>\n");
      out.write("\t\t<b><table style=\"border-collapse: collapse;\">\n");
      out.write("\t\t\t<tr><td>Bill no </td><td>: </td><td> ");
      out.print( transferId );
      out.write(" </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>From </td><td>: </td><td>");
      out.print( sourceName);
      out.write("</td></tr>\n");
      out.write("\t\t\t<tr><td>User </td><td>: </td><td> ");
      out.print( userName );
      out.write(" </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>To </td><td>: </td><td>");
      out.print( destName);
      out.write("</td></tr>\n");
      out.write("\t\t</table></b>\n");
      out.write("\t\t<table border=\"1\" style=\"border-collapse: collapse;border-left:1px;border-top:1px; \">\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<th style=\"width:40\">No.</th>\n");
      out.write("\t\t\t\t<th style=\"width:280\"> Item Name </th>\n");
      out.write("\t\t\t\t<th style=\"width:80\"> Weight </th>\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t<th style=\"width:70\"> MRP </th>\n");
      out.write("\t\t\t\t<th style=\"width:80\"> JS price </th>\n");
      out.write("\t\t\t\t<th style=\"width:80\"> Source Qty </th>\n");
      out.write("\t\t\t\t<!-- <th style=\"width:80\"> Trans. Qty </th> \n");
      out.write("\t\t\t\t<th style=\"width:80\"> Remain Qty </th>-->\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t<th style=\"width:80\"> Dest.Qty </th>\n");
      out.write("\t\t\t\t<th style=\"width:80\"> Acc.Qty </th>\n");
      out.write("\t\t\t\t<!-- <th style=\"width:80\"> After Trans. Qty </th> -->\n");
      out.write("\t\t\t\t<th style=\"width:80\"> Status </th>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t");
 	String inventoryStatus = null;
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
			 
      out.write("\n");
      out.write("\t\t\t</table>\n");
      out.write("\t\t\t<br/>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<br/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Print\" style=\"width:100\" onclick=\"printPage('content');\"/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Back Page\" style=\"width:100\" onclick=\"back();\"/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Home Page\" style=\"width:100\" onclick=\"home();\"/>\n");
      out.write("\t\t\t</center>\n");
      out.write("\t\t");
 
		objMI.closeAll();	
		}else{
		
      out.write("\n");
      out.write("\t\t\t<h3><b><br><br><br><center> Error</center></b></h3>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Back Page\" style=\"width:100\" onclick=\"back();\"/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Home Page\" style=\"width:100\" onclick=\"home();\"/>\n");
      out.write("\t\t    \t\t\n");
      out.write("\t\t");

			}
		
      out.write("\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("function printPage(id){\n");
      out.write("   var html=\"<html>\";\n");
      out.write("   html+= document.getElementById(id).innerHTML;\n");
      out.write("   html+=\"</html>\";\n");
      out.write("\n");
      out.write("   var printWin = window.open('','','left=3,top=4,width=700,height=600,toolbar=0,scrollbars=2,status  =0');\n");
      out.write("   printWin.document.write(html);\n");
      out.write("   printWin.document.close();\n");
      out.write("   printWin.focus();\n");
      out.write("   printWin.print();\n");
      out.write("   printWin.close();\n");
      out.write("   window.location=\"ReceiveInventoryForm.jsp\";\n");
      out.write("   }\n");
      out.write("function back(){\n");
      out.write("\twindow.location=\"ReceiveInventoryForm.jsp\";\n");
      out.write("\t}\n");
      out.write("function home(){\n");
      out.write("\twindow.location=\"HomeForm.jsp\";\n");
      out.write("\t}\n");
      out.write("</script>\n");
      out.write("\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
