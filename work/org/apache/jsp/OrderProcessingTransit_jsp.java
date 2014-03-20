/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-27 07:46:03 UTC
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

public final class OrderProcessingTransit_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=OrderProcessingTransit.jsp", true, 8192, true);
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
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write('\n');
      out.write('\n');

	 String[] orderno ; 
	 String orderStr="";	
 	 orderStr = request.getParameter("horderArray");
 	 orderno = orderStr.split(","); 
 	 		
 	 String[] orderComm ; 
	 String orderCommStr="";	
 	 orderCommStr = request.getParameter("hcommArray");
 	// System.out.println(" orderCommStr "+orderCommStr);
 	 orderComm = orderCommStr.split(","); 
 	//  System.out.println("  orderComm "+ orderComm);
 	 
 	String subType=request.getParameter("subType");
 	 String[] changeArray ; 
 	 String changeStr="";	
     changeStr=request.getParameter("hchangeArray"); 
     changeArray = changeStr.split(","); 
      
     
     
     
     String d_code="";	
     d_code=request.getParameter("hd_staff"); 
   	 System.out.println(" d_code :"+ d_code);
   	 System.out.println("  orderComm "+ orderCommStr);
     System.out.println("  subType "+ subType);
     System.out.println("  hchangeArray "+ changeStr);
     System.out.println("  horderArray "+ orderStr);
   
     float comm =0.0f;
 	 int deliveryBalance=0,success=0;
 	 Connection conn=null;
	 Statement stmt=null;	
	 order.ManageOrder mo;
	 mo = new order.ManageOrder("jdbc/js");       	
 	 try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			
		
		
			for(int i=0; i < orderno.length;i++){
			    int ordno = Integer.parseInt(orderno[i]);
			   // System.out.println("ordno"+ordno);
			     			 
				float paid = Float.parseFloat(changeArray[i]);	
				mo.updateOrderHistory(ordno,"Delivery Done",0);
				String query = "SELECT payment_type_code FROM orders where order_num = "+orderno[i];
				ResultSet rs1 = stmt.executeQuery(query);
				System.out.print("Getting Payment Type : "+query);
				rs1.next();
				String updSql="";
				if(!rs1.getString(1).equals("CR")){
					updSql="update orders set status_code='DELIVERED', "+
							"paid_amt='"+paid+"', del_datetime=now(),lastmodifieddate=now(), " +
							"action='Delivery Done', balance_amt = 0 where order_num='"+orderno[i]+"'";
				} else {
					updSql="update orders set status_code='DELIVERED', "+
							"paid_amt='"+paid+"', del_datetime=now(),lastmodifieddate=now(), " +
							"action='Delivery Done' where order_num='"+orderno[i]+"'";
				}
					System.out.println("\n update sql "+updSql);
				   int run_sql = stmt.executeUpdate(updSql); 
					if (run_sql==1){ 
						success=1;
						
						for(int k=0; k<orderComm.length;k=k+2){
						  int ord = Integer.parseInt(orderComm[k]);
						 // System.out.println("ordComm"+ord);
						  
							if( ord == ordno){
								int p = k +1;
								comm = Float.parseFloat(orderComm[p]);
								//System.out.println("comm"+comm);
								break;
							}
						}
						mo.setOrderCommission(ordno,d_code,comm,"ADD");
						//System.out.println("Done");
				
          			}
			}					
		
		stmt.close();
		conn.close();
		mo.closeAll();
		}catch (Exception e) {
			System.out.println("Exception occured in OrderProcessingTransit.jsp");
			e.getMessage();
			e.printStackTrace();	
			conn.close();
			mo.closeAll();			
		}
 		 if(success==1){			

      out.write("\n");
      out.write("             \n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("TrackingForm.jsp" + (("TrackingForm.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("Exp", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("0", request.getCharacterEncoding()));
        return;
      }
      out.write("\n");
      out.write("\t\t\t\t\n");

			}
			else if(success==0){

      out.write("  \n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("TrackingForm.jsp?subValue=<%=subType%>");
        return;
      }
      out.write('\n');

			}

      out.write("\n");
      out.write(" <input type=\"hidden\" name=\"hcountorder\" value=\"1\">\t \n");
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
