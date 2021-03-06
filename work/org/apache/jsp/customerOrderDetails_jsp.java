/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-24 11:02:19 UTC
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

public final class customerOrderDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("customerOrderDetails.jsp", request.getCharacterEncoding()), out, false);
      out.write('\n');
      out.write('\n');

		String call_from="";
		if(request.getParameter("call_from") != null){
			call_from = request.getParameter("call_from");
		}
		String custCode="";
		custCode=request.getParameter("custCodeStartWith");
		String query="";
		String num="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			query="select  a.order_num, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, "+
					"b.payment_type_desc, a.lastmodifieddate, a.status_code from orders a, payment_type b "+
					"where a.payment_type_code=b.payment_type_code and a.custcode='"+custCode+"'";
	

      out.write(" \n");
      out.write("\t\t<div style=\"width: 100%; overflow-y: scroll;\">\n");
      out.write("\t\t<table  border=\"1\" id=\"id\" class=\"item3\" style=\"width : 96%;max-height: 100px; float: right;\">\n");
      out.write("\t\t\t<tr style=\"width: 100%;\"><th colspan=9><b>Order Details</b></th></tr>\n");
      out.write("\t      \t<tr style=\"width: 100%;\">\t\t\t\t\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\"><b>Order</b></td>\t\t\t\t\n");
      out.write("\t\t\t\t<td style=\"width: 27%;\"><b>Order Date</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 4%;\"><b>Items</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\"><b>Tot Value</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\"><b>MRP</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\"><b>Discount</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\"><b>Pay Type</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 27%;\"><b>Last Modified Date</b></td>\n");
      out.write("\t\t\t\t<td style=\"width: 10%;\"><b>Status </b></td>\t\t\t\t\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t</table>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t<div style=\"width: 100%; max-height: 500px; overflow-y: scroll; \">\n");
      out.write("\t\t<table  border=\"1\" id=\"id11\" class=\"item3\" style=\"width : 96%;float: right;\">\n");
	
		rs=stat.executeQuery(query);  
		int cnt=0;
    	while(rs.next()) {
    		num=rs.getString(1);
    		if(cnt%2==0){
			 
      out.write("\n");
      out.write("\t\t\t\t<tr id=\"tr\" style=\"width: 100%;background-color:#ECFB99;\">\n");
      out.write("\t\t\t");

			}else{
			
      out.write("\n");
      out.write("\t\t\t\t<tr id=\"tr\" style=\"width: 100%;background-color:#ECFBB9;\">\n");
      out.write("\t\t\t");

			}
    		
      out.write("\n");
      out.write("\t\t\t<td align=\"left\"  style=\"width: 7%;\">\n");
      out.write("\t\t\t");
        
    		if(call_from.equals("comm")){
    		
      out.write("\n");
      out.write("    \t\t\t<font color=\"blue\" style=\"cursor: pointer;\"  onclick=\"displayOrderDetail('");
      out.print(rs.getString(1));
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(rs.getDate(2) );
      out.write("')\"><u>");
      out.print(rs.getString(1) );
      out.write("</u></font>\n");
      out.write("    \t\t");

    		} else {
				out.println(rs.getString(1));
    		}
			
      out.write("\n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 27%;\">\n");
        
    	
			out.println(rs.getString(2));

      out.write("\n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 4%;\">\n");
        
    	
			out.println(rs.getString(3));

      out.write("\n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 7%;\">\n");
        
    	
			out.println(rs.getString(4));

      out.write("\n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 7%;\">\n");
			
			out.println(rs.getString(5));

      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 7%;\">\n");
			
			out.println(rs.getString(6));

      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 7%;\">\n");
			
			out.println(rs.getString(7));

      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 27%;\">\n");
			
			out.println(rs.getString(8));

      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" style=\"width: 10%;\">\n");
			
			out.println(rs.getString(9));

      out.write("       \n");
      out.write("\t\t\n");
      out.write("\t\t\t</td></tr>\t\t\t\t\t\t        \t  \n");
		
			cnt++;
    	}	    
		rs.close();	
        stat.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
		

      out.write("\n");
      out.write("<input type=\"hidden\" name=\"horder\" value=\"");
      out.print(num);
      out.write("\">\n");
      out.write("</table>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("  ");
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
