<%
	int siteId = Integer.parseInt(request.getParameter("siteId"));
	String siteName = request.getParameter("siteName");
	String siteAddress = request.getParameter("siteAddress");
	String sitePhone = request.getParameter("sitePhone");

	inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
	boolean flag = objMV.isExist(siteName);
	if (flag) {
		String result = objMV.update(siteId,siteName, siteAddress,
				sitePhone);
		if (result.equals("Success")) {
			out.println("Site updated successfuly !");

		} else {

			out.println("Error !");

		}
	} else {
		out.println("Site does not exist !");
	}
	objMV.closeAll();
%>