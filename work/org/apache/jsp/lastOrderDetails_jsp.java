/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-10 07:41:56 UTC
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
import java.text.*;

public final class lastOrderDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ErrorPage.jsp?page=lastOrderDetails.jsp", true, 8192, true);
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
      out.write(" \n");
      out.write(" \n");
      out.write("\n");
      out.write("\t\n");
      out.write("\t");

	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	
      out.write("\n");
      out.write(" \t\t\n");
      out.write("\n");

			DecimalFormat df = new DecimalFormat("###,###.00");
			DecimalFormat dfQty = new DecimalFormat("0.000");
			DecimalFormat dfQty1 = new DecimalFormat("0");
				
			int last_order_num=0;		
			last_order_num=Integer.parseInt(request.getParameter("orderNoStartWith"));	
			if(last_order_num!=0){			
				
				String last_order_date="",itemCode="",pageName="";
				last_order_date=request.getParameter("orderDateStartWith");	
				pageName=request.getParameter("pageName");				
				String orderDate="";				
				int totalItems=0,totalItemsTaken=0 , entry_no=0;
				long item_taken=0,itemTaken=0;				
				float totalValue=0.0f;			
				int itemCount=0;
				float itemRate=0.0f;
				float itemQty=0.0f;
				float itemTotPrice=0.0f;
				float itemMRP=0.0f;
				float totalValueMRP=0.0f;
				float savings=0.0f;
				float totalValueDis=0.0f;
				float itemTotDis=0.0f;
				float comm_amt=0.0f;
				float tot_comm=0.0f;	
				float totMrp=0.0f;
				
				String itemName="";
				String itemWeight="";				
				String p_type="";
				String disRemark="";
        	    int i=0;
        	    
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
				
			query="select a.total_items, a.total_value, " +					
					"b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,b.item_taken, e.payment_type_desc, " + 
				  	"d.item_name, d.item_weight, d.comm_amt,b.item_code,a.total_taken,a.total_value_mrp,b.entry_no,b.price_version,a.site_id " +				  	
					"from orders a, order_detail b, item_master d ,payment_type e " +
					"where a.order_num = b.order_num " +					
					"and b.item_code = d.item_code " +
					"and a.payment_type_code = e.payment_type_code "+
					"and a.order_num = '" + last_order_num + "' and b.item_returned=0 "+
					"order by b.entry_no";
					
									
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, checkIndex=0;
				
			while(rs.next()) {
				
				if(checkIndex==0)
					checkIndex=0;				   
				i=1;				
				totalItems=rs.getInt(i++);
				totalValue=rs.getFloat(i++);
				
				itemRate=rs.getFloat(i++);
				itemQty=rs.getFloat(i++);
					
				itemTotPrice=rs.getFloat(i++);
				itemMRP=rs.getFloat(i++);
				itemTotDis=rs.getFloat(i++);
				disRemark=rs.getString(i++);
				item_taken=rs.getLong(i++);	
				if(item_taken==1)		
					itemTaken++;
				p_type=rs.getString(i++);
				
				itemName=rs.getString(i++);
				itemWeight=rs.getString(i++);
				comm_amt=rs.getFloat(i++);
				itemCode=rs.getString(i++);	
				totalItemsTaken=rs.getInt(i++);
				totalValueMRP=rs.getFloat(i++);	
				entry_no =	 rs.getInt(i++);
				int priceVersion = rs.getInt("price_version");
				int siteId= rs.getInt("site_id");
				tot_comm = tot_comm + (itemQty * comm_amt);	
								
	if (ctr==0) {			
	
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t<table align=center  border=\"1\" class=\"item3\" style=\"background-color:#FFE4C4; border-collapse: collapse;width: 90%; border-color: black;\" bordercolor=black>\t\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td colspan=\"10\" align=left>\n");
      out.write("\t\t\t<b><font color=\"blue\" size =\"2\">Note * </font>\n");
      out.write("\t\t\t<font color=red size =\"1.9\">Colour in Qty indicates picked item.</font></b>\n");
      out.write("\t\t</td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t\t<th colspan=4>Order Details</th>\n");
      out.write("\t\t<th colspan=2>Order No. : ");
      out.print(last_order_num);
      out.write(" </th>\n");
      out.write("\t\t<th colspan=\"4\">Order Date. : ");
      out.print(last_order_date);
      out.write(" </th>\t\n");
      out.write("\t</tr>\t\n");
      out.write("\t<tr>\n");
      out.write("\t\t\t");
if(pageName.equals("DeliveryActionForm")){
      out.write("\n");
      out.write("\t\t\t<td rowspan=\"2\" align=\"center\"><b>Return</b></td>\t\t\n");
      out.write("\t\t\t");
}
      out.write("\t\n");
      out.write("\t\t\t<td rowspan=\"2\"><b>Item</b></td>\n");
      out.write("\t\t\t<td rowspan=\"2\"><b>Rate</b></td>\t\t\n");
      out.write("\t\t\t<td rowspan=\"2\"><b>Weight</b></td>\n");
      out.write("\t\t\t");
if(pageName.equals("DeliveryActionForm")){ 
      out.write("\n");
      out.write("\t\t\t\t<td rowspan=\"2\"><b>Old Qty</b></td>\n");
      out.write("\t\t\t\t<td rowspan=\"2\"><b>New Qty</b></td>\n");
      out.write("\t        ");
}else{
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t<td rowspan=\"2\"><b>Qty</b></td>\n");
      out.write("\t\t\t");
}
      out.write("\n");
      out.write("\t\t\t<th colspan=\"2\"><b>Price</b></th>\n");
      out.write("\t\t\t<th colspan=\"2\"><b>Deals</b></th>\t\t\t\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t\n");
      out.write("\t\t<tr>\t\n");
      out.write("\t\t\t<td><b>Janta's Price</b></td>\n");
      out.write("\t\t\t<td ><b>MRP</b></td>\n");
      out.write("\t\t\t<td><b>Discount</b></td>\n");
      out.write("\t\t\t<td><b>Remark</b></td>\t\t\n");
      out.write("\t\t\t\n");
      out.write("\t\t</tr>\n");
      out.write("\n");
 ctr = ctr + 1; 
	} 
	savings = itemMRP - itemTotPrice;
	if(savings<0)
		savings=0.0f;
	
	
      out.write("\n");
      out.write("\t\n");
      out.write("<tr style=\"background-color: #FFE4a4;\">\t\n");
      out.write("\t");
