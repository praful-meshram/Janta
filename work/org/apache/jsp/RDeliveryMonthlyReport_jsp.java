/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-05 07:50:12 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.google.gson.Gson;
import beans.jqxgridFormat;
import beans.JsonOutputBean;
import java.util.ArrayList;
import beans.SalesOutputBean;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;
import java.text.*;

public final class RDeliveryMonthlyReport_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=RDeliveryMonthlyReport.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- files for JqxWidget grid  -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.base.css\" type=\"text/css\" />\n");
      out.write("    <link rel=\"stylesheet\" href=\"js/jqwidgets/styles/jqx.darkblue.css\" type=\"text/css\" />\n");
      out.write("\n");
      out.write("    \n");
      out.write("\n");
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
      out.write("     <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.export.js\"></script> \n");
      out.write("      <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.aggregates.js\"></script> \n");
      out.write("    <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.grouping.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<table style=\"width: 100%;height: auto;border: 10px;\">\n");
      out.write("\t\t<tr style=\"cursor: pointer;\">\n");
      out.write("\t\t\t<td style=\"width: 97%;\"><img alt=\"All Reports\" src=\"images/Background/report.png\" onclick=\"window.location.assign('Reports.jsp');\" style=\"float:right;\"></td>\n");
      out.write("\t\t\t<td><img alt=\"Home\" src=\"images/Background/House-icon.png\" onclick=\"window.location.assign('HomeForm.jsp');\" style=\"float:right;\"></td>\n");
      out.write("\t\t\t<td><img alt=\"Save To Excel\" src=\"images/Background/Excel-icon (2).png\"  id=\"saveToExcel\" style=\"float:right;\"/></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t</table>\n");
      out.write("\n");
      out.write("\n");

			String str1="",check="",pageName="RDelivery";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
		    check=request.getParameter("hchckall");		    

      out.write("\n");
      out.write("<form name=\"myform\" method=\"post\">\n");

