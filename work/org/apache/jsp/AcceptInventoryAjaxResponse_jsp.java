/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-07 09:17:07 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.bouncycastle.jce.provider.JDKKeyFactory.RSA;
import java.sql.ResultSet;
import inventory.ManageInventory;

public final class AcceptInventoryAjaxResponse_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	String ajaxCallOption = request.getParameter("ajaxCallOption");
	int box_site_qty, loose_site_qty, box_tot_qty, loose_tot_qty, box_item_qty, loose_item_qty;

	//System.out.println("ajaxCallOption value in:"+ajaxCallOption);
	if (ajaxCallOption.equals("getVendor")) {
		inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
		objMV.getVendor();
		String vendorName = "";
		Integer vendorId = 0;

      out.write("\n");
      out.write("<select name=\"vendorId\" onchange=\"getData('getVendorAddress');\"\n");
      out.write("\tstyle=\"width: 100%;\" tabindex=\"1\">\n");
      out.write("\t<option value=\"\">Select</option> \n");
      out.write("\t");

		while (objMV.rs.next()) {
				vendorId = objMV.rs.getInt(1);
				vendorName = objMV.rs.getString(2);
	
      out.write("\n");
      out.write("\t<option value=\"");
      out.print(vendorId);
      out.write('"');
      out.write('>');
      out.print(vendorName);
      out.write("</option>\n");
      out.write("\n");
      out.write("\t");

		}
			objMV.closeAll();
	
      out.write("\n");
      out.write("</select>\n");

	} else if (ajaxCallOption.equals("getVendorAddress")) {
		inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
		Integer vendorId = Integer.parseInt(request.getParameter("vendorId"));
		objMV.getVendorAddress(vendorId);
		String vendorAddress = "";
		if (objMV.rs.next()) {
			vendorAddress = objMV.rs.getString(1);

      out.write('\n');
      out.print(vendorAddress);
      out.write('\n');
      out.write('\n');

	}
		objMV.closeAll();
	} else if (ajaxCallOption.equals("getSite")) {
		//inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/re");
		objMV.getSite();
		String siteName = "";
		Integer siteId = 0;

      out.write("\n");
      out.write("<select name=\"siteId\" onchange=\"getData('getSiteAddress');\"\n");
      out.write("\tstyle=\"width: 100%;px;\" tabindex=\"2\">\n");
      out.write("\t<option value=\"\">Select</option>\n");
      out.write("\t");

		while (objMV.rs.next()) {
				siteId = objMV.rs.getInt(1);
				siteName = objMV.rs.getString(2);
	
      out.write("\n");
      out.write("\t<option value=\"");
      out.print(siteId);
      out.write('"');
      out.write('>');
      out.print(siteName);
      out.write("</option>\n");
      out.write("\n");
      out.write("\t");

		}
			objMV.closeAll();
	
      out.write("\n");
      out.write("</select>\n");

	} else if (ajaxCallOption.equals("getSiteAddress")) {
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		Integer siteId = Integer.parseInt(request.getParameter("siteId"));
		objMV.getSiteAddress(siteId);
		String siteAddress = "";
		if (objMV.rs.next()) {
			siteAddress = objMV.rs.getString(1);

      out.write('\n');
      out.print(siteAddress);
      out.write('\n');
      out.write('\n');

	}
		objMV.closeAll();
	} else if (ajaxCallOption.equals("searchString")) {
		ManageInventory objMI = new ManageInventory("jdbc/js");
		String barcode = "", itemName = "";
		barcode = request.getParameter("searchBarCode");
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		objMI.searchItem(barcode, itemName);
		String item_code, item_weight, item_name, title,bachka;
		int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
		double item_mrp, item_rate;

      out.write("\n");
      out.write("<div id=\"outer\" style=\"position: relative;width: 100%;border:1px solid black;\" >\n");
      out.write("\t<div id=\"inner\" style=\"height:150px;width:100%; overflow-y:scroll;\">\n");
      out.write("\t<table id=\"searchItemTable1\" class=\"genericTbl1\" style=\" font-size: 170%; width: 100%;margin-right: -17px; border-collapse: collapse;\" border=\"1\" cellpadding=0 cellspacing=0>\n");
      out.write("\t<thead>\n");
      out.write("\t<tr style=\"height: 20px;\" >\n");
      out.write("\t\t<th rowspan=\"2\">Item Name</th>\n");
      out.write("\t\t<th rowspan=\"2\">Weight</th>\n");
      out.write("\t\t<th rowspan=\"2\">MRP</th>\n");
      out.write("\t\t<th colspan=\"3\">Site Inventory</th>\n");
      out.write("\t\t<th colspan=\"3\" style=\"width: 100px;\">Total Inventory</th>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t\t<th>Box</th>\n");
      out.write("\t\t<th>Loose</th>\n");
      out.write("\t\t<th>Total</th>\n");
      out.write("\t\t<th>Box</th>\n");
      out.write("\t\t<th>Loose</th>\n");
      out.write("\t\t<th>Total</th>\n");
      out.write("\t</tr>\n");
      out.write("</thead>\n");
      out.write("\t\t");

			while (objMI.rs.next()) {
					barcode = objMI.rs.getString(1);
					item_code = objMI.rs.getString(2);
					//System.out.println("item_code "+item_code);
					item_weight = objMI.rs.getString(3);
					item_name = objMI.rs.getString(4);
					price_version = objMI.rs.getInt(6);
					item_mrp = objMI.rs.getDouble(7);
					item_rate = objMI.rs.getDouble(8);
					item_pv_qty = objMI.rs.getInt(9);
					item_box_qty = objMI.rs.getInt(10);
					//System.out.println("======\n\n\nitem obx quantity "+item_box_qty+" item code "+item_code+"\n item rate "+ item_rate);
					if(objMI.rs.getString(11).equals("true")){
						bachka="  (Bachka)";
					} else {
						bachka="";
					}
					site_qty = objMI.getSiteQuantity(item_code, siteId,
							price_version);
					item_qty=objMI.getTotalSiteQuantity(item_code,price_version);
					
					// if item_box_qty not 1 then it must give divide by 0 error
					if (item_box_qty != 1) {
						
						System.out.println(item_box_qty+ " if item box quantity "+item_qty);
						box_site_qty = (int) site_qty / item_box_qty;
						loose_site_qty = site_qty % item_box_qty;
						box_item_qty = (int) item_qty / item_box_qty;
						loose_item_qty = item_qty % item_box_qty;
					} else {
						box_site_qty = site_qty;
						loose_site_qty = 0;
						box_item_qty = item_qty;
						loose_item_qty = 0;
					}
		
      out.write("\n");
      out.write("\t\t<tr\n");
      out.write("\t\t\tonclick=\"Javascript:funShowPopup('");
      out.print(barcode);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_code);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_weight);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_name);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(site_qty);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_box_qty);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(price_version );
      out.write("');\"\n");
      out.write("\t\t\tstyle=\"cursor: pointer\">\n");
      out.write("\t\t\t<td style=\"display: none\"><input type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchIBarcode\" value=\"");
      out.print(barcode);
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td style=\"display: none\"><input style=\"cursor: pointer\"\n");
      out.write("\t\t\t\ttype=\"text\" name=\"searchICode\" value=\"");
      out.print(item_code);
      out.write("\" size=\"50\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t \n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(item_name);
      out.write("\" size=\"90\" title=\"");
      out.print(item_name);
      out.write("\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(item_weight);
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td style=\"display: none\"><input type=\"text\" name=\"searchICode\"\n");
      out.write("\t\t\t\tvalue=\"");
      out.print(item_rate);
      out.write("\" size=\"7\" class=\"hideTextField\"\n");
      out.write("\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(item_mrp);
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t");

				if (item_box_qty > 1) {
			
      out.write("\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(box_site_qty);
      out.write("\" size=\"2\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" />(");
      out.print(item_box_qty);
      out.write(")</td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(loose_site_qty);
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print((box_site_qty*item_box_qty+loose_site_qty));
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(box_item_qty);
      out.write("\" size=\"2\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" />(");
      out.print(item_box_qty);
      out.write(")</td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print(loose_item_qty);
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\"><input id=\"change\" style=\"cursor: pointer;\" type=\"text\"\n");
      out.write("\t\t\t\tname=\"searchICode\" value=\"");
      out.print((box_item_qty*item_box_qty+loose_item_qty));
      out.write("\" size=\"7\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" id='showPopUpCell'\n");
      out.write("\t\t\t\tonmouseover=\"Javascript:showMousePopup('");
      out.print( item_code);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( price_version);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( item_name );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_mrp );
      out.write("');\"\n");
      out.write("\t\t\t\tonmouseout=\"closePopup();\" /></td>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t");

				} else if (item_box_qty == 1) {
			
      out.write("\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\" colspan=\"3\"><input style=\"cursor: pointer;\"\n");
      out.write("\t\t\t\ttype=\"text\" name=\"searchICode\" value=\"");
      out.print(box_site_qty);
      out.write("\" size=\"2\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" />");
      out.print(bachka );
      out.write("</td>\n");
      out.write("\t\t\t<td style=\"display: none;\"><input\n");
      out.write("\t\t\t\tstyle=\"cursor: pointer;\" type=\"text\" name=\"searchICode\"\n");
      out.write("\t\t\t\tvalue=\"");
      out.print(loose_site_qty);
      out.write("\" size=\"7\" class=\"hideTextField\"\n");
      out.write("\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t<td bgcolor=\"#EFFBEF\" colspan=\"3\"><input id=\"change\" style=\"cursor: pointer;\"\n");
      out.write("\t\t\t\ttype=\"text\" name=\"searchICode\" value=\"");
      out.print(box_item_qty);
      out.write("\" size=\"2\"\n");
      out.write("\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" \n");
      out.write("\t\t\t\tonmouseover=\"Javascript:showMousePopup('");
      out.print( item_code);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( price_version);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( item_name );
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_mrp );
      out.write("');\"\n");
      out.write("\t\t\t\tonmouseout=\"closePopup();\"/></td>\n");
      out.write("\t\t\t<td style=\"display: none;\"><input\n");
      out.write("\t\t\t\tstyle=\"cursor: pointer;\" type=\"text\" name=\"searchICode\"\n");
      out.write("\t\t\t\tvalue=\"");
      out.print(loose_item_qty);
      out.write("\" size=\"7\" class=\"hideTextField\"\n");
      out.write("\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t");

				}
			
      out.write("\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t");

			}
			objMI.closeAll();
		
      out.write("\n");
      out.write("\t</table>\n");
      out.write("</div>\n");
      out.write("<div id=\"secondWrapper\" style=\"position:absolute;background-color: #BEF781; left:0; top:0; height:45px; overflow:hidden;\"></div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");

	} else if (ajaxCallOption.equals("popupTable")) {
		String barcode = request.getParameter("barcode");
		String item_code = request.getParameter("item_code");
		String item_weight = request.getParameter("item_weight");
		String item_name = request.getParameter("item_name");
		/* System.out.print("============\n Accept inventory item name "+ item_name+"  \n==========");
		System.out.print("============\n Accept inventory item name "+ barcode+"  \n=========="); */
		
		System.out.print("\nOP : "+request.getParameter("price_version")+"\n");
		int price_version = Integer.parseInt(request
				.getParameter("price_version"));
		int item_box_qty = Integer.parseInt(request
				.getParameter("box_qty"));
		System.out.println("\n" + item_box_qty + "\n");
		int item_qty = Integer.parseInt(request
				.getParameter("item_qty"));
		int popup_box_item_qty = (int) item_qty / item_box_qty;
		int popup_loose_item_qty = item_qty % item_box_qty;
		ManageInventory objMI = new ManageInventory("jdbc/js");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		objMI.getMrpValues(item_code, siteId);
		
		

      out.write("\n");
      out.write("<table>\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td>\n");
      out.write("\t\t\t<table id=\"popupItemTable\" class=\"genericTbl\" style=\"font-size: 70%; border-collapse: collapse;\" cellpadding=0 cellspacing=0>\n");
      out.write("\t\t\t\t");

					if (item_box_qty != 1) {
				
      out.write("\n");
      out.write("\t\t\t\t<tr bgcolor=\"LightBlue\">\n");
      out.write("\t\t\t\t\t<!--<th>Bar code</th>\n");
      out.write("\t\t\t\t\t\t\t\t<th>Item Code</th>-->\n");
      out.write("\t\t\t\t\t<th rowspan=\"2\" style=\"width: 150px;\">Item Name</th>\n");
      out.write("\t\t\t\t\t<th rowspan=\"2\" style=\"width: 50px;\">Weight</th>\n");
      out.write("\t\t\t\t\t<!--<th>JS Price </th>-->\n");
      out.write("\t\t\t\t\t<th rowspan=\"2\" style=\"width: 50px;\">MRP</th>\n");
      out.write("\t\t\t\t\t<th colspan=\"3\" style=\"width: 100px;\">Old Quantity</th>\n");
      out.write("\t\t\t\t\t<th colspan=\"3\" style=\"width: 100px;\">New Quantity</th>\n");
      out.write("\t\t\t\t\t<th colspan=\"3\" style=\"width: 100px;\">Total Quantity</th>\n");
      out.write("\t\t\t\t\t<!-- <th>Total MRP</th>\t-->\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Box</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Loose</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Total</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Box</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Loose</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Total</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Box</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Loose</td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 50px; background-color: #BEF781;\">Total</td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t");

					} else {
				
      out.write("\n");
      out.write("\t\t\t\t<tr bgcolor=\"LightBlue\">\n");
      out.write("\t\t\t\t\t<th style=\"width: 150px;\">Item Name</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 50px;\">Weight</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 50px;\">MRP</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 100px;\">Old Quantity</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 100px;\">New Quantity</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 100px;\">Total Quantity</th>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t");

					}
				
      out.write("\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupBarcode\" value=\"");
      out.print(barcode);
      out.write("\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupItemCode\" value=\"");
      out.print(item_code);
      out.write("\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupItemName\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(item_name);
      out.write("\" size=\"50\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t\t");
 System.out.print("============\n Accept inventory item name "+ item_name+"  \n=========="); 
      out.write("\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupItemWeight\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(item_weight);
      out.write("\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><select name=\"popupSelRate\"\n");
      out.write("\t\t\t\t\t\tonchange=\"setMrpRateValues('RATE');\" >\n");
      out.write("\t\t\t\t\t\t\t");

								double itemMrp;
									int priceVersion=0, cnt = 0;
									double itemRate;
									int priceVersion1;

									while (objMI.rs.next()) {
										itemRate = objMI.rs.getDouble(2);
										System.out.println(objMI.rs.getString(1)+" accept ajax "+ itemRate);
										priceVersion1 = objMI.rs.getInt(3);
										if (cnt == 0) {
											cnt = priceVersion1;
											cnt++;
										}
										if(priceVersion1==price_version){
											
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(priceVersion1);
      out.write("\" selected=\"selected\">");
      out.print(itemRate);
      out.write("</option>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

										}
										else{
							
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(priceVersion1);
      out.write('"');
      out.write('>');
      out.print(itemRate);
      out.write("</option>\n");
      out.write("\t\t\t\t\t\t\t");

										}
								}
									
							
      out.write("\n");
      out.write("\t\t\t\t\t\t\t<option value=\"");
      out.print(cnt);
      out.write("\">New</option>\n");
      out.write("\t\t\t\t\t</select> <input type=\"text\" name=\"popupRate\" value=\"0\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tstyle=\"display: none;\" tabindex=\"6\"\n");
      out.write("\t\t\t\t\t\tonkeydown=\"javascript:this.value=this.value.replace(/[^0-9.]/g, '');\"\n");
      out.write("\t\t\t\t\t\tonkeyup=\"javascript:this.value=this.value.replace(/[^0-9.]/g, '');setQtyValues();\"\n");
      out.write("\t\t\t\t\t\tautocomplete=\"off\" /></td>\n");
      out.write("\t\t\t\t\t<td><select name=\"popupSelMrp\"\n");
      out.write("\t\t\t\t\t\tonchange=\"setMrpRateValues('MRP');\">\n");
      out.write("\t\t\t\t\t\t\t");

								System.out.print(" result set "+objMI.rs);
								objMI.rs.beforeFirst();
								 	while (objMI.rs.next()) {
											itemMrp = objMI.rs.getDouble(1);
											priceVersion = objMI.rs.getInt(3);
											
										if(price_version==priceVersion){
										
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(priceVersion);
      out.write("\" selected=\"selected\">");
      out.print(itemMrp);
      out.write("</option>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");

										}else{
											
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<option value=\"");
      out.print(priceVersion);
      out.write('"');
      out.write('>');
      out.print(itemMrp);
      out.write("</option>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");

										}
									
								 	}
								 	
	
								
							
      out.write("\n");
      out.write("\t\t\t\t\t\t\t<option value=\"");
      out.print( priceVersion+1 );
      out.write("\">New</option>\n");
      out.write("\t\t\t\t\t</select> <input type=\"text\" name=\"popupMrp\" value=\"0\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tstyle=\"display: none;\"\n");
      out.write("\t\t\t\t\t\tonkeydown=\"javascript:this.value=this.value.replace(/[^0-9.]/g, '');\"\n");
      out.write("\t\t\t\t\t\tonkeyup=\"javascript:this.value=this.value.replace(/[^0-9.]/g, '');setQtyValues();setMrpAndRate();\"\n");
      out.write("\t\t\t\t\t\tautocomplete=\"off\" /></td>\n");
      out.write("\t\t\t\t\t");

						if (item_box_qty != 1) {
					
      out.write("\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupOldQty_box\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_box_item_qty);
      out.write("\" size=\"3\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /> (");
      out.print(item_box_qty);
      out.write(")</td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupOldQty\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_loose_item_qty);
      out.write("\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupOld_total\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print((popup_box_item_qty*item_box_qty+popup_loose_item_qty));
      out.write("\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupNewQty_box\" value=\"\"\n");
      out.write("\t\t\t\t\t\tsize=\"3\" onkeyup=\"setQtyValues('");
      out.print(item_box_qty);
      out.write("');\" />(");
      out.print(item_box_qty);
      out.write(")</td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupNewQty\" value=\"\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tonkeyup=\"setQtyValues('");
      out.print(item_box_qty);
      out.write("');\" /></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupNew_total\"\n");
      out.write("\t\t\t\t\t\tvalue=\"0\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupTotalQty_box\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_box_item_qty);
      out.write("\" size=\"3\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /> (");
      out.print(item_box_qty);
      out.write(")</td>\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupTotalQty\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_loose_item_qty);
      out.write("\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t\t<td><input type=\"text\" name=\"popupTotal_total\" style=\"color:blue;\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print((popup_box_item_qty*item_box_qty+popup_loose_item_qty));
      out.write("\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t");

						} else if (item_box_qty == 1) {
					
      out.write("\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupOldQty_box\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_box_item_qty);
      out.write("\" size=\"3\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" tabindex=\"7\"/></td>\n");
      out.write("\t\t\t\t\t<td style=\"display: none;\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupOldQty\" value=\"");
      out.print(popup_loose_item_qty);
      out.write("\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" tabindex=\"7\"/></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t");
      out.write("\n");
      out.write("\t\t\t\t \n");
      out.write("\t\t\t\t \t<!-- new quantity onkeyup event deactivated  -->\n");
      out.write("\t\t\t\t \t<td><input type=\"text\" name=\"popupNewQty_box\" value=\"\"\n");
      out.write("\t\t\t\t\t\tsize=\"10\" /></td>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t\t <td style=\"display: none;\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupNewQty\" value=\"\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tonkeyup=\"setQtyValues('");
      out.print(item_box_qty);
      out.write("');\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" name=\"popupTotalQty_box\"\n");
      out.write("\t\t\t\t\t\tvalue=\"");
      out.print(popup_box_item_qty);
      out.write("\" size=\"3\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td style=\"display: none;\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupTotalQty\" value=\"");
      out.print(popup_loose_item_qty);
      out.write("\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t");

						}
					
      out.write("\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupTotalMrp\" value=\"\" size=\"5\" class=\"hideTextField\"\n");
      out.write("\t\t\t\t\t\treadonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t<td style=\"display: none\"><input type=\"text\"\n");
      out.write("\t\t\t\t\t\tname=\"popupBoxQty\" value=\"");
      out.print(item_box_qty);
      out.write("\" size=\"5\"\n");
      out.write("\t\t\t\t\t\tclass=\"hideTextField\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t</table>\n");
      out.write("\n");
      out.write("\t\t</td>\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td colspan=\"1\" align=\"right\"><input type=\"button\" value=\"Accept<Alt+a>\"\n");
      out.write("\t\t\tonclick=\"funAddRow('");
      out.print(item_code);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(price_version);
      out.write("');\" accesskey=\"a\"/> <input type=\"button\" value=\"Close<Alt+x>\"\n");
      out.write("\t\t\tonclick=\"funCloseDiv();\" accesskey=\"x\" /></td>\n");
      out.write("\t</tr>\n");
      out.write("</table>\n");

	objMI.closeAll();
	} else if (ajaxCallOption.equals("getValues")) {
		String item_code = request.getParameter("item_code");
		int price_version = Integer.parseInt(request
				.getParameter("price_version"));
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		ManageInventory objMI = new ManageInventory("jdbc/js");
		int site_qty = objMI.getSiteQuantity(item_code, siteId,
				price_version);
		//objMI.closeAll();

      out.write('\n');
      out.print(site_qty);
      out.write('\n');

	objMI.closeAll();
	} else if (ajaxCallOption.equals("mouse_over_popup")) {
		String item_code = request.getParameter("item_code");
		String item_name = request.getParameter("item_name");
		String item_mrp = request.getParameter("item_mrp");
		int price_version=Integer.parseInt(request.getParameter("price_version"));
		ManageInventory objMI = new ManageInventory("jdbc/js");
		objMI.getQtyPerSide(item_code,price_version);
		out.print("<center>"+item_name+"<br>Price : Rs. "+item_mrp+"<br><hr style=\"width:170px\">");
		out.print("<table style='width: 95%; border-collapse: collapse; ' cellpadding=0 cellspacing=0><tr><th>Site</th><th></th><th>Qty</th></tr>");
		while(objMI.rs.next()){
			out.print("<tr><td>"+objMI.rs.getString(1)+"</td><td>:</td><td>"+objMI.rs.getInt(2)+"</td></tr>");
		}
		out.print("</table>");
		objMI.closeAll();
	}

      out.write('\n');
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
