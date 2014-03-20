package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;

public final class customer_005fdetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");

	try{
		String name="";
    	String phone="";
    	String building="";
    	String block="";
    	String wing="";
    	String add1="";
    	String add2="";
    	String custCode="";
    	String nameString="";
		name=request.getParameter("nameStartWith");
		phone=request.getParameter("phStartWith"); 
		building=request.getParameter("bldgStartWith");
		block=request.getParameter("blockStartWith");
		wing=request.getParameter("wingStartWith");
		add1=request.getParameter("add1StartWith");
		add2=request.getParameter("add2StartWith");
		custCode=request.getParameter("custCodeStartWith");
		nameString=request.getParameter("nameStringStartWith");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
    	Statement stat=conn.createStatement();
    	String query="";
    	query="select custname,phone,building,block,wing,add1,add2,custcode from customer_master where 1=1 ";
    	
    	if(name!=null){
    		query = query + " and custname like'" + name + "%'";
    	}
		if(phone!=null){
    		query = query + " and phone like'" + phone + "%'";
    	}
    	
		if(building!=null){
    		query = query + " and building like'" + building + "%'";
    	}
    	
		if(block!=null){
    		query = query + " and block like'" + block + "%'";
    	}
		if(wing!=null){
			query = query + " and wing like'" + wing + "%'";
		}
    	
		if(add1!=null){
    		query = query + " and add1 like'" + add1 + "%'";
    	}
    	
		if(add2!=null){
			query = query + " and add2 like'" + add2 + "%'";
    	}
    	if(custCode!=null){
    		query = query + "and custcode like'" + custCode + "%'";
    	}
    	if(nameString!=null){
    		query = query + "and custname like'%"+ nameString + "%'";
    	}	 	

      out.write("\r\n");
      out.write("       <table border=\"1\" name=\"t\">\r\n");
      out.write("       \r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t<td  name=\"custcode\"><b>CustCode</b></td>\r\n");
      out.write("\t\t<td><b>CustName</b></td>\r\n");
      out.write("\t\t<td><b>Phone</b></td>\r\n");
      out.write("\t\t<td><b>Building</b></td>\r\n");
      out.write("\t\t<td><b>Block</b></td>\r\n");
      out.write("\t\t<td><b>Wing</b></td>\r\n");
      out.write("\t\t<td><b>Add1</b></td>\r\n");
      out.write("\t\t<td><b>Add2</b></td>\r\n");
      out.write("          </tr>\r\n");
		    	
		ResultSet rs=stat.executeQuery(query);
    	while(rs.next()) {
 
      out.write("\r\n");
      out.write("\t\t\t<tr >\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t\t<td><a  href=\"cust_orderBill.jsp?name=");
      out.print(rs.getString(1));
      out.write("&tele=");
      out.print(rs.getString(2));
      out.write("&bldg=");
      out.print(rs.getString(3));
      out.write("&block=");
      out.print(rs.getString(4));
      out.write("&wing=");
      out.print(rs.getString(5));
      out.write("&add1=");
      out.print(rs.getString(6));
      out.write("&add2=");
      out.print(rs.getString(7));
      out.write("&cuscode=");
      out.print(rs.getString(8));
      out.write("\"  >\t\r\n");
 
            
    		out.println(rs.getString(8));

      out.write("\r\n");
      out.write("    \t \t</a></td><td>\r\n");
      out.write("    \t\t\t\r\n");
			
			out.println(rs.getString(1));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
			
			out.println(rs.getString(2));

      out.write("       \r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
           	out.println(rs.getString(3));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
           	out.println(rs.getString(4));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
			out.println(rs.getString(5));

      out.write("\r\n");
      out.write("\t\t\t</td><td>\r\n");
	
			out.println(rs.getString(6));

      out.write("\r\n");
      out.write("        \t</td><td>\r\n");

			out.println(rs.getString(7));

      out.write("\r\n");
      out.write("\t\t\t</td></tr>\t\t\t        \t  \r\n");
			    
		}
		rs.close();
		stat.close();
		conn.close();

      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("a:link {color: blue}\r\n");
      out.write("a:hover {background: blue;color: white}\r\n");
      out.write("a:active {background: blue;color: white}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
							
	}catch(Exception e){
	}		

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("      \tdocument.myform.custcode.focus();\r\n");
      out.write(" </script>");
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
