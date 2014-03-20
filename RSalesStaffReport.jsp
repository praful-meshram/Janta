
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.jasperreports.engine.JRException"%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.design.JasperDesign" %>
<%@ page import="net.sf.jasperreports.engine.xml.JRXmlLoader" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.data.JRXmlDataSource"%>
<%@ page import="net.sf.jasperreports.engine.data.*"%>
<%@ page import="net.sf.jasperreports.engine.JRParameter" %>
<%@ page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.export.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="net.sf.jasperreports.engine.JREmptyDataSource" %>
<%@ page import="java.util.Hashtable" %>

<%@ page errorPage="ReportErrorPage.jsp?page=RSalesStaffReport.jsp" %>

<%
	//SimpleDateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
	//SimpleDateFormat dateformat1 = new SimpleDateFormat("yyyy-mm-dd");
	String frmDate= request.getParameter("fromDate");
	String toDate= request.getParameter("toDate");	
	String selUeser=request.getParameter("selUeser");	
	//String frmDate= dateformat1.format(frdate);
	//String toDate= dateformat1.format(todt);

	String Criteria=request.getParameter("Criteria");;
	Connection conn=null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	String outputfile="";
	try{
		Context envContext = (Context) new InitialContext().lookup("java:comp/env");
		String pathForReport= (String) envContext.lookup("Reports");
		String pathForPDF= (String) envContext.lookup("pdffiles");
		pathForReport=(String) envContext.lookup("Reports")+"//RSalesStaffReport.jrxml";
		pathForPDF=	(String) envContext.lookup("pdffiles")+"//RSalesStaffReport.pdf";;
			
		pathForPDF=config.getServletContext().getRealPath(pathForPDF);	
		pathForReport = config.getServletContext().getRealPath(pathForReport);	
	
		//pathforpdf = session.getAttribute("pdfid").toString()+".pdf";
		System.out.println("Criteria  :"+Criteria);
		System.out.println("pathforpdf  :"+pathForPDF);	
		System.out.println("reportpath  :"+pathForReport);
		System.out.println("frmDate "+frmDate);
		
		
		Statement stmt1;		
		JasperReport jasperReport;
		JasperPrint jasperPrint;
		JRResultSetDataSource obj;
		ResultSet rs3;
		String i,j;
		try{
			//conn =((DataSource)(((Context)(new InitialContext().lookup("java:/comp/env"))).lookup("jdbc/js"))).getConnection();
			conn =((DataSource)(((Context)(new InitialContext().lookup("java:/comp/env"))).lookup("jdbc/re"))).getConnection();
			stmt1=conn.createStatement();
			String query="select o.enterd_by,concat(it.item_name,',',it.item_weight) as item_name,o.order_num,o.order_date,"+
					" od.item_code,od.qty, od.price, od.item_discount, od.remark" +
					" from orders o,order_detail od,item_master it ";
			if(!selUeser.equals("all")){
				query = query + " where o.enterd_by = '" +selUeser+"'";
			}else{
				query = query + " where 1=1";
			}
					
			if(frmDate!=null){
				//query = query + " and o.order_date between '"+frmDate+"' and '"+toDate+"'";
				query = query + " and date_format(o.order_date,'%Y-%m-%d') between '"+Date.valueOf(frmDate.replace("/","-"))+"' and '"+Date.valueOf(toDate.replace("/","-"))+"'";
				
			}
			
			query+=" and o.order_num = od.order_num"+
					" and it.item_code = od.item_code"+
					" order by  o.enterd_by,it.item_name,o.order_num,"+
					" o.order_date, od.item_code,"+
					" od.qty, od.price, od.item_discount, od.remark ";
			System.out.println(query);
			rs3=stmt1.executeQuery(query);
			
			Hashtable HT = new Hashtable();
			HT.put("ParaQuery",query);
			HT.put("Criteria",Criteria);			
			obj = new JRResultSetDataSource(rs3);			
			
			System.out.println("--- load xml ---");
			JasperDesign jasperDesign = JRXmlLoader.load(pathForReport);
			System.out.println("--- Compile Report ---");
			jasperReport = JasperCompileManager.compileReport(jasperDesign);
			System.out.println("--- Fill Report ---");	
			jasperPrint = JasperFillManager.fillReport(jasperReport, HT, obj);
			System.out.println("--- Export Report ---");
			JasperExportManager.exportReportToPdfFile(jasperPrint, pathForPDF);
			System.out.println("Complete");
			conn.close();
%>
<iframe src="./pdffiles/RSalesStaffReport.pdf" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
<%		
}
catch(Exception e){
	
	System.out.println("Error in getBillsPdf page="+ e);
%>
Error!!
<%
}
//out.println(pathForPDF); //System.out.println("Output Path"+outputfile);
}catch (Exception e){ System.out.println("exception = "+e); } %>
