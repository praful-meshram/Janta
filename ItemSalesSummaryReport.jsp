
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
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
	SimpleDateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat dateformat1 = new SimpleDateFormat("yyyy-MM-dd");
	
	System.out.println(dateformat);

	String frdate= request.getParameter("fromDate");
	String todt= request.getParameter("toDate");
	Date frmDate = (Date)dateformat.parse(frdate);
	Date tDate = (Date)dateformat.parse(todt);
	String groupCode=request.getParameter("grpCode");
	String itemName=request.getParameter("item");
	
	System.out.println("group code "+groupCode+" item name "+itemName);
	
	String fromDate= dateformat1.format(frmDate);
	String toDate= dateformat1.format(tDate);
	
	if(itemName==""){
		itemName="NotSelected";
	}
	Connection conn=null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	String outputfile="";
	try{
		Context envContext = (Context) new InitialContext().lookup("java:comp/env");
		String pathForReport= (String) envContext.lookup("Reports");
		String pathForPDF= (String) envContext.lookup("pdffiles");
		pathForReport=request.getSession().getServletContext().getRealPath(pathForReport);
		pathForPDF=request.getSession().getServletContext().getRealPath(pathForPDF);
		
		ItemSalesSummaryReport objmItemSalesSummaryReport = new ItemSalesSummaryReport();
		ArrayList<ItemSalesReportBean> objmItemSalesReportBean = new ArrayList<ItemSalesReportBean>();
		objmItemSalesReportBean = objmItemSalesSummaryReport.getList(fromDate,toDate,groupCode,itemName);
		objmItemSalesSummaryReport.MainMethod(objmItemSalesReportBean,pathForReport,fromDate,toDate,groupCode,itemName,pathForPDF);
		
		//Context initContext = new InitialContext();
		outputfile=pathForPDF+System.getProperty("file.separator")+"ItemSalesSummaryReport.pdf";;
		out.println(outputfile);
		//System.out.println("\nOutput Path"+outputfile);
	}catch (Exception e){
		System.out.println("exception = "+e);
	}
%>
<jsp:forward page="ItemSalesSummaryReportView.jsp">
<jsp:param value="<%=outputfile %>" name="outputfile"/>
</jsp:forward>