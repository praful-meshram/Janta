/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-07 09:33:41 UTC
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

public final class NewItemForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=NewItemForm.jsp", true, 8192, true);
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
      out.write('\n');
      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write("\n");
      out.write(" \n");
      out.write(" \n");
      out.write("\n");
      out.write("<script type=\"text/javascript\">\n");
String str2 = "";
			str2 = request.getParameter("Exp");
      out.write("\n");
      out.write("\tvar jExp=");
      out.print(str2);
      out.write("\n");
      out.write("\tif(jExp==2){\n");
      out.write("\t\talert(\"Item already exists !!!\");\n");
      out.write("\t}\n");
String backPage = "";
			backPage = request.getParameter("backPage");
			System.out.println("backPage = " + backPage);
      out.write("\n");
      out.write("\tfunction checkField(){\n");
      out.write("\t\tvar iname =document.myform.i_name.value;\n");
      out.write("\t\tvar ibarcode = document.myform.i_barcode.value;\n");
      out.write("\t\tvar iweight =document.myform.i_weight.value;\n");
      out.write("\t\tvar imrp =document.myform.i_mrp.value;\n");
      out.write("\t\tvar irate =document.myform.i_rate.value;\n");
      out.write("\t\tvar iGroupCode =document.myform.iGroupCode.value;\n");
      out.write("\t\tvar iDealType =document.myform.iDealType.value;\n");
      out.write("\t\tvar id_qty =document.myform.id_qty.value;\n");
      out.write("\t\tvar id_amt =document.myform.id_amt.value;\n");
      out.write("\t\tvar box_qty=document.myform.box_qty.value;\n");
      out.write("\t\tif(iGroupCode==\"\") {\n");
      out.write("\t\t\t\talert(\"Please Select the Item Group\");\n");
      out.write("\t\t\t\tdocument.myform.iGroupCode.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(iname==\"\") {\n");
      out.write("\t\t\t\talert(\"Please Enter Item Name\");\n");
      out.write("\t\t\t\tdocument.myform.i_name.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\t/*else if(ibarcode==\"\") {\n");
      out.write("\t\t\talert(\"Please Enter Item Barcode\");\n");
      out.write("\t\t\tdocument.myform.i_barcode.focus();\n");
      out.write("\t\t\treturn false;\n");
      out.write("\t\t}*/\n");
      out.write("\t\telse if(imrp==\"\") {\n");
      out.write("\t\t\t\talert(\"Please Enter Item MRP Value\");\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(isNaN(imrp)) {\n");
      out.write("\t\t\t\talert(\"Please Enter a number in MRP field\");\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.value=\"\";\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(box_qty==\"\") {\n");
      out.write("\t\t\t\talert(\"Please Enter Box Quantity Value\");\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(isNaN(box_qty)) {\n");
      out.write("\t\t\t\talert(\"Please Enter a number in Box Quantity field\");\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.value=\"\";\n");
      out.write("\t\t\t\tdocument.myform.i_mrp.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(irate==\"\") {\n");
      out.write("\t\t\t\talert(\"Please Enter Item Rate\");\n");
      out.write("\t\t\t\tdocument.myform.i_rate.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse if(isNaN(irate)) {\n");
      out.write("\t\t\t\talert(\"Please Enter a number in Rate field\");\n");
      out.write("\t\t\t\tdocument.myform.i_rate.value=\"\";\n");
      out.write("\t\t\t\tdocument.myform.i_rate.focus();\n");
      out.write("\t\t\t\treturn false;\n");
      out.write("\t\t}\n");
      out.write("\t\telse  if (document.myform.chck.checked==true){\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t        if(iDealType==\"\") {\n");
      out.write("\t\t\t\t\t\talert(\"Please Select the Deal type\");\n");
      out.write("\t\t\t\t\t\tdocument.myform.iDealType.focus();\n");
      out.write("\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse if(id_qty==\"\") {\n");
      out.write("\t\t\t\t\t\talert(\"Please Enter Deal Item Qty Value\");\n");
      out.write("\t\t\t\t\t\tdocument.myform.id_qty.focus();\n");
      out.write("\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse if(isNaN(id_qty)) {\n");
      out.write("\t\t\t\t\t\t\talert(\"Please Enter a number in Qty field\");\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.id_qty.value=\"\";\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.id_qty.focus();\n");
      out.write("\t\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse if(id_amt==\"\") {\n");
      out.write("\t\t\t\t\t\t\talert(\"Please Enter Item amount\");\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.id_amt.focus();\n");
      out.write("\t\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\n");
      out.write("\t\t\t\t\telse if(isNaN(id_amt)) {\n");
      out.write("\t\t\t\t\t\t\talert(\"Please Enter a number in amount field\");\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.id_amt.value=\"\";\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.id_amt.focus();\n");
      out.write("\t\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\t\n");
      out.write("\t\t\t\t\telse if(isNaN(i_comm)) {\n");
      out.write("\t\t\t\t\t\t\talert(\"Please Enter a number in Commission field\");\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.i_comm.value=\"\";\n");
      out.write("\t\t\t\t\t\t\tdocument.myform.i_comm.focus();\n");
      out.write("\t\t\t\t\t\t\treturn false;\n");
      out.write("\t\t\t\t\t}\t\t\t\t\t    \n");
      out.write("\t\t}\n");
      out.write("\t\t\n");
      out.write("\t\t  document.myform.Submit.disabled = true;\n");
      out.write("\t\t\tvar ans=confirm(\"Do you want to create this Item?\");\n");
      out.write("\t\t\tif (ans==true){\n");
      out.write("\t\t\t    \n");
      out.write("\t\t\t\tdocument.myform.action=\"NewItem.jsp\";\n");
      out.write("\t\t\t\tdocument.myform.submit();\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\telse\n");
      out.write("\t\t\t {\n");
      out.write("\t\t\t  window.refresh; \n");
      out.write("\t\t\t }\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t\n");
      out.write("\t}\t\n");
      out.write("\tfunction showMsg(){\n");
      out.write("\t\tvar backPage=document.myform.backPage.value;\n");
      out.write("\t\tif(backPage !=\"ItemDetailsForm.jsp\"){\n");
      out.write("\t  \t document.myform.action=\"HomeForm.jsp\";\n");
      out.write("\t   \t document.myform.submit();\n");
      out.write("\t   \t}else{\n");
      out.write("\t   \t\twindow.close();\n");
      out.write("\t   \t}\n");
      out.write("\t}\n");
      out.write("\tfunction CalComm(){\n");
      out.write("\t\tvar rate= document.myform.i_rate.value;\n");
      out.write("\t\tdocument.myform.i_comm.value = rate * 0.01;\n");
      out.write("\t}\t\t\t \t\n");
      out.write("    \n");
      out.write("    function disableBoxField(){\n");
      out.write("    \tvar item_type = document.myform.item_type.options[document.myform.item_type.selectedIndex].value;\n");
      out.write("\t\tif(item_type==\"true\"){\n");
      out.write("\t\t\tdocument.myform.box_qty.readOnly=true;\n");
      out.write("\t\t\tdocument.myform.box_qty.value=\"1\";\n");
      out.write("\t\t\t\n");
      out.write("\t\t} else{\n");
      out.write("\t\t\tdocument.myform.box_qty.value=\"\";\n");
      out.write("\t\t\tdocument.myform.box_qty.readOnly=false;\n");
      out.write("\t\t}\n");
      out.write("    }\n");
      out.write("</script>\n");
      out.write("<fieldset style=\"width: 35%;\"><legend>\n");
      out.write("\t<h3>Create a New Item</h3>\n");
      out.write("</legend>\n");
      out.write("<form name=\"myform\" action=\"NewItem.jsp\" method=\"post\">\n");
      out.write("\t<table border=\"0\" align=\"center\">\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 30%;\" align=\"left\"><b>Item Group </b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t");

				Connection conn = null;
				Statement stmt = null, stat = null;
				ResultSet rs = null, rs2 = null;
				try {
					String name, desc;
					int rowcount;
					Context initContext = new InitialContext();
					Context envContext = (Context) initContext
							.lookup("java:/comp/env");
					DataSource ds = (DataSource) envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
			
      out.write("\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><SELECT name=\"iGroupCode\">\n");
      out.write("\t\t\t\t\t<OPTION VALUE=\"\">\n");
      out.write("\t\t\t\t\t\tSelect Group\n");
      out.write("\t\t\t\t\t\t");

						rowcount = 0;
							while (rs.next()) {
								name = rs.getString(1);
								desc = rs.getString(2);
								if (rowcount == 0) {
					
      out.write("\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<OPTION VALUE=\"");
      out.print(name);
      out.write('"');
      out.write('>');
      out.print(desc);
      out.write("\n");
      out.write("\t\t\t\t\t\t");

							} else {
						
      out.write("\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t<OPTION VALUE=\"");
      out.print(name);
      out.write('"');
      out.write('>');
      out.print(desc);
      out.write("\n");
      out.write("\t\t\t\t\t\t");

							}
									rowcount++;
								}
								rowcount = 0;
								rs.close();
								stmt.close();
						
      out.write("\n");
      out.write("\t\t\t\t\t</td>\n");
      out.write("\t\t\t</SELECT>\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item Name</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_name\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item Barcode</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_barcode\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item Weight</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_weight\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item Type</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\">\n");
      out.write("\t\t\t\t<select name=\"item_type\" style=\"width:60%;\" onchange=\"disableBoxField();\">\n");
      out.write("\t\t\t\t\t<option value=\"false\">Single Item</option>\n");
      out.write("\t\t\t\t\t<option value=\"true\">Bachka</option>\n");
      out.write("\t\t\t\t\t<option value=\"mixItem\">Mix Item</option>\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t</select>\n");
      out.write("\t\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr >\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Box Quantity</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"box_qty\" value=\"\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item MRP [Rs.]</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_mrp\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td style=\"width: 25%;\" align=\"left\"><b>Item Rate [Rs.]</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_rate\" onblur=\"CalComm();\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td rowspan=\"2\" style=\"width: 25%;\" align=\"left\"><b>Commission Amount</b></td>\n");
      out.write("\t\t\t<td style=\"width: 2%;\" align=\"left\">:</td>\n");
      out.write("\t\t\t<td rowspan=\"2\" style=\"width: 40%;\" align=\"left\"><input type=\"text\" name=\"i_comm\">\n");
      out.write("\t\t\t\t&nbsp[1% of rate]</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t<td><input type=\"Checkbox\" id=\"chck\" value=\"N\" size=\"20\"\n");
      out.write("\t\t\t\tonClick=\"funEnabled();\"><b>&nbsp&nbsp&nbsp&nbspDeal flag</b></td>\n");
      out.write("\t\t\t\t<td></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\n");
      out.write("\t\t<tr>\n");
      out.write("\n");
      out.write("\t\t\t<td colspan=\"4\"><div id=\"div4\" style=\"VISIBILITY: hidden\">\n");
      out.write("\t\t\t\t\t<fieldset>\n");
      out.write("\t\t\t\t\t\t<legend>\n");
      out.write("\t\t\t\t\t\t\t<font color=\"blue\"><b>Deal</b></font>\n");
      out.write("\t\t\t\t\t\t</legend>\n");
      out.write("\t\t\t\t\t\t<table align=\"center\">\n");
      out.write("\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t<td><b>Deal Type</b></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td><SELECT name=\"iDealType\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<OPTION VALUE=\"\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\tSelect Type\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

											String name2, items = "", money = "", category = "";
												stat = conn.createStatement();
												rs2 = stat.executeQuery("select value from code_table where category='DealType'");
												while (rs2.next()) {
													name2 = rs2.getString(1);
										
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<OPTION VALUE=\"");
      out.print(name2);
      out.write('"');
      out.write('>');
      out.write(' ');
      out.print(name2);
      out.write(' ');
      out.write('\n');

 	}

 		rs2.close();
 		stat.close();
 		conn.close();
 	} catch (Exception e) {
 		e.getMessage();
 		e.printStackTrace();
 		rs.close();
 		stmt.close();
 		rs2.close();
 		stat.close();
 		conn.close();
 	}
 
      out.write("  \t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t</select></td>\n");
      out.write("\t\t  \t\t</tr>\n");
      out.write("\t\t  \t\t<tr>\n");
      out.write("\t\t  \t\t\t<td><b>Quantity</b></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td><input type=\"text\" name=\"id_qty\" size=\"20\"></td>\n");
      out.write("\t\t  \t\t\t<td><b>Amount</b></td>\n");
      out.write("\t\t\t\t\t\t\t\t<td><input type=\"text\" name=\"id_amt\" size=\"20\"></td>\n");
      out.write("\t\t  \t\t</tr>\n");
      out.write("\t\t  \t</table>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t  \n");
      out.write("\t\t</tr>\t\t\t\n");
      out.write("\t\t  \t\n");
      out.write("  \t</table>\n");
      out.write("  \t<br>\n");
      out.write("\t<center>\n");
      out.write("\t\t<input type=\"submit\" name=\"Submit\" disabled value=\"Submit <Alt+ s>\" accesskey=\"s\" onClick=\"checkField();return false;\">\n");
      out.write("\t\n");
      out.write("<input type=\"reset\" name=\"clear\" accesskey=\"r\"\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvalue=\"Clear <Alt+ r>\"> <INPUT type=BUTTON\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tvalue=\"Cancel <Alt+ c>\" accesskey=\"c\" onClick=\"showMsg();\"></center>\n");
      out.write("  \t<input type=\"hidden\" name=\"backPage\" value=\"");
      out.print(backPage);
      out.write("\">\n");
      out.write("  \n");
      out.write("  </form>\n");
      out.write("  \n");
      out.write("  </fieldset>\n");
      out.write("  <script type=\"text/javascript\">\n");
      out.write("    document.myform.i_name.focus();\n");
      out.write("    function check(){\n");
      out.write("    \t\tdocument.myform.Submit.disabled=false;\n");
      out.write("\t}\n");
      out.write("\tdocument.onkeyup = check;\n");
      out.write("\tfunction funEnabled(){\n");
      out.write("\t    if (document.myform.chck.checked==true){\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"visible\";\n");
      out.write("\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t\telse{\n");
      out.write("\t\t\tdocument.getElementById('div4').style.visibility=\"hidden\";\n");
      out.write("\t\t\t\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\t\t\t\n");
      out.write("</script>\n");
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
