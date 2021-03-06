/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-12 11:33:36 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import beans.JsonOutputBean;
import report.ManageReports;
import com.google.gson.Gson;
import beans.SalesAnalysisReportOutputBean;
import beans.CustomerBean;
import packaging.ManageSalesAnalysis;
import java.sql.ResultSet;
import packaging.ManageBreakdown;
import java.util.ArrayList;
import item.ManageItem;

public final class SalesAnalysis_jsp extends org.apache.jasper.runtime.HttpJspBase
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
	

	String call_option = request.getParameter("call_option");
		if(call_option.equals("analysis_list")){
			String dateRange1 = request.getParameter("dateRange1").trim();
			String dateRange2 = request.getParameter("dateRange2").trim();
			
			System.out.println("dateRange1 "+dateRange1+" dateRange2 "+dateRange2);
			
			
			//ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/js");
			ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/re");
			ArrayList outputList = new ArrayList();
			ResultSet rs =null;
				rs = manageSalesAnalysis.getCompleteSalesAnalysis(dateRange1,dateRange2);
				
			if(rs.next())
			{	float count=0;
				System.out.println("data available in breakdown header ...");
				do{		
					SalesAnalysisReportOutputBean analysisReportOutputBean = new SalesAnalysisReportOutputBean();
					analysisReportOutputBean.setCustomerName(rs.getString(1));
					analysisReportOutputBean.setBulding(rs.getString(2));
					analysisReportOutputBean.setStation(rs.getString(3));
					analysisReportOutputBean.setItemGroupDesc(rs.getString(4));
					analysisReportOutputBean.setFMCG_IND(rs.getInt(5));
					analysisReportOutputBean.setItemName(rs.getString(6));
					//analysisReportOutputBean.setOrderNo("<a href=\"javascript:passVar(\'"+rs.getString(7)+"\');\">"+rs.getString(7)+" </a>");
					analysisReportOutputBean.setOrderNo(rs.getInt(7));
					analysisReportOutputBean.setOrderNo1(rs.getInt(7)); 
					analysisReportOutputBean.setOrderDate(rs.getString(8));
					analysisReportOutputBean.setTotalValueDiscount(rs.getFloat(9));
					analysisReportOutputBean.setQuantity(rs.getInt(10));
					analysisReportOutputBean.setPrice(rs.getFloat(11));
					
					analysisReportOutputBean.setItemDiscount(rs.getFloat(12));
					count+= Float.parseFloat(rs.getString(11));	 
					analysisReportOutputBean.setSiteName(rs.getString(13));
					//System.out.println("data available in breakdown header ..."+i);
										
					outputList.add(analysisReportOutputBean); 
				}while(rs.next());
				System.out.println("total price "+count);
			} else {
				System.out.println("no data available ...");
			}
			manageSalesAnalysis.closeAll();
			
		
      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");
      out.print(new Gson().toJson(outputList) );
      out.write('\n');
      out.write('	');
      out.write('	');

		} 
			
		else if (call_option.equals("brekdown_details"))
		{
			System.out.println("breakdown details block....");
			int brekdown_number = Integer.parseInt(request.getParameter("bd_number"));
			//ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/js");
			ManageBreakdown manageBreakdown = new ManageBreakdown("jdbc/re");
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
			}
						
		}
		else if (call_option.equals("suggestedOrderNumberList")){
			ManageSalesAnalysis manageSalesAnalysis = new ManageSalesAnalysis("jdbc/re");
			System.out.println(" suggested order list ");
			String orderNum = request.getParameter("orderNum");
			ResultSet rs = manageSalesAnalysis.getSalesAnalysis(orderNum);
			ArrayList<SalesAnalysisReportOutputBean>  outputList = new ArrayList();
			while(rs.next()){
				SalesAnalysisReportOutputBean analysisReportOutputBean = new SalesAnalysisReportOutputBean();
				analysisReportOutputBean.setCustomerName(rs.getString(1));
				analysisReportOutputBean.setBulding(rs.getString(2));
				analysisReportOutputBean.setStation(rs.getString(3));
				analysisReportOutputBean.setItemGroupDesc(rs.getString(4));
				analysisReportOutputBean.setFMCG_IND(rs.getInt(5));
				analysisReportOutputBean.setItemName(rs.getString(6));
				//analysisReportOutputBean.setOrderNo("<a href=\"javascript:passVar(\'"+rs.getString(7)+"\');\">"+rs.getString(7)+" </a>");
				analysisReportOutputBean.setOrderNo(rs.getInt(7));
				analysisReportOutputBean.setOrderNo1(rs.getInt(7)); 
				analysisReportOutputBean.setOrderDate(rs.getString(8));
				analysisReportOutputBean.setTotalValueDiscount(rs.getFloat(9));
				analysisReportOutputBean.setQuantity(rs.getInt(10));
				analysisReportOutputBean.setPrice(rs.getFloat(11));
				
				analysisReportOutputBean.setItemDiscount(rs.getFloat(12));
				analysisReportOutputBean.setSiteName(rs.getString(13));
				//System.out.println("data available in breakdown header ..."+i);
									
				outputList.add(analysisReportOutputBean); 
				
			}
			manageSalesAnalysis.closeAll();
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
			jsonOutputBean.setOutputData(outputList);
			System.out.print(new Gson().toJson(outputList));
			out.print(new Gson().toJson(outputList));
			
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
