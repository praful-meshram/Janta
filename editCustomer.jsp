<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editCustomer.jsp" />	
</jsp:include> --%>
<%@ page errorPage="ErrorPage.jsp?page=editCustomer.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	String custCode="";
	custCode=request.getParameter("custCode");
	String custName="";
	custName=request.getParameter("custName");
	customer.ManageCustomer c;
	c = new customer.ManageCustomer("jdbc/js");	
	if (!request.getParameter("hoption").equals("1")){
		
		
		String phoneNo="";
		String building="";
		String building_no="";
		String block="";
		String wing="";
		String add1="";
		String add2="";
		String area="";
		String station="";
		String pincode="";
		String city="";
		String state="";	
		String mobile1="";
	
		phoneNo=request.getParameter("phone");
		building=request.getParameter("building");
		building_no=request.getParameter("buildingno");
		block=request.getParameter("block");
		wing=request.getParameter("wing");
		add1=request.getParameter("add1");
		add2=request.getParameter("add2");
		area=request.getParameter("area");
		station=request.getParameter("station");
		pincode=request.getParameter("pincode");
		city=request.getParameter("city");
		state=request.getParameter("state");		
		String payment =request.getParameter("payment");
		mobile1 = request.getParameter("mobileNum");
		
    	
		int ans = c.editCustomer(custCode,custName, building, building_no, block, wing, add1, add2, area, station, city, state, pincode, phoneNo,payment,mobile1); 
		
		
		
    	if(ans==1){
    		String hchckall = request.getParameter("hchckall");
    		if(hchckall.equals("1")){
    			String language_code="";
		    	String mobile="";
		    	String email="";
		    	String dob="";
		    	String marital_status="";
		    	String spouse_name="";
		    	String spouse_dob="";    	
		    	String marr_ann="";
		    	String totalmemb="";
		    	String grocery_name="";
		    	
		    	String occu_code="";    	
		    	String work_name="";  
		    	String work_add1="",work_add2="";  	
		    	String work_city="", work_state="", work_pincode="";
		    	String work_country="",work_tel="",work_fax="";
		    	
		    	language_code=request.getParameter("language_code");
		    	mobile=request.getParameter("mobile");
		    	email=request.getParameter("email");
		    	dob=request.getParameter("c_date1");
		    	marital_status=request.getParameter("marital_status");		    	
		    	spouse_name=request.getParameter("spouse_name");
		    	spouse_dob=request.getParameter("u_date1");
		    	marr_ann=request.getParameter("c_date2");   
		    	totalmemb=request.getParameter("totalmemb");
		    	grocery_name=request.getParameter("grocery_name");
		    	occu_code=request.getParameter("occu_code");
		    	work_name=request.getParameter("work_name");		    	
		    	work_add1=request.getParameter("work_add1");
		    	work_add2=request.getParameter("work_add2");
		    	work_city=request.getParameter("work_city");		
		    	work_state=request.getParameter("work_state");		
		    	work_pincode=request.getParameter("work_pincode");		
		    	work_country=request.getParameter("work_country");		
		    	work_tel=request.getParameter("work_tel");		
		    	work_fax=request.getParameter("work_fax");	
		    				
		    	int ans1= c.editCustomerAttribute(language_code, custCode, mobile, email, dob, marital_status, spouse_name, spouse_dob, marr_ann, totalmemb, grocery_name, occu_code, work_name, work_add1, work_add2, work_city, work_state, work_pincode, work_country, work_tel, work_fax);
		    	if(ans==1){
%>
    	    		<h3><b><br><br><br><center> Sucessfully Updated User   <font color="blue"> <br><br><%=custCode%>, <%=custName%> </font> </center></b></h3>
<%		    	
		    	
		    	}else{
%>
    	    	<h3><b><br><br><br><center> ERROR </center></b></h3>
<%			    	
		    	}
		    	
    		}else{
%>
    	    	<h3><b><br><br><br><center> Sucessfully Updated User   <font color="blue"> <br><br><%=custCode%>, <%=custName%> </font> </center></b></h3>
<%		    }
		}
		c.closeAll();
	}
	else{
		int ans = c.deleteCustomer(custCode);
		if(ans==1){
%>
    	    	<h3><b><br><br><br><center> Sucessfully Deleted Customer   <font color="blue"> <br><br><%=custCode%>, <%=custName%> </font> </center></b></h3>
<%		}
		c.closeAll();
	
	}
    	
%>  
