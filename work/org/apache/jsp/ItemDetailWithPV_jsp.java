/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-20 07:58:29 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;
import item.ManageItem;

public final class ItemDetailWithPV_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");

	String first = request.getParameter("first");
	String second = request.getParameter("second");
	ManageItem mi = new ManageItem("jdbc/js");
	ResultSet rs1 = mi.getItemWithPV(first,second);

      out.write("\r\n");
      out.write("\t<form action=\"SavePriceVersion.jsp?start_with=");
      out.print(first+second);
      out.write("\" method=\"post\">\r\n");
      out.write("\t<input type=\"submit\" value=\"Save\"/>\r\n");
      out.write("\t<div style=\"width: 100%;overflow-x: hidden;\">\r\n");
      out.write("\t\t<table style=\"width: 100%;float: right;border-collapse: collapse;\" border=\"1\"  cellspacing = 0 cellpadding = 0 bordercolor=black>\r\n");
      out.write("\t\t\t<tr style=\"background-color: #81F781;\">\r\n");
      out.write("\t\t\t\t<th style=\"width: 15%;\">Item Name</th>\r\n");
      out.write("\t\t\t\t<th style=\"width: 7%;\">Weight</th>\r\n");
      out.write("\t\t\t\t<th style=\"width: 78%;\">Price Versions</th>\r\n");
      out.write("\t\t\t</tr>\r\n");

	if(mi.rs.next()){
		String temp = "";
		int count=0;
		do{
			if(!mi.rs.getString(1).equals(temp)){
				count++;
				if(count%2==0){
			
      out.write("\r\n");
      out.write("\t\t\t\t<tr style=\"background-color: #E0F8F1;\">\r\n");
      out.write("\t\t\t");

				}else{
			
      out.write("\r\n");
      out.write("\t\t\t\t<tr style=\"background-color: #ECFB99;\">\r\n");
      out.write("\t\t\t");

				}
			
      out.write("\r\n");
      out.write("\t\t\t\t<td style=\"width: 15%;\" align=\"left\" valign=\"top\">");
      out.print(mi.rs.getString(2));
      out.write("\r\n");
      out.write("\t\t\t\t\t<input type=\"hidden\" name=\"item_code\" value=\"");
      out.print(mi.rs.getString(1));
      out.write("\"/>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t<td style=\"width: 7%;\" align=\"left\" valign=\"top\">");
      out.print(mi.rs.getString(3));
      out.write("</td>\r\n");
      out.write("\t\t\t\t<td style=\"width: 78%;\" align=\"left\" valign=\"top\">\r\n");
      out.write("\t\t\t\t\t<div id=\"pv_div\" style=\"border: 1px solid black;float: left;\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"popup\" id=\"popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"arrow-right\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t");

								if(rs1 != null){
									
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\tPrice Version : ");
      out.print(mi.rs.getInt(4) );
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<table style=\"widows: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr><th>Id</th><th>Site</th><th>Qty</th></tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

									while(rs1.next()){
										if(rs1.getString(1).equals(mi.rs.getString(1)) && rs1.getInt(2)==mi.rs.getInt(4)){
											
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getInt(3) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getString(5) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getInt(4) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

										}
										
									}
									
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

									rs1.beforeFirst();
								}
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<font color=\"blue\" onmouseover=\"dispPopup('popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("')\" \r\n");
      out.write("\t\t\t\t\t\t\t\tonmouseout=\"hidePopup('popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("')\"><u><b>V:</b>");
      out.print(mi.rs.getInt(4));
      out.write("</u></font>|<b>M:</b>");
      out.print(mi.rs.getFloat(5));
      out.write("|<b>R:</b>");
      out.print(mi.rs.getFloat(6));
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<br/>\r\n");
      out.write("\t\t\t\t\t\t");

						if(mi.rs.getString(7).equals("Y")){
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" \r\n");
      out.write("\t\t\t\t\t\t\t\tname=\"current_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tid=\"current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tchecked=\"checked\" value=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tonclick=\"checkField1('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Current\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"checkbox\" \r\n");
      out.write("\t\t\t\t\t\t\t\tname=\"discard_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tid=\"discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tonclick=\"checkField('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Discard\r\n");
      out.write("\t\t\t\t\t\t\t");

						} else {
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"radio\" \r\n");
      out.write("\t\t\t\t\t\t\t\tname=\"current_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tid=\"current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tonclick=\"checkField1('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Current\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"checkbox\" \r\n");
      out.write("\t\t\t\t\t\t\t\tname=\"discard_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\t\tid=\"discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\t\tonclick=\"checkField('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Discard\r\n");
      out.write("\t\t\t\t\t\t\t");

						}
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t");

			} else {
			
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<div id=\"pv_div\" style=\"border: 1px solid black;float: left;\">\r\n");
      out.write("\t\t\t\t\t<div class=\"popup\" id=\"popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"arrow-right\"></div>\r\n");
      out.write("\t\t\t\t\t\t");

								if(rs1 != null){
									
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\tPrice Version : ");
      out.print(mi.rs.getInt(4) );
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<table style=\"widows: 100%\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tr><th>Id</th><th>Site</th><th>Qty</th></tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

									while(rs1.next()){
										if(rs1.getString(1).equals(mi.rs.getString(1)) && rs1.getInt(2)==mi.rs.getInt(4)){
											
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getInt(3) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getString(5) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td>");
      out.print(rs1.getInt(4) );
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

										}
										
									}
									
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

									rs1.beforeFirst();
								}
							
      out.write("\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<font color=\"blue\" onmouseover=\"dispPopup('popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("')\" \r\n");
      out.write("\t\t\t\t\t\tonmouseout=\"hidePopup('popup_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getString(4));
      out.write("')\"><u><b>V:</b>");
      out.print(mi.rs.getInt(4));
      out.write("</u></font>|<b>M:</b>");
      out.print(mi.rs.getFloat(5));
      out.write("|<b>R:</b>");
      out.print(mi.rs.getFloat(6));
      out.write("\r\n");
      out.write("\t\t\t\t\t<br/>\r\n");
      out.write("\t\t\t\t\t");

					if(mi.rs.getString(7).equals("Y")){
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<input type=\"radio\" \r\n");
      out.write("\t\t\t\t\t\t\tname=\"current_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tid=\"current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tchecked=\"checked\" value=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\tonclick=\"checkField1('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Current\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" \r\n");
      out.write("\t\t\t\t\t\t\tname=\"discard_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tid=\"discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\tonclick=\"checkField('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Discard\r\n");
      out.write("\t\t\t\t\t\t");

					} else {
						
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<input type=\"radio\" \r\n");
      out.write("\t\t\t\t\t\t\tname=\"current_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tid=\"current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\tonclick=\"checkField1('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Current\r\n");
      out.write("\t\t\t\t\t\t<input type=\"checkbox\" \r\n");
      out.write("\t\t\t\t\t\t\tname=\"discard_");
      out.print(mi.rs.getString(1));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tid=\"discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("\"\r\n");
      out.write("\t\t\t\t\t\t\tvalue=\"");
      out.print(mi.rs.getInt(4));
      out.write("\" \r\n");
      out.write("\t\t\t\t\t\t\tonclick=\"checkField('current_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.write(' ');
      out.print(mi.rs.getInt(4));
      out.write("','discard_id_");
      out.print(mi.rs.getString(1));
      out.write('_');
      out.print(mi.rs.getInt(4));
      out.write("')\"/>Discard\r\n");
      out.write("\t\t\t\t\t\t");

					}
					
      out.write("\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t");
	
			}
			temp=mi.rs.getString(1);
			
		}while(mi.rs.next());
	} else {
		
      out.write("\r\n");
      out.write("\t\t<td colspan=\"3\">No record start with ");
      out.print(first+second );
      out.write("</td>\r\n");
      out.write("\t\t");

	}
	mi.closeAll();

      out.write("\r\n");
      out.write("\t</table>\r\n");
      out.write("</div>\r\n");
      out.write("</form>");
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