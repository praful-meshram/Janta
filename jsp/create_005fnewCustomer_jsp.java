package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;

public final class create_005fnewCustomer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	try{
		String custCode="";
		String custName="";
		String phoneNo="";
		String building="";
		String block="";
		String wing="";
		String add1="";
		String add2="";
		String area="";
		String pinCode="";
		String city="";
		String state="";
		String country="";
		String query="";
		String query1="";
		String get1="";
		int cusCode=0;
		custName=request.getParameter("cusName");
		phoneNo=request.getParameter("phone");
		building=request.getParameter("building");
		
		block=request.getParameter("block");
		wing=request.getParameter("wing");
		add1=request.getParameter("add1");
		add2=request.getParameter("add2");
		area=request.getParameter("area");
		pinCode=request.getParameter("pinCode");
		city=request.getParameter("city");
		state=request.getParameter("state");
		country=request.getParameter("country");
		query="select value from code_table where code='CustCodeStart'";
		
		                                                                   
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
    	Statement stat=conn.createStatement();
    	ResultSet rs=stat.executeQuery(query);
    	if(rs.next()){
			custCode=rs.getString(1);
			get1=custCode;
			
		}
		query="select value from code_table where code='NextCustCode'";	
	    rs=stat.executeQuery(query);
		if(rs.next()){
			cusCode=Integer.parseInt(rs.getString(1));
				get1=get1+Integer.toString(cusCode);		
		}
		cusCode=cusCode+1;
		query1="insert into customer_master values('"+get1+"','"+custName+"','"+building+"','"+block+"','"+wing+"','"+add1+"','"+add2+"','','"+area+"','"+city+"','"+state+"','"+country+"','"+pinCode+"','"+phoneNo+"','','',now(),now(),1,'','','','','','','','','M','')"; 
    	stat.execute(query1);
    	query="update code_table set value='" +cusCode+ "'where code='NextCustCode'";
    	stat.executeUpdate(query);   
    	rs.close();		
    	stat.close();
    	conn.close();
    }catch(Exception e)
    {
    }	

      out.write("    \t\r\n");
      out.write("    \t");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
