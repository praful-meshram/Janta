/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-03-19 05:00:18 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import inventory.ManageSite;
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

public final class TransferInventory_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<style type=\"text/css\">\n");
      out.write("div#content\n");
      out.write("{\n");
      out.write("border:2px solid black;\n");
      out.write("border-radius:2em;\n");
      out.write("}\n");
      out.write("\n");
      out.write("</style>\n");


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

      out.write("\n");
      out.write("\t\t<center><h1>Transfer Inventory Successfully</h3>\n");
      out.write("\t\t<div id=\"content\" align=\"center\">\n");
      out.write("\t\t<br/>\n");
      out.write("\t\t<img src=\"images/barcodeImages/");
      out.print(result);
      out.write(".PNG\" width=\"120px;\"/><h3>Transfer Inventory</h3>\n");
      out.write("\t\t<b><table>\n");
      out.write("\t\t\t<tr><td>Bill no </td><td>: </td><td> ");
      out.print(result);
      out.write(" </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Form </td><td>: </td><td> ");
      out.print( souceName);
      out.write("</td></tr>\n");
      out.write("\t\t\t<tr><td>User </td><td>: </td><td> ");
      out.print(userName);
      out.write(" </td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>To </td><td>: </td><td> ");
      out.print( destName);
      out.write("</td></tr>\n");
      out.write("\t\t</table></b>\n");
      out.write("\t\t<table border=\"1\" style=\"border-color:black;border-collapse: collapse;\">\n");
      out.write("\t\t\t<thead>\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<th rowspan=\"2\"> No.</th>\n");
      out.write("\t\t\t\t<th rowspan=\"2\"> Item Name </th>\n");
      out.write("\t\t\t\t<th rowspan=\"2\"> Weight </th>\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t<th rowspan=\"2\"> MRP </th>\n");
      out.write("\t\t\t\t<th colspan=\"3\" class=\"hidePrint\"> Source Qty </th>\n");
      out.write("\t\t\t\t<th colspan=\"3\"> Transfer Qty </th>\n");
      out.write("\t\t\t\t<th colspan=\"3\" class=\"hidePrint\"> After Tran. Dest. Qty </th>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<th class=\"hidePrint\">Box</th><th class=\"hidePrint\">Loose</th><th class=\"hidePrint\">Total</th>\n");
      out.write("\t\t\t\t<th>Box</th><th>Loose</th><th>Total</th>\n");
      out.write("\t\t\t\t<th class=\"hidePrint\">Box</th><th class=\"hidePrint\">Loose</th><th class=\"hidePrint\">Total</th>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t</thead>\n");
      out.write("\t\t\t<tbody>\n");
      out.write("\t\t\t");
 
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
			 
      out.write("\n");
      out.write("\t\t\t </tbody>\n");
      out.write("\t\t\t</table>\n");
      out.write("\t\t\t<br/>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<br/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Print\" style=\"width:100\" onclick=\"printPage('content');\"/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Back Page\" style=\"width:100\" onclick=\"back();\"/>\n");
      out.write("\t\t\t<input type=\"button\" value=\"Home Page\" style=\"width:100\" onclick=\"home();\"/>\n");
      out.write("\t\t\t</center>\n");
      out.write("\t    \t\t\n");

	objMI.closeAll();
		}else{

      out.write("\n");
      out.write("\t<h3><b><br><br><br><center> Error</center></b></h3>\n");
      out.write("\t<input type=\"button\" value=\"Back Page\" style=\"width:100\" onclick=\"back();\"/>\n");
      out.write("\t<input type=\"button\" value=\"Home Page\" style=\"width:100\" onclick=\"home();\"/>\n");
      out.write("  ");

	}

      out.write("\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("function printPage(id){\n");
      out.write("\tvar html=\"<html> <style> .hidePrint{display:none;}</style>\";\n");
      out.write("    html+= document.getElementById(id).innerHTML;\n");
      out.write("\n");
      out.write("   var printWin = window.open('','','left=3,top=4,width=700,height=600,toolbar=0,scrollbars=2,status  =0');\n");
      out.write("   printWin.document.write(html);\n");
      out.write("   printWin.document.close();\n");
      out.write("   printWin.focus();\n");
      out.write("   printWin.print();\n");
      out.write("   printWin.close();\n");
      out.write("   window.location=\"TransferInventoryForm.jsp\";\n");
      out.write("   }\n");
      out.write("function back(){\n");
      out.write("\twindow.location=\"TransferInventoryForm.jsp\";\n");
      out.write("\t}\n");
      out.write("function home(){\n");
      out.write("\twindow.location=\"HomeForm.jsp\";\n");
      out.write("\t}\n");
      out.write("</script>");
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
