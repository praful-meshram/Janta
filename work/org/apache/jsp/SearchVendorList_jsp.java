/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-11 11:55:39 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class SearchVendorList_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<script src=\"js/vendor.js\"></script> \n");
      out.write("<table border=\"1\"  id=\"id1\" class=\"item3\" style=\"width: 100%;border-collapse: collapse;\" >\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td><b>Vendor Name</b></td>\n");
      out.write("\t\t<td><b>Vendor Address</b></td>\n");
      out.write("\t\t<td><b>Phone Number</b></td>\t\t\n");
      out.write("\t</tr>\n");

	String vendorName = request.getParameter("vendorName");	
	String vendorPhone = request.getParameter("vendorPhone");
	int vendorId;
	String address;
	inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
	objMV.search(vendorName,vendorPhone);
	if(objMV.rs.next()){
	do{
		vendorId = objMV.rs.getInt(1);
		vendorName = objMV.rs.getString(2);
		address = objMV.rs.getString(3);
		vendorPhone = objMV.rs.getString(4);
		

      out.write("\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td><a href=\"EditVendorForm.jsp?vendorId=");
      out.print(vendorId);
      out.write("&vendorName=");
      out.print(vendorName);
      out.write("&vendorAddress=");
      out.print(address);
      out.write("&vendorPhone=");
      out.print(vendorPhone);
      out.write('"');
      out.write('>');
      out.print(vendorName);
      out.write("</a></td>\n");
      out.write("\t\t<td>");
out.println(address);
      out.write("</td>\n");
      out.write("\t\t<td>");
out.println(vendorPhone);
      out.write("</td>\t\t\n");
      out.write("\t</tr>\n");
 
	}while(objMV.rs.next());
	}else {
		
      out.write("\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td colspan=\"3\">No Matching record found...</td>\t\t\n");
      out.write("\t\t</tr>\n");
      out.write("\t");
 	
	}
	objMV.closeAll();

      out.write("\n");
      out.write("</table>");
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
