/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-24 11:29:55 UTC
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

public final class EditTargetReportForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=EditTargetReportForm.jsp", true, 8192, true);
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
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxdata.export.js\"></script> \n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.export.js\"></script> \n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.aggregates.js\"></script>  \n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.grouping.js\"></script> \n");
      out.write("\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<script src=\"js/editCustomer_details.js\"> </script> \n");
      out.write("\n");
      out.write("<script type=\"text/javascript\" src=\"js/popup.js\"></script>\n");
      out.write("<style>\n");
      out.write("hr {\n");
      out.write("color: #f00;\n");
      out.write("background-color: #f00;\n");
      out.write("height: 3px;\n");
      out.write("}\n");
      out.write("#selected_order{\n");
      out.write("width: 40%;\n");
      out.write("max-height: 300px;\n");
      out.write("border: 1px solid black; \n");
      out.write("background-color: #ECFB99;\n");
      out.write("float: right;\n");
      out.write("margin-top: 30px;\n");
      out.write("overflow: auto;\n");
      out.write("margin-right: 2%;\n");
      out.write("padding: 5px;\n");
      out.write("}\n");
      out.write("</style>\n");
      out.write("<script>\n");
      out.write("\t\n");
      out.write("\tfunction checkField(){\n");
      out.write("\t\tif(document.myform.chckall.checked==true){\n");
      out.write("\t\t\tshowHint();\n");
      out.write("\t\t}\n");
      out.write("\t\telse{\t\tvar c_date1,c_date2,u_date2,u_date1;\n");
      out.write("\t\t\t\tif(!($(\"#createDate2\").jqxDateTimeInput('disabled'))){\n");
      out.write("\t\t\t\tc_date1 = $('#createDate1').jqxDateTimeInput('getText');\n");
      out.write("\t\t\t\tc_date2 = $('#createDate2').jqxDateTimeInput('getText');\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t\n");
      out.write("\t\t\tif(!($(\"#updateDate2\").jqxDateTimeInput('disabled'))){\n");
      out.write("\t\t\t\tu_date1 = $('#updateDate1').jqxDateTimeInput('getText');\n");
      out.write("\t\t\t\tu_date2 = $('#updateDate2').jqxDateTimeInput('getText');\n");
      out.write("\t\t\t}\t    \n");
      out.write("\t\t    showHint();\t\t  \n");
      out.write("\t    }\n");
      out.write("\t}\n");
      out.write("\tfunction showMsg(){\n");
      out.write("\t  \t document.myform.action=\"HomeForm.jsp\";\n");
      out.write("\t   \t document.myform.submit();\n");
      out.write("\t}\n");
      out.write("\tfunction Clear(){\n");
      out.write("\t\t\n");
      out.write("\t\ttry{\n");
      out.write("\t\t\tdocument.getElementById(\"order_number\").focus();\n");
      out.write("\t\t} catch (exp){}\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
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
      out.write("\t\tdocument.myform.selmonth.value=\"\";\n");
      out.write("\t\t\n");
      out.write("\t\t$(\"#createDate1\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: \"yyyy-MM-dd\"});\n");
      out.write("\t\t$(\"#createDate2\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: \"yyyy-MM-dd\",value:new Date()});\n");
      out.write("\t\t$(\"#createDate2\").jqxDateTimeInput({disabled: true});\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t$(\"#updateDate1\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: \"yyyy-MM-dd\"});\n");
      out.write("\t\t$(\"#updateDate2\").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: \"yyyy-MM-dd\",value:new Date()});\n");
      out.write("\t\t$(\"#updateDate2\").jqxDateTimeInput({disabled: true});\n");
      out.write("\t\t\n");
      out.write("\t\t$('#createDate1').on('close', function (event) {\n");
      out.write("\t\t // Some code here. \n");
      out.write("\t\t \t$(\"#createDate2\").jqxDateTimeInput({disabled: false});\n");
      out.write("\t\t \t$(\"#createDate2\").jqxDateTimeInput({min: $('#createDate1').jqxDateTimeInput('getDate')});\n");
      out.write(" \t\t}); \t\n");
      out.write(" \t\t\n");
      out.write(" \t\t$('#updateDate1').on('close', function (event) {\n");
      out.write("\t\t // Some code here. \n");
      out.write("\t\t \t$(\"#updateDate2\").jqxDateTimeInput({disabled: false});\n");
      out.write("\t\t \t$(\"#updateDate2\").jqxDateTimeInput({min: $('#updateDate1').jqxDateTimeInput('getDate')});\n");
      out.write(" \t\t}); \t\n");
      out.write("\t\t\n");
      out.write("\t\tfunEnabled();\n");
      out.write("\t}\n");
      out.write("\t\n");
      out.write("function ckeckEmpty(){\n");
      out.write("\tif(document.getElementById(\"order_number\").value == \"\"){\n");
      out.write("\t\talert(\"Please Enter Order Number\");\n");
      out.write("\t\tdocument.getElementById(\"order_number\").focus();\n");
      out.write("\t\treturn false;\n");
      out.write("\t} else {\n");
      out.write("\t\treturn true;\n");
      out.write("\t}\n");
      out.write("}\n");
      out.write("\n");
      out.write("\n");
      out.write("</script>\n");

	String call_type = request.getParameter("call_type");
	if(call_type == null){
		call_type="";
	}
	if(call_type.equals("search_payment")){
		String m="<< Show List";
		
      out.write("\n");
      out.write("\t\t\t<div id=\"selected_order\">\n");
      out.write("\t\t\t\t<b>Selected orders</b>\n");
      out.write("\t\t\t\t<form action=\"PrintSelectedCustPayment.jsp\" method=\"get\" id=\"submit_form\">\n");
      out.write("\t\t\t\t<table style=\"width: 100%;border-collapse: collapse;\" border=1 id=\"selected_order_table\">\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<th style=\"width: 20%;\">Order Number</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 35%;\">Cust Name</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 20%;\">Balance</th>\n");
      out.write("\t\t\t\t\t<th style=\"width: 25%;\">&nbsp;</th>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t</table>\n");
      out.write("\t\t\t\t<table style=\"width: 100%;\" border=1 id=\"insert_table\">\n");
      out.write("\t\t\t\t</table>\n");
      out.write("\t\t\t\t <input type=\"text\" readonly=\"readonly\" name=\"order_count\" id=\"order_count_id\" size=\"3\" value=\"0\" style=\"background-color :#ECFB99 ;\"/> orders selected to print.\n");
      out.write("\t\t\t\t<input type=\"submit\" onclick=\" return printSelectedInformation()\" value=\"Print\" style=\"float: right;\"/>\n");
      out.write("\t\t\t\t</form>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t");

	}
if(!call_type.equals("search_payment") || !call_type.equals("communication")){

      out.write("\n");
      out.write("<center>\n");
} 
      out.write("\n");
      out.write("<fieldset style=\"width: 55%;\"><legend>\n");

	
	String msg = request.getParameter("msg"); 
	if(call_type.equals("receive_payment")){
		out.print("<h3>Search Customer To Receive Payment</h3>");
	} else if(call_type.equals("search_payment")){
		out.print("<h3>Search Customer To See Pending</h3>");
	}else if(call_type.equals("communication")){
		out.print("<h3>Search Customer To Communicate</h3>");
	}else{
		out.print("<h3>Search Customer</h3>");
	}
	

      out.write("\n");
      out.write("</legend>\n");

if(call_type.equals("receive_payment")){
	
      out.write("\n");
      out.write("\t\t<input type = \"radio\" name = \"radio\" onclick=\"ChangeCriteria('order')\" checked=\"checked\"/>Search By Order Number\n");
      out.write("\t\t<input type = \"radio\" name = \"radio\" onclick=\"ChangeCriteria('cust')\"/>Search By Customer Detail\n");
      out.write("\t");

}
if(call_type.equals("receive_payment")){
	
      out.write("\n");
      out.write("\t<br/><br/>\n");
      out.write("<form id=\"myform1\" action=\"SearchCustUsingOrderNo.jsp\" method=\"get\">\n");
      out.write("\t");

	if(msg!=null){
		out.print("<i><font color=red>No Matching Record Found</font></i><br/><br/>");
	} 
	
      out.write("\n");
      out.write("\tEnter Order Number :&nbsp;&nbsp;<input type = \"text\" name = \"order_number\" value=\"\" id =\"order_number\" onkeypress=\"return isNumberKey(event)\"/>\n");
      out.write("\t<input type = \"submit\" value=\"Search\" onclick=\"return ckeckEmpty();\"/>\n");
      out.write("\n");
      out.write("<br/>\n");
      out.write("</form>\n");
      out.write("<form name=\"myform\" method=\"post\" id=\"myform\" style=\"display: none\">\n");
}else{ 
      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\" id=\"myform\" >\n");
} 
      out.write("\n");
      out.write("\t<table style=\"width: 100%;\">\n");
      out.write("\t\t<tr style=\"width: 100%;\">\n");
      out.write("\t\t\t<td align=\"center\" colspan=3><b><font color=\"blue\">&nbspA</font>ll Customers List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp\n");
      out.write("\t\t\t<input type=\"CheckBox\" name=\"chckall\" accesskey=\"a\" onClick=\"funEnabled();\"></td>\n");
      out.write("\t\t</tr>\t\t\n");
      out.write("\t\t<tr style=\"width: 100%;\">\n");
      out.write("\t\t\t<td colspan=3>\n");
      out.write("\t\t\t<div id=\"div4\" style=\"width: 100%;\" >\n");
      out.write("\t\t\t\t<table>\t\t\t\t\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\">\n");
      out.write("\t\t\t\t\t\t\t<b><font color=\"blue\">C</font>ustomer Code</b>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 29%;\"><input style=\"width: 97%;\" type=\"text\" name=\"custCode\" accesskey=\"c\"></td>\n");
      out.write("\t\t\t\t\t\t");
