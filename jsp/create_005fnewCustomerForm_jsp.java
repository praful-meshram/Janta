package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class create_005fnewCustomerForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("function checkField(){\r\n");
      out.write("\tvar phoneNo=document.myform.phone.value;\r\n");
      out.write("\tvar custName=document.myform.cusName.value;\r\n");
      out.write("\tif(isNaN(phoneNo)) {\r\n");
      out.write("\t\t\talert(\"Please Enter a number in PhoneNumber field\");\r\n");
      out.write("\t}\r\n");
      out.write("\telse if(phoneNo==\"\") {\r\n");
      out.write("\t\t\talert(\"Please Enter your Phone Number\");\r\n");
      out.write("\t}\r\n");
      out.write("\telse if(custName==\"\") {\r\n");
      out.write("\t\t\talert(\"Please Enter Customer Name\");\r\n");
      out.write("\t}\r\n");
      out.write("\telse {\r\n");
      out.write("\t\tdocument.myform.action=\"create_newCustomer.jsp\";\r\n");
      out.write("\t\tdocument.myform.submit();\r\n");
      out.write("\t}\t\r\n");
      out.write("}\t\t\t\t \t\r\n");
      out.write("\r\n");
      out.write("//-->\t\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body onload=\"setfocus()\">\r\n");
      out.write("<h3>Create a New Customer</h3>\r\n");
      out.write("<form name=\"myform\">\r\n");
      out.write("<table border=\"0\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Customer Name</b></td><td><input type=\"text\" name=\"cusName\"  align=\"right\"></td>\r\n");
      out.write("<td><b>Phone Number</b></td><td><input type=\"text\" name=\"phone\" size=\"22\"  align=\"right\" colspan=\"2\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td ><b>Building</b></td><td><input type=\"text\" name=\"building\"  align=\"right\"></b></td>\r\n");
      out.write("<td align=\"right\"><b>Block</b></td>\r\n");
      out.write("<td><input type =\"text\" name=\"block\" size=\"5\"  align=\"right\">\r\n");
      out.write("<b>Wing</b>&nbsp&nbsp<input type =\"text\" name=\"wing\" size=\"5\" ></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Address1</b></td><td><input type =\"text\" name=\"add1\"></td>\r\n");
      out.write("<td align=\"right\"><b>Address2</b></td><td><input type =\"text\" name=\"add2\" size=\"22\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Area</b></td><td><input type=\"text\" name=\"area\"  align=\"right\"></td>\r\n");
      out.write("<td align=\"right\"><b>Pincode</b></td><td><input type=\"text\" name=\"pinCode\" size=\"22\"  align=\"right\" colspan=\"2\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>City</b></td><td><input type=\"text\" name=\"city\" value=\"Mumbai\"  align=\"right\"></td>\r\n");
      out.write("<td align=\"right\"><b>State</b></td><td><input type=\"text\" name=\"state\" value=\"Maharashtra\" size=\"22\"  align=\"right\" colspan=\"2\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Country</b></td><td><input type=\"text\" name=\"country\" value=\"India\" align=\"right\"></td>\r\n");
      out.write("<td></td><td></td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table> \r\n");
      out.write("<input type=\"submit\" name=\"submit\" value=\"Submit\" onClick=\"checkField()\">\r\n");
      out.write("<input type=\"reset\" name=\"clear\" value=\"Clear\">\r\n");
      out.write("</form>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("function setfocus(){\r\n");
      out.write("      \tdocument.myform.cusName.focus();}\r\n");
      out.write(" </script>\r\n");
      out.write("</body>\r\n");
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
