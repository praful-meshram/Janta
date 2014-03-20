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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	try{
		String order_Number="";
    	String cust_Code="";
    	String customer_Name="";
    	String order_Date="";
    	String enteredBy="";
    	int i=2;
		order_Number=request.getParameter("orderNumberStartWith");
		cust_Code=request.getParameter("custCodeStartWith"); 
		customer_Name=request.getParameter("custNameStartWith");
		order_Date=request.getParameter("orderDateStartWith");
		enteredBy=request.getParameter("enterByStartWith");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
    	Statement stat=conn.createStatement();
    	String query="select b.custname, a.order_num, a.custcode, a.order_date, a.del_date, a.enterd_by,b.phone,b.add1,b.add2,b.building,b.block,b.wing from orders a, customer_master b where a.custcode = b.custcode";
    	if(customer_Name!=""){
    		query = query + " and custname like'" + customer_Name + "%'";
    	}
    	if(order_Number!=""){
    		query = query + " and order_num like'" + order_Number + "%'";
    	}
    	if(cust_Code!=""){
    		query = query + " and b.custcode like'" + cust_Code + "%'";
    	}
    	if(order_Date!=""){
    		query = query + " and order_date like'" + order_Date + "%'";
    	}
    	if(enteredBy!=""){
    		query = query + " and enterd_by like'" + enteredBy + "%'";
    	}
    	query=query + "order by(order_num)";
    	//System.out.println("query"+query);

      out.write("    \t\r\n");
      out.write("    \t<table border=\"1\" id=\"id1\">\r\n");
      out.write("\t\t<tr id=\"id2\" bgcolor=\"PowderBlue\">\r\n");
      out.write("\t\t<td><b>OrderNumber</b></td>\r\n");
      out.write("\t\t<td><b>Order Date</b></td>\r\n");
      out.write("\t\t<td><b>Customer Code</b></td>\r\n");
      out.write("\t\t<td><b>Customer Name</b></td>\r\n");
      out.write("\t\t<td><b>Entered By</b></td>\r\n");
      out.write("\t\t</tr>\r\n");
		  	
		ResultSet rs=stat.executeQuery(query);

    	while(rs.next()) {
    		if(i%2==0) {
    			if (i==2) {

      out.write("\r\n");
      out.write("  \t\t\t<tr bgcolor=\"aqua\"><td  ><a  href=\"getOrderDetails_of_customer.jsp?custname=");
      out.print(rs.getString(1));
      out.write("&orderNo=");
      out.print(rs.getString(2));
      out.write("&phone=");
      out.print(rs.getString(7));
      out.write("&add1=");
      out.print(rs.getString(8));
      out.write("&add2=");
      out.print(rs.getString(9));
      out.write("&bldg=");
      out.print(rs.getString(10));
      out.write("&block=");
      out.print(rs.getString(11));
      out.write("&wing=");
      out.print(rs.getString(12));
      out.write("\">\r\n");
  		
				}
				else {

      out.write("\r\n");
      out.write("  \t\t\t<tr bgcolor=\"aqua\"><td ><a  href=\"getOrderDetails_of_customer.jsp?custname=");
      out.print(rs.getString(1));
      out.write("&orderNo=");
      out.print(rs.getString(2));
      out.write("&phone=");
      out.print(rs.getString(7));
      out.write("&add1=");
      out.print(rs.getString(8));
      out.write("&add2=");
      out.print(rs.getString(9));
      out.write("&bldg=");
      out.print(rs.getString(10));
      out.write("&block=");
      out.print(rs.getString(11));
      out.write("&wing=");
      out.print(rs.getString(12));
      out.write("\">\r\n");
  		
				}
				
			i=i+1;
			}
			else {

      out.write("\r\n");
      out.write("\t\t\t<tr  bgcolor=\"PowderBlue\"><td><a href=\"getOrderDetails_of_customer.jsp\">\r\n");

			i=i+1;
			}				
			out.println(rs.getString(2));

      out.write("\r\n");
      out.write("\t\t\t</a></td><td>\r\n");
			
			out.println(rs.getString(4));

      out.write("       \r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
           	out.println(rs.getString(3));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
           	out.println(rs.getString(1));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
			out.println(rs.getString(6));

      out.write("\r\n");
      out.write("\t\t\t</td></tr>\r\n");
		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();

      out.write("<style type=\"text/css\">\r\n");
      out.write("a:link {color: blue}\r\n");
      out.write("a:hover {background: blue;color: white}\r\n");
      out.write("a:active {background: blue;color: white}\r\n");
      out.write("</style>\r\n");
      out.write("\t\t</table>\r\n");
							
	}catch(Exception e){
	}		

      out.write("      \r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\t");
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
