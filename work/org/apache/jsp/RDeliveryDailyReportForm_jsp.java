/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-27 05:56:28 UTC
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

public final class RDeliveryDailyReportForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=RDeliveryDailyReportForm.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
      out.write("\t<script type=\"text/javascript\" src=\"js/jqwidgets/jqxdata.export.js\"></script> \n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.export.js\"></script> \t\n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.aggregates.js\"></script> \t\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write('\n');

if(session.getAttribute("user_type_code") != null){
String userTypeCode=session.getAttribute("user_type_code").toString();


      out.write("\t\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
	
	if(!userTypeCode.equals("3")){

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "leftsidemenu.jsp", out, false);
      out.write('\n');
}
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<style>\n");
      out.write("hr {\n");
      out.write("color: #f00;\n");
      out.write("background-color: #f00;\n");
      out.write("height: 3px;\n");
      out.write("}\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("<script language=\"javascript\" src=\"js/codethatcalendarstd.js\"></script>\n");
      out.write("<script>\n");
      out.write("var flag=true;\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\tfunction checkField(){\n");
      out.write("\t\t\n");
      out.write("\t\tvar c_date1 = $('#range1').jqxDateTimeInput('getText');\n");
      out.write("\t\tvar c_date2 = $('#range2').jqxDateTimeInput('getText');\n");
      out.write("\t\tvar url = \"&c_date1=\"+c_date1+\"&c_date2=\"+c_date2;\n");
      out.write("\t    \n");
      out.write("\t   if (flag==false){\n");
      out.write("\t       //document.myform.action=\"RCollectionDailyReport.jsp?Exp=0\";\n");
      out.write("\t       document.myform.action=\"RDeliveryDailyReport.jsp?Exp=0\"+url;\n");
      out.write("\t   \t\t\n");
      out.write(" \t\t}\n");
      out.write(" \t\telse{\n");
      out.write(" \t\t\t//document.myform.action=\"RDeliveryDailyReportSummary.jsp?Exp=0\";\n");
      out.write(" \t\t\tdocument.myform.action=\"RDeliveryDailyReportSummary.jsp?Exp=0\"+url;\n");
      out.write("\t   \t}\n");
      out.write(" \t\tdocument.myform.submit();\n");
      out.write("\t}\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("</script>\n");
      out.write("<form method=\"post\" name=\"myform\" >\n");
      out.write("<td width=\"50%\">\n");
      out.write("\t<h3><center>Daily Reports </center></h3>\n");
      out.write("\t\n");
      out.write("\t<center><b><font color=\"blue\">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type=\"CheckBox\" name=\"chckall\" checked onClick=\"funEnabled();\"></center>\n");
      out.write("\t<br><br>\n");
      out.write("\t<div id=\"div4\" style=\"VISIBILITY:hidden\" align=\"center\">\t\t\n");
      out.write("\t\t<table border=\"0\" align=\"center\">\t\t\n");
      out.write("\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td colspan=4><fieldset><legend>Range</legend><table align=\"center\">\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t<td><b>From<font color=\"blue\">D</font>ate</b></td><td><div id=\"range1\"></div></td>\n");
      out.write("\t\t\t\t\t\t\t<td><font color=\"blue\"> T</font>oDate</td><td><div id=\"range2\"></td>\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t<tr></tr>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t</table></fieldset></td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t</table></div>\n");
      out.write("\n");
      out.write("<br>\n");
      out.write("\t<input  type=\"hidden\" name=\"hchckall\" value=\"1\">\t\n");
      out.write("\t<center><input type=\"submit\" name=\"Submit\" value=\"Summary <Alt+s>\" accesskey=\"s\" onclick=\"checkField();return false;\">\n");
      out.write("\t\n");
      out.write("\t<input type=\"reset\" name=\"clear\" accesskey=\"r\" value=\"Clear <Alt+r>\" onclick=\"document.getElementById('txtHint').innerHTML='';\">\n");
      out.write("<!--\t<br><br><center><input type=\"button\" name=\"Details\" value=\"Details <Alt+d>\" accesskey=\"s\" onclick=\"flag=false;checkField();return false;\">\t-->\n");
      out.write("\t\n");
      out.write("\t<INPUT type=BUTTON value=\"Cancel <Alt+c>\" accesskey=\"c\" onClick=\"showMsg();\">\n");
      out.write("\t\n");
      out.write("\t</td></tr></table>\t\n");
      out.write("</form>\n");
      out.write("<script>\t\n");
      out.write("\tfunction showMsg(){\n");
      out.write("\t\t \t document.myform.action=\"HomeForm.jsp\";\n");
      out.write("\t\t\t document.myform.submit();\n");
      out.write("    }\n");
      out.write("\tfunction funEnabled(){\n");
      out.write("\t    if (document.myform.chckall.checked==true){\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"hidden\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=1;\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t\telse{\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"visible\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=0;\t\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\t\n");
      out.write("\twindow.onload=Clear;\n");
      out.write("\t\t\n");
      out.write("\t\tfunction Clear(){\t\n");
      out.write("\t\tdocument.myform.chckall.checked=true;\n");
      out.write("\t\tdocument.myform.hchckall.value=1;\n");
      out.write("\t\t\n");
      out.write("\t\t//document.myform.c_date1.value= \"\";\n");
      out.write("\t\t//document.myform.c_date2.value=\"\";\t\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t$(\"#range1\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: \"yyyy-MM-dd\"});\n");
      out.write("\t\t$(\"#range2\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: \"yyyy-MM-dd\",value:new Date()});\n");
      out.write("\t\n");
      out.write("\t\t\n");
      out.write("\t\t//$('#range1').jqxDateTimeInput({allowNullDate: true});\n");
      out.write("\t\t//alert( $('#range1').jqxDateTimeInput('allowNullDate'));\n");
      out.write("\t\t\n");
      out.write("\t\t$('#range1').on('close', function (event) {\n");
      out.write("\t\t // Some code here. \n");
      out.write("\t\t \t$(\"#range2\").jqxDateTimeInput({disabled: false});\n");
      out.write("\t\t \t$(\"#range2\").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});\n");
      out.write(" \t\t}); \t\t\t\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t}\n");
      out.write("</script>\n");
} 
      out.write("\n");
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
