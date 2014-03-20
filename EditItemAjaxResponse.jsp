<%@page import="item.ManageItem"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String ajaxOption = request.getParameter("ajaxOption");
	//System.out.println("duplicate Record " +ajaxOption);
	if(ajaxOption.equals("duplicateRecord")){
		String ItemName = request.getParameter("name");
		String ItemWeight = request.getParameter("weight");
		String ItemGroup = request.getParameter("groupCode");
		
		ManageItem mi = new ManageItem("jdbc/js");
		System.out.println("i_weight "+ItemWeight);
		int chk = mi.CheckItem(ItemGroup,ItemName,ItemWeight);
		mi.closeAll();
		if(chk==1)
			System.out.println("duplicate Record ");
		else
			System.out.println("new Record ");
	
		out.print(chk);
	}
%>