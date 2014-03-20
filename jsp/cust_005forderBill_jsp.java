package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;

public final class cust_005forderBill_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


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

      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write(" \r\n");
      out.write("\r\n");

	String customerName="";
  	customerName=request.getParameter("name");
  	String telephone="";
  	telephone=request.getParameter("tele");
  	String building="";
  	building=request.getParameter("bldg");
  	String block="";
  	block=request.getParameter("block");
	String wing="";
 	wing=request.getParameter("wing");
	String add1="";
 	add1=request.getParameter("add1");
 	String add2="";
	add2=request.getParameter("add2");
	String custCode="";
	custCode=request.getParameter("cuscode");

      out.write("  \r\n");
      out.write("\t<html>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<script src=\"customerBillOrder.js\"></script>\r\n");
      out.write("\t\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"autosuggest/autosuggest2.js\"></script>\r\n");
      out.write("        <script type=\"text/javascript\" src=\"autosuggest/suggestions2.js\"></script>\r\n");
      out.write("                <script type=\"text/javascript\" src=\"autosuggest/remotesuggestions.js\"></script>\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"autosuggest/autosuggest.css\" />        \r\n");
      out.write("        <script type=\"text/javascript\">\r\n");
      out.write("            window.onload = function () {\r\n");
      out.write("                var oTextbox = new AutoSuggestControl(document.getElementById(\"txt1\"), new RemoteStateSuggestions());        \r\n");
      out.write("            }\r\n");
      out.write("        </script>\t\r\n");
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t</head>\r\n");
      out.write("\t<body>\r\n");
      out.write("\t<form name=\"myform\">\r\n");
      out.write("\t<h3> Order Details:</h3>\r\n");
      out.write("\t<table id=\"1\">\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t<tr><td>\r\n");
      out.write(" \t<b>Customer Code:</b></td><td><b>");
      out.print(custCode);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write("\t<tr><td>\r\n");
      out.write(" \t<b>Customer Name:</b></td><td><b>");
      out.print(customerName);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr><tr><td>\r\n");
      out.write(" \t<b>Phone :</td><td><b>");
      out.print(telephone);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write(" \t<tr><td>\r\n");
      out.write(" \t<b>Address:</b></td><td><b>");
      out.print(add1);
      out.write("</b>&nbsp&nbsp<b>");
      out.print(add2);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write(" \t<tr><td>\r\n");
      out.write(" \t<b>Building:</b></td><td><b>");
      out.print(building);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write(" \t<tr><td>\r\n");
      out.write(" \t<b>Block:</b></td><td><b>");
      out.print(block);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write(" \t<tr><td>\r\n");
      out.write(" \t<b>Wing:</b></td><td><b>");
      out.print(wing);
      out.write("</b><br>\r\n");
      out.write(" \t</td></tr>\r\n");
      out.write(" \t</table>\r\n");
      out.write(" \t<br>   \r\n");
      out.write("\t<table id=\"ItemTable\" border=\"1\">\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<th colspan=\"7\"><center><b>Order Details</b></center></th>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td><b>Item</b></td>\r\n");
      out.write("\t\t<td><b>Rate</b></td>\r\n");
      out.write("\t\t<td><b>Unit</b></td>\r\n");
      out.write("\t\t<td><b>Qty</b></td>\r\n");
      out.write("\t\t<td colspan=\"2\"><b><center>Price</center></b></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td colspan=4>&nbsp;</td>\r\n");
      out.write("\t\t<td><b>Janta's Price</b></td>\r\n");
      out.write("\t\t<td ><b>MRP</b></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td colspan=4> <div id='totalSel'>Total selected items = 0 </div></td>  \r\n");
      out.write("\t\t<td colspan=2> <div id='totalAmt'>Total = 0 </div></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table><br>  \r\n");
      out.write("\t\r\n");
      out.write("\t<input type=\"hidden\" name=\"hidTotal\">\r\n");
      out.write("\t<input type=\"hidden\" name=\"hidMRP\">\r\n");
      out.write("\t<input type=\"hidden\" name=\"hidCount\">\r\n");
      out.write("\t<input type=\"hidden\" name=\"cusCode\" value=\"");
      out.print(custCode);
      out.write("\"> \r\n");
      out.write("\t\r\n");
      out.write("\t<input type=\"button\"  onclick=\"addRow()\" value=\"Add New Row\">\r\n");
      out.write("\t<input type=\"button\" name=\"PrintOnly\" value=\" Print Only  \" \r\n");
      out.write("\tonclick=\"printTable('");
      out.print(custCode);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(customerName);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(building);
      out.write("',\r\n");
      out.write("\t'");
      out.print(block);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(wing);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(add1);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(add2);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(telephone);
      out.write("')\">&nbsp&nbsp&nbsp   \r\n");
      out.write("\t<input type=\"button\" name=\"Print&Save\" value=\" Print & Save \" onclick=\"window.print()\"&&\"save()\">&nbsp&nbsp&nbsp \r\n");
      out.write("\t<input type=\"button\" name=\"Save\" value=\" Save Only \" onclick=\"save()\">&nbsp&nbsp&nbsp\r\n");
      out.write("\t<input type=\"button\" name=\"Clear\" value=\" Clear \"  onClick=\"window.location.reload(false)\" />&nbsp&nbsp&nbsp\r\n");
      out.write("\t\r\n");
      out.write("\t</form>\r\n");
      out.write("\t</body>\r\n");
      out.write("\t</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
