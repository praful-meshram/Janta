/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-07 10:36:08 UTC
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

public final class DeliveryDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("DeliveryDetails.jsp", request.getCharacterEncoding()), out, false);
      out.write('\n');
      out.write('\n');
      out.write('\n');

		Connection conn=null;
		Statement stmt=null,stat=null,stat1=null;
		ResultSet rs1=null;	
        String orderNo="";
        String subValue="";
        int deliveryBalance=0,success=0;
	  	subValue=request.getParameter("subValue");  	
  		orderNo=request.getParameter("horderNo");  	  	
  		String status="";
        status=request.getParameter("hstatus");         
        String d_code="";
       	d_code=request.getParameter("d_staff");         	
       	String allowActionValue="";  
       	allowActionValue=request.getParameter("hallowaction");    
       	float change=0.0f;
       	change=Float.valueOf(request.getParameter("change"));       
       	float comm=0.0f;
       	comm=Float.valueOf(request.getParameter("comm"));  
       	int versionNo=0;  
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");       	
       	
       	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			stat = conn.createStatement(); 
			stat1 = conn.createStatement(); 
			
			System.out.println(" allowActionValue :"+allowActionValue);
			
			if(!allowActionValue.equals("Hold")){
				deliveryBalance=deliveryBalance+(int)comm;	
				String query="SELECT status_code FROM orders o where order_num = "+orderNo;						
				ResultSet rs2 = stmt.executeQuery(query); 
				rs2.next();
				System.out.print("Order status : "+rs2.getString(1));
				String status_code = rs2.getString(1);
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);			
				String updSql="update orders set status_code='TRANSIT',dstaff_code='"+d_code+"', "+
				"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
				"action='"+allowActionValue+"' where order_num='"+orderNo+"'";		
				System.out.println(" updSql :"+updSql);
				int run_sql = stmt.executeUpdate(updSql);
				
				if (run_sql==1){ 			
					if(!status_code.equals("CHECKED")){
						query = "select od.item_code, od.qty, od.price_version, o.site_id from order_detail od, orders o "+
							"where o.order_num = od.order_num and od.order_num = '"+orderNo+"'";
						System.out.println("query "+query);
						ResultSet rs = stmt.executeQuery(query);
						int count = 0;
						while(rs.next()){
							Statement st = conn.createStatement();
							String query1 = "update item_master set item_qty = item_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"'";
							System.out.println("Master :"+query1);
							st.executeUpdate(query1);
							query1 = "update item_price set item_pv_qty = item_pv_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"' "+ 
									" and price_version  = "+rs.getInt(3);
							System.out.println("Price :"+query1);
							st.executeUpdate(query1);
							
							/* Inventory already updated while creating order   */
							
							/* 
							query1 = "update item_site_inventory set item_site_qty = item_site_qty - "+rs.getInt(2)+" where item_code = '"+rs.getString(1)+"' "+
									"and price_version  = "+rs.getInt(3)+" and site_id = "+rs.getInt(4);
							System.out.println("Site :"+query1);
							st.executeUpdate(query1);
							
							*/
						}
					}
				}
				
				
			}
			else if(allowActionValue.equals("Hold")){	
				//deliveryBalance=deliveryBalance-(int)comm;
				String updSql="";
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);
				if(!d_code.equals("") ){
					updSql="update orders set status_code='HOLD',dstaff_code='"+d_code+"', "+
					"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
					"action='"+allowActionValue+"' where order_num='"+orderNo+"'";
				}
				else if(d_code.equals("") ){
					updSql="update orders set status_code='HOLD', "+
					"change_amt='"+change+"', sent_datetime= now(), lastmodifieddate= now(), " +
					"action='"+allowActionValue+"' where order_num='"+orderNo+"'";
				}
				int run_sql = stmt.executeUpdate(updSql); 			
					if (run_sql==1) 
						success=1;			
		  	}	
			
			conn.close();
			mo.closeAll();
       	}
		catch (Exception e) {
			conn.close();	
			mo.closeAll();
			System.out.println("Exception occured in DeliveryDetails.jsp");
			e.getMessage();
			e.printStackTrace();				
		}
			if(success==1){			

      out.write("\n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("TrackingForm.jsp" + (("TrackingForm.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("subValue", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(subValue), request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("printdeliver", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(success), request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("ordernum", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(orderNo), request.getCharacterEncoding()));
        return;
      }
      out.write('\n');

			}
			else if(success==0){

      out.write("\n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("TrackingForm.jsp" + (("TrackingForm.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("subValue", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(subValue), request.getCharacterEncoding()));
        return;
      }
      out.write('\n');

			}

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
