/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2014-02-24 12:02:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.google.gson.Gson;
import java.util.ArrayList;
import beans.jqxgridFormat;
import beans.JsonOutputBean;
import beans.CustomerBean;
import payment.ManagePayment;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.io.*;

public final class editCustomerDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "sessionBoth.jsp" + (("sessionBoth.jsp").indexOf('?')>0? '&': '?') + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("formName", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("editCustomerDetails.jsp", request.getCharacterEncoding()), out, false);
      out.write('\n');
		
String call_type=request.getParameter("call_type");
//String call_type=request.getParameter("type");

System.out.println("call type "+call_type);
	if(call_type == null){
		call_type = "";
	}
	String type = request.getParameter("type");
	customer.ManageCustomer c;
	//c = new customer.ManageCustomer("jdbc/js");
	c = new customer.ManageCustomer("jdbc/re");
	
	if(type.equals("dispList")){
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
		String hchckall="";
		hchckall=request.getParameter("hchckallStartWith");
		String fromForm="";
		fromForm=request.getParameter("fromForm");		
		String selmonth="";
		System.out.println(" hchckall "+hchckall);
		if(hchckall.equals("1")){
			c.listCustomers();
		}
		else{
			String name="";
	    	String phone="";
	    	String mobile="";
	    	String building="";
	    	String block="";
	    	String wing="";
	    	String add1="";
	    	String add2="";
	    	String custCode="";
	    	String nameString="";
	    	String c_date1="";
	    	String c_date2="";
	    	String u_date1="";    	
	    	String u_date2="";    	
	    	String city="", state="", area="";
	    	String building_no="", station="";
	    	String ordernumber = "";
	    	
	  		 //name=request.getParameter("name");
			name=request.getParameter("nameStartWith");
		
			phone=request.getParameter("phStartWith"); 
			building=request.getParameter("bldgStartWith");
			building_no=request.getParameter("bldgnoStartWith");
			block=request.getParameter("blockStartWith");
			wing=request.getParameter("wingStartWith");
			add1=request.getParameter("add1StartWith");
			add2=request.getParameter("add2StartWith");
			custCode=request.getParameter("custCodeStartWith");
			nameString=request.getParameter("nameStringStartWith");
			c_date1=request.getParameter("c_date1StartWith");
			c_date2=request.getParameter("c_date2StartWith");
			u_date1=request.getParameter("u_date1StartWith");
			u_date2=request.getParameter("u_date2StartWith");
			area=request.getParameter("areaStartWith");
			station=request.getParameter("stationStartWith");
			selmonth = request.getParameter("selmonth");
			String payment = request.getParameter("payment");
			mobile = request.getParameter("moStartWith");
			if(request.getParameter("ordernumber") != null){
				ordernumber = request.getParameter("ordernumber");
			}
			System.out.println(name +"c_date1 "+c_date1+" u_date1 "+u_date1+" nameString "+nameString);
			System.out.println("c_date2 "+c_date2+" u_date1 "+u_date2);
			c.listCustomerWithDate(name, phone, building, building_no, block, wing, add1, add2, custCode, 
					c_date1, c_date2, u_date1, u_date2,nameString, area, station,selmonth,payment,mobile,
					call_type,ordernumber); 
	}
		if(call_type.equals("search_payment")){
		
      out.write("\t\n");
      out.write("\t\t<div style=\"width:100%;\">\n");
      out.write("\t\t\t<input type= \"checkbox\" id=\"respective_check\" style=\"float: left; margin-left: 1%;px;\"/>\n");
      out.write("\t\t\t<font style=\"float: left; color: red;\">Select Other Order of same customer</font>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t<br/>\n");
      out.write("\t\t<br/>\n");
      out.write("\t\t");
} 
				
 				/* jsonOutputBean.getFormat().add(new jqxgridFormat("Cust Code","custcode"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Cust Name","custname"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Phone","phone"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Mobile","mobile1")); */
			
      out.write("\n");
      out.write("\t\t\t\t<table style=\"text-align: left;border-collapse: collapse;width: 100%;\" border=\"1\">\n");
      out.write("\t\t\t\t\t<thead>\n");
      out.write("\t\t\t\t\t\t<tr>");
if(call_type.equals("communication") || call_type.equals("search_payment") || call_type.equals("receive_payment")){
							out.print("<td>Cust Code</td>");
						} else
							out.print("<td>Cust Code</td>");
						
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t<td>Cust Name</td> \n");
      out.write("\t\t\t\t\t\t\t<td>Phone</td>\n");
      out.write("\t\t\t\t\t\t\t<td>Mobile</td>\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t");

				
				
				if(call_type.equals("communication")){
			/* 		jsonOutputBean.getFormat().add(new jqxgridFormat("Contact Date","contactDate"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Commit Date","commitDate")); */ 
					
      out.write("\n");
      out.write("\t\t\t\t\t\t<td>Contact Date</td>\n");
      out.write("\t\t\t\t\t\t<td>Commit Date</td>\n");
      out.write("\t\t\t\t\t");

				}else{
			/* 		jsonOutputBean.getFormat().add(new jqxgridFormat("Building","building"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Flat No.","building_no"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area"));  */
					
      out.write("\n");
      out.write("\t\t\t\t\t<td>Building</td>\n");
      out.write("\t\t\t\t\t<td>Flat No.</td>\n");
      out.write("\t\t\t\t\t<td>Area.</td>\n");
      out.write("\t\t\t\t\t");

				}
				if(call_type.equals("search_payment") || call_type.equals("communication")){
					
					/* jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","order_number"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Date","orderdate"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Del Date ","del_date"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Balance","balance"));  */
					
					
      out.write("\n");
      out.write("\t\t\t\t\t<td>Order Number</td>\n");
      out.write("\t\t\t\t\t<td>Date </td>\n");
      out.write("\t\t\t\t\t<td>Del Date</td>\n");
      out.write("\t\t\t\t\t<td>Payment Type</td>\n");
      out.write("\t\t\t\t\t<td>Balance</td>\n");
      out.write("\t\t\t\t\t");
	
				}else{
					/*  jsonOutputBean.getFormat().add(new jqxgridFormat("Create Date","create_datetime"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Update Date","update_datetime"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type ","payment_type"));  */
					
      out.write("\n");
      out.write("\t\t\t\t\t<td>Create Date</td>\n");
      out.write("\t\t\t\t\t<td>Update Date </td>\n");
      out.write("\t\t\t\t\t<td>Payment Type</td>\n");
      out.write("\t\t\t\t\t");
if(call_type.equals("receive_payment")){
					
      out.write("\n");
      out.write("\t\t\t\t\t<td>Balance</td>\n");
      out.write("\t\t\t\t\t");
	}
			}
				if(selmonth !=null && selmonth !=""){				
					/*  jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order No.","last_order_num"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order Date","last_order_date"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Days ","DATEDIFF"));  */
					
      out.write("\n");
      out.write("\t\t\t\t\t<td>Last Order No.</td>\n");
      out.write("\t\t\t\t\t<td>Last Order Date</td>\n");
      out.write("\t\t\t\t\t<td>Days</td>\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t");
	
				}
		
      out.write("\t\t</tr>\n");
      out.write("\t\t\t\t</thead>\n");
      out.write("\t\t\t\t<tbody>\n");
      out.write("\t\t");

		int count = 0;
		//ArrayList<CustomerBean> listOutputBeans = new ArrayList();
    	while(c.rs.next()) {
    		//CustomerBean outputBean = new CustomerBean();
    		
      out.write("\n");
      out.write("    \t\t<tr id=\"tr_");
      out.print(count);
      out.write("\" onmouseover=\"onMouseOver(this);\" onmouseout=\"onMouseOut(this);\" style=\"cursor: pointer;\">\n");
      out.write("    \t\t");

       		String custCodeLink=null;
			if(fromForm.equals("CustPmtHstry")){
			custCodeLink = 	"<a href=\"editCustPaymentHistoryForm.jsp?name="+c.rs.getString(1)+"&cuscode="+c.rs.getString(8)+"\" >";
			
      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t<td>");
      out.print(custCodeLink+c.rs.getString(8)+"</a>");
      out.write("</td>\n");
      out.write("\t\t\t");

			}else if(call_type.equals("search_payment") || call_type.equals("communication")){
		/* 	custCodeLink="<input id='ch_"+count+"' type='checkbox' name =selected_cust value='true' "+
							"onclick=selectCustomer('ch_"+count+"','tr_"+count+"','"+c.rs.getString(8)+"','"+c.rs.getString("order_number")+"','"+c.rs.getString(1)+
							"','"+c.rs.getFloat("balance")+"')/>"; */
			custCodeLink=c.rs.getString(8);				
							
							
			if(call_type.equals("search_payment")){
					custCodeLink="<input id=ch_"+count+" type='checkbox' name =selected_cust value='true' "+
							"onclick=\"selectCustomer('ch_"+count+"','tr_"+count+"','"+c.rs.getString(8)+"','"+c.rs.getString("order_number")+"','"+c.rs.getString(1)+
							"','"+c.rs.getFloat("balance")+"')\"/>"+c.rs.getString(8)+"</a>";
							
				} 
		
				
      out.write("\n");
      out.write("\t\t\t\t\t\t");
      out.write("\n");
      out.write("\t\t\t\t\t\t<td>");
      out.print(custCodeLink);
      out.write("</td>\n");
      out.write("\t\t\t\t");
	
			}else if(call_type.equals("receive_payment")){
				
      out.write("\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString(8)+"</a>");
      out.write("</td>\n");
      out.write("\t\t\t");
	

			}else{
				custCodeLink="<a href=\"editCustomerForm.jsp?name="+c.rs.getString(1)+"&tele="+c.rs.getString(2)+"&bldg="+c.rs.getString(3)+"&block="+c.rs.getString(4)+
				"&wing="+c.rs.getString(5)+"&add1="+c.rs.getString(6)+"&add2="+c.rs.getString(7)+"&cuscode="+c.rs.getString(8)+"&area="+c.rs.getString(11)+"&station="+
				c.rs.getString(16)+"&pincode="+c.rs.getString(12)+"&city="+c.rs.getString(13)+"&state="+c.rs.getString(14)+"&building_no="+c.rs.getString(15)+
				"&payment="+c.rs.getString(18)+"&mobile="+c.rs.getString(17)+"\">";
				
      out.write("\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t<td>");
      out.print(custCodeLink+c.rs.getString(8)+"</a>");
      out.write("</td>\n");
      out.write("\t\t\t");

			}
			//outputBean.setCustcode(custCodeLink+c.rs.getString(8)+"</a>");
			
			if(call_type.equals("communication")){
				//outputBean.setCustname("<font color=blue style=\"cursor: pointer;\" onclick=\"dispCommForm('"+c.rs.getString(8)+">')\"><u>"+c.rs.getString(1)+"</u></font>"); 
				
      out.write("\n");
      out.write("\t\t\t\t\t<td><font color=blue style=\"cursor: pointer;\" onclick=\"dispCommForm('");
      out.print(c.rs.getString(8));
      out.write("')\"><u>");
      out.print(c.rs.getString(1) );
      out.write("</u></font></td>\n");
      out.write("\t\t\t\t");

			}else{
				//outputBean.setCustname(c.rs.getString(1));
				
      out.write("\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString(1) );
      out.write("</td>\n");
      out.write("\t\t\t\t");

			}
			/* outputBean.setPhone(c.rs.getString(2));
			outputBean.setMobile1(c.rs.getString(17)); */
			
      out.write("\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString(2) );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString(17) );
      out.write("</td>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t");

			if(call_type.equals("communication")){
				//ManagePayment mp = new ManagePayment("jdbc/js");
				ManagePayment mp = new ManagePayment("jdbc/re");
				mp.getLastCommDetail(c.rs.getString(8));
				if(mp.rs.next()){
				/*  outputBean.setContactDate(mp.rs.getString(1));
				outputBean.setCommitDate(c.rs.getString(2));  */

				
      out.write("\n");
      out.write("\t\t\t\t<td>");
      out.print(mp.rs.getString(1) );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(mp.rs.getString(2) );
      out.write("</td>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t");

				
				} else {
			/* 		 outputBean.setContactDate("--");
					outputBean.setCommitDate("--");  */
					
      out.write("\n");
      out.write("\t\t\t\t\t<td style=\"text-align: center;\">--</td>\n");
      out.write("\t\t\t\t\t<td style=\"text-align: center;\">--</td>\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t\t");

				}
				mp.closeAll();
			}else{
/* 			 outputBean.setBuilding(c.rs.getString(3));
			outputBean.setBuilding_no(c.rs.getString(15));
           outputBean.setArea(c.rs.getString(11));  */
           
      out.write("\n");
      out.write("\t\t\t<td>");
      out.print(c.rs.getString(3) );
      out.write("</td>\n");
      out.write("\t\t\t<td>");
      out.print(c.rs.getString(15) );
      out.write("</td>\n");
      out.write("\t\t\t<td>");
      out.print(c.rs.getString(11) );
      out.write("</td>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");

			
			}
			if(call_type.equals("search_payment") || call_type.equals("communication")){
			

				/*  outputBean.setOrder_number(c.rs.getString("order_number"));
				outputBean.setOrderdate(c.rs.getString("orderdate"));	 
				outputBean.setDel_date(c.rs.getString("del_date"));	 */
				
      out.write("\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString("order_number") );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString("orderdate") );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(c.rs.getString("del_date") );
      out.write("</td>\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t");

				
			}else{
			/* outputBean.setCreate_datetime(c.rs.getString(9));	
          	outputBean.setUpdate_datetime(c.rs.getString(10));   */
          	
      out.write("\n");
      out.write("\t\t\t<td>");
      out.print(c.rs.getString(9) );
      out.write("</td>\n");
      out.write("\t\t\t<td>");
      out.print(c.rs.getString(10) );
      out.write("</td>\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t");

			}
           	String paytype=c.rs.getString(18);
           	//outputBean.setPayment_type(paytype);
           String	typedesc = c.getpaytype(paytype);
           	if(paytype.equals("")){
           		paytype = "NO TYPE";
           	 	//outputBean.setPayment_type("NO TYPE");
           	 
      out.write("\n");
      out.write(" \t\t\t<td>");
      out.print("NO TYPE");
      out.write("</td>\n");
      out.write(" \t\t\t\n");
      out.write(" \t\t\t\n");
      out.write(" \t\t\t");

           		
           	}else{
           		
      out.write("\n");
      out.write("           \t\t<td>");
      out.print(typedesc);
      out.write("</td>\n");
      out.write("           \t\t");

           	}
			if(call_type.equals("receive_payment")){
				//outputBean.setBalance("<a href=\"ReceivePayment.jsp?cust_code="+c.rs.getString(8)+"\">"+c.rs.getFloat("balance")+"</a>");
				 
      out.write("\n");
      out.write("\t\t \t\t\t<td><a href=\"ReceivePayment.jsp?cust_code_=");
      out.print(c.rs.getString(8));
      out.write('"');
      out.write('>');
      out.print(c.rs.getFloat("balance") );
      out.write("</a></td>\n");
      out.write("\t\t \t\t\t\n");
      out.write("\t\t \t\t\t\n");
      out.write("\t\t \t\t\t");

			}else if(call_type.equals("search_payment") || call_type.equals("communication")){
			//outputBean.setBalance((c.rs.getFloat("balance")+"").trim());
			 
      out.write("\n");
      out.write("\t \t\t\t<td>");
      out.print((c.rs.getFloat("balance")+"").trim());
      out.write("</td>\n");
      out.write("\t \t\t\t\n");
      out.write("\t \t\t\t\n");
      out.write("\t \t\t\t");

			}else{
				//String typedesc =null;
		
			if(paytype.equals("NO TYPE")){
				typedesc = "NO TYPE";
				
			}else{
				typedesc = c.getpaytype(paytype);
           		
           	}
			//System.out.println("typedesc "+typedesc);
			//outputBean.setPayment_type("<a href=\"JavaScript:dispDiv('"+c.rs.getString(8)+"','"+c.rs.getString(1)+"','"+paytype+"','"+c.rs.getString(11)+"');\">"+typedesc+"</a>");
			String a = "<a href=\"JavaScript:dispDiv('"+c.rs.getString(8)+"','"+c.rs.getString(1)+"','"+paytype+"','"+c.rs.getString(11)+"');\">"+typedesc+"</a>";
			
      out.write("\n");
      out.write(" \t\t\t");
      out.write("\n");
      out.write(" \t\t\t\n");
      out.write(" \t\t\t");

			}

				if(selmonth !=null && selmonth !=""){	
					/* outputBean.setLast_order_num(c.rs.getString(19));
					outputBean.setLast_order_date(c.rs.getString(20));
					outputBean.setDATEDIFF(c.rs.getString(21)); */
					
      out.write("\n");
      out.write("\t\t \t\t\t<td>");
      out.print(c.rs.getString(19) );
      out.write("</td>\n");
      out.write("\t\t \t\t\t<td>");
      out.print(c.rs.getString(20) );
      out.write("</td>\n");
      out.write("\t\t \t\t\t<td>");
      out.print(c.rs.getString(21) );
      out.write("</td>\n");
      out.write("\t\t \t\t\t\n");
      out.write("\t\t \t\t\t");

				}
				
	count++;
	//listOutputBeans.add(outputBean);
	}    
    //jsonOutputBean.setOutputData(listOutputBeans);	
    
    //System.out.println(new Gson().toJson(jsonOutputBean));
    //out.println(new Gson().toJson(jsonOutputBean));
    	

      out.write("\n");
      out.write("</tbody>\n");
      out.write("</table>\n");
      out.write("\t\t\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<ceneter> <div id=\"dispdiv\" align=\"center\" style=\"border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF; overflow:auto; height:300px; width=200px;\"> </div></center>\n");
      out.write("\t        <input type=\"hidden\" id=\"rows\" name=\"rows\" value=\"");
      out.print(count);
      out.write("\"/>\t  \n");
      out.write("\n");
		
	}else if(type.equals("dispDiv")){
	  String custcode = request.getParameter("custcode");
	  String custname = request.getParameter("custname");
	  String payment =  request.getParameter("payment");	
	  String area=  request.getParameter("area");
	    

      out.write("\t  <div style=\"z-index: 1000\">\n");
      out.write("\t  <table style=\"z-index: 1000\">\n");
      out.write("\t  \t<tr><td><b>Customer Code </b> &nbsp;: &nbsp; ");
      out.print( custcode);
      out.write("</td>\n");
      out.write("\t  \t<td><b>Customer Name</b> &nbsp;: &nbsp; ");
      out.print( custname);
      out.write("</td>\n");
      out.write("\t\t<td><b>Payment Type</b>   &nbsp;:&nbsp; <select name=\"selpay\" id=\"selpay1\" >\n");
 	
			if(payment.equals("NO TYPE")){

      out.write("\n");
      out.write("\t\t\t\t<option value=\"select\"> Select Type</option>\n");
			}		
				c.disppaytype();
				while(c.rs1.next()){
				
 			 if(c.rs1.getString(1).equals(payment)){
      out.write("\n");
      out.write("\t\t\t\t<option selected value=\"");
      out.print(c.rs1.getString(1));
      out.write('"');
      out.write('>');
      out.print(c.rs1.getString(2));
      out.write("</option>\n");
			}
      out.write("\t\t\t\t\n");
      out.write("\t\t\t\t<option value=\"");
      out.print(c.rs1.getString(1));
      out.write('"');
      out.write('>');
      out.print(c.rs1.getString(2));
      out.write("</option>\n");
			 }
      out.write("\n");
      out.write("\t  \t\t</select></td>\n");
      out.write("\t  \t</tr>\n");
      out.write("\t  \t<tr><td colspan=\"3\">\n");
      out.write("\t  \t\t<div style=\"overflow:auto; height:200px;\">\n");
      out.write("\t  \t\t<table  border=\"1\" id=\"id\" class=\"item3\" align=\"center\" width=\"100%\">  \n");
      out.write("\t\t\t\t<th colspan=\"10\"><b>Order Details</b></th>\n");
      out.write("\t\t      \t<tr>\t\t\t\t\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Order Number</b></td>\t\t\t\t\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Order Date</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Total Items</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Total Values</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>MRP</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Discount</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Balance Amount</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Payment Type</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"10%\"><b>Last Modified Date</b></td>\n");
      out.write("\t\t\t\t\t<td width=\"5%\"><b>Status </b></td>\n");
      out.write("\t\t\t</tr>\n");
	
		c.getcustDetails(custcode);
			String orderno,orderdt,totalitem , paymenttype,lastdt,status;
			float totval,mrp,dis,bal;
			float sumval=0.0f,summrp=0.0f,sumdis=0.0f,sumbal=0.0f;
    	while(c.rs.next()) {
    	   orderno = c.rs.getString(1);
    	   orderdt= c.rs.getString(2);
    	   totalitem = c.rs.getString(3);
    	   totval=c.rs.getFloat(4);
    	   mrp=c.rs.getFloat(5);
    	   dis=c.rs.getFloat(6);
    	   paymenttype= c.rs.getString(7);
    	   lastdt= c.rs.getString(8);
    	   status= c.rs.getString(9);
    	   bal =  c.rs.getFloat(10);    	   
    	   
    	   sumval = sumval + totval;
    	   //summrp = summrp = mrp;
    	  // sumdis = sumdis + dis;
    	   sumbal = sumbal +bal;

      out.write("\n");
      out.write("\t\t\t<tr id=\"tr\"><td align=\"left\" width=\"10%\">\n");
 out.println(c.rs.getString(1));
      out.write("\n");
      out.write("\t\t\t</td><td align=\"left\" width=\"10%\">\n");
 out.println(c.rs.getString(2));
      out.write("\n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\">\n");
 out.println(c.rs.getString(3));
      out.write("\n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\">\n");
 out.println(c.rs.getString(4));
      out.write("\n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\">\n");
	out.println(c.rs.getString(5));
      out.write("       \n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\">\n");
	out.println(c.rs.getString(6));
      out.write("       \n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\">\n");
	out.println(c.rs.getString(10));
      out.write("       \n");
      out.write("\t    \t</td><td align=\"left\" width=\"10%\">\n");
	out.println(c.rs.getString(7));
      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" width=\"10%\">\n");
	out.println(c.rs.getString(8));
      out.write("       \n");
      out.write("\t\t\t</td><td align=\"left\" width=\"10%\">\n");
	out.println(c.rs.getString(9));
      out.write("       \n");
      out.write("\t\t\t</td></tr>\t\t\t\t\t\t        \t  \n");
		}
      out.write("\n");
      out.write("\n");
      out.write("<tr id=\"tr\"><td align=\"left\" width=\"10%\">\n");
      out.write("\t\t\t</td><td align=\"right\"  width=\"10%\">\n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\"><b>Total :</b>\n");
      out.write("\t\t\t</font></td><td align=\"right\" width=\"10%\"><font color=\"red\">\n");
 out.println(sumval);
      out.write("\n");
      out.write("\t\t\t</font></td><td align=\"right\" width=\"10%\"><font color=\"red\">     \n");
      out.write("\t\t\t</font></td><td align=\"right\" width=\"10%\">\n");
      out.write("\t\t\t</td><td align=\"right\" width=\"10%\"> <font color=\"red\">\n");
	out.println(sumbal);
      out.write("       \n");
      out.write("\t\t\t</font>     \n");
      out.write("\t    \t</td><td align=\"left\" width=\"10%\"> \n");
      out.write("\t\t\t</td><td align=\"left\" width=\"10%\">     \n");
      out.write("\t\t\t</td><td align=\"left\" width=\"10%\">\n");
      out.write("\t\t\t</td></tr>\t\t\t    \n");
      out.write("\t  \t</table> </div> \t\n");
      out.write("\t  \t</td></tr>\n");
      out.write("\t  \t<tr><td align =\"center\" colspan=\"3\"><input type=\"button\" value=\"Save Payment Type\" onclick=\"funsave('");
      out.print( custcode);
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print( custname);
      out.write("');return false;\"><input type=\"button\" name=\"return\" value=\"Close\" onclick=\"funclose();\"></td></tr>\n");
      out.write("\t  </table>\n");
      out.write("\t  </div>\n");
      out.write("\t  \n");

	}else if(type.equals("savepay")){
	
		 String custcode = request.getParameter("custcode");	
		 String custname = request.getParameter("custname");  
	 	 String payment =  request.getParameter("payment");
	 	// System.out.println(custcode+payment);
	 	 int ans = c.savePaymentType(custcode,payment);
	 	 if(ans == 1){
	 	 	String typedesc = c.getpaytype(payment);

      out.write("\n");
      out.write("\t\tAdded Payment Type ");
      out.print(typedesc  );
      out.write(" for ");
      out.print( custcode );
      out.write(' ');
      out.write(',');
      out.print( custname );
      out.write(' ');
      out.write('\n');

	 	 }else{

      out.write("\n");
      out.write("\t\t<center> Error</center>\n");

	 	 }
	}
	c.closeAll();

      out.write('\n');
      out.write('\n');
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