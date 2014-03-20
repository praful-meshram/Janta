<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<%@ page errorPage="ErrorPage.jsp?page=SendMsgCustomerDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<jsp:include page="sessionBoth.jsp?formName=SendMsgCustomerDetails.jsp"/> 

<form name="myform" method="post">
<%	
        String hchckall= request.getParameter("hchckall"); 
       
		customer.ManageCustomer c;
		c = new customer.ManageCustomer("jdbc/js");
		if(hchckall.equals("1")){	
			c.listCustomers();
		}
		else{
			String name="";
	    	String phone="";
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
	    	
			name=request.getParameter("custName");
			phone=request.getParameter("phonenumber"); 
			building=request.getParameter("Building");
			building_no=request.getParameter("Building_no");
			block=request.getParameter("block");
			wing=request.getParameter("wing");
			add1=request.getParameter("add1");
			add2=request.getParameter("add2");
			custCode=request.getParameter("custCode");
			nameString=request.getParameter("nameString");
			c_date1=request.getParameter("c_date1");			
			c_date2=request.getParameter("c_date2");		
			u_date1=request.getParameter("u_date1");			
			u_date2=request.getParameter("u_date2");			
			area=request.getParameter("area");
			station=request.getParameter("station");
%>
			<input type="hidden" name="custCode" value="<%=custCode%>">
			<input type="hidden" name="custName" value="<%=name%>">
			<input type="hidden" name="phonenumber" value="<%=phone%>">
			<input type="hidden" name="Building" value="<%=building%>">
			<input type="hidden" name="Building_no" value="<%=building_no%>">
			<input type="hidden" name="block" value="<%=block%>">
			<input type="hidden" name="wing" value="<%=wing%>">
			<input type="hidden" name="add1" value="<%=add1%>">
			<input type="hidden" name="add2" value="<%=add2%>">
			<input type="hidden" name="nameString" value="<%=nameString%>">
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
			<input type="hidden" name="u_date1" value="<%=u_date1%>">
			<input type="hidden" name="u_date2" value="<%=u_date2%>">
			<input type="hidden" name="area" value="<%=area%>">
			<input type="hidden" name="station" value="<%=station%>">		
<%
			
			c.listCustomerWithDate(name, phone, building, building_no, block, wing, add1, add2, custCode, c_date1, c_date2, u_date1, u_date2,nameString, area, station,"","","","",""); 
		}
%>
      

       <table  id="id1" border="1" class="item3">
       	
        	<tr>
				<td width="5%"><b>CustCode</b></td>
				<td width="10%"><b>CustName</b></td>
				<td width="8%"><b>Phone</b></td>
				<td width="3%"><b>Building</b></td>
				<td width="3%"><b>Flat No.</b></td>
				<td width="3%"><b>Wing</b></td>
				<td width="10%"><b>Area</b></td>
				<td width="10%"><b>Mobile</b></td>	
				<td width="10%"><b>Send SMS</b></td>	
            </tr>
      
<%		    	
		
	    	while(c.rs.next()) {
 %>
			<tr >		
				<td>
<%             
    			out.println(c.rs.getString(8));
%>
    	 		</a></td><td>    			
<%			
				out.println(c.rs.getString(1));
%>
				</td><td>
<%			
				out.println(c.rs.getString(2));
%> 						
				</td><td>
<%	
           		out.println(c.rs.getString(3));
%>
				</td><td>
<%	
           		out.println(c.rs.getString(4));
%>
				</td><td>
<%	
				out.println(c.rs.getString(5));
%>
				</td><td>
<%	
				out.println(c.rs.getString(11));
%>
        		</td><td>
<%
				out.println(c.rs.getString(17));
%>
				</td>
				<td>
<%
				String msg= c.rs.getString(17); 
                if(!msg.equals("")){  
             
%>				
					
				<input type="CHECKBOX" name="chck" onclick="SelectMobile(<%=msg%>);"></td>
			</tr>			        	  
<%			}    
		}	
		c.closeAll();	
%>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>

</table>
<center> <br><br><b>Message : &nbsp&nbsp<b><input type="text" name="textmsg" size="50"><br><br>
<input type="submit" name="search"  title="Press <Enter>" value="Send <Enter>" accesskey="s" onclick="Send();return false;">
 
<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();">
			

<input type="hidden" name="hchckall" value="<%=hchckall%>">
<input type="hidden" name="hmsg" value="">
<input type="hidden" name="hcnt" value="">
<script>
  var codeArray = new Array(); 
  var cnt=0;

  var ct=0;
function showMsg(){
	  	 document.myform.action="SendBulkMessageForm.jsp";
	   	 document.myform.submit();
	}
function SelectMobile(msg){
	    var ch=0;
		for(ct=0;ct<=cnt;ct++){
			if(codeArray[ct]==msg){
				delete (codeArray[ct]);
				cnt=cnt-1;
				ch=ch+1;				
			}
		}
		if(ch==0){
		  codeArray[cnt]=msg;	
		   cnt=cnt+1;
		}	
	
	}
function Send(){
	if(cnt == 0){
	 alert("Select atleast one option");
	 return false;
	}
	else{
		document.myform.hmsg.value=codeArray;
		document.myform.hcnt.value=cnt;
		var ans = confirm("DO you want to Send Message .."+ document.myform.hmsg.value);
		if(ans = true){
			document.myform.action="SendBulkMessage.jsp";
			document.myform.submit();
		}
		else{
			window.refresh; 
		}
	}
}
	
</script>

</form>
</body>
</html>	