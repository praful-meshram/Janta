package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class header_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
 	
    String str = "";
	if (session != null) {
		if (session.getAttribute("user_type_code") != null) {
		
			str = session.getAttribute("user_type_code").toString();
			   
		}
	}

      out.write("\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<title>Retail Management-Janta Stores</title>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("body {\r\n");
      out.write("     font: 15px Cambria;\r\n");
      out.write("      background: #a9caed;\r\n");
      out.write("     margin: 0;\r\n");
      out.write("     padding: 0px;\r\n");
      out.write("    }    \r\n");
      out.write("    </style>\r\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"stylesheet/menu.css\" />\r\n");
      out.write("\r\n");
      out.write("    <script type=\"text/javascript\" src=\"js/DropDownMenu1.js\"></script>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<table width=\"100%\" CELLPADDING=\"0\" cellspacing=\"0\"><tr CELLPADDING=\"0\" cellspacing=\"0\"><td align=\"center\" valign=\"top\" ><img src=\"images/retail4.jpg\" />\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t</tr></table>\r\n");
      out.write("\t\t\r\n");
      out.write("    <table cellspacing=\"0\" cellpadding=\"0\" id=\"menu1\" class=\"ddm1\" width=\"100%\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td colspan=100>\r\n");
      out.write("\t\t<p class=\"item3\" href=\"javascript:void(0)\">Welcome User</p>\r\n");
      out.write("\t</td>\r\n");
      out.write("\t</td>\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"Main.jsp\">Home</a>\r\n");
      out.write("        </td>\r\n");
      out.write("        \r\n");
      out.write("        ");
 if(str.equals("2"))
        {
      out.write("\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("             \r\n");
      out.write("            <a class=\"item1\" href=\"javascript:void(0)\">Administration</a>\r\n");
      out.write("            <div class=\"section\">\r\n");
      out.write("\t\t    <a class=\"item2\" href=\"NewUserForm.jsp\">Create User</a>\r\n");
      out.write("                <a class=\"item2\" href=\"EditUserForm.jsp\">Edit User</a>\r\n");
      out.write("                \r\n");
      out.write("             </div>\r\n");
      out.write("        </td>");
 } 
      out.write("\r\n");
      out.write("         ");
if(str.equals("2")||str.equals("1"))
        {
      out.write("\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"javascript:void(0)\">Orders</a>\r\n");
      out.write("            <div class=\"section\">\r\n");
      out.write("                <a class=\"item2\" href=\"customer_detailsForm.jsp\">Create Order</a>\r\n");
      out.write("                <a class=\"item2\" href=\"order_detailsForm.jsp\">List/Edit/Print Order</a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </td>\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"javascript:void(0)\">Customer</a>\r\n");
      out.write("            <div class=\"section\">\r\n");
      out.write("                <a class=\"item2\" href=\"create_newCustomerForm.jsp\">Create New Customer</a>\r\n");
      out.write("                <a class=\"item2\" href=\"EditTargetReportForm.jsp\">Edit/List Customers</a>\r\n");
      out.write("         \r\n");
      out.write("            </div>\r\n");
      out.write("        </td>\r\n");
      out.write("       \r\n");
      out.write("\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"Edit_ProfileForm.jsp\">Profile</a>\r\n");
      out.write("        </td>\r\n");
      out.write("        ");
}
      out.write("        \r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"javascript:void(0)\">About Us</a>\r\n");
      out.write("        </td>\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1\" href=\"javascript:void(0)\">Help</a>\r\n");
      out.write("\t    </td>\r\n");
      out.write("\t     ");
if(str.equals("2") || str.equals("1"))
        {
      out.write("\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <a class=\"item1 right\" href=\"Login.jsp?Log=1\">Logout</a>\r\n");
      out.write("        </td>\r\n");
      out.write("        ");
}
      out.write("\r\n");
      out.write("    </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("    \r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("    var ddm1 = new DropDownMenu1('menu1');\r\n");
      out.write("    ddm1.position.top = -1;\r\n");
      out.write("    ddm1.init();\r\n");
      out.write("    </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    \r\n");
      out.write("      ");
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