if(pageName.equals("DeliveryActionForm")){ 
      out.write("\n");
      out.write("\t<td width='8%' align=\"center\">\n");
      out.write("\t\t<input type=\"checkbox\" name=\"chck\" value=\"");
      out.print(itemCode);
      out.write("\" id=\"chck_");
      out.print(itemCount);
      out.write("\"\n");
      out.write("\t\tonclick=\"SelectReturnedItem('");
      out.print(itemRate);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(checkIndex);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemTotPrice);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemQty);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_taken);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemCode);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemMRP);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(pageName);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemCount);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(entry_no);
      out.write("',this);\">\n");
      out.write("\t</td>\n");
      out.write("\t");
}
      out.write("\t\n");
      out.write("\t<td style=\"display: none;\"><input type=\"text\" value=\"");
      out.print(itemCode );
      out.write("\" name=\"hItemCode\"></td>\n");
      out.write("\t<td style=\"display: none;\"><input type=\"text\" value=\"");
      out.print(priceVersion );
      out.write("\" name=\"hPriceVersion\"></td>\n");
      out.write("\t<td style=\"display: none;\"><input type=\"text\" value=\"");
      out.print(siteId );
      out.write("\" name = \"hSiteId\"></td>\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t<td style=\"width: 15%; padding: 0px 0px 0px 5px;\" align=left>");
      out.print(itemName);
      out.write("</td>\n");
      out.write("\t<td style=\"width: 10%; padding: 0px 5px 0px 5px;\" align=right>");
      out.print(itemRate);
      out.write("</td>\t\n");
      out.write("\t<td style=\"width: 10%; padding: 0px 0px 0px 5px;\" >");
      out.print(itemWeight);
      out.write("</td>\t\n");
      out.write("\t<td style=\"display: none;\"><input type=\"hidden\" name=\"outQty\" value=\"");
      out.print(dfQty1.format(itemQty));
      out.write("\"/></td>\n");
      out.write("\t");

	System.out.println("itemcode "+itemCode+"\t price vesion "+priceVersion+"\tsiteid "+siteId);
	if(item_taken==1){
      out.write("\n");
      out.write("\t<td style=\"width: 6%; padding: 0px 0px 0px 5px;\" valign=top BGCOLOR=#FF99FF  >\n");
      out.write("\t<input type=\"hidden\" value=\"");
      out.print(itemQty);
      out.write("\" id='prevQtyTextField");
      out.print(itemCount);
      out.write("' name=\"prevQtyTextField\">\n");
      out.write("\t<div id=\"divPrevQty");
      out.print(itemCount);
      out.write('"');
      out.write('>');
      out.print(dfQty1.format(itemQty));
      out.write("</div></td>\n");
      out.write("\t");
}else if(item_taken==0){
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t<td style=\"width: 6%; padding: 0px 0px 0px 5px;\">\n");
      out.write("\t<input type=\"hidden\" value=\"");
      out.print(itemQty);
      out.write("\" id='prevQtyTextField");
      out.print(itemCount);
      out.write("' name=\"prevQtyTextField\">\n");
      out.write("\t<div id=\"divPrevQty");
      out.print(itemCount);
      out.write('"');
      out.write('>');
      out.print(dfQty1.format(itemQty));
      out.write("</div></td>\n");
      out.write("\t");
} 
      out.write('\n');
      out.write('	');
