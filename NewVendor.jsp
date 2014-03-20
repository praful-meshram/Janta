
<%
	String vendorName = request.getParameter("vendorName");
	String vendorAddress = request.getParameter("vendorAddress");
	String vendorPhone = request.getParameter("vendorPhone");

	inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
	boolean flag = objMV.isExist(vendorName);
	if (flag) {
		out.println("Vendor already exist !");

	} else {
		String result = objMV.insert(vendorName, vendorAddress,
				vendorPhone);
		if (result.equals("Success")) {
			out.println("Vendor created successfully !");

		} else {

			out.println("Error !");

		}
	}
	objMV.closeAll();
%>
