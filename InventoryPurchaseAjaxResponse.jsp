<%@page import="com.tutorialspoint.DataBean"%>
<%@page import="com.tutorialspoint.DataBeanList"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
<%@page import="com.tutorialspoint.CreateReport"%>
<%@page import="java.util.Vector"%>
<%@page import="outputbean.PurchaseInventoryJasperBean"%>
<%@page import="net.sf.jasperreports.engine.JRDataSourceProvider"%>
<%@page import="net.sf.jasperreports.engine.JRDataSource"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanArrayDataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="outputbean.ItemPurchaseInventoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="inventory.PurchaseInventoryDetail"%>
<%
	String ajaxCall = request.getParameter("ajaxCall");
	System.out.println("in if 11 "+ajaxCall);
	if(ajaxCall.equals("vendorList")){
		System.out.println("in if 122 ");
		PurchaseInventoryDetail purchaseInventoryDetail = new PurchaseInventoryDetail();
		Hashtable<Integer, String> vendorList = purchaseInventoryDetail.getVendorList();
		System.out.println("hash size  "+vendorList.size());
		%>
		<select id='vendorNameList'>
			<option value="">All</option>
			<%
			
				Enumeration keys = vendorList.keys();
				
				while(keys.hasMoreElements()){
					Integer key = (Integer)keys.nextElement();
					String vendorName = vendorList.get(key); 
					%>
					<option value="<%=key%>"><%=vendorName%></option>
					<%
				}
			%>
		</select>
		<%
		
	}else if(ajaxCall.equals("purchaseDetails")){
	
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	String vendorID = request.getParameter("vendorId");
	
	PurchaseInventoryDetail purchaseInventoryDetail = new PurchaseInventoryDetail();
	//Vector listOutPutBean  = purchaseInventoryDetail.getPurchaseInventoryDetailsIReportDataSource(vendorID, fromDate, toDate);
	//ArrayList<ItemPurchaseInventoryBean> listOutPutBean  = purchaseInventoryDetail.getPurchaseInventoryDetailsIReportDataSource()(vendorID, fromDate, toDate);
	ArrayList<PurchaseInventoryJasperBean> listOutPutBean = purchaseInventoryDetail.
			getPurchaseInventoryDetails(vendorID, fromDate, toDate);
	
	Context envContext = (Context) new InitialContext().lookup("java:comp/env");
	String pathForReport= (String) envContext.lookup("jasper");
	pathForReport=session.getServletContext().getRealPath(pathForReport);
	System.out.println("pathForReport1111 "+pathForReport);
	
    String masterReportFileName = pathForReport+System.getProperty("file.separator")+"PurchaseInventoryMasterReport.jrxml";
    String subReportFileName = pathForReport+System.getProperty("file.separator")+"PurchaseInventorySubReportNew.jrxml";
    
    String destFileName = pathForReport+System.getProperty("file.separator")+"jasper_report_template.JRprint";
   
    JRBeanCollectionDataSource beanColDataSource = new JRBeanCollectionDataSource(listOutPutBean);
	System.out.println("before try ..\n"+masterReportFileName+"\n"+subReportFileName);
    try {
       /* Compile the master and sub report */
       JasperReport jasperMasterReport = JasperCompileManager
          .compileReport(masterReportFileName);
       JasperReport jasperSubReport = JasperCompileManager
          .compileReport(subReportFileName);
       
       Map<String, Object> parameters = new HashMap<String, Object>();
       parameters.put("subReportPath", pathForReport+"/");
       System.out.println(" in try ");
       JasperPrint jasperPrint = JasperFillManager.fillReport(jasperMasterReport, parameters, beanColDataSource);
       System.out.println(" in try 1");
       JasperExportManager.exportReportToPdfFile(jasperPrint,pathForReport+System.getProperty("file.separator")+"Demo.pdf");
       System.out.println(" in try11 ");
    } catch (JRException e) {
  		     e.printStackTrace();
    }

 %>
 	<iframe src="<%="Report/SubReport/Demo.pdf"%>" width="100%" height="430px;"></iframe>
 	<%-- <embed type=object src="<%="Report/SubReport/Demo.pdf"%>" width="100%" height="430px;"></embed> --%>
 	<%-- <object classid="" type="application/pdf"
         data="<%="Report/SubReport/Demo.pdf"%>" style="width: 100%; height=100%;">
    <p>Fallback text</p>
</object> --%>
 <%
 System.out.println("Done filling!!! ...");
 	}
%>