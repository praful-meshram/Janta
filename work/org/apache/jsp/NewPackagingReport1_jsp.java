/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-12 05:45:33 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import beans.JasonObject;
import com.google.gson.Gson;
import beans.BreakdownOutputBean;
import beans.jqxgridFormat;
import beans.JsonOutputBean;
import java.sql.ResultSet;
import packaging.ManageBreakdown;
import java.util.ArrayList;
import item.ManageItem;

public final class NewPackagingReport1_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=NewPackagingReport1.jsp", true, 8192, true);
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write('\n');
      out.write('\n');
	
	String call_option = request.getParameter("call_option");
		if(call_option.equals("brekdown_list")){
			String frDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			//ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/re");
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			
			jsonOutputBean.getFormat().add(new jqxgridFormat("Breakdown Number","breakdownNumber","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Bachka Name","bachkaName","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Weight","itemWeight","80px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Loss","loss","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Gain","gain","100px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Site ","siteName","120px"));
			
			jqxgridFormat format = new jqxgridFormat("Breakdown Date","breakdownDate","130px");
			format.setSortable(false);
			jsonOutputBean.getFormat().add(format);
			jsonOutputBean.getFormat().add(new jqxgridFormat("Entered By","enteredBy","120px"));
			
			
      out.write("\n");
      out.write("\t\t\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t");

			ArrayList<BreakdownOutputBean> listOutputBeans = new ArrayList();
			ResultSet rs = manageBreakdown.getBreakdownList(frDate,toDate);
			if(rs.next())
			{
				System.out.println("data available in breakdown header ...");
				do{		
					//bd_number,bachka_code,loss_in_breakdown,gain_in_breakdown,site_id,bd_date,entered_by 
						int number = rs.getInt(1);
						BreakdownOutputBean outputBean = new BreakdownOutputBean();
						outputBean.setBreakdownNumber(rs.getInt("bd_number"));
						outputBean.setBachkaName(rs.getString("bachka_code"));
						outputBean.setLoss(rs.getFloat("loss_in_breakdown"));
						outputBean.setGain(rs.getFloat("gain_in_breakdown"));
						outputBean.setSiteName(rs.getString("site_name"));
						outputBean.setBreakdownDate(rs.getString("bd_date"));
						outputBean.setEnteredBy(rs.getString("entered_by"));
						outputBean.setItemWeight(rs.getString("item_weight"));
						listOutputBeans.add(outputBean);
					
				} while(rs.next());
			} else {
				
			}
			manageBreakdown.closeAll();
			jsonOutputBean.setOutputData(listOutputBeans);
			
			System.out.println(new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
		} 
			
		else if (call_option.equals("brekdown_details"))
		{
			System.out.println("breakdown details block....");
			int brekdown_number = Integer.parseInt(request.getParameter("bd_number"));
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ResultSet rs = manageBreakdown.getBreakdownDetails(brekdown_number);
			System.out.print("afer result set of breakdown details..");
			
      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");

			if(rs.next()){
				
				
      out.write("\n");
      out.write("\t\t\t\t<table style=\"border-collapse: collapse;\" border=1>\n");
      out.write("\t\t\t\t<tr style=\"background-color: gray; color: white; \"> \n");
      out.write("\t\t\t\t<!-- <th>Breakdown Number</th>\n");
      out.write("\t\t\t\t<th>Item Code</th>\n");
      out.write("\t\t\t\t <th>Price Version</th>\n");
      out.write("\t\t\t\t<th>New Quantity</th> -->\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t<th>Item Name</th>\n");
      out.write("\t\t\t\t <th>Price Version</th>\n");
      out.write("\t\t\t\t<th>New Quantity</th>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t");

					do{
				
      out.write("\n");
      out.write("\t\t\t\t\t<tr style=\"background-color: #D8D8D8;\"> \n");
      out.write("\t\t\t\t\t\t<td style=\"width: 10%;\" align=\"center\">\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(rs.getString(1) );
      out.write("\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 10%;\" align=\"center\">\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(rs.getString(2) );
      out.write("\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t<td style=\"width: 10%;\" align=\"center\">\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(rs.getString(3) );
      out.write("\n");
      out.write("\t\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t\t\t");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t");

				}while(rs.next());
				manageBreakdown.closeAll();
			
      out.write("\n");
      out.write("\t\t\t\t</table>\n");
      out.write("\t\t\t");
	
			}
			else{
				System.out.println("else part of breakdown details ");
				
			
      out.write("<table style=\"width: 100%;border-collapse: collapse;\" border=1>\n");
      out.write("\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t<td style=\"width: 100%;padding: 5px;\" colspan=\"5\">\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\tNo result matching search criteria...\n");
      out.write("\t\t\t\t\t</td>\n");
      out.write("\t\t\t\t</tr>\n");
      out.write("\t\t\t\t</table>\n");
      out.write("\t\t\t");

			}
						
		}
		else if (call_option.equals("brekdown_detailsPopUp"))
		{
			System.out.println("else part of breakdown details popUp ");
			String brekdownNumber = request.getParameter("breakDownNumber"); 
			ManageBreakdown  manageBreakdown = new ManageBreakdown("jdbc/re");
			ResultSet resultSet = manageBreakdown.getBreakDownDetailsPopUp(brekdownNumber);
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			
			//jsonOutputBean.getFormat().add(new jqxgridFormat("Breakdown Number","breakdownNumber","150px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name", "bachkaName","200px"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Weight", "itemWeight"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Mrp", "itemMRP"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Item Rate", "itemRate"));
			jsonOutputBean.getFormat().add(new jqxgridFormat("Quantity   ", "qty"));
			
			ArrayList<BreakdownOutputBean> listOutputBeans = new ArrayList();
			while(resultSet.next()){
				BreakdownOutputBean outputBean = new BreakdownOutputBean();
				outputBean.setBreakdownNumber(resultSet.getInt("bd_number"));
				outputBean.setBachkaName(resultSet.getString("item_name"));
				outputBean.setItemWeight(resultSet.getString("item_weight"));
				outputBean.setItemMRP(resultSet.getFloat("item_mrp"));
				outputBean.setItemRate(resultSet.getFloat("item_rate"));
				outputBean.setQty(resultSet.getInt("new_qty"));
				
				listOutputBeans.add(outputBean);
				
			}
			
			manageBreakdown.closeAll();
			jsonOutputBean.setOutputData(listOutputBeans);
			System.out.println("breakdown details "+new Gson().toJson(jsonOutputBean));
			out.println(new Gson().toJson(jsonOutputBean));
			
		}
		
		 
      out.write(" \n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\t\t");
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