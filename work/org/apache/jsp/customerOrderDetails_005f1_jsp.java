/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-24 10:47:38 UTC
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
import java.io.*;
import payment.*;

public final class customerOrderDetails_005f1_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("customerOrderDetails.jsp", request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("\r\n");

		String custCode="";
		custCode=request.getParameter("custCodeStartWith");
		ManagePayment manage = new ManagePayment("jdbc/js");
		manage.getOrderInfo(custCode);
		
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<center><h4>Order Details</h4></center>\r\n");
      out.write("\t\t<div style=\"width: 99%;overflow-y:scroll;\">\r\n");
      out.write("\t\t\t<table border=\"1\" style=\"width: 98%; float: right;background-color: #BEF781;\">\r\n");
      out.write("\t\t\t\t<tr style=\"width: 100%;\">\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 8%;\">O.No.</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Date</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Total</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Change</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Paid</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Advance</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Discount</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Other</th>\r\n");
      out.write("\t\t\t\t\t<th style=\"width: 9%;\">Balance</th>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div style=\"width: 99%;max-height: 120px;overflow-y:scroll;\">\r\n");
      out.write("\t\t\t<table border=\"1\" style=\"width: 98%;float: right;\">\r\n");
      out.write("\t\t\t");

			int count = 0;
			float total_balance = 0f;
			if(manage.rs.next()){
			do{
				if(count%2==0){
				
      out.write("\r\n");
      out.write("\t\t\t\t\t<tr style=\"width: 100%;background-color:#ECFBB9;\">\r\n");
      out.write("\t\t\t\t");

				}else{
					
      out.write("\r\n");
      out.write("\t\t\t\t\t<tr style=\"width: 100%;background-color:#ECFB99;\">\r\n");
      out.write("\t\t\t\t\t");

				}
				
      out.write("\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 8%; cursor: pointer;\" align=\"left\">\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<b><u>\r\n");
      out.write("\t\t\t\t\t<font color=blue onclick=\"displayOrderDetail('");
      out.print(manage.rs.getString(1));
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( manage.rs.getDate(2) );
      out.write("')\">");
      out.print(manage.rs.getString(1));
      out.write("</font>\r\n");
      out.write("\t\t\t\t\t</u></b>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"display:none;\"><input type=\"hidden\" name=\"ord_num\" size=\"7\" id=\"order_num_");
      out.print(count);
      out.write("\" value = \"");
      out.print(manage.rs.getString(1));
      out.write("\"/></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getDate(2) );
      out.write("<input type=\"hidden\" name=\"date\" value=\"");
      out.print( manage.rs.getDate(2) );
      out.write("\"/></td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(3) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(4) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(5) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(6) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(7) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\">");
      out.print( manage.rs.getFloat(9) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"width: 9%;\" id=\"balance_");
      out.print(count);
      out.write('"');
      out.write('>');
      out.print( manage.rs.getFloat(8) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td style=\"display:none;\"><input type=\"hidden\" name=\"balance\" value=\"");
      out.print( manage.rs.getFloat(8) );
      out.write("\"/></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t");

			total_balance = total_balance + manage.rs.getFloat(8);
			count++;
			} while(manage.rs.next());
			}else{
			
      out.write("\r\n");
      out.write("\t\t\t\t<tr style=\"width: 100%;background-color:#ECFBB9;\"><td colspan=\"12\">No Pending</td><tr>\r\n");
      out.write("\t\t\t");

			}
			manage.closeAll();  
			
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