package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;

public final class getOrderno_005fof_005fOrderDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	   
		String orderNumber="";
		String query="";
		int totalItems=0;
		int jantaPrice=0;
		int total=0;
		orderNumber=request.getParameter("orderNumberStartWith");
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
		Statement stat=conn.createStatement();
		query="select a.custcode,b.rate,b.qty,c.item_name,c.item_unit,c.item_mrp from orders a,order_detail b,item_master c where a.order_num ='" +orderNumber+ "' and a.order_num=b.order_num and b.item_code=c.item_code";
		
		ResultSet rs=stat.executeQuery(query);

      out.write("\r\n");
      out.write("\t\t<table border=\"1\">\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<th colspan=\"7\"><center><b>Order Details</b></center></th>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td><b>Item</b></td>\r\n");
      out.write("\t\t<td><b>Rate</b></td>\r\n");
      out.write("\t\t<td><b>Unit</b></td>\r\n");
      out.write("\t\t<td><b>Qty</b></td>\r\n");
      out.write("\t\t<td colspan=\"2\"><b><center>Price</center></b></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td colspan=4>&nbsp;</td>\r\n");
      out.write("\t\t<td><b>Janta's Price</b></td>\r\n");
      out.write("\t\t<td ><b>MRP</b></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
		
		while(rs.next()){
		totalItems=totalItems+1;
		jantaPrice=rs.getInt(2)*rs.getInt(3);
		total=total+jantaPrice;


      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td>\r\n");

		
		out.println(rs.getString(4));

      out.write("\t\t\t\t\r\n");
      out.write("\t\t</td><td>\r\n");

		out.println(rs.getInt(2));

      out.write("\r\n");
      out.write("\t\t</td><td>\r\n");

		out.println(rs.getString(5));

      out.write("\r\n");
      out.write("\t\t</td><td>\r\n");

		out.println(rs.getInt(3));

      out.write("\r\n");
      out.write("\t\t</td><td>\r\n");

		out.println((rs.getInt(2))*(rs.getInt(3)));

      out.write("\r\n");
      out.write("\t\t</td><td>\r\n");

		out.println(rs.getString(6));

      out.write("\r\n");
      out.write("\t\t</td></tr>\t\t\t\t\t\t\t\t\t\r\n");
		
		}

      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td colspan=4>Total selected items =");
      out.print(totalItems);
      out.write(" </div></td>  \r\n");
      out.write("\t\t<td colspan=2>Total =");
      out.print(total);
      out.write("</div></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
		
		rs.close();
		stat.close();
		conn.close();
	}
	catch(Exception e){
	}

      out.write("\t\t\t\t\t\t\t\t  \t\t\t\t");
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
