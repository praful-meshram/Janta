/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-07 09:28:59 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import inventory.ManageInventory;

public final class ReceiveInventoryAjaxResponse_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');
      out.write('\n');

	String ajaxCallOption = request.getParameter("ajaxCallOption");	
    //System.out.println("ajaxCallOption value in:"+ajaxCallOption);
	 if(ajaxCallOption.equals("getSite")){
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		objMV.getSite();
		String siteName="";
		Integer siteId=0;

      out.write("\n");
      out.write("\t\t<select name=\"siteId\" id=\"siteId1\" onchange=\"getData('getSiteAddress')\";  style=\"width:150px;\" tabindex=\"1\">\n");
      out.write("\t\t<option value=\"\">Select</option>\n");

		while(objMV.rs.next()){
			siteId = objMV.rs.getInt(1);
			siteName = objMV.rs.getString(2);				

      out.write("\n");
      out.write("\t\t\t<option value=\"");
      out.print(siteId);
      out.write('"');
      out.write('>');
      out.print(siteName);
      out.write("</option>\t\n");
      out.write("\t\n");
 
		}
		objMV.closeAll();

      out.write("\n");
      out.write("\t\t</select>\n");

	}else if(ajaxCallOption.equals("getSiteAddress")){
		try{
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		Integer siteId = Integer.parseInt(request.getParameter("siteId"));	
		objMV.getSiteAddress(siteId);
		String siteAddress = "";
		if(objMV.rs.next()){
			
			siteAddress = objMV.rs.getString(1);				

      out.write("\n");
      out.write("\t\t\t");
      out.print(siteAddress);
      out.write("\t\n");
      out.write("\t\n");
 
		}
		objMV.closeAll();
		}catch(Exception e){}
	}
	else if(ajaxCallOption.equals("getDes")){
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				objMV.getSite();
				String siteName="";
				Integer siteId=0;
		
      out.write("\n");
      out.write("\t\t\t\t<select name=\"desId\" id=\"desId1\" onchange=\"getData('getDesAddress')\";   style=\"width:150px;\" tabindex=\"2\">\n");
      out.write("\t\t\t\t<option value=\"\">Select</option>\n");
      out.write("\t\t");

				while(objMV.rs.next()){
					siteId = objMV.rs.getInt(1);
					siteName = objMV.rs.getString(2);				
		
      out.write("\n");
      out.write("\t\t\t\t\t<option value=\"");
      out.print(siteId);
      out.write('"');
      out.write('>');
      out.print(siteName);
      out.write("</option>\t\n");
      out.write("\t\t\t\n");
      out.write("\t\t");
 
				}
				objMV.closeAll();
		
      out.write("\n");
      out.write("\t\t\t\t</select>\n");
      out.write("\t\t");

			}else if(ajaxCallOption.equals("getDesAddress")){
				try{
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				Integer siteId = Integer.parseInt(request.getParameter("siteId"));
				objMV.getSiteAddress(siteId);
				String siteAddress = "";
				if(objMV.rs.next()){
					
					siteAddress = objMV.rs.getString(1);				
		
      out.write("\n");
      out.write("\t\t\t\t\t");
      out.print(siteAddress);
      out.write("\t\n");
      out.write("\t\t\t\n");
      out.write("\t\t");
 
				}
				objMV.closeAll();
			}catch(Exception e){}
	}else if(ajaxCallOption.equals("getTransferNumber")){
		try{
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		String siteId =request.getParameter("siteId");
		String desId=request.getParameter("desId");
		String frDate=request.getParameter("fromDate");
		String toDate=request.getParameter("toDate");
		objMV.getTransferNum(siteId,desId,frDate,toDate);
		Integer trnsId=0;
		

      out.write("\n");
      out.write("\t\t<select name=\"transId\" id='transId1' onchange=\"funSearchTrnsList()\";  style=\"width:150px;\" tabindex=\"3\">\n");
      out.write("\t\t<option value=\"\">Select</option>\n");

		while(objMV.rs.next()){
			trnsId = objMV.rs.getInt(1);

      out.write("\n");
      out.write("\t\t\t<option value=\"");
      out.print(trnsId);
      out.write('"');
      out.write('>');
      out.print(trnsId);
      out.write("</option>\t\n");
      out.write("\t\n");
 
		}
		objMV.closeAll();

      out.write("\n");
      out.write("\t\t</select>\n");

	
		}catch(Exception e){}
		}else if(ajaxCallOption.equals("searchString")){
		ManageInventory  objMIV = new ManageInventory("jdbc/js");
		String trnsNumber = request.getParameter("searchTrnsNumber");
		String siteId = request.getParameter("siteId");
		String desId=request.getParameter("desId");
		objMIV.searchTrnsNum(trnsNumber,siteId,desId);	
		int total_trans_items, trnsferNumber;
		
	

      out.write("\n");
      out.write("\t<table  id=\"searchItemTable\" class=\"genericTbl\"   style=\"font-size: 17px;width:80%;\">\n");
      out.write("\t\t<thead>\n");
      out.write("\t\t<tr style=\"position:relative;top:expression(document.all['searchTrnsNumberListDiv'].scrollTop);\">\n");
      out.write("\t\t\t<th>Transfer Number</th>\n");
      out.write("\t\t\t<th>No. of Items</th>\n");
      out.write("\t\t</tr>\t\n");
      out.write("\t\t</thead>\n");

		while(objMIV.rs.next()){
			
			trnsferNumber= objMIV.rs.getInt(1);
			total_trans_items = objMIV.rs.getInt(2);
			

      out.write("\t\t\t\n");
      out.write("\t\t\t<tr onclick=\"fundisplayTable('");
      out.print(trnsferNumber);
      out.write("')\"; style=\"cursor: pointer;\" >\n");
      out.write("\t\t\t<td><input type=\"text\" name=\"searchItrnsnum\" value=\"");
      out.print(trnsferNumber);
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write("\t\t \t<td><input type=\"text\" name=\"searchICode\" value=\"");
      out.print(total_trans_items );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write("\t\t \t</tr>\n");
      out.write("\n");
	}
objMIV.closeAll();

      out.write("\n");
      out.write("</table>\n");
      out.write("\n");

	}
	else if(ajaxCallOption.equals("popupTable")){
		try{
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		int desId=Integer.parseInt(request.getParameter("desId"));
		
		ManageInventory  objMIVB = new ManageInventory("jdbc/js");
		int trnsNumber =Integer.parseInt(request.getParameter("searchTrnsNumber"));
		objMIVB.getTrnsList(trnsNumber,siteId,desId);	

      out.write("\n");
      out.write("<table  id=\"displayItemTable\" align=\"center\" class=\"genericTbl\" style=\"font-size:17px;width:100%;\">\n");
      out.write("\t<thead>\n");
      out.write("\t<tr>\n");
      out.write("\t\t<th>Barcode</th>\n");
      out.write("\t\t<th>Item Code</th>\n");
      out.write("\t\t<th>Item Name</th>\n");
      out.write("\t\t<th>Weight</th>\n");
      out.write("\t\t<th>JS Price</th>\n");
      out.write("\t\t<th>MRP</th>\n");
      out.write("\t\t<th>Source Qty</th>\n");
      out.write("\t\t<th>Des Qty.</th>\n");
      out.write("\t\t<th>Transfer Qty.</th>\n");
      out.write("\t\t<th>Accept Qty.</th>\n");
      out.write("\t\t<th>Status.</th>\n");
      out.write("\t<!-- \t<th>Remaining Qty.</th>\n");
      out.write("\t\t<th>Aftr trans. Qty.</th> -->\n");
      out.write("\t\t<th>Remark</th>\n");
      out.write("\t\t\n");
      out.write("\t</tr>\t\n");
      out.write("\t</thead>\n");
      out.write("\n");
int statusID=0;
while( objMIVB.rs.next()){
	String barcode=objMIVB.rs.getString("barcode");
   	String item_code=objMIVB.rs.getString("item_code");
	String item_name=objMIVB.rs.getString("item_name");
	String item_weight=objMIVB.rs.getString("item_weight");
	int priceversion=objMIVB.rs.getInt("price_version");
	System.out.println("priceversion"+priceversion);
	double item_mrp, item_rate ;
	item_rate =objMIVB.rs.getDouble("item_rate");
	item_mrp=objMIVB.rs.getDouble("item_mrp");
	
	int source_qty=objMIVB.rs.getInt(10);
	int des_qty=objMIVB.rs.getInt(11);
	int transfer_qty=objMIVB.rs.getInt("transfer_qty");
	int remainingQty=source_qty - transfer_qty;
	int aftrtransferQty=des_qty + transfer_qty;
	
	objMIVB.getitemstatus();

      out.write("\n");
      out.write("    <tr>\n");
      out.write("\t<td><input type=\"text\" name=\"Ibarcode\" value=\"");
      out.print(barcode);
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t<td><input type=\"text\" name=\"IitemCode\" value=\"");
      out.print(item_code );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t<td><input type=\"text\" name=\"Iitemname\" value=\"");
      out.print(item_name );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t<td><input type=\"text\" name=\"Iitemweight\" value=\"");
      out.print(item_weight );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t\n");
      out.write(" \t<td><input type=\"text\" name=\"Iitem_rate\" value=\"");
      out.print(item_rate );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t<td><input type=\"text\" name=\"Iitem_mrp\" value=\"");
      out.print(item_mrp );
      out.write("\" size=\"7\" class=\"hideTextField\" readonly=\"readonly\"/></td>\n");
      out.write(" \t\n");
      out.write(" \t<td><input type=\"text\" name=\"Isource_qty\" value=\"");
      out.print(source_qty);
      out.write("\" size=\"4\" class=\"hideTextField\" readonly=\"readonly\" onblur=\"setQtyValues()\";/></td>\n");
      out.write(" \t<td><input type=\"text\" name=\"Ides_qty\" value=\"");
      out.print(des_qty);
      out.write("\" size=\"4\" class=\"hideTextField\" readonly=\"readonly\" onblur=\"setQtyValues()\";/></td>\n");
      out.write(" \t\n");
      out.write(" \t<td><input type=\"text\"  name=\"Itransfer_qty\" value=\"");
      out.print(transfer_qty);
      out.write("\" size=\"4\" class=\"hideTextField\" readonly=\"readonly\"  /></td>\n");
      out.write(" \t<td><input type=\"text\"  name=\"Iaccept_qty\" value=\"");
      out.print(transfer_qty);
      out.write("\" size=\"4\" class=\"hideTextField\" onchange=\"validate(this,'");
      out.print(statusID );
      out.write("');\" readonly=\"readonly\"/></td>\n");
      out.write(" \t<td style=\"display: none\"><input type=\"hidden\" name=\"transfernum\" value=\"");
      out.print(trnsNumber);
      out.write("\" class=\"hideTextField\"/></td>\n");
      out.write(" \t<td style=\"display: none\"><input type=\"hidden\" name=\"priceversion\" value=\"");
      out.print(priceversion);
      out.write("\" class=\"hideTextField\"/></td>\n");
      out.write(" \t<td>\n");
      out.write(" \t<select  id=\"itemStatus");
      out.print(statusID);
      out.write("\" name=\"IStatus\"  onchange=\"statusOptions(this);\" >\n");
      out.write("\t\t\n");
 

		while(objMIVB.rs1.next()){
		
			String  itemStatus = objMIVB.rs1.getString(1);
			
			
      out.write("\n");
      out.write("\t\t\t<option value=\"");
      out.print(itemStatus);
      out.write('"');
      out.write('>');
      out.print(itemStatus);
      out.write("</option>\t\n");
      out.write("\t\n");
 
		}
	
	
	
      out.write("\t</select>\n");
      out.write("\t\t</td>\n");
      out.write("\t\n");
      out.write("\n");
      out.write("\t<td><input type=\"text\" name=\"Remark\" id=\"Remark1\" size=\"15\"/></td>\n");
      out.write("\t\n");
      out.write("\t</tr>\n");
      out.write("\t");
statusID++; }
      out.write('\n');
	
objMIVB.closeAll();
		}catch(Exception e){}
		}
      out.write("\n");
      out.write("\t </table>\n");
      out.write("\t");
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