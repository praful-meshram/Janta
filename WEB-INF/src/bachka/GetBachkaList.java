package bachka;

import java.util.ArrayList;
import java.util.List;
import inventory.*;

public class GetBachkaList {
	public List<String> getData(String query) {
		List<String> matched = new ArrayList<String>();
		ManageInventory objMI = null;
		try {
			objMI = new ManageInventory("jdbc/js");
			objMI.getBachkaList(query);
			while (objMI.rs.next()) {
				matched.add(objMI.rs.getString(1));
			}
			objMI.closeAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return matched;
	}
}
