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

public final class AcceptInventoryForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=AcceptInventoryForm.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("AcceptInventoryForm.jsp", request.getCharacterEncoding()), out, false);
      out.write("\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write(" \n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<title>Retail Management-Janta Stores</title>\n");
      out.write("<script type=\"text/javascript\" src=\"js/AcceptInventory.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/popup.js\"></script>\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/border_radius.css\" />\n");
      out.write("</head>\n");
      out.write("<body class=\"bodyClass\" onmousemove=\"capmouse();\">\n");
      out.write("\t<br/>\n");
      out.write("\t<br/>\n");
      out.write("\t\n");
      out.write("\t<center><h4>Accept Inventory</h4></center>\n");
      out.write("\t<form name=\"myform\" method=\"post\">\n");
      out.write("\t\t<table align=\"center\" style=\"width: 100%\">\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<td style=\"width: 5%\">&nbsp;</td>\n");
      out.write("\t\t\t\t<td style=\"width: 90%\">\n");
      out.write("\t\t\t\t\t<div class=\"roundedDiv\"\n");
      out.write("\t\t\t\t\t\tstyle=\"background-color: #BEF781; border: 1; width: 100%;\">\n");
      out.write("\t\t\t\t\t\t<table class=\"custorderinfo\" style=\"width: 80%\">\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<th style=\"width:10%;\">Vendor Name</th>\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"left\" style=\"width:20%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"vendorNameDiv\" style=\"width: 100%;\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td>&nbsp;</td>\n");
      out.write("\t\t\t\t\t\t\t\t<th style=\"width:10%;\">Site Name</th>\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"left\" style=\"width:20%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"siteNameDiv\" style=\"width: 100%;\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td>&nbsp;</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td><b>with Bill Number?</b> &nbsp;<input type=\"checkbox\"\n");
      out.write("\t\t\t\t\t\t\t\t\tname=\"chckBillNumber\" onclick=\"funDisplayDiv()\" /></td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<th>Vendor Address</th>\n");
      out.write("\t\t\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"vendorAddress\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td>&nbsp;</td>\n");
      out.write("\t\t\t\t\t\t\t\t<th>Site Address</th>\n");
      out.write("\t\t\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"siteAddress\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td>&nbsp;</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=\"2\"><div id=\"displayBillDiv\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\tstyle=\"visibility: hidden;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<b>Bill Number :</b> <input type=\"text\" name=\"billNumber\" />\n");
      out.write("\t\t\t\t\t\t\t\t\t</div></td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t</td>\n");
      out.write("\t\t\t\t<td style=\"width: 10%\">&nbsp;</td>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<td style=\"width: 5%\">&nbsp;</td>\n");
      out.write("\t\t\t\t<td style=\"width: 80%\">\n");
      out.write("\t\t\t\t\t<div class=\"roundedDiv\"\n");
      out.write("\t\t\t\t\t\tstyle=\"background-color: #BEF781; border: 1; width: 100%;\">\n");
      out.write("\t\t\t\t\t\t<table class=\"custorderinfo\">\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 27%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<table class=\"custorderinfo\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<th>Enter Bar Code</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td colspan=\"3\"><input type=\"text\" name=\"searchBarCode\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tsize=\"22\" onchange=\"funHandleSearchString('barcode');\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<th>Enter Item Name</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td colspan=\"3\"><input type=\"text\" name=\"itemName\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tsize=\"22\" onchange=\"funHandleSearchString('itemName');\" tabindex=\"3\"/></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td colspan=\"2\" align=\"right\"><input accesskey=\"s\" type=\"button\" value=\"Search<Alt+s>\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tclass=\"menulired\" onclick=\"funSearchItem();\"/>&nbsp;\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<input accesskey=\"c\" type=\"button\" value=\"Clear<Alt+c>\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tclass=\"menulired\" onclick=\"funClearBarcodeItemName();\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 1%;\"></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 72%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"searchItemListDiv\" style=\"height: 150px; border: 1\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t</td>\n");
      out.write("\t\t\t\t<td style=\"width: 10%\">&nbsp;</td>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<td style=\"width: 5%\">&nbsp;</td>\n");
      out.write("\t\t\t\t<td style=\"width: 80%\">\n");
      out.write("\t\t\t\t\t<div class=\"roundedDiv\"\n");
      out.write("\t\t\t\t\t\tstyle=\"background-color: #BEF781; border: 1; width: 100%;\">\n");
      out.write("\t\t\t\t\t\t<table class=\"custorderinfo\">\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 17%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<table class=\"custorderinfo\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td>Total Items : <input type=\"text\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tname=\"grandTotalQty\" value=\"0\" class=\"hideTextFieldGreen\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\treadonly=\"readonly\" />\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td>Total MRP : <input type=\"text\" name=\"grandTotalMrp\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvalue=\"0\" class=\"hideTextFieldGreen\" readonly=\"readonly\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td><input type=\"button\" accesskey=\"p\" value=\"Save & Print<Alt+p>\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tclass=\"menulired\" onclick=\"funSaveOrder();\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td><input type=\"button\" accesskey=\"r\" value=\"     Refresh<Alt+r>   \" class=\"menulired\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tonclick=\"window.location.reload()\" />\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td><input type=\"button\" accesskey=\"h\" value=\"      Home<Alt+h>     \"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tclass=\"menulired\" onclick=\"funCancelOrder();\" /></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<td></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 1%;\"></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td style=\"width: 82%;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<div id=\"selectedItemsDiv\" style=\"position:relative;height: 200px; border: 1px solid green;\">\t\t\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<div id=\"inner1\" style=\"height:198px;width:100%; overflow-y:scroll;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<table class=\"genericTbl\" style=\"font-size: 150%;width:100%;margin-right: -17px;\" id=\"selectedItemsTable\" border=\"1\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<thead bgcolor=\"#BEF781\" style=\"height:20px;\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th rowspan=\"2\">Item Name</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th rowspan=\"2\">Weight</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th rowspan=\"2\">MRP</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th colspan=\"3\">Old Quantity</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th colspan=\"3\">New Quantity</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th colspan=\"3\">Total Quantity</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<th rowspan=\"2\">Delete</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Box</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Loose</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Total</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Box</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Loose</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Total</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Box</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Loose</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t<td>Total</td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t</thead>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<tbody>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t</tbody>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<div id=\"secondWrapper1\" style=\"position:absolute;background-color: #BEF781; left:0; top:0; height:48px; overflow:hidden;\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t</td>\n");
      out.write("\t\t\t\t<td style=\"width: 10%\">&nbsp;</td>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t</table>\n");
      out.write("\t\t<input type=\"hidden\" name=\"ajaxCallOption\">\n");
      out.write("\t\t<div id=\"baseDiv\" style=\"top: 0px;\" align=\"center\"></div>\n");
      out.write("\t\t<div id=\"popupItemDiv\"\n");
      out.write("\t\t\tstyle=\"x-height: 140px; x-width: 850px; border: 2px solid black; background-color: #BEF781; padding: 25px; display: none; font-size: 100%; text-align: center;\">\n");
      out.write("\t\t</div>\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t<script type=\"text/javascript\">\n");
      out.write("\t\t\twindow.onload = funOnload;\n");
      out.write("\t\t\tfunction funOnload() {\n");
      out.write("\t\t\t //alert('load');\n");
      out.write("\t\t\t\tgetData(\"getVendor\");\n");
      out.write("\t\t\t}\n");
      out.write("\t\t</script>\n");
      out.write("\t</form>\n");
      out.write("\t<div id=\"popupMouseOver\" class=\"popupMouseOver\">\n");
      out.write("\t\t\t<div id=\"close\" onclick=\"closePopup();\"><b>x</b></div>\n");
      out.write("\t\t\t<div id=\"right\">\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div id=\"inner_div\" style=\"width:150px;padding:2px;\"></div>\n");
      out.write("\t\t</div>\n");
      out.write("</body>\n");
      out.write("</html>");
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