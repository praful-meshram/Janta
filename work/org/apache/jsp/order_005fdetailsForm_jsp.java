/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-03-03 10:15:21 UTC
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

public final class order_005fdetailsForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=order_detailsForm.jsp", true, 8192, true);
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
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write(' ');
      out.write('\n');
      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write("\n");
      out.write("<script type=\"text/javascript\" src=\"js/jquery-1.10.2.min.js\"></script>\n");
      out.write(" <link rel=\"stylesheet\" href=\"css/themes/base/jquery.ui.all.css\">\n");
      out.write("\t<script src=\"js/ui/jquery.ui.core.js\"></script>\n");
      out.write("\t<script src=\"js/ui/jquery.ui.widget.js\"></script>\n");
      out.write("\t<script src=\"js/ui/jquery.ui.datepicker.js\"></script>\n");
      out.write("\t<link rel=\"stylesheet\" href=\"css/demos.css\">\n");
      out.write(" \n");
      out.write("<script type=\"text/javascript\"  src=\"js/order_details.js\">\n");
      out.write("</script> \n");
      out.write("\n");
      out.write("<style>\n");
      out.write("hr {\n");
      out.write("color: #f00;\n");
      out.write("background-color: #f00;\n");
      out.write("height: 3px;\n");
      out.write("}\n");
      out.write("\n");
      out.write("</style>\n");
      out.write("<script language=\"javascript\" src=\"js/codethatcalendarstd.js\"></script>\n");
      out.write("<script>\n");
      out.write("\t\n");
      out.write("\tfunction checkField(){\n");
      out.write("\t\t\tvar c_date1 = document.myform.c_date1.value ;\n");
      out.write("\t\t\tvar c_date2 = document.myform.c_date2.value ;\n");
      out.write("\t\t\tvar u_date1 = document.myform.u_date1.value ;\n");
      out.write("\t\t\tvar u_date2 = document.myform.u_date2.value ;\n");
      out.write("\t\t\t\n");
      out.write("\t\t\tif(c_date1!=\"\" && c_date2==\"\"){\n");
      out.write("\t\t\t\talert(\"enter create to_date \");\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\tif(c_date2!=\"\" && c_date1==\"\"){\n");
      out.write("\t\t\t\talert(\"enter create from_date \");\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\tif(u_date1!='' && u_date2==''){\n");
      out.write("\t\t\t\talert(\"enter update to_date \");\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\tif(u_date2!='' && u_date1==''){\n");
      out.write("\t\t\t\talert(\"enter update from_date \");\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t\n");
      out.write("\t\t    showHint();\t\t    \n");
      out.write("\t}\n");
      out.write("\tfunction showMsg(){\n");
      out.write("\t\t \t document.myform.action=\"HomeForm.jsp\";\n");
      out.write("\t\t\t document.myform.submit();\n");
      out.write("    }\n");
      out.write("</script>\n");
      out.write("<b>Please Enter Order Details to Search  </b>\n");
      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\" class=\"ddm1\">\n");
      out.write("<table align=\"center\" width=\"100%\" tabindex=\"2\">\n");
      out.write("\t<tr>\n");
      out.write("\t<td>\n");
      out.write("\t<table border=\"0\" align=\"left\">\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">P</font>hone Number</b></td><td><input type=\"text\" name=\"phonenumber\" align=\"right\" colspan=\"2\" accesskey=\"p\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">O</font>rder Number</b></td><td><input type=\"text\" name=\"orderNumber\" accesskey=\"o\" align=\"right\"></td>\n");
      out.write("\t <td><b><font color=\"blue\">C</font>ustomer Code</b><td><input type=\"text\" name=\"customerCode\" accesskey=\"c\" align=\"right\" colspan=\"2\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td ><b>Customer <font color=\"blue\">N</font>ame</b></td>\n");
      out.write("\t <td><input type=\"text\" name=\"customerName\" accesskey=\"n\" align=\"right\"></b></td>\n");
      out.write("\t <td><b><font color=\"blue\">E</font>ntered By</b></td><td><input type =\"text\" name=\"enteredBy\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr><td colspan=4><fieldset><legend>Date Range</legend><table align=\"center\">\t\t\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b>Create<font color=\"blue\">D</font>ate</b></td>\n");
      out.write("\t <td><input type =\"text\"  accesskey=\"d\" name=\"c_date1\" id=\"c_date1\" size=\"15\" readonly=\"readonly\"/></td>\n");
      out.write("\t <td> <b>And</b></td><td> <input type =\"text\" name=\"c_date2\" id=\"c_date2\"  size=\"15\" readonly=\"readonly\"/></td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t <td><b><font color=\"blue\">U</font>pdate Date</b></td>\n");
      out.write("\t <td><input type =\"text\" readonly accesskey=\"u\" name=\"u_date1\" id=\"u_date1\" size=\"15\" readonly=\"readonly\"/></td>\n");
      out.write("\t <td><b>And</b></td><td> <input type =\"text\" name=\"u_date2\" id =\"u_date2\" size=\"15\" readonly=\"readonly\"/></td>\n");
      out.write("\t</tr>\n");
      out.write("</table></fieldset></td></tr>\n");
      out.write("  </table>\n");
      out.write(" </td>\n");
      out.write("  <td>\n");

    Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query="select a.order_num, a.custcode, a.order_date,a.total_items,a.total_value, b.custname ,b.phone,a.status_code,a.enterd_by from orders a, customer_master b  where a.custcode = b.custcode order by a.lastmodifieddate Desc limit 5";
    	rs=stat.executeQuery(query);
    	

      out.write("    \t\n");
      out.write("    \t<table border=\"1\" id=\"id1\" class=\"item3\" style=\"border-collapse: collapse;\"  >\n");
      out.write("    \t<tr><th colspan=\"7\"><center><b>Recently updated orders</b></center></th></tr>\n");
      out.write("\t\t\t<tr> \n");
      out.write("\t\t\t\t<td><b>Order No.</b></td>\n");
      out.write("\t\t\t\t<td><b>Cust Code</b></td>\n");
      out.write("\t\t\t\t<td><b>Order Date</b></td>\n");
      out.write("\t\t\t\t<td><b>Items</b></td>\t\n");
      out.write("\t\t\t\t<td><b>Order Value</b></td>\t\n");
      out.write("\t\t\t\t<td><b>Enterd By</b></td>\n");
      out.write("\t\t\t\t<td><b>Status</b></td>\t\t\n");
      out.write("\t\t   </tr>\n");
		
		while(rs.next()) {

      out.write("\n");
      out.write("          \n");
      out.write("             <tr> <td><a href=\"print_order.jsp?orderNo=");
      out.print(rs.getString(1));
      out.write("&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=");
      out.print(rs.getString(8));
      out.write('"');
      out.write('>');
      out.write('\n');
			//System.out.println("\n\n PPPPPPPPPPPP \n\n print_order.jsp?orderNo="+rs.getString(1)+"&backPage=customer_detailsForm.jsp&buttonFlag=Y&statusCode="+rs.getString(8));
			out.println(rs.getString(1));

      out.write("       \n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t</a></td><td title=\"");
      out.print(rs.getString(6));
      out.write(',');
      out.print(rs.getString(7));
      out.write('"');
      out.write('>');
      out.write('\n');
	
           	out.println(rs.getString(2));

      out.write("\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(rs.getString(3));

      out.write("\t\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(rs.getString(4));

      out.write("\t\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(rs.getString(5));

      out.write("\t\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(rs.getString(9));

      out.write("\t\n");
      out.write("\t\t\t</td><td>\n");
	
           	out.println(rs.getString(8));

      out.write("\t\n");
      out.write("\t\t\t</td></tr>\n");
		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();

      out.write("\n");
      out.write("\t</table>\n");
      out.write("</td>\n");
      out.write("</tr>\n");
						
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}		

      out.write("\n");
      out.write("\n");
      out.write("</table>  \n");
      out.write("</table> \n");
      out.write("\t<br><br>\n");
      out.write("\t<input type=\"submit\" name=\"search\" title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"checkField();return false;\">\n");
      out.write("\t<input type=\"reset\" name=\"clear\" value=\"Clear <Alt+c>\" tabindex=\"1\" title=\"Press <Alt+c>\" accesskey=\"c\" onclick='document.getElementById(\"txtHint\").innerHTML=\"\";'>\n");
      out.write("\t<INPUT type=BUTTON value=\"Cancel <Alt+s>\" accesskey=\"s\" onClick=\"showMsg();\">\n");
      out.write("\t<hr>Suggestions: <div id=\"txtHint\" class=\"ddm1\" style=\"overflow: auto;max-height: 380px;\"></div>\n");
      out.write("\t<br><br>\n");
      out.write("\t<p><h1><center><div id=\"waitMessage\"></center></div></h1></p>\n");
      out.write("\t<script type=\"text/javascript\">\n");
      out.write("\t\t  //document.myform.orderNumber.focus();\n");
      out.write("\t\t  document.myform.phonenumber.focus();\n");
      out.write("\t\t  var currentFld = 0;\n");
      out.write("\t\t  function getKey(){\n");
      out.write("\t\t\t\tvar key = event.keyCode;\n");
      out.write("\t\t\t\tif (key == 38 || key == 40){\n");
      out.write("\t\t\t\t\tif (key == 38) currentFld--; //up arrow\n");
      out.write("\t\t\t\t\telse currentFld++; //down\n");
      out.write("\t\t\t\t\tif (!document.myform.elements[currentFld]) {\n");
      out.write("\t\t\t\t\t\ttref = document.getElementById(\"id1\");\n");
      out.write("\t\t\t\t\t\tahref = tref.getElementsByTagName(\"A\");\n");
      out.write("\t\t\t\t\t\tahref[currentFld-13].focus();\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse\n");
      out.write("\t\t\t\t\t\tdocument.myform.elements[currentFld].focus();\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t    }\n");
      out.write("\t\t\tdocument.onkeydown = getKey;      \t\n");
      out.write("   \t</script>\n");
      out.write("\t \n");
      out.write("</form>\n");
      out.write("</body>\n");
      out.write("</html>");
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
