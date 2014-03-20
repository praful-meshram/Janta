package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class LoginForm_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write(" \r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("<!--\r\n");

	String errMsg="";
	errMsg=request.getParameter("Exp");

      out.write("\r\n");
      out.write("     \r\n");
      out.write("\tvar jExp=");
      out.print(errMsg);
      out.write("\r\n");
      out.write("       \r\n");
      out.write("\tfunction trimString(str){\r\n");
      out.write("    \treturn str.replace(/^\\s+|\\s+$/g, '');\r\n");
      out.write("  \t}\r\n");
      out.write("\r\n");
      out.write("\tfunction validateString(field, errmsg, lenmsg, min, max, required) { \r\n");
      out.write("\t\tif (!field.value && !required){\r\n");
      out.write("\t\t\treturn true;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tif (!field.value){\r\n");
      out.write("\t   \t\talert(errmsg);\r\n");
      out.write("\t   \t\tfield.focus(); \r\n");
      out.write("\t   \t\tfield.select(); \t\t\t  \r\n");
      out.write("\t   \t\treturn false;\r\n");
      out.write("\t\t }\r\n");
      out.write("\t\r\n");
      out.write("\t\tif (trimString(field.value).length < min || field.value.length > max){\r\n");
      out.write("\t   \t\talert(lenmsg);\r\n");
      out.write("\t   \t\tfield.focus(); \r\n");
      out.write("\t   \t\tfield.select(); \r\n");
      out.write("\t   \t\treturn false;\r\n");
      out.write("\t   \t}\r\n");
      out.write("\t\treturn true; \r\n");
      out.write("     \r\n");
      out.write("\t}\r\n");
      out.write("\tfunction validateOnload(){\r\n");
      out.write("\tvar jExp=");
      out.print(errMsg);
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \t\tif(jExp==1){\r\n");
      out.write("   \t\t\talert(\"Enter correct name and password\")\r\n");
      out.write("  \t\t}\r\n");
      out.write("   \t\telse if(jExp==2){\r\n");
      out.write("  \t\t\talert(\"You are not activated yet\")\r\n");
      out.write("  \t\t}\r\n");
      out.write(" \t \telse if(jExp==3){\r\n");
      out.write("  \t\t\talert(\"Your Date has been expired\")\r\n");
      out.write("  \t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("//-->\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<form method=\"post\" name=\"LoginForm\" action=\"Login.jsp\"  onSubmit=\"return (validateString(this.username, 'Please enter your name', 'Name must be between 3 and 20 characters', 3, 20, true) && validateString(this.password,'Enter Password','password length should be 6 char or more',6,32,true));\">\r\n");
      out.write(" <br><br><br><br> \r\n");
      out.write(" <center>\r\n");
      out.write(" <table>\r\n");
      out.write("  \r\n");
      out.write("\t<tr>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("  \t\t<td colSpan=3 >User Name</td>\r\n");
      out.write("    \t</td>\r\n");
      out.write("\t\t<td colSpan=2 ><INPUT name=\"username\" accesskey=\"u\" maxlength=\"100\" value=\"\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t </td>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("\t\t<td colSpan=3 > Password</td>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td colSpan=2 ><INPUT TYPE=password name=\"password\" maxlength=\"32\" accesskey=\"p\"value=\"\"> </td>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("  \t</tr>\r\n");
      out.write("  \t<tr>\r\n");
      out.write("\t\t<td colSpan=3 > </td>\r\n");
      out.write("    \t</td>\r\n");
      out.write("\t\t<td colSpan=2 > <INPUT TYPE=image image src=\"images/submit.gif\" name=\"submit\"> </td>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("  \t</tr>\r\n");
      out.write(" </table>\r\n");
      out.write("</center>\r\n");
      out.write("</form>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("<!--\r\n");
      out.write("validateOnload();\r\n");
      out.write("document.LoginForm.username.focus();\r\n");
      out.write("//-->\t\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
