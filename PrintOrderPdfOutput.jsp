<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperPrintManager"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<head>
	<title>Print Bill</title>
	<script type="text/javascript">
	window.onload=function(){
		self.focus();
 
	}
</script>
</head>
<table id="table" width="90%" height="100%" align="center">
	<tr>
		<td height="100%">
  			<iframe id="frame1" name="frame1"  src="Print/reportPrintTitle.pdf"  width="90%" height="650" frameborder="0"></iframe>
  			
  		</td>
  </tr>
</table>
	
<% 
	/* JasperPrint jasperPrint = (JasperPrint)request.getAttribute("jasperPrint");
	String outputfile = request.getParameter("outputfile");
	System.out.print("outputfile "+outputfile+"###");
	//JasperPrintManager.printReport(outputfile , true);
	JasperPrintManager.printReport(jasperPrint, true);  */
%> 