if(call_type.equals("search_payment") || call_type.equals("communication")){ 
      out.write("\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\">\n");
      out.write("\t\t\t\t\t\t\t<b>O<font color=\"blue\">r</font>der Number</b>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 29%;\"><input style=\"width: 97%;\" type=\"text\" name=\"ordernumber\" accesskey=\"c\"></td>\n");
      out.write("\t\t\t\t\t\t");
} 
      out.write("\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Customer <font color=\"blue\">N</font>ame</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 29%;\"><input style=\"width: 97%;\" type=\"text\" name=\"custName\"  align=\"right\" accesskey=\"n\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">P</font>hone Number</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 29%;\"><input style=\"width: 97%;\" type=\"text\" name=\"phonenumber\" size=\"22\" align=\"right\" colspan=\"2\" accesskey=\"p\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>M<font color=\"blue\">o</font>bile Number</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type=\"text\" name=\"mobilenumber\" size=\"22\" align=\"right\" colspan=\"2\" accesskey=\"o\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Na<font color=\"blue\">m</font>e String</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" style=\"width: 100%;\" type=\"text\" name=\"nameString\" size=\"22\"  align=\"right\" accesskey=\"m\" colspan=\"2\"></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">B</font>uilding</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type=\"text\" name=\"Building\" accesskey=\"b\" align=\"right\"></b></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Building <font color=\"blue\">N</font>o.</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type=\"text\" name=\"Building_no\"  size=\"22\"  accesskey=\"o\"></b></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t    <td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">W</font>ing</b></td>\n");
      out.write("\t\t\t\t\t    <td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t    <td><input style=\"width: 97%;\" type =\"text\" name=\"wing\" accesskey=\"w\" ></td>\n");
      out.write("\t\t\t\t\t    \n");
      out.write("\t\t\t\t\t    <td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t    \n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">F</font>lat No.</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type =\"text\" name=\"block\"  size=\"22\" accesskey=\"f\" align=\"right\">\n");
      out.write("\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Addr<font color=\"blue\">e</font>ss1</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type =\"text\" accesskey=\"e\" name=\"add1\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>A<font color=\"blue\">d</font>dress2</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td><input style=\"width: 97%;\" type =\"text\" accesskey=\"d\" name=\"add2\" size=\"22\"></td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr >\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>A<font color=\"blue\">r</font>ea</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t");
 
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
      out.write("\t\t\t\t\t\t\t<SELECT style=\"width: 97%;\" name=\"area\">\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION VALUE=\"\"> Select Area </OPTION>\n");
      out.write("\t\t\t\t\t\t");

 								while (rs.next()) {
 								name = rs.getString(1);
 						
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION VALUE=\"");
      out.print(name);
      out.write('"');
      out.write('>');
      out.write(' ');
      out.print( name);
      out.write(" </OPTION>\n");
      out.write("\t\t\t\t\t\t");

								}
    					
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</SELECT>\n");
      out.write("\t\t\t\t\t\t</td>\t\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Payment Type</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t\t<SELECT style=\"width: 97%;\" name=\"payment\" align=\"left\">\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION selected VALUE=\"\"> Select Type </OPTION>\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION VALUE=\"NoType\"> No Type </OPTION>\n");
      out.write("\t\t\t\t\t\t");

        						ResultSet rs2 = stmt.executeQuery("SELECT payment_type_code, payment_type_desc FROM payment_type");
    							while (rs2.next()){	
						
      out.write("\t\n");
      out.write("\t\t\t\t\t\t\t\t<OPTION VALUE=\"");
      out.print(rs2.getString(1));
      out.write('"');
      out.write('>');
      out.write(' ');
      out.print( rs2.getString(2));
      out.write(" </OPTION>\n");
      out.write("\t\t\t\t\t\t");
	
       							}
        						rs2.close();    	
    							stmt.close();
    							conn.close();
							} catch (Exception e) {
   								e.getMessage();
    							e.printStackTrace();    	
							}
						
      out.write("\n");
      out.write("\t\t\t\t\t\t\t</SELECT>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Create<font color=\"blue\">D</font>ate</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t\t<!-- <input type =\"text\" accesskey=\"d\" name=\"c_date1\" size=\"15\" style=\"width: 79%;\">\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" onClick=\"c1.popup('c_date1');\" value=\"...\" style=\"width: 15%;\"/> -->\n");
      out.write("\t\t\t\t\t\t\t<div id='createDate1'></div>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>And</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td> \n");
      out.write("\t\t\t\t\t\t\t<!-- <input type =\"text\" name=\"c_date2\" size=\"15\" style=\"width: 79%;\">\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" onClick=\"c1.popup('c_date2');\" value=\"...\" style=\"width: 15%;\"/> -->\n");
      out.write("\t\t\t\t\t\t\t<div id='createDate2'></div>\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">U</font>pdate Date</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td>\n");
      out.write("\t\t\t\t\t\t\t<!-- <input type =\"text\" accesskey=\"u\" name=\"u_date1\" size=\"15\" style=\"width: 79%;\"/>\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" onClick=\"c1.popup('u_date1');\" value=\"...\" style=\"width: 15%;\"/> -->\n");
      out.write("\t\t\t\t\t\t\t<div id=\"updateDate1\"></div>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>And</b></td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t\t<td> \n");
      out.write("\t\t\t\t\t\t\t<!-- <input type =\"text\" name=\"u_date2\" size=\"15\" style=\"width: 79%;\"/>\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" onClick=\"c1.popup('u_date2');\" value=\"...\" style=\"width: 15%;\"/> -->\n");
      out.write("\t\t\t\t\t\t\t<div id='updateDate2'></div>\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b><font color=\"blue\">S</font>tation</b></td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t<td><input style=\"width: 97%;\" type =\"text\"  size=\"22\" accesskey=\"d\" name=\"station\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<td style=\"width: 8%;\" align=\"left\"></td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<td style=\"width: 15%;\" align=\"left\"><b>Last Order Days</b></td>\n");
      out.write("\t\t\t\t\t<td style=\"width: 1%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t\t\t<td><input style=\"width: 97%;\" type=\"text\" name=\"selmonth\"/></td></tr>\n");
      out.write("\t\t\t\t</table></div>\n");
      out.write("\t\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t\t\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td align=\"center\" colspan=4>\n");
      out.write("\t\t\t\t<input type=\"submit\" name=\"search\"  title=\"Press <Enter>\" value=\"Search <Enter>\" accesskey=\"s\" onclick=\"checkField();return false;\"/>\n");
      out.write("\t\t\t\t<input type=\"reset\" name=\"clear\" title=\"Press <Alt+c>\" tabindex=\"1\" value=\"Clear <Alt+c>\" accesskey=\"c\" onclick=\"document.getElementById('txtHint').innerHTML='';\"/>\n");
      out.write("\t\t\t\t<INPUT type=BUTTON value=\"Cancel <Alt+c>\" accesskey=\"c\" onClick=\"showMsg();\"/></center>\n");
      out.write("\t\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t</table>\n");
      out.write("\t</fieldset>\n");
      out.write("\t<input  type=\"hidden\" name=\"hchckall\" value=\"1\">\n");
      out.write("\t<input type=\"hidden\" name=\"call_type\" value=\"");
      out.print( call_type );
      out.write("\"/>\n");
      out.write("<script>\n");
      out.write("function funEnabled(){\n");
      out.write("\t    if (document.myform.chckall.checked==true){\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"hidden\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=1;\t\t\n");
      out.write("\t\t\t$(\"#createDate2\").jqxDateTimeInput({disabled: true});\n");
      out.write("\t\t\t$(\"#updateDate2\").jqxDateTimeInput({disabled: true});\n");
      out.write("\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t\telse{\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"visible\";\n");
      out.write("\t\t\tdocument.myform.hchckall.value=0;\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("window.onload =Clear;\n");
      out.write("\n");
      out.write("function ChangeCriteria(str){\n");
      out.write("\tif(str == \"cust\"){\n");
      out.write("\t\tdocument.getElementById(\"myform\").style.display='block';\n");
      out.write("\t\tdocument.getElementById(\"myform1\").style.display='none';\n");
      out.write("\t}else if(str == \"order\"){\n");
      out.write("\t\tdocument.getElementById(\"myform\").style.display='none';\n");
      out.write("\t\tdocument.getElementById(\"myform1\").style.display='block';\n");
      out.write("\t\tdocument.getElementById(\"txtHint\").innerHTML=\"\";\n");
      out.write("\t\tdocument.getElementById(\"order_number\").focus();\n");
      out.write("\t\tdocument.getElementById(\"order_number\").value=\"\";\n");
      out.write("\t}\n");
      out.write("}\n");
      out.write("function isNumberKey(evt) {\n");
      out.write("\tvar charCode = (evt.which) ? evt.which : event.keyCode;\n");
      out.write("\tif (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))\n");
      out.write("\t\treturn false;\n");
      out.write("\telse\n");
      out.write("\t\treturn true;\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\t<hr><center><div id=\"txtHint\" class=\"ddm1\" style=\"background-color: white;width: 100%;max-height: 400px;overflow: auto;\"></div></center>\n");
      out.write("\t<br><br>\n");
      out.write("\t<p><h1><center><div id=\"waitMessage\"  style=\"cursor: sw-resize;\"></center></div></h1></p>\n");
 
	String fromFromName="";
	if(request.getParameter("fromForm")!=null)
		fromFromName=request.getParameter("fromForm");
	//CustPmtHstry

      out.write("\n");
      out.write("\t<input type=\"hidden\" name=\"fromForm\" value=\"");
      out.print( fromFromName );
      out.write("\">\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("<div id=\"dispdiv\" align=\"center\" style=\"border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF; overflow:auto; height:300px; width=200px;\"> </div>\n");
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
