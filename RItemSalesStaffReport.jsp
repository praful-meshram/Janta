
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.ItemBean"%>
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
<%@ page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@ page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@ page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import="net.sf.jasperreports.engine.JasperReport"%>
<%@ page import="net.sf.jasperreports.engine.data.JRXmlDataSource"%>
<%@ page import="net.sf.jasperreports.engine.data.*"%>
<%@ page import="net.sf.jasperreports.engine.JRParameter"%>
<%@ page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.export.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@ page import="java.util.Hashtable"%>
<%@ page errorPage="ReportErrorPage.jsp?page=RSalesStaffReport.jsp" %>
<%
	String type = request.getParameter("type");
	if (type.equals("searchItem")) {
		String selItem = request.getParameter("serachItem");
		//item.ManageItem mi = new item.ManageItem("jdbc/js");
		item.ManageItem mi = new item.ManageItem("jdbc/re");
		mi.ItemList(selItem);	
		ArrayList<ItemBean> listOuItemBeans = new ArrayList();
		while(mi.rs.next()) {
			String item_code, item_name, item_weight, item_rate, item_mrp;
			item_code = mi.rs.getString(1);
			item_name = mi.rs.getString(2);
			item_weight = mi.rs.getString(3);
			item_rate = mi.rs.getString(4);
			item_mrp = mi.rs.getString(5);
			
			ItemBean outputBean = new ItemBean();
			outputBean.setI_code(item_code);
			outputBean.setI_name("<a  href=\"Javascript:checkField('"+item_code+"')\"> "+item_name+"</a>");
			outputBean.setI_weight(item_weight);
			outputBean.setI_rate(Float.parseFloat(item_rate));
			outputBean.setI_mrp(Float.parseFloat(item_mrp));
			listOuItemBeans.add(outputBean); 
		
		}
		
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		jsonOutputBean.setOutputData(listOuItemBeans);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Code","i_code"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Item Name","i_name"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Weight","i_weight"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Rate","i_rate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("MRP","i_mrp"));
		
		System.out.print(new Gson().toJson(jsonOutputBean));
		out.print(new Gson().toJson(jsonOutputBean));

	}
	else if (type.equals("pdf")) {

		String frmDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		System.out.println("frmDate  :" + frmDate);
		System.out.println("toDate  :" + toDate);
		String selUeser = request.getParameter("selUeser");
		String selItem = request.getParameter("selItem");
		String Criteria = request.getParameter("Criteria");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String outputfile = "";
		try {
			Context envContext = (Context) new InitialContext()
					.lookup("java:comp/env");
			String pathForReport = (String) envContext
					.lookup("Reports");
			String pathForPDF = (String) envContext.lookup("pdffiles");
			pathForReport = (String) envContext.lookup("Reports")
					+ "//RItemSalesStaffReport.jrxml";
			pathForPDF = (String) envContext.lookup("pdffiles")
					+ "//RItemSalesStaffReport.pdf";
			;

			pathForPDF = config.getServletContext().getRealPath(
					pathForPDF);
			pathForReport = config.getServletContext().getRealPath(
					pathForReport);

			//pathforpdf = session.getAttribute("pdfid").toString()+".pdf";

			System.out.println("pathforpdf  :" + pathForPDF);
			System.out.println("reportpath  :" + pathForReport);

			Statement stmt1;
			JasperReport jasperReport;
			JasperPrint jasperPrint;
			JRResultSetDataSource obj;
			ResultSet rs3;
			String i, j;
			try {
				conn = ((DataSource) (((Context) (new InitialContext()
						.lookup("java:/comp/env"))).lookup("jdbc/js")))
						.getConnection();
				stmt1 = conn.createStatement();
				String query = "select o.enterd_by,concat(it.item_name,',',it.item_weight) as item_name,o.order_num,o.order_date,"
						+ " od.item_code,od.qty, od.price, od.item_discount, od.remark"
						+ " from orders o,order_detail od,item_master it ";
				if (!selUeser.equals("all")) {
					query = query + " where o.enterd_by = '" + selUeser
							+ "'";
				} else {
					query = query + " where 1=1";
				}
				if (!selItem.equals("all")) {
					query = query + " and od.item_code = '" + selItem
							+ "'";
				}

				if(frmDate!=null)
					query = query + " and o.order_date between '"+ Date.valueOf(frmDate.replace("/", "-"))+ "' and '"+ Date.valueOf(toDate.replace("/", "-"))+ "'";
				
				query += " and o.order_num = od.order_num"
						+ " and it.item_code = od.item_code"
						+ " order by  o.enterd_by,it.item_name,o.order_num,"
						+ " o.order_date, od.item_code,"
						+ " od.qty, od.price, od.item_discount, od.remark";
				System.out.println(query);
				rs3 = stmt1.executeQuery(query);

				Hashtable HT = new Hashtable();
				HT.put("ParaQuery", query);
				HT.put("Criteria", Criteria);
				obj = new JRResultSetDataSource(rs3);

				System.out.println("--- load xml ---");
				JasperDesign jasperDesign = JRXmlLoader
						.load(pathForReport);
				System.out.println("--- Compile Report ---");
				jasperReport = JasperCompileManager
						.compileReport(jasperDesign);
				System.out.println("--- Fill Report ---");
				jasperPrint = JasperFillManager.fillReport(
						jasperReport, HT, obj);
				System.out.println("--- Export Report ---");
				JasperExportManager.exportReportToPdfFile(jasperPrint,
						pathForPDF);
				System.out.println("Complete");
				conn.close();
%>
<iframe src="./pdffiles/RItemSalesStaffReport.pdf" scrolling="auto"
	width="100%" height="100%" frameborder="0"></iframe>
<%
	} catch (Exception e) {

				System.out.println("Error in getBillsPdf page=" + e);
%>
Error!!
<%
	}
			//out.println(pathForPDF); //System.out.println("Output Path"+outputfile);
		} catch (Exception e) {
			System.out.println("exception = " + e);
		}
	}
%>
