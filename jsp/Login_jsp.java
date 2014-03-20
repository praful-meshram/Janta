package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class Login_jsp extends org.apache.jasper.runtime.HttpJspBase
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

 String nextPage = "Main.jsp"; 
      out.write('\r');
      out.write('\n');
      user.Login idHandler = null;
      synchronized (request) {
        idHandler = (user.Login) _jspx_page_context.getAttribute("idHandler", PageContext.REQUEST_SCOPE);
        if (idHandler == null){
          idHandler = new user.Login();
          _jspx_page_context.setAttribute("idHandler", idHandler, PageContext.REQUEST_SCOPE);
          out.write('\r');
          out.write('\n');
          org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("idHandler"), request);
          out.write('\r');
          out.write('\n');
        }
      }
      out.write("\r\n");
      out.write("\r\n");

	String str="";
	str=request.getParameter("Log");
	if(str==null){
	str="";
	}
  
	if(str.equals("1")){
		boolean ses; 
		ses=idHandler.logOff(request);
		if(ses==true){

      out.write("\r\n");
      out.write("\t\t");
      if (true) {
        _jspx_page_context.forward("LoginForm.jsp");
        return;
      }
      out.write("\r\n");
      out.write("\r\n");

		}
	}
	else {
		String auth,retauthval="5";
   		int  lenauth;

   		auth = idHandler.authenticate(request.getParameter("username"),request.getParameter("password"),request);
   		lenauth = auth.length() ;
   		retauthval = auth.substring(0,1);
   
   		if (retauthval.equals("1")) {

      out.write("\r\n");
      out.write("\t\t");
      if (true) {
        _jspx_page_context.forward( nextPage);
        return;
      }
      out.write('\r');
      out.write('\n');

		
    	}  
    	else if(retauthval.equals("2")) {

      out.write("\r\n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("LoginForm.jsp?Exp=2");
        return;
      }
      out.write("\r\n");
      out.write("        \r\n");
              
		}
        else if(retauthval.equals("3")) {

      out.write("\r\n");
      out.write("        \r\n");
      out.write("\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("LoginForm.jsp?Exp=3");
        return;
      }
      out.write("  \r\n");
 
		}
   		else {

      out.write("\r\n");
      out.write("\t\t\t\t\t");
      if (true) {
        _jspx_page_context.forward("LoginForm.jsp?Exp=1");
        return;
      }
      out.write('\r');
      out.write('\n');

   		}
	}

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
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
