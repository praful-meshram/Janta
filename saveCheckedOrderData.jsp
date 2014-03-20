<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%
	Connection conn = null;
	Statement stmt = null, stat = null, stat1 = null;
	ResultSet rs1 = null;
	String orderNo = request.getParameter("orderNo");
	String bagNo = request.getParameter("bagNo");
	String oldItemValues = request.getParameter("oldItems");
	String newItemsValues = request.getParameter("newItems");
	String userName = session.getAttribute("UserName").toString();
	String objOldItemCode = "";
	String objNewItemCode = "";
	System.out.println("Old : " + oldItemValues);
	System.out.println("New : " + newItemsValues);
	float price = 0.0f, qty = 0.0f, oldPrice = 0.0f;
	boolean ans = false;
	order.ManageOrder mo = new order.ManageOrder("jdbc/js");
	if (!oldItemValues.equals("") && !newItemsValues.equals("")) {
		String[] arrOldItemList;
		String[] arrNewItemList;
		arrOldItemList = oldItemValues.split("##");
		arrNewItemList = newItemsValues.split("##");
		String[] arrOldItem;
		String[] arrNewItem;
		for (int i = 0; i < arrOldItemList.length; i++) {
			//---------get old item code
			arrOldItem = arrOldItemList[i].split("@@");
			objOldItemCode = arrOldItem[0];
			oldPrice = Float.parseFloat(arrOldItem[6]);
			//----------get new item data
			arrNewItem = arrNewItemList[i].split("@@");
			objNewItemCode = arrNewItem[0];
			price = Float.parseFloat(arrNewItem[5]);
			qty = Float.parseFloat(arrNewItem[4]);
			ans = mo.saveCheckedOrderItems(orderNo, objOldItemCode,
					oldPrice, objNewItemCode, price, qty);

		}
		if (ans) {
			ans = false;
			ans = mo.saveCheckedOrder(orderNo, userName, bagNo);
			if (ans) {
				try {
					Context initContext = new InitialContext();
					Context envContext = (Context) initContext
							.lookup("java:/comp/env");
					DataSource ds = (DataSource) envContext
							.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					stat = conn.createStatement();
					String query = "select od.item_code, od.qty, od.price_version, o.site_id from order_detail od, orders o "
							+ "where o.order_num = od.order_num and od.order_num = '"
							+ orderNo + "'";
					ResultSet rs = stmt.executeQuery(query);
					int count = 0;
					while (rs.next()) {
						String query1 = "update item_master set item_qty = item_qty - "
								+ rs.getInt(2)
								+ " where item_code = '"
								+ rs.getString(1) + "'";
						System.out.println("Master :" + query1);
						stat.executeUpdate(query1);
						query1 = "update item_price set item_pv_qty = item_pv_qty - "
								+ rs.getInt(2)
								+ " where item_code = '"
								+ rs.getString(1)
								+ "' "
								+ " and price_version  = " + rs.getInt(3);
						System.out.println("Price :" + query1);
						stat.executeUpdate(query1);
						query1 = "update item_site_inventory set item_site_qty = item_site_qty - "
								+ rs.getInt(2)
								+ " where item_code = '"
								+ rs.getString(1)
								+ "' "
								+ "and price_version  = "
								+ rs.getInt(3)
								+ " and site_id = " + rs.getInt(4);
						System.out.println("Site :" + query1);
						stat.executeUpdate(query1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				out.println("Swap");
			} else {
				out.println("ERROR");
			}
		}
		conn.close();
		
	} else {
		ans = mo.saveCheckedOrder(orderNo, userName, bagNo);
		if (ans) {
			try {
				Context initContext = new InitialContext();
				Context envContext = (Context) initContext
						.lookup("java:/comp/env");
				DataSource ds = (DataSource) envContext
						.lookup("jdbc/js");
				conn = ds.getConnection();
				stmt = conn.createStatement();
				stat = conn.createStatement();
				stat1 = conn.createStatement();
				String query = "select od.item_code, od.qty, od.price_version, o.site_id from order_detail od, orders o "
						+ "where o.order_num = od.order_num and od.order_num = '"
						+ orderNo + "'";
				ResultSet rs = stmt.executeQuery(query);
				int count = 0;
				while (rs.next()) {
					Statement st = conn.createStatement();
					String query1 = "update item_master set item_qty = item_qty - "
							+ rs.getInt(2)
							+ " where item_code = '"
							+ rs.getString(1) + "'";
					System.out.println("Master :" + query1);
					st.executeUpdate(query1);
					query1 = "update item_price set item_pv_qty = item_pv_qty - "
							+ rs.getInt(2)
							+ " where item_code = '"
							+ rs.getString(1)
							+ "' "
							+ " and price_version  = " + rs.getInt(3);
					System.out.println("Price :" + query1);
					st.executeUpdate(query1);
					query1 = "update item_site_inventory set item_site_qty = item_site_qty - "
							+ rs.getInt(2)
							+ " where item_code = '"
							+ rs.getString(1)
							+ "' "
							+ "and price_version  = "
							+ rs.getInt(3)
							+ " and site_id = " + rs.getInt(4);
					System.out.println("Site :" + query1);
					st.executeUpdate(query1);
				}
			} catch (Exception e) {
				e.printStackTrace();
				
			}
			out.println("Success");
		} else {
			out.println("ERROR");
		}
		conn.close();
	}
	mo.closeAll();
%>