if(pageName.equals("DeliveryActionForm")){ 
      out.write("\n");
      out.write("\t\t<td style=\"width: 6%; padding: 0px 5px 0px 5px;\" valign=\"middle\">\n");
      out.write("\t\t\t<input type=\"hidden\" value=\"");
      out.print(itemQty);
      out.write("\" id='newQtyTextField");
      out.print(itemCount);
      out.write("' name=\"newQtyTextField\">\n");
      out.write("\t\t\t<div id=\"divNewQty");
      out.print(itemCount);
      out.write("\" style=\"float: left; vertical-align: middle;margin-top: 6px;\">");
      out.print(dfQty1.format(itemQty));
      out.write("</div>\n");
      out.write("\t\t\t<div id='divInQty");
      out.print(itemCount);
      out.write("' style=\"VISIBILITY:hidden; float: right;\">\n");
      out.write("\t\t\t\t<input type=\"text\" size=\"2\" \n");
      out.write("\t\t\t\t\tname=\"inQty");
      out.print(itemCount);
      out.write("\" \n");
      out.write("\t\t\t\t\tid=\"inQty_");
      out.print(itemCount);
      out.write("\"\n");
      out.write("\t\t\t\t\tonblur=\"funchckempty(this);\" \n");
      out.write("\t\t\t\t\tonchange=\"funInQty('");
      out.print(itemRate);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(checkIndex);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemTotPrice);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemQty);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(item_taken);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemCode);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemMRP);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(pageName);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(itemCount);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(entry_no);
      out.write("',this);\" \n");
      out.write("\t\t\t\t\tonkeypress=\"return isNumberKey(event)\"></div>\n");
      out.write("\t\t</td>\n");
      out.write("\t");
}
      out.write('\n');
      out.write('	');
