package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class customer_005fdetailsForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<script src=\"customer_details.js\">\r\n");
      out.write("   \r\n");
      out.write("</script> \r\n");
      out.write("</head>\r\n");
      out.write("<body onload=\"onloadValidate()\" >\r\n");
      out.write("\r\n");
      out.write("<b>Please Enter Customer Details to Search  </b>\r\n");
      out.write("<form name=\"myform\" method=\"post\">\r\n");
      out.write("<table border=\"0\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b><font color=\"blue\">C</font>ustomer Code</b></td><td><input type=\"text\" name=\"custCode\" accesskey=\"c\"></td>\r\n");
      out.write("<td><b><font color=\"blue\">P</font>hone Number</b></td><td><input type=\"text\" name=\"phonenumber\" size=\"22\" align=\"right\" colspan=\"2\" accesskey=\"p\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Customer <font color=\"blue\">N</font>ame</b></td><td><input type=\"text\" name=\"cusName\"  align=\"right\" accesskey=\"n\"></td>\r\n");
      out.write("<td><b>Na<font color=\"blue\">m</font>e String</b></td><td><input type=\"text\" name=\"nameString\" size=\"22\"  align=\"right\" accesskey=\"m\" colspan=\"2\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td ><b><font color=\"blue\">B</font>uilding</b></td><td><input type=\"text\" name=\"Building\" accesskey=\"b\" align=\"right\"></b></td>\r\n");
      out.write("<td align=\"right\"><b>Bl<u>o</u>ck</b></td>\r\n");
      out.write("<td><input type =\"text\" name=\"block\" accesskey=\"o\" size=\"5\"  align=\"right\">\r\n");
      out.write("<b><font color=\"blue\">W</font>ing</b>&nbsp&nbsp<input type =\"text\" name=\"wing\" accesskey=\"w\"size=\"5\" ></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b><font color=\"blue\">A</font>ddress1</b></td><td><input type =\"text\" accesskey=\"a\" name=\"add1\"></td>\r\n");
      out.write("<td align=\"right\"><b>A<font color=\"blue\">d</font>dress2</b></td><td><input type =\"text\" accesskey=\"d\" name=\"add2\" size=\"22\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table> \r\n");
      out.write("<input type=\"submit\" name=\"search\"  title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"showHint();return false;\">\r\n");
      out.write("\r\n");
      out.write("<input type=\"reset\" name=\"clear\" title=\"Press <Alt+c>\" tabindex=\"1\" value=\"Clear <Alt+c>\" accesskey=\"c\" onclick=\"document.getElementById('txtHint').innerHTML='';\">\r\n");
      out.write("</form>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write(" \t\r\n");
      out.write("\r\n");

	String errMsg="";
	errMsg=request.getParameter("Exp");

      out.write("\r\n");
      out.write("   \r\n");
      out.write("   var jExp=");
      out.print(errMsg);
      out.write("\r\n");
      out.write("   function onloadValidate() {\r\n");
      out.write("   \tdocument.myform.custCode.focus();\r\n");
      out.write(" \t\tif(jExp==1){\r\n");
      out.write("   \t\t\talert(\"You Successfully created an Order\");\r\n");
      out.write("   \t\t\twindow.refresh;\r\n");
      out.write("   \t\t\tjExp=jExp+1;\r\n");
      out.write("   \t\t\t\r\n");
      out.write("  \t\t}\r\n");
      out.write("  \t\t\r\n");
      out.write("   }\r\n");
      out.write("  \r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<p>Suggestions: <div id=\"txtHint\"></div></p>\r\n");
      out.write("<br><br>\r\n");
      out.write("<p><h1><center><div id=\"waitMessage\"  style=\"cursor: sw-resize\"></center></div></h1></p>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
