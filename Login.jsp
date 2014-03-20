<jsp:useBean id="idHandler" class="user.Login" scope="request">
<jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>

<%
	System.out.println("login.jsp..............");
	String nextPage="",userTypeCode="";
	String str="";
	str=request.getParameter("Log");
	if(str==null){
		str="";
	}
  
	if(str.equals("1")){
		boolean ses; 
		ses=idHandler.logOff(request);
		if(ses==true){
%>
		<jsp:forward page="LoginForm.jsp" />
<%
		}
	}
	else {
		String auth,retauthval="5";
   		int  lenauth;

   		auth = idHandler.authenticate(request.getParameter("username"),request.getParameter("password"),request);
   		lenauth = auth.length() ;
   		retauthval = auth.substring(0,1);
   		System.out.println("session.getAttribute(' user_type_code') "+session.getAttribute("user_type_code"));
   		if (session.getAttribute("user_type_code") != null) {		
			userTypeCode = session.getAttribute("user_type_code").toString();
			 
		}
		if(userTypeCode.equals("3")){
			nextPage="HomeForm.jsp?exp=1";
		}
		else{
			nextPage="HomeForm.jsp";	
		}
	   
   		if (retauthval.equals("1")) {
%>
		<jsp:forward page="<%= nextPage%>" />
<%
		
    	}  
    	else if(retauthval.equals("2")) {
%>
				<jsp:forward page="LoginForm.jsp?Exp=2" />
        
<%              
		}
        else if(retauthval.equals("3")) {
%>
        
				<jsp:forward page="LoginForm.jsp?Exp=3" />  
<% 
		}
   		else {
%>
					<jsp:forward page="LoginForm.jsp?Exp=1" />
<%
   		}
	}
%>


