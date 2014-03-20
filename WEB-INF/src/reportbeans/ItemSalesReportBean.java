package reportbeans;

import java.util.Date;

public class ItemSalesReportBean {
	String itemCode;
	String itemName;
	String itemGroup;
	Double totalQuantity;
	Double totalValue;
	Date orderDate;
	
	/**
	 * @return the itemCode
	 */
	public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode the itemCode to set
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return the itemName
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName the itemName to set
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return the itemGroup
	 */
	public String getItemGroup() {
		return itemGroup;
	}
	/**
	 * @param itemGroup the itemGroup to set
	 */
	public void setItemGroup(String itemGroup) {
		this.itemGroup = itemGroup;
	}
	/**
	 * @return the totalQuantity
	 */
	public Double getTotalQuantity() {
		return totalQuantity;
	}
	/**
	 * @param totalQuantity the totalQuantity to set
	 */
	public void setTotalQuantity(Double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	/**
	 * @return the totalValue
	 */
	public Double getTotalValue() {
		return totalValue;
	}
	/**
	 * @param totalValue the totalValue to set
	 */
	public void setTotalValue(Double totalValue) {
		this.totalValue = totalValue;
	}
	/**
	 * @return the orderDate
	 */
	public Date getOrderDate() {
		return orderDate;
	}
	/**
	 * @param orderDate the orderDate to set
	 */
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	
		
}
