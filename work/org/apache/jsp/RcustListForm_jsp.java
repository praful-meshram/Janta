/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-12 06:40:31 UTC
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

public final class RcustListForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=RcustListForm.jsp", true, 8192, true);
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
      out.write(" \n");
      out.write("\t<!-- files for JqxWidget grid  -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.base.css\" type=\"text/css\" />\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.darkblue.css\" type=\"text/css\" />\n");
      out.write("\t<link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.ui-redmond.css\" type=\"text/css\" />\n");
      out.write("\t\n");
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
      out.write(" \n");
      out.write(" \n");
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
      out.write("<script language=\"javascript\" src=\"js/codethatcalendarstd.js\"></script>\n");
      out.write("<script>\n");
      out.write("\t\n");
      out.write("\tfunction checkField(){\n");
      out.write("\t\t//sene date with url\n");
      out.write("\t\t\n");
      out.write("\t\tvar crateDate1 = $('#crateDate1').jqxDateTimeInput('getText');\n");
      out.write("\t\tvar crateDate2 = $('#crateDate2').jqxDateTimeInput('getText');\n");
      out.write("\t\t\n");
      out.write("\t\tvar updateDate1 = $('#updateDate1').jqxDateTimeInput('getText');\n");
      out.write("\t\tvar updateDate2 = $('#updateDate2').jqxDateTimeInput('getText');\n");
      out.write("\t\t\n");
      out.write("\t\tvar url = \"\";\n");
      out.write("\t\tif(!($(\"#crateDate2\").jqxDateTimeInput('disabled')))\n");
      out.write("\t\t\turl = \"&c_date1=\"+crateDate1+\"&c_date2=\"+crateDate2;\n");
      out.write("\t\tif(!($(\"#updateDate2\").jqxDateTimeInput('disabled')))\n");
      out.write("\t\t\turl += \"&u_date1=\"+updateDate2+\"&u_date2=\"+updateDate2;\n");
      out.write("\t\t\t\n");
      out.write("\t\tdocument.myform.action=\"RcustList.jsp?Exp=0\"+url;\n");
      out.write("\t\t\n");
      out.write("\t\t//alert(document.myform.action);\n");
      out.write("\t   \t\n");
      out.write("\t   \tdocument.myform.submit();\n");
      out.write("\t   \t\n");
      out.write("\t}\n");
      out.write("\tfunction showMsg(){\n");
      out.write("\t  \t document.myform.action=\"HomeForm.jsp\";\n");
      out.write("\t   \t document.myform.submit();\n");
      out.write("\t}\n");
      out.write("\tfunction Clear(){\n");
      out.write("\t\tdocument.myform.chckall.checked= true;\n");
      out.write("\t\t document.myform.hchckall.vaue=\"1\";\n");
      out.write("\t\tdocument.myform.custCode.value=\"\";\n");
      out.write("\t\tdocument.myform.phonenumber.value=\"\";\n");
      out.write("\t\tdocument.myform.custName.value=\"\";\n");
      out.write("\t\tdocument.myform.nameString.value=\"\";\t\t\n");
      out.write("\t\tdocument.myform.Building.value=\"\";\n");
      out.write("\t\tdocument.myform.Building_no.value=\"\";\n");
      out.write("\t\tdocument.myform.wing.value=\"\";\n");
      out.write("\t\tdocument.myform.block.value=\"\";\n");
      out.write("\t\tdocument.myform.add1.value=\"\";\n");
      out.write("\t\tdocument.myform.add2.value=\"\";\n");
      out.write("\t\tdocument.myform.area.value=\"\";\n");
      out.write("\t\tdocument.myform.station.value=\"\";\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t// create date\n");
      out.write("\t\t$(\"#crateDate1\").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: \"yyyy-MM-dd\"});\n");
      out.write("\t\t$(\"#crateDate2\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: \"yyyy-MM-dd\",value:new Date()});\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t$(\"#crateDate2\").jqxDateTimeInput({disabled: true})\n");
      out.write("\t\t\n");
      out.write("\t\t//alert(\"create datetime  \"+ $(\"#crateDate2\").jqxDateTimeInput('disabled'));\n");
      out.write("\t\t\n");
      out.write("\t\t$('#crateDate1').on('close', function (event) {\n");
      out.write("\t\t // Some code here. \n");
      out.write("\t\t \t$(\"#crateDate2\").jqxDateTimeInput({disabled: false});\n");
      out.write("\t\t \t$(\"#crateDate2\").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});\n");
      out.write(" \t\t}); \n");
      out.write(" \t\t\n");
      out.write(" \t\t\n");
      out.write(" \t\t// update date\n");
      out.write(" \t\t$(\"#updateDate1\").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: \"yyyy-MM-dd\"});\n");
      out.write("\t\t$(\"#updateDate2\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: \"yyyy-MM-dd\",value:new Date()});\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t$(\"#updateDate2\").jqxDateTimeInput({disabled: true});\n");
      out.write("\t\t$('#updateDate1').on('close', function (event) {\n");
      out.write("\t\t // Some code here. \n");
      out.write("\t\t \t$(\"#updateDate2\").jqxDateTimeInput({disabled: false});\n");
      out.write("\t\t \t$(\"#updateDate2\").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});\n");
      out.write(" \t\t}); \n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\">\n");
      out.write("<td  width=\"50%\">\n");
      out.write("\t<table align=\"center\">\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td align=\"center\" colspan=3><b><font color=\"blue\">&nbspA</font>ll Customers List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"CheckBox\" name=\"chckall\" checked onClick=\"funEnabled();\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td colspan=3><fieldset><legend> Selection Criteria</legend>\n");
      out.write("\t\t\t<div id=\"div4\" style=\"VISIBILITY:hidden\" >\n");
      out.write("\t\t\t\t<table>\t\n");
      out.write("\t\t\t\t\t<br>\t\t\t\n");
      out.write("\t\t\t\t\t<tr><td colSpan=\"4\"><b>Please Enter Customer Details to Search:</b></td></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td><b><font color=\"blue\">C</font>ustomer Code</b></td><td><input type=\"text\" name=\"custCode\" accesskey=\"c\"></td>\n");
      out.write("\t\t\t\t\t\t<td><b><font color=\"blue\">P</font>hone Number</b></td><td><input type=\"text\" name=\"phonenumber\" size=\"22\" align=\"right\" colspan=\"2\" accesskey=\"p\"></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td><b>Customer <font color=\"blue\">N</font>ame</b></td><td><input type=\"text\" name=\"custName\"  align=\"right\" accesskey=\"n\"></td>\n");
      out.write("\t\t\t\t\t\t<td><b>Na<font color=\"blue\">m</font>e String</b></td><td><input type=\"text\" name=\"nameString\" size=\"22\"  align=\"right\" accesskey=\"m\" colspan=\"2\"></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td ><b><font color=\"blue\">B</font>uilding</b></td><td><input type=\"text\" name=\"Building\" accesskey=\"b\"    align=\"right\"></b></td>\n");
      out.write("\t\t\t\t\t\t<td ><b>Building <font color=\"blue\">N</font>o.</b></td><td><input type=\"text\" name=\"Building_no\"  size=\"22\"  accesskey=\"o\"></b></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t    <td><b><font color=\"blue\">W</font>ing</b></td><td><input type =\"text\" name=\"wing\" accesskey=\"w\" ></td>\n");
      out.write("\t\t\t\t\t\t<td><b><font color=\"blue\">F</font>lat No.</b></td><td><input type =\"text\" name=\"block\"  size=\"22\" accesskey=\"f\" align=\"right\">\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td><b>Addr<font color=\"blue\">e</font>ss1</b></td><td><input type =\"text\" accesskey=\"e\" name=\"add1\"></td>\n");
      out.write("\t\t\t\t\t\t<td ><b>A<font color=\"blue\">d</font>dress2</b></td><td><input type =\"text\" accesskey=\"d\" name=\"add2\" size=\"22\"></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr >\n");
      out.write("\t\t\t\t\t\t<td ><b>A<font color=\"blue\">r</font>ea</b></td><td>\n");
 

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
      out.write("\t\t\t\t\t\t\t</select></td>\n");
      out.write("\t\t\t\t\t\t\t<td ><b><font color=\"blue\">S</font>tation</b></td><td><input type =\"text\"  size=\"22\" accesskey=\"d\" name=\"station\"></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<!-- <tr>\n");
      out.write("\t\t\t\t\t\t\t<td><b>Create<font color=\"blue\">D</font>ate</b></td><td><input type =\"text\" accesskey=\"d\" name=\"c_date1\" size=\"15\"><input type=\"button\" onClick=\"c1.popup('c_date1');\" value=\"...\"/></td><td> <b>And</b></td><td> <input type =\"text\" name=\"c_date2\"  size=\"15\"><input type=\"button\" onClick=\"c1.popup('c_date2');\" value=\"...\"/></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<td><b><font color=\"blue\">U</font>pdate Date</b></td><td><input type =\"text\" accesskey=\"u\" name=\"u_date1\" size=\"15\"><input type=\"button\" onClick=\"c1.popup('u_date1');\" value=\"...\"/></td><td><b>And</b></td><td> <input type =\"text\" name=\"u_date2\" size=\"15\"><input type=\"button\" onClick=\"c1.popup('u_date2');\" value=\"...\"/></td>\n");
      out.write("\t\t\t\t\t\t</tr> -->\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<td><b>Create<font color=\"blue\">D</font>ate</b></td><td><div id=\"crateDate1\"></div></td><td> <b>And</b></td><td><div id=\"crateDate2\"></div></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<td><b><font color=\"blue\">U</font>pdate Date</b></td><td><div id=\"updateDate1\"></td><td><b>And</b></td><td> <div id=\"updateDate2\"></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t</table></div></fieldset>\n");
      out.write("\t\t\t\t</td>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t<tr></tr>\n");
      out.write("\t\t\t<tr></tr>\n");
      out.write("\t\t\t<tr>\n");
      out.write("\t\t\t\t<td align=\"center\" colspan=4>\n");
      out.write("\t\t\t\t\t<input type=\"submit\" name=\"search\"  title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"checkField();return false;\">\n");
      out.write("\t\t\t\t    <input type=\"reset\" name=\"clear\" title=\"Press <Alt+c>\" tabindex=\"1\" value=\"Clear <Alt+c>\" accesskey=\"c\">\n");
      out.write("\t\t\t\t    <INPUT type=BUTTON value=\"Cancel <Alt+c>\" accesskey=\"c\" onClick=\"showMsg();\"></center>\n");
      out.write("\t\t\t\t    \n");
      out.write("\t\t\t\t</td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\n");
      out.write("\t\t  </table>\n");
      out.write("\t\t  <input  type=\"hidden\" name=\"hchckall\" value=\"1\">\n");
      out.write("\t\t  <input type=\"hidden\" name=\"htotalchangeamt\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"htotalordercnt\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"htotalpaidamt\" value=\"\">\t\t\n");
      out.write(" </td>\n");
      out.write(" </tr>\n");
      out.write(" \n");
      out.write(" \n");
      out.write(" </table>\n");
      out.write("</form>\n");
      out.write("<script>\n");
      out.write("function funEnabled(){\n");
      out.write("\t    if (document.myform.chckall.checked==true){\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"hidden\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=1;\t\t\n");
      out.write("\t\t}\n");
      out.write("\t\telse{\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"visible\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=0;\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("window.onload =Clear;\n");
      out.write("</script>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("\n");
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
