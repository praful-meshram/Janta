/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-11 07:34:27 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;
import javax.swing.JOptionPane;
import javax.swing.JFrame;

public final class DeliveryAction_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("DeliveryAction.jsp", request.getCharacterEncoding()), out, false);
      out.write('\n');
      out.write('\n');

      	ResultSet rs=null,rs1=null;
       	Statement stmt=null,stat=null;
       	Connection conn=null;   
       	String totItemsAfterRet="",itemTaken="",totalVal="",remark="",allowActionValue="",paidstr="",CheckChanged=""; 
		int finalItemCount=0,deliveryBalance=0,success=0;
		float balance_amt=0.0f;
		float change_amt=0.0f;
		float expected_amt=0.0f;
  		float paidamt=0.0f;	 
  		balance_amt=Float.valueOf(request.getParameter("hbalanceAmt"));
        change_amt=Float.valueOf(request.getParameter("hchange")); 		
       	allowActionValue=request.getParameter("hallowaction");
       	
		double totalMrp=0.0f,totalRetMrp=0.0f;
		
       	totalMrp=Double.valueOf(request.getParameter("htotalmrp").replace(",", ""));
       	totItemsAfterRet=request.getParameter("hretitem");
       	totalVal=request.getParameter("htotalvalue");
     	itemTaken=request.getParameter("hitemtaken");
		totalRetMrp=Double.valueOf(request.getParameter("hretmrp"));     	   		
		double finalMrp=totalMrp-totalRetMrp;
       	CheckChanged=request.getParameter("hCheckChanged");         	
        String orderNo="",hcodeArray="",oldQty="";
  		orderNo=request.getParameter("horderNo");  
  		String totalItems=request.getParameter("htotalitems");		
		finalItemCount=Integer.parseInt(totalItems)-Integer.parseInt(totItemsAfterRet);
		String splitFlag=request.getParameter("hsplitflag");
		oldQty=request.getParameter("holdItems");  		
  		String oldItemQty[]=oldQty.split(",");
  		hcodeArray=request.getParameter("hicodearray");  		
  		String temp1[]=hcodeArray.split(",");
  		String hQtyArray=request.getParameter("hqtyArray");  		
  		String qty[]=hQtyArray.split(",");
  		String hPriceArray=request.getParameter("hpriceArray");  		
  		String price[]=hPriceArray.split(",");
  		String hEntryArray=request.getParameter("hentryArray");  		
  		String entry[]=hEntryArray.split(",");
  		paidstr=request.getParameter("paidamt");
  		String [] newQtyTextField = request.getParameterValues("newQtyTextField");
  		String [] prevQtyTextField = request.getParameterValues("prevQtyTextField");
  		String [] itemCode = request.getParameterValues("hItemCode");
  		String [] priceVersion = request.getParameterValues("hPriceVersion");
  		String siteId = request.getParameter("hSiteId");
  		
  		System.out.println(newQtyTextField.length +" updsql "+prevQtyTextField.length);
  		System.out.println(itemCode.length +" code  "+priceVersion.length+"site id "+siteId);
  		
  		for(int i=0;i<newQtyTextField.length && i<prevQtyTextField.length;i++){
  			System.out.println(newQtyTextField[i] +" qty values "+prevQtyTextField[i]);
  		}
  		
  		if(paidstr==null)
			paidamt=0.0f;  		
  		else if(!paidstr.equals(""))
  			paidamt=Float.valueOf(request.getParameter("paidamt"));  	
       	remark=request.getParameter("remark");        	
       	String d_code="";
       	d_code=request.getParameter("d_staff");            	
       	float comm=0.0f,afterRetComm=0.0f;
       	comm=Float.valueOf(request.getParameter("comm1"));	
       	afterRetComm=Float.valueOf(request.getParameter("hafterretcomm"));
       	double removeBaltopay=0.0f;	
       	order.ManageOrder mo;    	
		mo = new order.ManageOrder("jdbc/js"); 
       	try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stmt = conn.createStatement(); 
			stat = conn.createStatement(); 	
			String balquery="SELECT balance_to_pay FROM delivery_staff d, orders o "+
							"where d.dstaff_code=o.dstaff_code and order_num='"+orderNo+"'";
			rs1=stat.executeQuery(balquery);
			while(rs1.next()){
				deliveryBalance=rs1.getInt(1);
			}
			if(comm>afterRetComm){ 
				removeBaltopay=comm-afterRetComm; 	 
				comm=afterRetComm;  
				deliveryBalance=deliveryBalance-(int)removeBaltopay;
       		}
			String updSql1="";
			int itemRemoved = 0;
			if(!hcodeArray.equals("")){
				for(int i=0; i<temp1.length; i++){
					if(!itemCode[i].equals("")){	
					
						int itemReturn = (int)(Float.parseFloat(prevQtyTextField[i].trim())- Float.parseFloat(newQtyTextField[i].trim()));
						System.out.println("if   item code "+itemCode[i] +" itemReturn "+itemReturn);
						if(itemReturn==(int)(Float.parseFloat(prevQtyTextField[i].trim()))){
							itemRemoved++;
						}
							
						
					    if(itemReturn == 0){
					   		//int entry_no = Integer.parseInt(entry[i]);
							updSql1=" update order_detail set item_returned=0 where order_num='"+orderNo+"' "+
									" and item_code='"+itemCode[i]+"' and entry_no='"+i+"'";
							stmt.executeUpdate(updSql1);
						}else{
							
							CallableStatement callableStatement = conn.prepareCall("CALL updateOrderOnItemReturn(?,?,?,?,?,?)");
									
							callableStatement.setString(1, orderNo);
							callableStatement.setString(2, itemCode[i]);
							callableStatement.setInt(3, Integer.parseInt(priceVersion[i].trim()));
							callableStatement.setInt(4,Integer.parseInt(siteId.trim()));
							callableStatement.setInt(5, itemReturn);
							callableStatement.registerOutParameter(6, Types.BOOLEAN);
							System.out.println("CALL updateOrderOnItemReturn(?,?,?,?,?)");	
							callableStatement.execute();
							boolean flag = callableStatement.getBoolean(6);
							System.out.println(" flag "+flag);	
							
							
							
							
							/* float qtyVal = Float.parseFloat(qty[i]);
							float priceVal = Float.parseFloat(price[i]);
							//int entry_no = Integer.parseInt(entry[i]);
							updSql1="update order_detail set qty='"+qtyVal+"',price='"+priceVal+"'"+
							"where order_num='"+orderNo+"' "+
							"and item_code='"+temp1[i]+"' and entry_no='"+i+"'";
							stmt.executeUpdate(updSql1);
							updSql1 = "select od.price_version,o.site_id from order_detail od, orders o "+
								"where o.order_num = "+orderNo+
								" and o.order_num = od.order_num "+
								"and od.item_code = '"+temp1[i]+"'";
							ResultSet rs2 = stmt.executeQuery(updSql1);
							if(rs2.next()){
								Statement st =  conn.createStatement();
								String query1 = "update item_master set item_qty = item_qty + "+(Float.parseFloat(oldItemQty[i])-qtyVal)+" where item_code = '"+temp1[i]+"'";
								System.out.println("Master :"+query1);
								st.executeUpdate(query1);
								query1 = "update item_price set item_pv_qty = item_pv_qty + "+(Float.parseFloat(oldItemQty[i])-qtyVal)+" where item_code = '"+temp1[i]+"' "+ 
										" and price_version  = "+rs2.getInt(1);
								System.out.println("Price :"+query1);
								st.executeUpdate(query1);
								
								// Update Inventory  in the case of itm return 
								int diff = (int)(Float.parseFloat(prevQtyTextField[i].trim())- Float.parseFloat(newQtyTextField[i].trim()));
								query1 = "update item_site_inventory set item_site_qty = item_site_qty + ? "+
										 " where item_code = ? '"+
										 " and price_version  = ?"+
										 " and site_id = ?";
								System.out.println("Site :"+query1);
								PreparedStatement  preparedStatement = conn.prepareStatement(query1);
								System.out.println("Site :"+query1);
								preparedStatement.setInt(1, diff);
								preparedStatement.setString(2, temp1[i]);
								preparedStatement.setInt(3, rs2.getInt(1));
								preparedStatement.setInt(4, rs2.getInt(2));
								
								System.out.println("Site :"+query1);
								preparedStatement.executeUpdate();
							} */
						}
					}			
				}	
			}	
			String updSql="";	
			System.out.println("allowActionValue "+allowActionValue);
			// set final item count
			finalItemCount=Integer.parseInt(totalItems)-itemRemoved;
			System.out.println("totalItems "+totalItems+"\ttotItemsAfterRet "+finalItemCount);  
			if(allowActionValue.equals("Delivery Done") ){ 
				balance_amt = balance_amt - (paidamt-change_amt);
				if(CheckChanged.equals("Yes")){
					updSql="update orders set status_code='DELIVERED',paid_amt='"+paidamt+"', "+
					"comm_amt='"+comm+"',total_value='"+totalVal+"',total_items='"+finalItemCount+"', "+
					"total_taken='"+itemTaken+"',total_value_mrp='"+finalMrp+"',payment_type_code='CHQ', "+
					"remark='"+remark+"',action='"+allowActionValue+"',change_amt="+change_amt+",balance_amt="+balance_amt+",  "+
					"del_datetime=now(),lastmodifieddate=now() where order_num='"+orderNo+"'";			
				}
				else{
					updSql="update orders set status_code='DELIVERED',paid_amt='"+paidamt+"', "+
					"comm_amt='"+comm+"',total_value='"+totalVal+"',total_items='"+finalItemCount+"', "+
					"total_taken='"+itemTaken+"',total_value_mrp='"+finalMrp+"', "+
					"remark='"+remark+"',action='"+allowActionValue+"',change_amt="+change_amt+",balance_amt="+balance_amt+", "+
					"del_datetime=now(), lastmodifieddate=now() where order_num='"+orderNo+"'";			
				}
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);	
				System.out.println("updsql "+updSql);
				int run_sql = stmt.executeUpdate(updSql); 
				updSql = "update orders set total_value_mrp = (select sum(qty*mrp) from order_detail where order_num="+orderNo+
						") where order_num ="+orderNo;
				System.out.println("updsql orders  "+updSql);
				run_sql = stmt.executeUpdate(updSql);
				
				if (run_sql==1){ 
				    mo.setOrderCommission(Integer.parseInt(orderNo),d_code,(int)comm,"ADD");
				    System.out.println(Integer.parseInt(orderNo)+"..."+d_code+"....."+comm);				
					String query="update delivery_staff set balance_to_pay='"+deliveryBalance+"' where dstaff_code='"+d_code+"'";				
					int runsql =stmt.executeUpdate(query);	
					if (runsql==1){ 
						success=1;
					}
				}
			   }
			else if(allowActionValue.equals("Hold")){
				balance_amt = balance_amt - (paidamt-change_amt);
				
				
				if(CheckChanged.equals("Yes")){
					updSql="update orders set status_code='HOLD',paid_amt='"+paidamt+"', "+
					"comm_amt='"+comm+"',total_value='"+totalVal+"',total_items='"+finalItemCount+"', "+
					"total_taken='"+itemTaken+"',total_value_mrp='"+finalMrp+"',payment_type_code='CHQ', "+
					"remark='"+remark+"',action='"+allowActionValue+"',change_amt="+change_amt+",balance_amt="+balance_amt+", "+
					"del_datetime=now() where order_num='"+orderNo+"'";			
				}
				else{
					updSql="update orders set status_code='HOLD',paid_amt='"+paidamt+"', "+
					"comm_amt='"+comm+"',total_value='"+totalVal+"',total_items='"+finalItemCount+"', "+
					"total_taken='"+itemTaken+"',total_value_mrp='"+finalMrp+"', "+
					"remark='"+remark+"',action='"+allowActionValue+"',change_amt="+change_amt+",balance_amt="+balance_amt+", "+
					"del_datetime=now() where order_num='"+orderNo+"'";			
				}			
			
				mo.updateOrderHistory(Integer.parseInt(orderNo),allowActionValue,(int)comm);										
				int run_sql = stmt.executeUpdate(updSql); 
				mo.updateDeliveryBalance(Integer.parseInt(orderNo),(int)comm);
				if (run_sql==1){ 
				 	mo.setOrderCommission(Integer.parseInt(orderNo),d_code,(int)comm,"ADD");
					success=1;
				}
			}
			conn.close();
			mo.closeAll();
		  	}
			catch (Exception e) {
				System.out.println("Exception occured in DeliveryAction.jsp");
				e.getMessage();
				e.printStackTrace();				
			}			
			if(success==1){
				response.sendRedirect(request.getParameter("back_page")+"?cust_code="+request.getParameter("cust_code"));
			}else if(success==0){
				response.sendRedirect(request.getParameter("back_page")+"?cust_code="+request.getParameter("cust_code"));
			}

      out.write("\t\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}