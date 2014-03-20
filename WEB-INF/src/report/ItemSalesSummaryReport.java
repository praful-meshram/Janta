package report;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import reportbeans.ItemSalesReportBean;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ItemSalesSummaryReport {

	public static JasperDesign jasperDesign;
	public static JasperPrint jasperPrint;
	public static JasperReport jasperReport;
	Connection conn=null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	
	//get a parameter to pass into jrxml
	public Map getReportParameter(String pathForReport,String toDate,String fromDate,String itemName) {
		Map parameters = new HashMap();
		parameters.put("fromDate",fromDate);
		parameters.put("toDate",toDate);
		if(itemName.equals("NotSelected")){
			itemName="";
		}
		parameters.put("itemName",itemName);
		return parameters;
	}

	public void MainMethod(ArrayList<ItemSalesReportBean> objmItemSalesReportBean,String pathForReport,String toDate,String fromDate,String groupCode,String itemName,String pathForPDF)throws IOException {
		try {
				JasperDesign jasperDesign = JRXmlLoader.load(pathForReport+System.getProperty("file.separator")+"ItemSalesSummaryReport.jrxml");
				jasperReport = JasperCompileManager.compileReport(jasperDesign);
				jasperPrint = JasperFillManager.fillReport(jasperReport, getReportParameter(pathForReport,toDate,fromDate,itemName), new JRBeanCollectionDataSource(objmItemSalesReportBean));
				JasperExportManager.exportReportToPdfFile(jasperPrint, pathForPDF+System.getProperty("file.separator")+"ItemSalesSummaryReport.pdf");
				
			} catch (Exception e) {
		      e.printStackTrace(); 
			}
	}
	
	public ArrayList<ItemSalesReportBean> getList (String fromDate, String toDate,String groupCode,String itemName) {
		ArrayList<ItemSalesReportBean> objmList=null;
		try {
				objmList = new ArrayList<ItemSalesReportBean>();
				Context envContext = (Context) new InitialContext().lookup("java:comp/env");
				//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
				DataSource ds = (DataSource)envContext.lookup("jdbc/re");
				conn = ds.getConnection();
				String whereCondition="";
				ItemSalesReportBean objmItemSalesReportBean;
				
				if(!groupCode.equals("select") && itemName.equals("NotSelected")){
					whereCondition=" and a.order_num = b.order_num and d.item_group_code= '"+groupCode+"' "; 
	    			
				}else if(groupCode.equals("select") && !itemName.equals("NotSelected")){
					whereCondition=" and a.order_num = b.order_num and c.item_name like '"+itemName+"%' "; 
	    			
				}else if(!groupCode.equals("select") && !itemName.equals("NotSelected")){
					whereCondition=" and a.order_num = b.order_num and c.item_name like '"+itemName+"%' and d.item_group_code= '"+groupCode+"'"; 
	    			    		   
				}else if(groupCode.equals("select") && itemName.equals("NotSelected")){
					whereCondition=" ";
				}
				String query="select b.item_code,d.item_group_desc,c.item_name, sum(b.qty),sum(b.price) "+
		    			" from orders a,order_detail b, item_master c, item_group d " +
		    			" where a.order_num = b.order_num and a.order_date between '"+fromDate+"' and '"+toDate+"' " +
		    			" and b.item_code = c.item_code and d.item_group_code = c.item_group_code "+whereCondition+" " +
		    			" group by b.item_code,d.item_group_desc,c.item_name order by c.item_name ";
				stmt =conn.prepareStatement(query);	
			   rs = stmt.executeQuery();
			   System.out.print(query);
				while(rs.next()){
					objmItemSalesReportBean =new ItemSalesReportBean();
					objmItemSalesReportBean.setItemCode(rs.getString(1));
					objmItemSalesReportBean.setItemGroup(rs.getString(2));
					objmItemSalesReportBean.setItemName(rs.getString(3));
					objmItemSalesReportBean.setTotalQuantity(rs.getDouble(4));
					objmItemSalesReportBean.setTotalValue(rs.getDouble(5));
					objmList.add(objmItemSalesReportBean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return objmList; 
	}
	
}
