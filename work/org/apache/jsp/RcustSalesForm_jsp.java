/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-12 06:40:28 UTC
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

public final class RcustSalesForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=RcustSalesForm.jsp", true, 8192, true);
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
      out.write("\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t<!-- files for JqxWidget grid  -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.base.css\" type=\"text/css\" />\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.darkblue.css\" type=\"text/css\" />\n");
      out.write("\t<link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.ui-redmond.css\" type=\"text/css\" />\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/gettheme.js\"></script>\n");
      out.write("\t<script type=\"text/javascript\" src=\"js/jquery-1.10.2.min.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxcore.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxdata.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxbuttons.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxscrollbar.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxlistbox.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxcalendar.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxdatetimeinput.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.filter.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.selection.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.sort.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.pager.js\"></script>\n");
      out.write("     <script type=\"text/javascript\" src=\"js/jqwidgets/jqxmenu.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxlistbox.js\"></script>\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxdropdownlist.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write('\n');
      out.write(' ');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "leftsidemenu.jsp", out, false);
      out.write("\n");
      out.write("<!-- <script language=\"javascript\" src=\"js/codethatcalendarstd.js\"></script> -->\n");
      out.write("<script type='text/javascript' src='js/report.js'></script>\n");
      out.write("\t<script type='text/javascript' src='js/zapatec.js'></script>\n");
      out.write("\t<script type='text/javascript' src='js/dndmodule.js'></script>\n");
      out.write("\t<script type='text/javascript' src='js/list-sorting.js'></script>\n");
      out.write("\t<script type=\"text/javascript\" src=\"js/RcustSalesForm.js\">\n");
      out.write("\t<link href=\"stylesheet/lists.css\" rel=\"stylesheet\" type=\"text/css\"/>\n");
      out.write("\n");
      out.write("\t\n");
      out.write("<script language=\"javascript\">\n");
      out.write("\n");
      out.write("\t\n");
      out.write("</script>\t\n");
      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\">\n");
      out.write("<TD  align=\"center\" width=\"50%\">\n");
      out.write("<center><b>Please Enter Customer Details </b></center><br><br>\n");
      out.write("\t<table>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>\t\t\t\n");
      out.write("\t\t\t<td align=left><b><font color=\"blue\">F</font>rom Date</b></td>\n");
      out.write("\t\t\t<td align=left>\n");
      out.write("\t\t\t\t<div id=\"range1\" name=\"range1\"></div> \n");
      out.write("\t\t\t</TD>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>\t\t\t\n");
      out.write("\t\t\t<td align=left><b><font color=\"blue\">T</font>o Date</b></td>\n");
      out.write("\t\t\t<td align=left>\n");
      out.write("\t\t\t\t<div id=\"range2\" name=\"range2\" ></div>\n");
      out.write("\t\t\t </TD>\n");
      out.write("\t\t</tr>\t\n");
      out.write("\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td colspan=3><fieldset><legend> Selection Criteria</legend>\n");
      out.write("\t\t\t<table align=left>\n");
      out.write("\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td><b><font color=\"blue\">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"CheckBox\" name=\"chckall\" checked onClick=\"funEnabled();\"></td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td colspan=2>\n");
      out.write("\t\t\t\t\t<div id=\"div4\" style=\"VISIBILITY:hidden\" >\n");
      out.write("\t\t\t\t\t\t<table>\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<td><b><font color=\"blue\">C</font>ode</b></td><td><input type=\"text\" name=\"custCode\" accesskey=\"c\" size=\"10\"></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td><b><font color=\"blue\">A</font>rea</b></td>\n");
      out.write("\t\t\t\t\t<td>\n");
 

	String name;
	try {
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("select value from code_table where category='AREA' order by value asc");
					

      out.write("\n");
      out.write("\t\t\t\t\t<center>\n");
      out.write("\t\t\t\t\t\t<SELECT name=\"area\" align=\"left\">\n");
      out.write("\t\t\t\t\t\t<OPTION VALUE=\"\"> Select Area \n");

 		while (rs.next()) {
 			name = rs.getString(1);
 			

      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION VALUE=\"");
      out.print(name);
      out.write('"');
      out.write('>');
      out.write(' ');
      out.print( name);
      out.write(' ');
      out.write('\n');

		}
    	rs.close();    	
    	stmt.close();
    	conn.close();
	}
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();    	
	}

      out.write("\n");
      out.write("\t\t\t\t\t</select></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<td><b><font color=\"blue\">N</font>ame</b></td><td colspan=\"1\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("\t\t\t\t\t\t\t\t<!-- <input type=\"text\" name=\"custName\"  align=\"right\" accesskey=\"n\" size=\"35\" onblur=\"fundispitem(this.value);\"> -->\n");
      out.write("\t\t\t\t\t\t\t\t<input type=\"text\" name=\"custName\"  align=\"right\" accesskey=\"n\" size=\"35\">\n");
      out.write("\t\t\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t<tr>\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t<td colspan=\"4\" ><div id=\"dispitem\" style=\"visbility:hidden;display:none;overflow:auto;height:100\"></div></td>\n");
      out.write("\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t</table>\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t</tr>\t\t\t\n");
      out.write("\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t<tr></tr>\t\n");
      out.write("\t\t\t</table> \n");
      out.write("\t\t \t</fieldset></td></tr>\n");
      out.write("\t</table><br>\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t<center><input type=\"submit\" name=\"search\"  title=\"Press <Enter>\" value=\"Summary <Enter>\" accesskey=\"s\" onclick=\"flag=true;checkField();return false;\">\n");
      out.write("\t<input type=\"reset\" name=\"clear\" title=\"Press <Alt+r>\" tabindex=\"1\" value=\"Clear  <Alt+r>  \" accesskey=\"r\" onClick=\"window.location.reload(); return false;\">\n");
      out.write("\t<br><br>\n");
      out.write("\t&nbsp&nbsp&nbsp&nbsp<input type=\"button\" name=\"detail\"  title=\"Press <Alt+d>\" value=\"Details  <Alt+d>   \" accesskey=\"d\" onclick=\"flag=false;checkField();return false;\">&nbsp&nbsp\n");
      out.write("\t<INPUT type=BUTTON value=\"Cancel <Alt+c>\" accesskey=\"c\" onClick=\"showMsg();\"></center>\n");
      out.write("</TD>\n");
      out.write("</TR></TABLE>\t\n");
      out.write("\t<input  type=\"hidden\" name=\"hcondition\" value=\"summary\">\n");
      out.write("\t<input  type=\"hidden\" name=\"hchckall\" value=\"1\">\n");
      out.write("\t<input type=\"hidden\" name=\"htotalchangeamt\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"htotalordercnt\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"htotalpaidamt\" value=\"\">\t\n");
      out.write("\t<input  type=\"hidden\" name=\"hitemname\" value=\"\">\n");
      out.write("\t<input  type=\"hidden\" name=\"hitem\" value=\"\">\t\n");
      out.write("\t</form>\n");
      out.write("\t<div id=\"salesSummery\"></div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
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