/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-20 08:03:05 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public final class CancelOrderForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=CancelOrderForm.jsp", true, 8192, true);
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
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write("\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("\t<script src=\"js/jquery-1.10.2.min.js\"></script>\n");
      out.write("\t<link rel=\"stylesheet\" href=\"css/themes/base/jquery.ui.all.css\">\n");
      out.write("\t<script src=\"js/ui/jquery.ui.core.js\"></script>\n");
      out.write("\t<script src=\"js/ui/jquery.ui.widget.js\"></script>\n");
      out.write("\t<script src=\"js/ui/jquery.ui.datepicker.js\"></script>\n");
      out.write("\t<link rel=\"stylesheet\" href=\"css/demos.css\">\n");
      out.write("\t<script type=\"text/javascript\"  src=\"js/CancelOrder.js\"></script>\n");
      out.write("\t<style>\n");
      out.write("\t\thr {\n");
      out.write("\t\tcolor: #f00;\n");
      out.write("\t\tbackground-color: #f00;\n");
      out.write("\t\theight: 3px;\n");
      out.write("\t\t}\n");
      out.write("\t</style>\n");
      out.write("\t\n");
      out.write("</head> \n");
      out.write("\n");
      out.write("<b>Please Enter Order Details to Search  </b>\n");
      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\" class=\"ddm1\">\n");
      out.write("<table align=\"center\" width=\"100%\" tabindex=\"2\">\n");
      out.write("\t<tr>\n");
      out.write("\t<td>\n");
      out.write("\t<table border=\"0\" align=\"left\">\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">P</font>hone Number</b></td><td><input type=\"text\" name=\"phonenumber\" align=\"right\" colspan=\"2\" accesskey=\"p\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">O</font>rder Number</b></td><td><input type=\"text\" name=\"orderNumber\" accesskey=\"o\" align=\"right\"></td>\n");
      out.write("\t <td><b><font color=\"blue\">C</font>ustomer Code</b><td><input type=\"text\" name=\"customerCode\" accesskey=\"c\" align=\"right\" colspan=\"2\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td ><b>Customer <font color=\"blue\">N</font>ame</b></td>\n");
      out.write("\t <td><input type=\"text\" name=\"customerName\" accesskey=\"n\" align=\"right\"></b></td>\n");
      out.write("\t <td><b><font color=\"blue\">E</font>ntered By</b></td><td><input type =\"text\" name=\"enteredBy\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr><td colspan=4><fieldset><legend>Date Range</legend><table align=\"center\">\t\t\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b>Create<font color=\"blue\">D</font>ate</b></td><td><input type=\"text\" id='createFromDate' value=\"\" readonly=\"readonly\"></td>\n");
      out.write("\t <td> <b>&nbsp;&nbsp;And&nbsp;&nbsp;&nbsp;</b></td><td><input type=\"text\" id='createToDate' readonly=\"readonly\"/></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">U</font>pdate Date</b></td><td><input type=\"text\" id='updateFromDate' value=\"\" readonly=\"readonly\"/></td>\n");
      out.write("\t <td><b>&nbsp;&nbsp;And&nbsp;&nbsp;&nbsp;</b></td><td><input type=\"text\" id='updateToDate' value=\"\" readonly=\"readonly\"></td>\n");
      out.write("\t</tr>\n");
      out.write("</table></fieldset></td></tr>\n");
      out.write("  </table>\n");
      out.write(" </td>\n");
      out.write("  <td>\n");
      out.write("\n");
      out.write("</table>  \n");
      out.write("</table> \n");
      out.write("\t<br><br>\n");
      out.write("\t<input type=\"submit\" name=\"search\" title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"checkField();return false;\">\n");
      out.write("\t<input type=\"reset\" name=\"clear\" value=\"Clear <Alt+c>\" tabindex=\"1\" title=\"Press <Alt+c>\" accesskey=\"c\" onclick='window.location.reload();'>\n");
      out.write("\t<INPUT type=BUTTON value=\"Cancel <Alt+s>\" accesskey=\"s\" onClick=\"showMsg();\">\n");
      out.write("\t<hr><b>Suggestions: </b><div id=\"txtHint\" style=\"height: 375px;overflow: auto;\"></div>\n");
      out.write("\t<br><br>\n");
      out.write("\t<p><h1><center><div id=\"waitMessage\"></center></div></h1></p>\n");
      out.write("\t<script type=\"text/javascript\">\n");
      out.write("\t\t  //document.myform.orderNumber.focus();\n");
      out.write("\t\t  document.myform.phonenumber.focus();\n");
      out.write("\t\t  var currentFld = 0;\n");
      out.write("\t\t  function getKey(){\n");
      out.write("\t\t\t\tvar key = event.keyCode;\n");
      out.write("\t\t\t\tif (key == 38 || key == 40){\n");
      out.write("\t\t\t\t\tif (key == 38) currentFld--; //up arrow\n");
      out.write("\t\t\t\t\telse currentFld++; //down\n");
      out.write("\t\t\t\t\tif (!document.myform.elements[currentFld]) {\n");
      out.write("\t\t\t\t\t\ttref = document.getElementById(\"id1\");\n");
      out.write("\t\t\t\t\t\tahref = tref.getElementsByTagName(\"A\");\n");
      out.write("\t\t\t\t\t\tahref[currentFld-13].focus();\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse\n");
      out.write("\t\t\t\t\t\tdocument.myform.elements[currentFld].focus();\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t    }\n");
      out.write("\t\t\tdocument.onkeydown = getKey;      \t\n");
      out.write("   \t</script>\n");
      out.write("\t \n");
      out.write("</form>\n");
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