if(pageName.equals("DeliveryActionForm")){ 
      out.write("\n");
      out.write("\t\t<td style=\"width: 6%; padding: 0px 5px 0px 5px;\"><div id=\"divTotalPrice");
      out.print(itemCount);
      out.write('"');
      out.write('>');
      out.print(itemTotPrice);
      out.write("</div></td>\n");
      out.write("\t");
}else{
      out.write("\t\t\n");
      out.write("\t\t<td style=\"width: 6%; padding: 0px 5px 0px 5px;\" valign=top align=right>");
      out.print(itemTotPrice);
      out.write("</td>\n");
      out.write("\t");
}
      out.write('\n');
      out.write('	');
 if(itemMRP<=0) { 
      out.write("\n");
      out.write("\t<td style=\"width: 8%; padding: 0px 5px 0px 5px;\" align=right>NA</td>\n");
      out.write("\t");
 } else { 
      out.write("\n");
      out.write("\t<td style=\"width: 8%; padding: 0px 5px 0px 5px;\" align=right id=\"mrp_td_");
      out.print(itemCount);
      out.write('"');
      out.write('>');
      out.print(df.format(itemMRP));
      out.write("</td>\n");
      out.write("\t");
}
      out.write("\n");
      out.write("\t\n");
      out.write("\t<td align='right' style=\"width: 6%; padding: 0px 5px 0px 5px;\">");
      out.print( df.format(savings));
      out.write("/-</td>\n");
      out.write("\t<td width='6%'>");
      out.print(disRemark);
      out.write("\n");
      out.write("\t<input type=\"hidden\" name=\"hentry");
      out.print(itemCount);
      out.write("\" value=\"");
      out.print(entry_no);
      out.write("\" id=\"hentry_id_");
      out.print(itemCount );
      out.write("\"/></td></tr>\n");
	checkIndex++;
	itemCount++;	
	totMrp = totMrp + itemMRP*itemQty;
	}
	//long item_deliver = totalItems-item_taken; previous code(Sanketa)
	long item_deliver = totalItems-totalItemsTaken;

      out.write("\n");
      out.write("\n");
      out.write("\t<tr>\n");
      out.write("\t\n");
      out.write("\t\t\t<th>\n");
      out.write("\t\t\t\t<div id='totalSel' align=\"left\">\n");
      out.write("\t\t\t\t\t<b> Total items:  <label id=\"totItems\">");
      out.print(totalItems);
      out.write("</label> <br>\n");
      out.write("\t\t\t\t\t\tPickup: <label id=\"pickup\"> ");
      out.print(itemTaken);
      out.write(" </label> <br> \n");
      out.write("\t\t\t\t\t\tDeliver:<label id=\"deliver\"> ");
      out.print(item_deliver);
      out.write("</label> \n");
      out.write("\t\t\t\t\t\t<input type=\"hidden\" name=\"count\" value=\"");
      out.print(itemCount);
      out.write("\" id=\"row_count\"/>\n");
      out.write("\t\t\t\t\t</b>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</th>\n");
      out.write("\t\t\t\n");
		if(pageName.equals("DeliveryActionForm")){
      out.write("\n");
      out.write("\t\t\t<th><b>Payment : ");
      out.print(p_type);
      out.write("</b></th><th></th><th></th><th></th>\n");
      out.write("\t\t");
}else if(!pageName.equals("DeliveryActionForm")){
      out.write("\t\t\n");
      out.write("\t\t\t<th><b>Payment : ");
      out.print(p_type);
      out.write("</b></th><th></th><th></th>\n");
}
      out.write("\t\t\t\n");
      out.write("\t\t");
if(pageName.equals("DeliveryActionForm")){ 
      out.write("\n");
      out.write("\t\t\t<th align=right></th>\n");
      out.write("\t\t");
}
      out.write("\t\t\n");
      out.write("\t\t\t<th align=right><div id='totalValue' align=\"right\"><b>Total: <label id=\"totVal\">");
      out.print(totalValue);
      out.write("</label></b></div></th>\n");
      out.write("\t\t\t<th align=right><div id='totalValue' align=\"right\"><b>Total MRP: <label id=\"totMrp\">");
      out.print(df.format(totMrp));
      out.write("</label></b></div></th>\n");
      out.write("\t\t\t<th align=left colspan=2><div id='totalComm' align=\"right\">Commission: <label id=\"comm\">");
      out.print(df.format(tot_comm));
      out.write("</label></b>\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"comm\" value=\"");
      out.print(tot_comm);
      out.write("\"/>\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"hreturnval\" value=\"");
      out.print(itemName);
      out.write("\"/>\t\n");
      out.write("\t\t\t<input type=\"hidden\" name=\"htotalmrp\" value=\"");
      out.print(totalValueMRP);
      out.write("\"/>\t</div></th>\t\t\t\t\t\n");
      out.write("\t\t</tr>\n");

		rs.close();
		stat.close();
		conn.close();
	}catch(Exception e)
	{
		System.out.println(e);
		rs.close();
		stat.close();
		conn.close();
	}
}


      out.write("\n");
      out.write("\n");
      out.write("</table>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
