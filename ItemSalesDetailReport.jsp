
<%@page import="report.ItemSalesDetailReport"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reportbeans.ItemSalesReportBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="report.ItemSalesSummaryReport"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
	System.out.println("In Report..1");

	SimpleDateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat dateformat1 = new SimpleDateFormat("yyyy-MM-dd");
	String frdate= request.getParameter("fromDate");
	String todt= request.getParameter("toDate");
	Date frmDate = (Date)dateformat.parse(frdate);
	Date tDate = (Date)dateformat.parse(todt);
	String fromDate= dateformat1.format(frmDate);
	String toDate= dateformat1.format(tDate);
	String groupCode=request.getParameter("grpCode");
	String itemName=request.getParameter("item");
	if(itemName==""){
		itemName="NotSelected";
	}
	Connection conn=null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	String outputfile="";
	System.out.println("In Report..2");
	try{
		Context envContext = (Context) new InitialContext().lookup("java:comp/env");
		String pathForReport= (String) envContext.lookup("Reports");
		String pathForPDF= (String) envContext.lookup("pdffiles");
		pathForPDF=request.getSession().getServletContext().getRealPath(pathForPDF);
		pathForReport=request.getSession().getServletContext().getRealPath(pathForReport);
		ItemSalesDetailReport objmItemSalesDetailReport = new ItemSalesDetailReport();
		ArrayList<ItemSalesReportBean> objmItemSalesReportBean = new ArrayList<ItemSalesReportBean>();
		objmItemSalesReportBean = objmItemSalesDetailReport.getList(fromDate,toDate,groupCode,itemName);
		System.out.println("In Report..32");
		objmItemSalesDetailReport.MainMethod(objmItemSalesReportBean,pathForReport,fromDate,toDate,groupCode,itemName,pathForPDF);
		outputfile=pathForPDF+System.getProperty("file.separator")+"ItemSalesDetailReport.pdf";;
		out.println(outputfile);
		System.out.println("In Report..33");
		
	}catch (Exception e){
		System.out.println("exception = "+e);
	}
	System.out.println("In Report..4");
%>
<iframe src="./pdffiles/ItemSalesDetailReport.pdf" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe> 