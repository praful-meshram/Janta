package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class getOrderDetails_005fof_005fcustomer_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write(' ');
      out.write('\r');
      out.write('\n');

	String customerName="";
	String orderNo="";
	String phone="";
	String add1="";
	String add2="";
	String bldg="";
	String block="";
	String wing="";
	customerName=request.getParameter("custname");
	orderNo=request.getParameter("orderNo");
	phone=request.getParameter("phone");
	add1=request.getParameter("add1");
	add2=request.getParameter("add2");
	bldg=request.getParameter("bldg");
	block=request.getParameter("block");
	wing=request.getParameter("wing");
	

      out.write("\t\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<script src=\"getOrderDetails_of_customer.js\">\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body onload=\"showHint()\">\r\n");
      out.write("<table id=\"1\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Customer Name:</b></td>\r\n");
      out.write("<td><b>");
      out.print(customerName);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Phone:</b></td>\r\n");
      out.write("<td><b>");
      out.print(phone);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Address:</b></td>\r\n");
      out.write("<td><b>");
      out.print(add1);
      out.write("&nbsp");
      out.print(add2);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Building:</b></td>\r\n");
      out.write("<td><b>");
      out.print(bldg);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Block:</b></td>\r\n");
      out.write("<td><b>");
      out.print(block);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("<td><b>Wing:</b></td>\r\n");
      out.write("<td><b>");
      out.print(wing);
      out.write("</b></td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<form name=\"myform\">\r\n");
      out.write("<h3> Order Details:</h3>\r\n");
      out.write("<div id=\"orders\"></div>  \r\n");
      out.write("<br>\r\n");
      out.write("<input type=\"hidden\" name=\"order_no\" value=\"");
      out.print(orderNo);
      out.write("\">\r\n");
      out.write("<input type=\"button\" name=\"Print\" value=\" Print\" onclick=\"window.print()\">&nbsp&nbsp&nbsp   \r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
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