DecimalFormat df = new DecimalFormat("###,###.00");
		report.ManageReports c;
		//c = new report.ManageReports("jdbc/js");
		c = new report.ManageReports("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	String criteria="";
		String year="";
    	String order_date="";		
		int total_orders=0,count=0;		
		int grand_total_orders=0;
		
		//float total_value= 0.0f,expected_value=0.0f;
		//float total_change= 0.0f;
		float total_paid= 0.0f,total_other_amt=0.0f,total_collected=0.0f,total_diff= 0.0f;
		
		float total_expected=0.0f,grand_total_expected=0.0f;
		//float grand_total_change=0.0f;		
		float grand_total_paid=0.0f,grand_total_diff=0.0f,grand_total_other_amt=0.0f,
			  grand_total_total_collected=0.0f;
		
    	if(hchckall.equals("1")){
    		c.listDeliveryMonthlyReports(); 
    		criteria ="All";
    	}
    	else{
    		    	
	    	String selMonth="";			
			selMonth=request.getParameter("selMonth");		
			criteria = 	selMonth;		
			c.listDeliveryMonthlyReportsWithDate(selMonth); 
      out.write("\n");
      out.write("\t\t\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"selMonth\" value=\"");
      out.print(selMonth);
      out.write('"');
      out.write('>');
      out.write('\n');

		}

      out.write("\n");
      out.write("\n");
      out.write("\t\t\n");
      out.write("       \n");
      out.write("       \t<br><center><b> Monthly Delivery Report</center> \n");
      out.write("       <br>\t&nbsp\t Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Detail\n");
      out.write("       <br>\t&nbsp\t Month Criteria&nbsp&nbsp&nbsp:  ");
      out.print(criteria);
      out.write("\n");
      out.write("       \n");
      out.write("        <div id=\"delivaryMonth\" style=\"display: none;\">\n");
		    	
			ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
	    	while(c.rs.next()) {	
	    		order_date= c.rs.getString(1);		    	
		    	if(order_date!=null){ 
			    	count++; 
			    	//monthName=c.rs.getString(1);
			    	year = c.rs.getString(2);
		    		total_orders= c.rs.getInt(3);
			    	total_paid= c.rs.getFloat(4);
			    	total_other_amt=c.rs.getFloat(5);
			    	total_collected=c.rs.getFloat(7);
			    	total_diff=c.rs.getFloat(5);
		    		total_expected = c.rs.getFloat(8);

	    			grand_total_orders = total_orders + grand_total_orders;
					grand_total_paid = total_paid + grand_total_paid;
					grand_total_other_amt = +grand_total_other_amt;
					grand_total_total_collected = total_collected+grand_total_total_collected;
					grand_total_diff = total_diff+grand_total_diff;
					grand_total_expected = total_expected + grand_total_expected;
					
					SalesOutputBean outputBean = new SalesOutputBean(); 
					outputBean.setOrder_date(order_date); // month
					outputBean.setYear(year);
					/* outputBean.setTotal_orders("<a  href=\"ReportOrderListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&pageName="+
												pageName+"&check='"+document.myform.hchckall.value+"'\">"+(total_orders+"").trim()+"</a>");
				 */
				 	
					outputBean.setTotal_orders("<a  href=\"ReportOrderListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&pageName="+
							pageName+"&check='1' \">"+(total_orders+"").trim()+"</a>");
					outputBean.setTotalOrders1(df.format(total_orders));
					outputBean.setTotal_paid(df.format(total_paid));
					outputBean.setTotal_other_amt(df.format(total_other_amt));
					outputBean.setTotal_collected(df.format(total_collected));
					outputBean.setDiffamt("<a  href=\"ReportDifferenceListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&check="+check+"\" >"+df.format(total_diff)+"</a>");
					outputBean.setDiffamt1(df.format(total_diff));
					outputBean.setExpectedAmount((total_expected+"").trim());
					
					listOutputBeans.add(outputBean);
					
				}
			    
		    	
		}	
	    c.closeAll();	
		JsonOutputBean jsonOutputBean	= new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBeans);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Month","order_date","110px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Year","year","110px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","180px"));
		jqxgridFormat  format = new  jqxgridFormat("Total Orders","totalOrders1","180px"); 
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format); 
		jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","total_paid","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Other Amount","total_other_amt","180px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Difference","diffamt","180px"));
		format = new jqxgridFormat("Difference","diffamt1","180px");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format); 
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Expected","expectedAmount","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Collected","total_collected"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
	    

      out.write("\t\n");
      out.write("</div>\n");
      out.write("<div id=\"delivaryMonthGrid\"></div>\n");
      out.write("<style type=\"text/css\">\n");
      out.write("a:link {color: blue}\n");
      out.write("a:hover {background: blue;color: white}\n");
      out.write("a:active {background: blue;color: white}\n");
      out.write("</style>\n");
      out.write("<br>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<input type=\"hidden\" name=\"hcount\" value=\"");
      out.print(count);
      out.write("\">\n");
      out.write("<input type=\"hidden\" name=\"hchckall\" value=\"");
      out.print(hchckall);
      out.write("\">\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("function Pass(){\n");
      out.write("\tif(document.myform.hcount.value==0)\n");
      out.write("\t\talert(\"No records available to save in excel\");\n");
      out.write("\telse if(document.myform.hcount.value>0){\n");
      out.write("\t\tdocument.myform.action=\"RCollectionDailyReport.jsp?Exp=1\";\n");
      out.write("\t    document.myform.submit();\n");
      out.write("\t}\n");
      out.write("}\n");
      out.write("function check(){\t\n");
      out.write("\tvar jExp=");
      out.print(str1);
      out.write("\t\t\t\n");
      out.write("\tif(jExp==1){\t\t\t\n");
      out.write("\t\tdocument.getElementById('divexcel').style.visibility=\"hidden\";\t\t\n");
      out.write("\t}\n");
      out.write("\t\n");
      out.write("\tvar gsonObject = jQuery.parseJSON($('#delivaryMonth').html());\n");
      out.write("\t\t//alert(gsonObject.grandTotalValues);\n");
      out.write("\t\t\t var source =\n");
      out.write("            {\n");
      out.write("                localdata: gsonObject.OutputData,\n");
      out.write("                datatype: \"array\"\n");
      out.write("                \n");
      out.write("            };\n");
      out.write("            \n");
      out.write("         \t$(\"#delivaryMonthGrid\").jqxGrid(\n");
      out.write("            {\t\n");
      out.write("            \ttheme:'darkblue',\n");
      out.write("                height: 340,\n");
      out.write("                source: source,\n");
      out.write("                sortable: true,\n");
      out.write("                //filterable: true,\n");
      out.write("                width:'100%',\n");
      out.write("                pageable :true,\n");
      out.write("                 groupable: true,\n");
      out.write("                //showaggregates: true,\n");
      out.write("                //showstatusbar: true,\n");
      out.write("                //selectionmode: 'singlerow',\n");
      out.write("                columns:gsonObject.format\n");
      out.write("                \t\t\n");
      out.write("                \n");
      out.write("            });\t\n");
      out.write("            \n");
      out.write("             $(\"#saveToExcel\").click(function () {\n");
      out.write("             \t\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'totalOrders');\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('showcolumn', 'totalOrders1');\n");
      out.write("             \t\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'diffamt');\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('showcolumn', 'diffamt1');\n");
      out.write("             \t\n");
      out.write("             \t\n");
      out.write("                $(\"#delivaryMonthGrid\").jqxGrid('exportdata', 'xls', 'Monthly Sales Report');     \n");
      out.write("                \n");
      out.write("                \t$('#delivaryMonthGrid').jqxGrid('showcolumn', 'totalOrders');\n");
      out.write("             \t\t$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'totalOrders1');\n");
      out.write("             \t\t \t\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('showcolumn', 'diffamt');\n");
      out.write("             \t$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'diffamt1');\n");
      out.write("             \t\t\n");
      out.write("                \n");
      out.write("                      \n");
      out.write("            });\t\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("}\n");
      out.write("\twindow.onload = check;\n");
      out.write("\n");
      out.write("</script>\n");
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