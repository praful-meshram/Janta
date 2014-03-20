<%
	int vendorId = Integer.parseInt(request.getParameter("vendorId"));
	String vendorName = request.getParameter("vendorName");
	String vendorAddress = request.getParameter("vendorAddress");
	String vendorPhone = request.getParameter("vendorPhone");

	inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
	
	boolean flag = objMV.isExistEdit(vendorName, vendorId);
	if (flag) {
		String result = objMV.update(vendorId,vendorName, vendorAddress,
				vendorPhone);
		if (result.equals("Success")) {
			out.println("Vendor updated successfuly !");
			

		} else {

			out.println("Error !");

		}
	} else {
		out.println("Vendor already exist !");
	}
	objMV.closeAll();
%>