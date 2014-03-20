
<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@page import="javax.print.attribute.standard.Copies"%>
<%@page import="javax.print.attribute.PrintRequestAttributeSet"%>
<%@page import="javax.print.attribute.standard.MediaPrintableArea"%>
<%@page import="javax.print.attribute.standard.MediaSizeName"%>
<%@page import="net.sf.jasperreports.engine.export.JRPrintServiceExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPrintServiceExporterParameter"%>
<%@page import="javax.print.attribute.standard.PrinterName"%>
<%@page import="javax.print.attribute.HashPrintServiceAttributeSet"%>
<%@page import="javax.print.attribute.PrintServiceAttributeSet"%>
<%@page import="java.awt.print.PrinterJob"%>
<%@page import="net.sf.jasperreports.engine.print.JRPrinterAWT"%>
<%@page import="javax.print.PrintServiceLookup"%>
<%@page import="net.sf.jasperreports.j2ee.servlets.ImageServlet"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@page import="net.sf.jasperreports.engine.export.HtmlExporter"%>
<%@page import="net.sf.jasperreports.engine.xml.JasperPrintFactory"%>
<%@page import="net.sf.jasperreports.engine.JasperPrintManager"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@page import="beans.PrintOrderDetailsBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="net.sourceforge.barbecue.*"%>
<%@ page import="javax.imageio.ImageIO" %>

<head>
<title>Printing...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
.boldtable, .boldtable TD, .boldtable TH{
	font-family: consolas;
	font-size:10.5pt;
}

.boldtable1, .boldtable1 TD, .boldtable1 TH{
	font-family: consolas;
	font-size:10.5pt;
}

</style>

