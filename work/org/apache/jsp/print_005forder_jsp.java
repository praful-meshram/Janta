/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-03-03 10:20:55 UTC
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
import java.awt.*;
import java.util.*;
import java.text.*;
import java.awt.image.BufferedImage;
import net.sourceforge.barbecue.*;
import javax.imageio.ImageIO;

public final class print_005forder_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      			"ReportErrorPage.jsp?page=print_order.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<html>\n");
      out.write("<head>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<title>Printing...</title>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\n");
      out.write("<style>\n");
      out.write(".boldtable, .boldtable TD, .boldtable TH\n");
      out.write("{\n");
      out.write("font-family: consolas;\n");
      out.write("font-size:11pt;\n");
      out.write("}\n");
      out.write("\n");
      out.write(".boldtable1, .boldtable1 TD, .boldtable1 TH\n");
      out.write("{\n");
      out.write("font-family: consolas;\n");
      out.write("font-size:11pt;\n");
      out.write("}\n");
      out.write("\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("\n");
      out.write("<form name=\"myform\">\n");

boolean flag1 = true;
//commnet to avoid exception
/* try{
	if(request.getParameter("callfrom").equals("receive_payment_page"))
		flag1 = false;
} catch (Exception e){
	System.out.print("Flag exp : ");
	e.printStackTrace();
} */
			    System.out.print("print order ");				

				DecimalFormat df = new DecimalFormat("###,###.00");
				DecimalFormat dfQty = new DecimalFormat("0.000");
				DecimalFormat dfQty1 = new DecimalFormat("0");
						
				String orderDate="";
				String enteredBy="";				
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
        	    int i=0;
				
				float totalValue=0.0f;
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
				
				String username=(String)session.getAttribute("UserName");
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
        	    
        		String orderNo="",statusCode="";
        		
        		orderNo=request.getParameter("orderNo");
        		statusCode=request.getParameter("statusCode");
        		String backPage="";
        		
        		backPage=request.getParameter("backPage");
             
		String query="",copyOrder="CopyOrder";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			query="select code,value from code_table where code in ('StoreName','StoreAdd1','StorePhone','BILLMSG')";
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
					"a.other_charges,b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,ifnull(e.payment_type_desc,''), b.item_taken, " + 
				  	"d.item_name, d.item_weight, c.custcode,c.custname,c.building,c.building_no, "+
				  	"c.block,c.wing,c.add1,c.add2,c.phone, c.area, c.station " +
					"from orders a left outer join payment_type e on a.payment_type_code = e.payment_type_code, "+
					"order_detail b, customer_master c, item_master d, item_group g " +
					"where a.order_num = b.order_num " +
					"and a.custcode = c.custcode " +
					"and b.item_code = d.item_code " +			
					"and a.order_num = '" + orderNo + "' "+
					" and g.item_group_code = d.item_group_code "+
					"order by g.item_group_number, b.entry_no";
			System.out.println(" Print Query :"+query);		
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, itemCount=0;
				
			while(rs.next()) {
					
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
				//System.out.println(dis_amt);			
				bal_amt=rs.getFloat(i++);
				other_charges_amt=rs.getFloat(i++);
											
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
				
				Barcode objBarcode = BarcodeFactory.createCode128C(orderNo+"");
				System.out.println(" Resultset :"+j);	
				//to avoid display order number under barcode image;
				objBarcode.setDrawingText(false);
				System.out.println(" Resultset1 :"+j);	
				String ImagePath = (String) envContext.lookup("imagesfile");
				System.out.println(" Resultset 2:"+j);	
				ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+orderNo+".PNG";
				System.out.println(ImagePath+" Resultset 3:"+j);	
				//System.out.println("ImagePath :"+ImagePath);
				File f = new File(ImagePath);            	
                BarcodeImageHandler.savePNG(objBarcode, f);
               	
				
					
	if (ctr==0) {	
      out.write(" \n");
      out.write("\t\n");
      out.write("\t<table class='boldtable' width=710 cellpadding='0' cellspacing='4' border='0'> \n");
      out.write("\t<tr><td width='15%' colspan=2 align='right'>&nbsp;</td>\n");
      out.write("\t<td width='60%' colspan=2 align='center'>\n");
      out.write("\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n");
      out.write("\t<img src=\"images/barcodeImages/");
      out.print(orderNo);
      out.write(".PNG\" width=\"120px;\"/></td>\n");
      out.write("\t<td width='25%' colspan=2 align='right'></td>\n");
      out.write("\t</tr>\n");
      out.write("\t\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t<tr><td colspan=2 align='right'>");
      out.print(totalItems);
      out.write('-');
      out.print(totalTaken);
      out.write('=');
      out.print(totalItems - totalTaken);
      out.write("</td>\n");
      out.write("\t\t<td colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(orderDate);
      out.write(' ');
      out.write('(');
      out.print(username);
      out.write(")</td><tr>\t\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t\t\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td width='15%' colspan=2 align='right'>");
      out.print(custCode);
      out.write("</td>\n");
			if(!deliveryRemark.equals("")){
				if(other_charges_amt>0){	

      out.write("\n");
      out.write("\t\t\t<td width='60%' colspan=2 align='center'>");
      out.print(custName);
      out.write(" (DI: ");
      out.print(deliveryRemark);
      out.write(") (Oth Chrgs : ");
      out.print(other_charges_amt);
      out.write(")</td>\n");
				}else if(other_charges_amt<=0){

      out.write("\n");
      out.write("\t\t\t<td width='60%' colspan=2 align='center'>");
      out.print(custName);
      out.write(" (DI: ");
      out.print(deliveryRemark);
      out.write(")</td>\n");
				}
			}else if(deliveryRemark.equals("")){
				if(other_charges_amt>0){

      out.write("\n");
      out.write("\t\t\t\t\t<td width='60%' colspan=2 align='center'>");
      out.print(custName);
      out.write(" (Oth Chrgs : ");
      out.print(other_charges_amt);
      out.write(")</td>\n");
				}else if(other_charges_amt<=0){

      out.write("\t\n");
      out.write("\t\t\t\t<td width='60%' colspan=2 align='center'>");
      out.print(custName);
      out.write("</td>\t\t\t\t\n");
				}
				System.out.println("deliveryRemark "+deliveryRemark);
			}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t<td width='25%' colspan=2 align='right'></td>\n");
      out.write("\t</tr>\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td colspan=5 width='80%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(buildingNo);
      out.write(',');
      out.write(' ');
      out.print(wing);
      out.write(',');
      out.write(' ');
      out.print(block);
      out.write(',');
      out.write(' ');
      out.print(building);
      out.write(',');
      out.write(' ');
      out.print(area);
      out.write("</td>\n");
      out.write("\t\t<td colspan=1 width='20%' align='right'>");
      out.print(phone);
      out.write("</td>\n");
      out.write("\t</tr>\n");
      out.write("\t\n");
      out.write("\t<tr>\n");
      out.write("\t\t<td colspan=5 width='80%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.print(add1);
      out.write(' ');
      out.write(',');
      out.print(add2);
      out.write(',');
      out.write(' ');
      out.print(station);
      out.write("</td>\n");
      out.write("\t\t<!--  <td colspan=1 width='20%' align='right' height=\"100%\"><img src=\"images/barcodeImages/");
      out.print(orderNo);
      out.write(".PNG\" width=\"150\" height=\"105%\"/></td>-->\n");
      out.write("\t\t<td colspan=1 width='20%' align=\"right\">");
      out.print(orderNo);
      out.write("</td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t<tr><td colspan=6></td></tr>\n");
      out.write("\t</table>\n");
 ctr = ctr + 1; 
	} 
	savings = totalValueMRP - totalValue;
	if(savings<0)
		savings=0.0f;
	
	
      out.write("\n");
      out.write("\t<table class='boldtable1' width=700 cellpadding='0' cellspacing='3' border='0'>\n");
      out.write("\n");
      out.write("<tr>\n");
      out.write("\t<td width='9%' valign=top align=\"left\">");
      out.print(itemWeight);
      out.write("</td>\n");
      out.write("\t");
 if ((itemQtyCheck-itemQty)==0)
	{ 
      out.write("\n");
      out.write("\t<td width='6%' valign=top align=\"left\">");
      out.print(dfQty1.format(itemQty));
      out.write("</td>\n");
      out.write("\t");
 } else { 
      out.write("\n");
      out.write("\t<td width='6%' valign=top align=\"left\">");
      out.print(dfQty.format(itemQty));
      out.write("</td>\n");
      out.write("\t");
 } 
      out.write("\n");
      out.write("\t\n");
      out.write("\t<td width='55%' valign=top align=\"left\">");
      out.print(itemName);
      out.write("&nbsp;");
      out.print(disRemark);
      out.write("</td>\n");
      out.write("\t");
 if(taken_ind > 0) { 
      out.write("\n");
      out.write("\t\t<td width='10%' valign=top>Taken</td>\n");
      out.write("\t");
 } else { 
      out.write("\n");
      out.write("\t<td width='10%' valign=top align=\"left\">&nbsp;</td>\n");
      out.write("\t");
}
      out.write("\n");
      out.write("\t<td width='10%' valign=top align=right>");
      out.print(df.format(itemTotPrice));
      out.write("</b></td>\n");
      out.write("\t");
 if(itemMRP<=0) { 
      out.write("\n");
      out.write("\t<td width='10%' valign=top align=right>NA</td>\n");
      out.write("\t");
 } else { 
      out.write("\n");
      out.write("\t<td width='10%' valign=top align=right>");
      out.print(df.format(itemMRP));
      out.write("</td>\n");
      out.write("\t");
}
      out.write("\n");
      out.write("</tr>\n");
      out.write("\n");
 
if(flag1){
if ((pageItemCount == itemsPerPage)&&(itemCount != totalItems)) 
{ 
	pageItemCount = 0;
      out.write("\n");
      out.write("<tr>\n");
      out.write("\t<td colSpan=6 align=right>Contd..</td>\t\n");
      out.write("\n");
      out.write("</tr>\n");
      out.write("<tr><td colSpan=6><p style=\"page-break-after:always;\">&nbsp;</p></td></tr>\n");
      out.write("\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("<tr><td colspan=6>&nbsp;</td></tr>\n");
      out.write("\n");
      out.write(" ");

}

if (itemCount==totalItems) {
	emptyLines = itemsPerPage - (totalItems%itemsPerPage);
	while ((emptyLines > 0)&&(emptyLines !=itemsPerPage)) { 
      out.write("\n");
      out.write("\n");
      out.write("\t<tr><td width='100%' colspan=6>&nbsp;</td></tr>\n");
      out.write("\n");
 emptyLines=(emptyLines - 1);} } }}
      out.write("\n");
      out.write("\n");
      out.write("<tr>\n");
      out.write("\t");
 if (bal_amt == 0 ) { 
      out.write("\n");
      out.write("\t<td colSpan=5 width='92%' cellspacing='0' align='right'><font size=\"5\"><B>");
      out.print(df.format(totalValue));
      out.write("</b></font></td>\n");
      out.write("\t<td colSpan=1 width='8%' cellspacing='0' align='right'>(");
      out.print(p_type);
      out.write(")</td>\t\n");
      out.write("\t");
 } else { 
      out.write("\n");
      out.write("\t<td colSpan=6 width='100%' cellspacing='0' align='right'>");
      out.print(df.format(totalValue));
      out.write('(');
      out.write('A');
      out.write(':');
      out.print(df.format(adv_amt));
      out.write(',');
      out.write('D');
      out.write(':');
      out.print(df.format(dis_amt));
      out.write(")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=\"5pt\"><B>Bal:");
      out.print(df.format(bal_amt));
      out.write("</b></font>(");
      out.print(p_type);
      out.write(")</td>\n");
      out.write("\t");
 } System.out.println("\n\n\ntotal value "+totalValue+"\t bal amt "+bal_amt);
      out.write("\n");
      out.write("</tr>\n");
      out.write("\n");
      out.write(" <tr><td colSpan=6 cellspacing='0' align='center'>");
      out.print( df.format(savings));
      out.write("/-</td></tr>\n");
      out.write("\n");
      out.write("</table>\n");

		
		rs.close();
		stat.close();
		conn.close();
	}catch(Exception e)
	{
		System.out.println("Exception occured in print order.jsp ="+e);
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}


      out.write("\n");
      out.write("<br><br>\n");
      out.write("<input type=\"hidden\" name=\"horderNo\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"orderNo\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"backPage\" value=\"");
      out.print(backPage);
      out.write("\">\n");
      out.write("<input type=\"hidden\" name=\"hstatusCode\" value=\"\">\n");
      out.write("<input type=\"hidden\" name=\"hcopy\" value=\"\">\n");
      out.write("</form>\n");
      out.write("<div id=\"id1\">\n");
      out.write("\n");

if(flag1){

      out.write("\n");
      out.write("<input type=\"submit\" id=\"Submit\" value=\"Print <Alt+p>\" accesskey=\"p\" onClick=\"Pass();\">\n");
      out.write("<input type=\"button\" id=\"Edit\" value=\"Edit <Alt+e>\" accesskey=\"e\" onClick=\"Edit();\">\n");
      out.write("<input type=\"button\" id=\"Cancel\" value=\"Return <Alt+r>\" accesskey=\"r\" onClick=\"back();\">\n");
      out.write("<input type=\"button\" id=\"Copy\" value=\"Copy <Alt+c>\" accesskey=\"c\" onClick=\"copy();\">\n");

}

      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("function Fun_Print(){    \n");
      out.write("     document.getElementById('id1').style.visibility=\"hidden\";\n");
      out.write("     self.print();\n");
      out.write("     back();\n");
      out.write("}\n");
      out.write("\n");
      out.write("function Pass(){\n");
      out.write("\tdocument.myform.orderNo.value=\"");
      out.print(orderNo);
      out.write("\";\n");
      out.write("\tdocument.myform.backPage.value=\"");
      out.print(backPage);
      out.write("\";\n");
      out.write("\tdocument.myform.action=\"print_order1.jsp?orderNo=");
      out.print(orderNo);
      out.write("\";\n");
      out.write("\tdocument.myform.submit();\n");
      out.write("\t\n");
      out.write("}\n");
      out.write("\n");
      out.write("\n");
      out.write("function back(){\n");
      out.write("\tvar backPage=\"\";\n");
      out.write("\tbackPage =\"");
      out.print(request.getParameter("backPage"));
      out.write("\";\n");
      out.write("\twindow.location=backPage;\n");
      out.write("}\n");
      out.write("function Edit(){\n");
      out.write("\tdocument.myform.hcopy.value=\"\";\n");
      out.write("\tdocument.myform.horderNo.value=\"");
      out.print(orderNo);
      out.write("\";\n");
      out.write("\tdocument.myform.hstatusCode.value=\"");
      out.print(statusCode);
      out.write("\";\t\t\n");
      out.write("\tdocument.myform.action=\"EditOrderForm.jsp\";\n");
      out.write("\tdocument.myform.submit();\n");
      out.write("\n");
      out.write("}\n");
      out.write("function copy(){\n");
      out.write("\tdocument.myform.horderNo.value=\"");
      out.print(orderNo);
      out.write("\";\n");
      out.write("\tdocument.myform.hcopy.value=\"");
      out.print(copyOrder);
      out.write("\";\n");
      out.write("\tdocument.myform.action=\"EditOrderForm.jsp\";\n");
      out.write("\tdocument.myform.submit();\n");
      out.write("}\n");
      out.write("window.onload = function(){\n");
      out.write("\tvar isPrint=\"");
      out.print(flag);
      out.write("\";\n");
      out.write("\tif (isPrint == \"N\") {\n");
      out.write("\t\t//Fun_Print();\n");
      out.write("\t}\n");
      out.write("}\t\n");
      out.write("</script>\n");
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
