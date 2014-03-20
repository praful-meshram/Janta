<%@ page import="java.util.Hashtable" %>
<%
	String utype="";
	Hashtable HT = new Hashtable();
	String formName= request.getParameter("formName");
	//System.out.println("formName : "+ formName);
	if(session.getAttribute("user_type_code") !=null){
		utype=session.getAttribute("user_type_code").toString();
		
		if (session.getAttribute("ParaHash") != null) {	
			   HT = (Hashtable)session.getAttribute("ParaHash");	
			    if(formName!=null){	   
				   String access_flag = HT.get(formName).toString();
				  // System.out.println("access_flag : "+access_flag);
				   if(!access_flag.equals("Y") ){	
%>
				
					<jsp:forward page="HomeForm.jsp?exp=5&formname=<%=formName%>"/>
					
					
<%					}
			   }else{
%>
					<jsp:forward page="HomeForm.jsp?exp=5" />
<%	
		}
		}else{
%>
					<jsp:forward page="LoginForm.jsp?Exp=5" />
<%	
		}
		if(session==null) {
%> 
			<jsp:forward page="LoginForm.jsp" />
<%
		}
		else if(utype.equals("1")) {
%>    
			<jsp:forward page="LoginForm.jsp" />
<%       
		}
     }
		else{
%>
			<jsp:forward page="LoginForm.jsp" />
     
<%
		}
 %>  
         