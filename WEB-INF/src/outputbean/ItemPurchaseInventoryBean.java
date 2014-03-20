package outputbean;

import java.util.Collection;
import java.util.Vector;

public class ItemPurchaseInventoryBean {
	private int vendor_id;
	private int po_number;
	private int site_id;
	private String itemCode;
	private float itemMRP;
	private float itemRate;
	private String siteName;
	private String itemName;
	private String vendorName;
	private String billNumber;
	private String poDate;
	private String enteredBy;
	private int itemQty;
	public static Vector iReportDataSource = new Vector();
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public int getVendor_id() {
		return vendor_id;
	}
	public void setVendor_id(int vendor_id) {
		this.vendor_id = vendor_id;
	}
	public int getPo_number() {
		return po_number;
	}
	public void setPo_number(int po_number) {
		this.po_number = po_number;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public float getItemMRP() {
		return itemMRP;
	}
	public void setItemMRP(float itemMRP) {
		this.itemMRP = itemMRP;
	}
	public float getItemRate() {
		return itemRate;
	}
	public void setItemRate(float itemRate) {
		this.itemRate = itemRate;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getBillNumber() {
		return billNumber;
	}
	public void setBillNumber(String billNumber) {
		this.billNumber = billNumber;
	}
	public String getPoDate() {
		return poDate;
	}
	public void setPoDate(String poDate) {
		this.poDate = poDate;
	}
	public String getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(String enteredBy) {
		this.enteredBy = enteredBy;
	}
	public int getItemQty() {
		return itemQty;
	}
	public void setItemQty(int itemQty) {
		this.itemQty = itemQty;
	}
	public static Collection getIReprtCollection( )
    {
        return iReportDataSource;
    }
	
	
	
	
	
	

}
