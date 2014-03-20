package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class order_005fdetailsForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write(" \n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<script src=\"order_details.js\">\n");
      out.write("</script> \n");
      out.write("</head>\n");
      out.write("<body onload=\"setfocus()\">\n");
      out.write("<b>Please Enter Order Details to Search  </b>\n");
      out.write("<form name=\"myform\" method=\"post\">\n");
      out.write("<table border=\"0\">\n");
      out.write("<tr>\n");
      out.write("<td><b><font color=\"blue\">O</font>rder Number</b></td><td><input type=\"text\" name=\"orderNumber\" accesskey=\"o\" align=\"right\"></td>\n");
      out.write("<td><b>Cu<font color=\"blue\">s</font>tomer Code</b><td><input type=\"text\" name=\"customerCode\" accesskey=\"s\" align=\"right\" colspan=\"2\"></td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("<td ><b>Customer <font color=\"blue\">N</font>ame</b></td>\n");
      out.write("<td><input type=\"text\" name=\"customerName\" accesskey=\"n\" align=\"right\"></b></td>\n");
      out.write("<td align=\"right\"><b>Order <font color=\"blue\">D</font>ate</b></td>\n");
      out.write("<td><input type =\"text\" name=\"orderDate\" size=\"20\"  align=\"right\">\n");
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("<td><b><font color=\"blue\">E</font>ntered By</b></td><td><input type =\"text\" name=\"enteredBy\"></td>\n");
      out.write("<td></td>\n");
      out.write("</tr>\n");
      out.write("</table> \n");
      out.write("<br><br>\n");
      out.write("<input type=\"submit\" name=\"search\" title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"showHint();return false;\">\n");
      out.write("<input type=\"reset\" name=\"clear\" value=\"Clear <Alt+c>\" tabindex=\"1\" title=\"Press <Alt+c>\" accesskey=\"c\" onclick='document.getElementById(\"txtHint\").innerHTML=\"\";'>\n");
      out.write("</form>\n");
      out.write("<p>Suggestions: <div id=\"txtHint\"></div></p>\n");
      out.write("<br><br>\n");
      out.write("<p><h1><center><div id=\"waitMessage\" ;\"></center></div></h1></p>\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("function setfocus(){\n");
      out.write("      \tdocument.myform.orderNumber.focus();}\n");
      out.write(" </script>\n");
      out.write("</body>\n");
      out.write("</html>");
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
