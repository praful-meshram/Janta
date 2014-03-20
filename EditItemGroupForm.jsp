<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditItemGroupForm.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=EditItemGroupForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%@page contentType="text/html"%>

<%
		String ig_code="";
		String ig_desc="";
		String fmcg_flag="";
		ig_code=request.getParameter("ig_code");
		ig_desc=request.getParameter("ig_desc");
		fmcg_flag=request.getParameter("fmcg_flag");
		int ig_number = Integer.parseInt(request.getParameter("ig_number"));
		
%>
<script type="text/javascript">
	function checkField(){
		var idesc =document.myform.ig_desc.value;
		if(idesc=="") {
				alert("Please Enter Item Group Description");
				document.myform.ig_desc.focus();
				return false;
		}
		var ig_number =document.myform.ig_number.value;
		if(isNaN(ig_number)) {
				alert("Please Enter a number in  Item Group Number field.");
				document.myform.ig_number.focus();
				return false;
		}
		else{	
			var ans=confirm("Do you want to edit this Item Group?");
			if (ans==true){
				document.myform.action="EditItemGroup.jsp";
				document.myform.submit();
			}
			else{
			  	window.refresh; 
			}
		}
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	function Warn(){
		alert("U  Can't Change The Item Group Code");
    }
</script>
<center><h3>Edit Item Group</h3></center><br>
<form name="myform" action="EditItemGroup.jsp" method="post">
 	<table border="0" align="center">
		<tr>
			<td><b>Item Group Code</b></td><td><input type="text" name="ig_code" readonly value="<%=ig_code%>"  onClick="Warn();" ></td>
		</tr>
		<tr>
			<td><b>Item Group Description</b></td><td><input type="text" name="ig_desc" value="<%=ig_desc%>" ></td>
		</tr>
		<tr>
			<td><b>Item Group Number</b></td><td><input type="text" name="ig_number" value="<%=ig_number%>" ></td>
		</tr>
		<tr>
<%      
		if(fmcg_flag.equals("0")){
%> 
			<td><b>FMCG Flag</b></td><td><input type="checkbox" name="fmcg_flag"></td>
<%      }
		else{
%>
			<td><b>FMCG Flag</b></td><td><input type="checkbox" checked name="fmcg_flag"></td>
<%}%>
		
		</tr>
		</table>
  	<br><br> 
	<center><input type="submit" name="Submit"  disabled value="Submit <Alt+s>" accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
  	<input type="hidden" name="hfmcg_flag" value="0">
  </form>
 <script type="text/javascript"> 
 	function SetFlag(){
  		if(document.myform.fmcg_flag.checked==true){
  			document.myform.hfmcg_flag.value=1;  			
  			alert(document.myform.hfmcg_flag.value);
  		}
  		else{
  			document.myform.hfmcg_flag.value=0;
  			alert(document.myform.hfmcg_flag.value);
  		}
  	}
  		document.myform.ig_desc.focus();
      	function check(){
	    		document.myform.Submit.disabled=false;
		}
		document.onkeyup = check;
		document.onclick = check;		
		
</script>
</body>
</html>