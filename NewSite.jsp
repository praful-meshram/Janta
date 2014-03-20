
<%
	String siteName = request.getParameter("siteName");
	String siteAddress = request.getParameter("siteAddress");
	String sitePhone = request.getParameter("sitePhone");

	inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
	boolean flag = objMV.isExist(siteName);
	if (flag) {
		out.println("Site already exist !");

	} else {
		String result = objMV.insert(siteName, siteAddress,
				sitePhone);
		if (result.equals("Success")) {
			out.println("Site added successfuly !");

		} else {

			out.println("Error !");

		}
	}
	objMV.closeAll();
%>
