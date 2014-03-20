<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="Denominations.jsp" />	
</jsp:include>
  --%>
  
 <%@ page errorPage="ErrorPage.jsp?page=Denominations.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%	String strflag="";
    int chckcnt =0;
     try{
        
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");  
		mo.getAllcoininfo();
%>   
<form name="myform" method="POST" onsubmit="return false;"> 	
<script>
	 var arrayono = new Array();
	 var cnt= 0,tempcnt=0;
 
	 function funvd(tcnt){
	    for(tempcnt=0; tempcnt<tcnt; tempcnt++){ 
		     if (eval("document.myform.chckflag"+tempcnt+".checked")== true){
			  	arrayono[tempcnt] = eval("document.myform.chckflag"+tempcnt+".value"); 
			 }
		}
	    document.myform.hdenomid.value = arrayono;	    
	    document.myform.action="DenominationsSave.jsp";
	    document.myform.submit();
	 }
	 function check(){
	    document.myform.Submit.disabled = false;
	 }
	document.onclick = check;
	
	function Cancel(){
		document.myform.action="HomeForm.jsp";
	    document.myform.submit();
	}
</script>
    	<br><br><br><center><table   border="1" class="item3"  >
    	<tr><th colspan="5"><center><b>Valid Denomination </b></center></th></tr>
			<tr> 
				<td><b>Denom Id</b></td>
				<td><b>Denom Value</b></td>
				<td><b>Denom Description</b></td>
				<td><b>Update</b></td>					
		   </tr>
<%		

		while(mo.rs2.next()){
		
%>
        
             <tr> 
             <td> 
<%			
			out.println(mo.rs2.getString(1));
%>       
						
			</td><td>
<%	
           	out.println(mo.rs2.getString(2));
%>
			</td><td>
<%	
           	out.println(mo.rs2.getString(3));
%>	
			</td><td>
<%	
			
			if(mo.rs2.getString(4).equals("Y")){			
%>			
			<input type="checkbox" name="chckflag<%=chckcnt%>" value="<%=mo.rs2.getString(1)%>" checked >
<%	
 			}else{
 			 
%>	
			<input type="checkbox" name="chckflag<%=chckcnt%>" value="<%=mo.rs2.getString(1)%>" >
			</td></tr>
<%		    }
         chckcnt= chckcnt +1;
		}	
		mo.closeAll();			
	}catch(Exception e){
		System.out.println(e);
	}		
%>
</table><br><br>
<input type="submit" name="Submit" value="Save <Alt+s>" disabled accesskey ="s" onclick="funvd(<%=chckcnt%>);return false;">
<input type="button" name="Cancel" value="Cancel <Alt+c>" accesskey ="c" onclick="Cancel();">
<input type="hidden" name="hdenomid">
</form>


