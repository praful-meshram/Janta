package outputbean;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Vector;

/**
 * @author praful
 * @date 14-02-2014
 * 
 * code for Jasper bean to pass array list and vendor name for group by clause 
 *
 */
public class PurchaseInventoryJasperBean {
	private String groupBy;
	private ArrayList<ItemPurchaseInventoryBean> listItemPurchseInventoryBean;
	//private Collection<ItemPurchaseInventoryBean> collectionItemPurchseInventoryBean;
	private static Vector<ItemPurchaseInventoryBean> itemReportBean;
	
	public String getGroupBy() {
		return groupBy;
	}
	public void setGroupBy(String groupBy) {
		this.groupBy = groupBy;
	}
	public ArrayList<ItemPurchaseInventoryBean> getListItemPurchseInventoryBean() {
		return listItemPurchseInventoryBean;
	}
	public void setListItemPurchseInventoryBean(
			ArrayList<ItemPurchaseInventoryBean> listItemPurchseInventoryBean) {
		this.listItemPurchseInventoryBean = listItemPurchseInventoryBean;
	}
	
	
		
	
}
