/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-03-14 07:47:49 UTC
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
import beans.DelivaryReportOutputBean;
import java.util.ArrayList;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;
import java.text.*;

public final class RDeliveryDailyReportSummary_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=RDeliveryDailyReportSummary.jsp", true, 8192, true);
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
      out.write("\t <script type=\"text/javascript\" src=\"js/jqwidgets/jqxgrid.grouping.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t<table style=\"width: 100%;height: auto;border: 10px;\">\n");
      out.write("\t\t<tr style=\"cursor: pointer;\">\n");
      out.write("\t\t\t<td style=\"width: 97%;\"><img alt=\"All Reports\" src=\"images/Background/report.png\" onclick=\"window.location.assign('Reports.jsp');\" style=\"float:right;\"></td>\n");
      out.write("\t\t\t<td><img alt=\"Home\" src=\"images/Background/House-icon.png\" onclick=\"window.location.assign('HomeForm.jsp');\" style=\"float:right;\"></td>\n");
      out.write("\t\t\t<td ><img alt=\"Save To Excel\" src=\"images/Background/Excel-icon (2).png\"  id=\"saveToExcel\" style=\"float:right;\"/></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr></tr>\n");
      out.write("\t</table>\n");
      out.write("\n");

	String str1 = "", pageName = "RDelivery", pageType = "Summary", closeResult = "";
	str1 = request.getParameter("Exp");
	closeResult = request.getParameter("closeresult");
	if(str1.equals("1")) {
		response.setContentType("application/vnd.ms-excel");
	} else {
		response.setContentType("text/html");

      out.write("\n");
      out.write("<style>\n");
      out.write("#id1 {\n");
      out.write("\twidth: 80%;\n");
      out.write("\tborder-collapse: collapse;\n");
      out.write("\tfont-family: arial;\n");
      out.write("}\n");
      out.write("a:link {\n");
      out.write("\tcolor: blue\n");
      out.write("}\n");
      out.write("\n");
      out.write("a:hover {\n");
      out.write("\tbackground: blue;\n");
      out.write("\tcolor: white\n");
      out.write("}\n");
      out.write("\n");
      out.write("a:active {\n");
      out.write("\tbackground: blue;\n");
      out.write("\tcolor: white\n");
      out.write("}\n");
      out.write("form{\n");
      out.write("\tfont-family: arial;\n");
      out.write("}\n");
      out.write("</style>\n");
      out.write("<center>\n");
      out.write("\t");

		}
	
      out.write("\n");
      out.write("\t<form name=\"myform\" method=\"post\">\n");
      out.write("\t\t");

			DecimalFormat df = new DecimalFormat("###,###.00");
			int count = 0;
			report.ManageReports c;
			//c = new report.ManageReports("jdbc/js");
			c = new report.ManageReports("jdbc/re");
			String hchckall = "";
			hchckall = request.getParameter("hchckall");
			String criteria = "";
			String order_date = "";
			int total_orders = 0;
			int grand_total_orders = 0;

			float total_value = 0.0f, expected_value = 0.0f, total_expected = 0.0f;
			float total_change = 0.0f, grand_total_expected = 0.0f;
			float total_paid = 0.0f, total_other_amt = 0.0f, total_collected = 0.0f;
			float total_diff = 0.0f;

			float grand_total_value = 0.0f;
			float grand_total_change = 0.0f;
			float grand_total_paid = 0.0f, grand_total_other_amt = 0.0f, grand_total_total_collected = 0.0f;
			float grand_total_diff = 0.0f;

			if (hchckall.equals("1")){
				System.out.println(" ppp  c_date1111 ");
				c.listDeliveryDailyReportSummary();
				criteria = "All";
			} else {
				String c_date1 = "";
				String c_date2 = "";

				c_date1 = request.getParameter("c_date1");
				c_date2 = request.getParameter("c_date2");
				
				System.out.println(" ppp  c_date1 "+c_date1);
				System.out.println("c_date2 "+c_date2);
				
				criteria = c_date1 + " to " + c_date2;
				c.listDeliveryDailyReportsWithDateSummary(c_date1, c_date2);
		
      out.write("\n");
      out.write("\n");
      out.write("\t\t<input type=\"hidden\" name=\"c_date1\" value=\"");
      out.print(c_date1);
      out.write("\"> \n");
      out.write("\t\t<input type=\"hidden\" name=\"c_date2\" value=\"");
      out.print(c_date2);
      out.write("\">\n");
      out.write("\n");
      out.write("\t\t");

			}
		
      out.write("\n");
      out.write("\t\t<br>\n");
      out.write("\t\t<h4>Daily Delivery Report</h4>\n");
      out.write("\t\t<br> Type: Summary <br> Date Criteria:\n");
      out.write("\t\t");
      out.print(criteria);
      out.write("\n");
      out.write("\t\t<div id=\"delivaryReportInfo\" style=\"display: none;\">\t\t\t \n");
      out.write("\t\t\t");

				ArrayList<DelivaryReportOutputBean> listOutputBeans = new ArrayList(); 
				while (c.rs.next()) {
					System.out.println("while ");
					order_date = c.rs.getString(1);
					System.out.println(count + order_date);
					if (order_date != null) {
						System.out.println("if 1");
						count++;
						
						total_orders = c.rs.getInt(2);
						total_paid = c.rs.getFloat(3);
						total_diff = c.rs.getFloat(4);
						total_other_amt = c.rs.getFloat(5);
						total_collected = c.rs.getFloat(6);
						total_expected = c.rs.getFloat(7);
						
						
						grand_total_orders = total_orders + grand_total_orders;
						grand_total_paid = total_paid + grand_total_paid;
						grand_total_other_amt = total_other_amt
								+ grand_total_other_amt;
						grand_total_total_collected = total_collected
								+ grand_total_total_collected;
						grand_total_diff = total_diff + grand_total_diff;
						grand_total_expected = total_expected
								+ grand_total_expected;
					}
					if (order_date != null){
						System.out.println("if 2");
						DelivaryReportOutputBean outputBean = new DelivaryReportOutputBean();
						outputBean.setOrderDate("<a href=\"RDeliveryDailyReportDetails.jsp?order_date="+order_date+"\" "+
												"target=\"_blank\">"+(order_date+"").trim()+"</a>");
						outputBean.setOrderDate1((order_date+"").trim());
						outputBean.setTotalOrders("<a href=\"ReportOrderListWithDate.jsp?order_dt="+order_date+"&Exp=0&pageName="+pageName+"\">"+
													(total_orders+"").trim()+"</a>");
						outputBean.setTotalOrders1((total_orders+"").trim());
						outputBean.setTotalPaid(df.format(total_paid));
						outputBean.setTotalDiff("<a href=\"ReportDifferenceListWithDate.jsp?order_dt="+order_date+"&Exp=0,&pageType="+pageType+"&order_type=ALLDIFF&payment_type=ALL\">"+
														df.format(total_diff)+"</a>");
						outputBean.setTotalDiff1(df.format(total_diff));
						outputBean.setTotalOtherAmt(df.format(total_other_amt));
						outputBean.setTotalCollected(df.format(total_collected));
						outputBean.setTotalExpected(df.format(total_expected));
						outputBean.setCheckBox("<input type=\"CHECKBOX\" name=\"chck\"value='"+order_date+"'>");
						listOutputBeans.add(outputBean); 	  	
					}
				}
				c.closeAll();
				System.out.println("close ");
				DelivaryReportOutputBean outputBean = new DelivaryReportOutputBean();
				outputBean.setOrderDate("<a href=\"RDeliveryDailyReportAllDetails.jsp\" target=\"_blank\"><font color=\"red\">ALL Pending</a>");
				outputBean.setOrderDate1("ALL Pending");
				
				outputBean.setTotalOrders("<a href=\"ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALL&payment_type=ALL\">"+			
											+ grand_total_orders+"</a>");
				outputBean.setTotalOrders1((grand_total_orders+"").trim());
				
				outputBean.setTotalPaid(df.format(grand_total_paid));
				
				outputBean.setTotalOtherAmt(df.format(grand_total_other_amt));
				
				outputBean.setTotalDiff("<a href=\"ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALLDIFF&payment_type=ALL\">"+
										+grand_total_diff+"</a>");
				outputBean.setTotalDiff1((grand_total_diff+"").trim());
				
				outputBean.setTotalCollected(df.format(grand_total_total_collected));
				outputBean.setTotalExpected(df.format(grand_total_expected));
				listOutputBeans.add(outputBean); 	  	
				
				JsonOutputBean jsonOutputBean = new JsonOutputBean();
				jsonOutputBean.setOutputData(listOutputBeans);
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Date","orderDate","250px"));
				jqxgridFormat format = new jqxgridFormat("Date","orderDate1","250px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","150px"));
				format = new jqxgridFormat("Total Orders","totalOrders1","150px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","totalPaid","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Other amount","totalOtherAmt","150px"));
				
				jsonOutputBean.getFormat().add(new jqxgridFormat("Difference","totalDiff","150px"));
				format = new jqxgridFormat("Differnce","totalDiff1","150px");
				format.setHidden(true);
				jsonOutputBean.getFormat().add(format);
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Expected","totalExpected","150px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Total Collected","totalCollected","130px"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Close Orders","checkBox","110px"));
				outputBean.setCheckBox("<input type=\"CHECKBOX\" name=\"chck\" value='' style=\"display: none;float:'center'\">");
				System.out.println(new Gson().toJson(jsonOutputBean));
				out.println(new Gson().toJson(jsonOutputBean));
				
			
      out.write("\n");
      out.write("\t</div>\n");
      out.write("\t<div id=\"delivaryReportInfoGrid\"></div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<input type=\"hidden\" name=\"hchckall\" value=\"");
      out.print(hchckall);
      out.write("\">\n");
      out.write("<input type=\"hidden\" name=\"hiddatearray\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"hcount\" value=\"");
      out.print(count);
      out.write("\">\t\n");
      out.write("<br/>\n");
      out.write("\t");

	if (count > 0) {
	
      out.write("\n");
      out.write("\t<!-- <input type=\"submit\" name=\"Submit\" value=\"Save to excel <Alt+ e>\" accesskey=\"e\" onClick=\"Javascript:Pass();return false;\"> -->\n");
      out.write("\t");

		}
	
      out.write(" <input type=BUTTON name=\"Submit\"  accesskey=\"s\" onClick=\"save();return false;\" value=\"Save <Alt+ s>\">\n");
      out.write("\t<input type=\"reset\" name=\"clear\" accesskey=\"r\" value=\"Clear <Alt+ r>\">\n");
      out.write("\t");

		if (count == 0) {
	
      out.write("\n");
      out.write("\t<!-- <table align=\"center\" bgcolor=\"#ECFB99\" width=40% height=20%>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\t<td align=\"center\"><font color=\"red\" size=\"5\">No Records Available</font></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t</table> -->\n");
      out.write("\t");

		}
	
      out.write('\n');
      out.write('\n');
      out.write('\n');

	if (closeResult != null) {
		if (closeResult.equals("1")) {

      out.write(" \t\n");
      out.write("\t\t<script>\n");
      out.write("\t\t\talert(\"Order status set to closed\");\n");
      out.write("\t\t</script>\n");

		}
	}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\tfunction Pass() {\n");
      out.write("\t\tif (document.myform.hcount.value == 0)\n");
      out.write("\t\t\talert(\"No records available to save in excel\");\n");
      out.write("\t\telse if (document.myform.hcount.value > 0) {\n");
      out.write("\t\t\tdocument.myform.action = \"RDeliveryDailyReportSummary.jsp?Exp=1\";\n");
      out.write("\t\t\tdocument.myform.submit();\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction check() {\n");
      out.write("\t\tvar jExp=");
      out.print(str1);
      out.write("\n");
      out.write("\tif (jExp == 1) {\n");
      out.write("\t\t\tdocument.getElementById('divexcel').style.visibility = \"hidden\";\n");
      out.write("\t\t}\n");
      out.write("\t\t\n");
      out.write("\t}\n");
      out.write("\tvar checkCount = 0;\n");
      out.write("\tfunction save() {\n");
      out.write("\t\tif (document.myform.chck.checked == false) {\n");
      out.write("\t\t\talert(\"No orders selected to close\");\n");
      out.write("\t\t\tcheckCount = 0;\n");
      out.write("\t\t} else if (document.myform.chck.checked == true) {\n");
      out.write("\t\t\t//alert(\"CHECKED\");\n");
      out.write("\t\t\tcheckCount = 1;\n");
      out.write("\t\t}\n");
      out.write("\t\tif (document.myform.chck.value == null) {\n");
      out.write("\t\t\tfor (i = 0; i < document.myform.chck.length; i++) {\n");
      out.write("\t\t\t\tif (document.myform.chck[i].checked == true) {\n");
      out.write("\t\t\t\t\tcheckCount = checkCount + 1;\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\tif (checkCount == 0)\n");
      out.write("\t\t\t\talert(\"No orders selected to close\");\n");
      out.write("\t\t}\n");
      out.write("\t\tif (document.myform.hcount.value == 0)\n");
      out.write("\t\t\talert(\"No records available to save\");\n");
      out.write("\t\telse if (document.myform.hcount.value > 0 && checkCount > 0) {\n");
      out.write("\t\t\tcheckSelectedDate();\n");
      out.write("\n");
      out.write("\t\t\tvar ans = confirm(\"Do you want to change the status to Closed? \");\n");
      out.write("\t\t\tif (ans == true) {\n");
      out.write("\t\t\t\tdocument.myform.action = \"RDeliveryCloseOrders.jsp?page=Summary\";\n");
      out.write("\t\t\t\tdocument.myform.submit();\n");
      out.write("\t\t\t} else {\n");
      out.write("\t\t\t\twindow.refresh;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t}\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\tfunction checkSelectedDate() {\n");
      out.write("\t\tvar date = '$$$$';\n");
      out.write("\t\tvar arr = new Array();\n");
      out.write("\n");
      out.write("\t\tif (document.myform.chck.checked == true) {\n");
      out.write("\t\t\tarr = document.myform.chck.value;\n");
      out.write("\t\t\tcheckCount = checkCount + 1;\n");
      out.write("\t\t} else if (document.myform.chck.checked == false) {\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\t\tif (document.myform.chck.value == null) {\n");
      out.write("\t\t\tfor (i = 0; i < document.myform.chck.length; i++) {\n");
      out.write("\t\t\t\tif (document.myform.chck[i].checked == true) {\n");
      out.write("\t\t\t\t\tarr[i] = document.myform.chck[i].value;\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t\t}\n");
      out.write("\t\t}\n");
      out.write("\t\tdocument.myform.hiddatearray.value = arr;\n");
      out.write("\t}\n");
      out.write("\t\n");
      out.write("\twindow.onload = function(){\n");
      out.write("\t\tcheck();\n");
      out.write("\t\t\n");
      out.write("\t\tvar gsonObject = jQuery.parseJSON($('#delivaryReportInfo').html());\n");
      out.write("\t\t\n");
      out.write("\t\t//alert(gsonObject);\n");
      out.write("\t\t//alert(gsonObject.OutputData[0].orderDate1);\n");
      out.write("\t\t//alert(gsonObject.format.orderDate1.textfield);\n");
      out.write("\t\t\n");
      out.write("\t\t var source =\n");
      out.write("            {\n");
      out.write("                localdata:gsonObject.OutputData,\n");
      out.write("                datatype: \"array\"\n");
      out.write("                \n");
      out.write("            };\n");
      out.write("\t\t\t$(\"#delivaryReportInfoGrid\").jqxGrid(\n");
      out.write("            {\t\n");
      out.write("            \ttheme:'darkblue',\n");
      out.write("\t            height: 350,\n");
      out.write("                source: source,\n");
      out.write("                sortable: true,\n");
      out.write("                filterable: true,\n");
      out.write("                width:'90%',\n");
      out.write("               // pageable :true,\n");
      out.write("                //showaggregates: true,\n");
      out.write("                //showstatusbar: true,\n");
      out.write("                //selectionmode: 'singlecell',\n");
      out.write("                  groupable: true,\n");
      out.write("                columns: gsonObject.format\n");
      out.write("            });\t\n");
      out.write("            \n");
      out.write("            \n");
      out.write("             $(\"#saveToExcel\").click(function () {\n");
      out.write("               // alert(\"excel \");\n");
      out.write("               \n");
      out.write("               \n");
      out.write("               $('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'orderDate');\n");
      out.write("            \t$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalOrders');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalDiff');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'checkBox');\n");
      out.write("               \n");
      out.write("               // $('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'orderDate1');\n");
      out.write("            \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalOrders1');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalDiff1');\n");
      out.write("               \n");
      out.write("               \n");
      out.write("               \n");
      out.write("               $(\"#delivaryReportInfoGrid\").jqxGrid('exportdata', 'xls', 'Daily  Delivary Report');   \n");
      out.write("               \n");
      out.write("                \n");
      out.write("                $('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'orderDate1');\n");
      out.write("            \t$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalOrders1');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('hidecolumn', 'totalDiff1');\n");
      out.write("               \t\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'orderDate');\n");
      out.write("            \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalOrders');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'totalDiff');\n");
      out.write("               \t$('#delivaryReportInfoGrid').jqxGrid('showcolumn', 'checkBox');\n");
      out.write("                \n");
      out.write("                     \n");
      out.write("            });\t\n");
      out.write("\t\t\n");
      out.write("\t}\n");
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
