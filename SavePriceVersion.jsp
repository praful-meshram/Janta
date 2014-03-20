<%@page import="item.ManageItem"%>
<%@page import="java.util.ArrayList"%>
<%
String item_codes[]=request.getParameterValues("item_code");
String current_pv[]=new String[item_codes.length];
ArrayList<String[]> discard_pv = new ArrayList<String[]>();
ManageItem mi = new ManageItem("jdbc/js");
for(int i=0;i<item_codes.length;i++){
	current_pv[i] = request.getParameter("current_"+item_codes[i]);
	mi.setCurrentPV(item_codes[i],current_pv[i]);
	discard_pv.add(i,request.getParameterValues("discard_"+item_codes[i]));
	if(discard_pv.get(i)!=null)
		mi.discardPV(item_codes[i],discard_pv.get(i));
}
mi.closeAll();
response.sendRedirect("ManagePriceVersion.jsp?start_with=AA");
%>