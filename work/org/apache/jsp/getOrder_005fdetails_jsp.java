/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-05 05:37:53 UTC
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

public final class getOrder_005fdetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("getOrder_details.jsp", request.getCharacterEncoding()), out, false);
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

		String phone_Number="";
		String order_Number="";
    	String cust_Code="";
    	String customer_Name="";
    	String enteredBy="";
    	String c_date1="";
    	String u_date1="";
    	String c_date2="";
    	String u_date2="";
    	String orderNo="";
    	String orderDate="";
    	String custCode="";
    	String custName="";
    	String entered_By="";
    	String status="";
    	String deliveryPerson="";
    	String deldt="";
    	String sentdt="";

    	int i=2;
    	phone_Number=request.getParameter("phoneNumberStartWith");
		order_Number=request.getParameter("orderNumberStartWith");
		cust_Code=request.getParameter("custCodeStartWith"); 
		customer_Name=request.getParameter("custNameStartWith");		
		enteredBy=request.getParameter("enterByStartWith");
		c_date1=request.getParameter("c_date1StartWith");
		u_date1=request.getParameter("u_date1StartWith");
		c_date2=request.getParameter("c_date2StartWith");
		u_date2=request.getParameter("u_date2StartWith");	    	
    	
    	order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		mo.listOrders(phone_Number,customer_Name,order_Number,cust_Code,enteredBy, c_date1, c_date2, u_date1, u_date2);		

      out.write("    \t\n");
      out.write("    \t<table border=\"1\" id=\"id1\" class=\"item3\">\n");
      out.write("    \t \t<thead>\n");
      out.write("\t\t\t\t<tr id=\"id2\">\n");
      out.write("\t\t\t\t\t<td  width=\"5%\"><b>OrderNumber</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"15%\"><b>Order Date</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Customer Code</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"20%\"><b>Customer Name</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"5%\"><b>Entered By</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Status</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Delivery Person</b></td>\t\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Del Date</b></td>\t\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Sent Date</b></td>\t\t\t\t\t\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t</thead>\n");
      out.write("\t\t\t<tbody>\n");
		  	
		Date DELDATE = null;
		Date Snddate = null;

    	while(mo.rs.next()) {
    		orderNo=mo.rs.getString(2);
    		orderDate=mo.rs.getString(4);
        	custCode=mo.rs.getString(3);
        	custName=mo.rs.getString(1);
        	entered_By=mo.rs.getString(6);
        	status=mo.rs.getString(14);
        	deliveryPerson=mo.rs.getString(15);    	
         	if(mo.rs.getString(16)==null)
         	{
         		deldt="     -";
         	}
         	else{ 
         		deldt=mo.rs.getString(16);
         	}
        	if(mo.rs.getString(17)==null){
        		sentdt="     -";  
        	}else{
        		sentdt=mo.rs.getString(17);  
        	}
        
 
      out.write("\n");
      out.write("\n");
      out.write("<tr>\n");
      out.write("\t\t\t<td ><a  href=\"print_order.jsp?orderNo=");
      out.print(mo.rs.getString(2));
      out.write("&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=");
      out.print(mo.rs.getString(14));
      out.write("\">\n");
      out.write("\n");

			out.println(orderNo);

      out.write("\n");
      out.write("\t\t\t</a></td><td>\n");
			
			out.println(orderDate);

      out.write("       \n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(custCode);

      out.write("\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(custName);

      out.write("\n");
      out.write("\t\t\t</td><td>\n");
	
			out.println(entered_By);

      out.write("\n");
      out.write("\t\t\t</td>\n");
      out.write("\t\t\t<td>\n");
	
			out.println(status);

      out.write("\n");
      out.write("\t\t\t</td>\n");
			if(deliveryPerson!=null){	

      out.write("\n");
      out.write("\t\t\t\t<td><a  href=\"print_delivered_order.jsp?&orderNo=");
      out.print(orderNo);
      out.write("&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=");
      out.print(status);
      out.write('"');
      out.write('>');
      out.write('\n');
			
				out.println(deliveryPerson);
			}if(deliveryPerson==null){
	
      out.write("\n");
      out.write("\t\t<td>\n");
	
		out.println("Not Delivered Yet");
	}

      out.write("\t\t\n");
      out.write("\t\t</td><td>\n");
	
           	out.println(deldt);

      out.write("\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(sentdt);

      out.write("\n");
      out.write("\t\t\t</td>\t\t\t\n");
      out.write("</tr>\n");
   }
	mo.closeAll();

      out.write("\n");
      out.write("    <style type=\"text/css\">\n");
      out.write("\t\ta:link {color: blue}\n");
      out.write("\t\ta:hover {background: blue;color: white}\n");
      out.write("\t\ta:active {background: blue;color: white}\n");
      out.write("\t\t</style>\n");
      out.write("\t</tbody>\n");
      out.write("\t</table>\n");
      out.write(" \n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t");
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