</head>
<body>
<form name="myform" method="post">
<%				String outputPDFfile=null;
				ArrayList<PrintOrderDetailsBean> listPrintOutputBean = new ArrayList();
				DecimalFormat df = new DecimalFormat("###,###.00");
				DecimalFormat dfQty = new DecimalFormat("0.000");
				DecimalFormat dfQty1 = new DecimalFormat("0");
				String username=(String)session.getAttribute("UserName");		
				String orderDate="";
				String flag="";
				flag= request.getParameter("buttonFlag");
				if (flag==null)
					flag="N";
				int totalItems=0;
				int totalTaken=0;
				int taken_ind=0;
				int itemsPerPage=15;
				int pageItemCount=0;
				int emptyLines=0;
				int  itemQtyCheck=0;
				float totalValue=0.0f;
				String enteredBy="";
				
				float itemRate=0.0f;
				float itemQty=0.0f;
				float itemTotPrice=0.0f;
				float itemMRP=0.0f;
				float totalValueMRP=0.0f;
				float savings=0.0f;
				float totalValueDis=0.0f;
				float itemTotDis=0.0f;
				float adv_amt=0.0f;
				float dis_amt=0.0f;
				float bal_amt=0.0f;
				float other_charges_amt=0.0f;	
				
				String itemName="";
				String itemWeight="";
				String custCode="";
				String custName="";
				String building="";
				String buildingNo="";
				String block="";
				String wing="";
				String add1="";
				String add2="";
				String area="";
				String phone="";
				String codeValue="";
				String categoryCode="";
				String storeName="";
				String storeAdd1="";
				String storePhone="";
				String billMessage="";
				String disRemark="";
				String p_type="";
				String station="";
				String deliveryRemark="";
				
        	    int i=0;
        		String orderNo="";
        		
        		orderNo=request.getParameter("orderNo");   
        		System.out.println("orderNo : "+orderNo);
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
					
			query="select code,value from code_table where code in ('StoreName','StoreAdd1','StorePhone','BILLMSG')";
			System.out.println("code table : "+query);
			rs=stat.executeQuery(query);
			
			while(rs.next())
			{
				categoryCode=rs.getString(1);
				codeValue=rs.getString(2);
									
				if (categoryCode.equals("BILLMSG"))
				{
					billMessage=codeValue;
				}
				
				if (categoryCode.equals("StoreName"))
				{
					storeName=codeValue;
				}
				
				if (categoryCode.equals("StoreAdd1"))
				{
					storeAdd1=codeValue;
				}

				if (categoryCode.equals("StorePhone"))
				{
					storePhone=codeValue;
				}				
				
			}
			rs.close();

			query="select DATE_FORMAT(a.order_date,'%d/%m/%y %r'), a.total_items, a.total_taken, a.total_value, " +
					"a.total_value_mrp, a.enterd_by,a.total_value_discount,a.remark, a.advance_amt, a.discount_amt, a.balance_amt, " + 
					"a.other_charges,b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,e.payment_type_desc, b.item_taken, " + 
				  	"d.item_name, d.item_weight, " +
				  	"c.custcode,c.custname,c.building,c.building_no,c.block,c.wing,c.add1,c.add2,c.phone, c.area, c.station " +
					"from orders a, order_detail b, customer_master c, item_master d ,payment_type e, item_group g " +
					"where a.order_num = b.order_num " +
					"and a.custcode = c.custcode " +
					"and b.item_code = d.item_code " +
					"and a.payment_type_code = e.payment_type_code "+
					"and a.order_num = '" + orderNo + "' "+
					"and g.item_group_code = d.item_group_code "+
					"order by g.item_group_number, b.entry_no";
					
				System.out.println("Print Query 1 :"+query);						
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, itemCount=0;
			  	
			while(rs.next()) {
				PrintOrderDetailsBean printOutputBean = new PrintOrderDetailsBean();
				i=1;
				itemCount=itemCount+1;
				pageItemCount=pageItemCount+1;		
				
				orderDate=rs.getString(i++);
				totalItems=rs.getInt(i++);
				totalTaken=rs.getInt(i++);
				totalValue=rs.getFloat(i++);
				totalValueMRP=rs.getFloat(i++);
				enteredBy=rs.getString(i++);
				totalValueDis=rs.getFloat(i++);
				deliveryRemark=rs.getString(i++);
				adv_amt=rs.getFloat(i++);
				dis_amt=rs.getFloat(i++);				
				bal_amt=rs.getFloat(i++);
				other_charges_amt=rs.getFloat(i++);;
				
				itemRate=rs.getFloat(i++);
				itemQty=rs.getFloat(i);
				itemQtyCheck=rs.getInt(i++);			
					
				itemTotPrice=rs.getFloat(i++);
				itemMRP=rs.getFloat(i++);
				itemTotDis=rs.getFloat(i++);
				disRemark=rs.getString(i++);
				
				p_type=rs.getString(i++);			
				taken_ind=rs.getInt(i++);							
				itemName=rs.getString(i++);
				itemWeight=rs.getString(i++);
				custCode=rs.getString(i++);
				custName=rs.getString(i++);
				building=rs.getString(i++);
				buildingNo=rs.getString(i++);
				block=rs.getString(i++);
				wing=rs.getString(i++);
				add1=rs.getString(i++);
				add2=rs.getString(i++);
				phone=rs.getString(i++);
				area=rs.getString(i++);
				station=rs.getString(i++);
				
				Barcode objBarcode = BarcodeFactory.createCode128C(orderNo+"");//Int2of5
				String ImagePath = (String) envContext.lookup("imagesfile");
				ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+orderNo+".PNG";
				objBarcode.setDrawingText(false);//to avoid display order number under barcode image;
				//System.out.println("ImagePath:"+ImagePath);
				File f = new File(ImagePath);            	
                BarcodeImageHandler.savePNG(objBarcode, f);
                BufferedImage bimg = ImageIO.read(new File(ImagePath)); 
				//printOutputBean.setImage(bimg);
				printOutputBean.setBufferedImage(bimg);
				
				// for page header
				
                
	if (ctr==0) {	
		printOutputBean.setTotalItems(totalItems);
		printOutputBean.setTotalItemsTaken(totalTaken);
		printOutputBean.setTotalItemsRemain(totalItems-totalTaken);
		printOutputBean.setOrderDate(orderDate);
		printOutputBean.setCustCode(custCode);
		printOutputBean.setCustName(custName);
		printOutputBean.setUserName(username);
		printOutputBean.setPhone(phone);
		//printOutputBean.setOrderNo(orderNo);
		
		if(!deliveryRemark.equals("")){
			if(other_charges_amt>0){	
				printOutputBean.setDeliveryRemark("(DI :"+deliveryRemark+")");
				printOutputBean.setOther_charges_amt("(Oth Chrgs:"+other_charges_amt+")");
				System.out.println("\n\n == deliveryRemark111 "+deliveryRemark);
			}else if(other_charges_amt<=0){
				printOutputBean.setDeliveryRemark("(DI :"+deliveryRemark+")");
			}
		}
		else if(deliveryRemark.equals("")){
				if(other_charges_amt>0){
					printOutputBean.setOther_charges_amt("(Oth Chrgs:"+other_charges_amt+")");
				}else if(other_charges_amt<=0){
					printOutputBean.setCustName(custName);
				}
		}
		
		printOutputBean.setAddressLine1(buildingNo+", "+wing+", "+block+", "+building+", "+area);
		printOutputBean.setAddressLine2(add1+", "+add2+", "+station);
		printOutputBean.setOrderNo(orderNo);
		 //ctr = ctr + 1;
		 
	} 
	savings = totalValueMRP - totalValue;
	if(savings<0)
		savings=0.0f;
	
	if ((itemQtyCheck-itemQty)==0)
	{
		printOutputBean.setItemQty((int)itemQty);
	}else {
		printOutputBean.setItemQty((int)itemQty);
	} 
	
	printOutputBean.setItemWeight(itemWeight);
	printOutputBean.setItemName(itemName);
	printOutputBean.setDisRemark(disRemark);
	//System.out.println(bimg+"disRemark111 "+disRemark);
	if(taken_ind > 0) { 
		System.out.print("Taken");
	}else {
		System.out.print(" ");
	}
	printOutputBean.setItemTotPriceToJsPrice(itemTotPrice);
	
	if(itemMRP<=0) { 
		printOutputBean.setItemMRP(0.000f);
	} else { 
		printOutputBean.setItemMRP(itemMRP);
	}
	

if (itemCount==totalItems) {
	emptyLines = itemsPerPage - (totalItems%itemsPerPage);
	
	if (emptyLines > 0) { 
	while ((emptyLines > 0)&&(emptyLines !=itemsPerPage)) { 
		emptyLines=(emptyLines - 1);
		} 
	}
	
	//if (bal_amt == totalValue)
		System.out.println("total val "+totalValue+" "+p_type+"ba "+bal_amt);; 
	if (bal_amt == 0){
		printOutputBean.setTotalValue(totalValue);
		printOutputBean.setP_type(p_type);
	
	} else { 
		printOutputBean.setTotalValue(totalValue);
		printOutputBean.setAdv_amt(adv_amt);
		printOutputBean.setDis_amt(dis_amt);
		printOutputBean.setBal_amt(bal_amt);
		printOutputBean.setP_type(p_type);
	}
	
		printOutputBean.setSavings((savings+" /-").trim());
		} 
	listPrintOutputBean.add(printOutputBean);
	}
		rs.close();
		stat.close();
		conn.close();
	}catch(Exception e)
	{
		System.out.println(""+e);
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}
	System.out.println("backPage :"+request.getParameter("backPage"));
	
	System.out.println("listPrintOutputBean "+listPrintOutputBean.size());
	System.out.println("\n\n == deliveryRemark111 "+deliveryRemark);
		try{
			Context envContext = (Context) new InitialContext().lookup("java:comp/env");
			String pathForReport= (String) envContext.lookup("jrxmlPath");
			String pathForPDf= (String) envContext.lookup("pdfPath");
			pathForReport=request.getSession().getServletContext().getRealPath(pathForReport);
			pathForPDf=request.getSession().getServletContext().getRealPath(pathForPDf);
			System.out.println("pathForReport "+pathForReport);
			System.out.println("pathForPDf "+pathForPDf);
			
			
			
			
			//InputStream inputStream = new FileInputStream(pathForReport);
			JRBeanCollectionDataSource beanColDataSource = new JRBeanCollectionDataSource(listPrintOutputBean);
			Map parameters = new HashMap();
			
			JasperDesign jasperDesign = JRXmlLoader.load(pathForReport+System.getProperty("file.separator")+"reportPrintTitle.jrxml");
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, beanColDataSource);
			JasperExportManager.exportReportToPdfFile(jasperPrint, pathForPDf+System.getProperty("file.separator")+"reportPrintTitle.pdf");
			System.out.println("application.getContextPath(); "+application.getContextPath());
			
			
			/* 
			 
			PrinterJob job = PrinterJob.getPrinterJob();
			// Create an array of PrintServices 
			javax.print.PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);
			System.out.println("Services length = "+services.length + " name " + services[3].getName());
				
		     //set printer service
		     job.setPrintService(services[2]);
		     PrintRequestAttributeSet printRequestAttributeSet = new HashPrintRequestAttributeSet();
		    
		     //MediaSizeName mediaSizeName = MediaSizeName.findMedia(4,4,MediaPrintableArea.INCH);
		     //PrintRequestAttributeSet.add(mediaSizeName);
		     //printRequestAttributeSet.add(new Copies(1));
		     
		     JRPrintServiceExporter exporter;
		     exporter = new JRPrintServiceExporter();
		     exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		     // We set the selected service and pass it as a paramenter 
		     exporter.setParameter(JRPrintServiceExporterParameter.PRINT_SERVICE, services[2]);
		     exporter.setParameter(JRPrintServiceExporterParameter.PRINT_SERVICE_ATTRIBUTE_SET, services[2].getAttributes());
		     exporter.setParameter(JRPrintServiceExporterParameter.PRINT_REQUEST_ATTRIBUTE_SET, printRequestAttributeSet);
		     exporter.setParameter(JRPrintServiceExporterParameter.DISPLAY_PAGE_DIALOG, Boolean.FALSE);
		     exporter.setParameter(JRPrintServiceExporterParameter.DISPLAY_PRINT_DIALOG, Boolean.FALSE);
		     exporter.exportReport();
		     		 
		     */
		     //JasperPrintManager.printReport(jasperPrint,false);
			

		}
	catch(Exception e){
		e.printStackTrace();
	}
		
	
%>
	
	<%-- <jsp:forward page="PrintOrderPdfOutput.jsp">
		<jsp:param value="<%=outputPDFfile %>" name="outputfile"/>
	</jsp:forward> --%>

	
<input type="hidden" name="horderNo" value="">
</form>
<script>
function Fun_Print(){    
     myWindow = window.open('PrintOrderPdfOutput.jsp',"_blank");
   	 back();
}
function back(){
	var backPage="";
	backPage ="<%=request.getParameter("backPage")%>";
	if(backPage != "customer_detailsForm1.jsp"){			
		if(backPage != "create_newCustomer.jsp" ){
			if(backPage != "cust_orderBill.jsp"){		
				 window.location=backPage; 
				 
			}
		 } else {
			window.close();
		}
	} else {
		window.close();
	}	
}
window.onload = function(){
	
	Fun_Print();
	
		
}	
</script>
</body>
</html>