<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="bachka.*"%>
<%
    GetBachkaList db = new GetBachkaList();
 
    String query = request.getParameter("q");
     
    List<String> countries = db.getData(query);
 
    Iterator<String> iterator = countries.iterator();
    while(iterator.hasNext()) {
        String bachka = (String)iterator.next();
        out.println(bachka);
    }
%>