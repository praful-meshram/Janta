package beans;

public class PurchaseDetailsOutputBean {
	private int po_number;
	private String bill_number;
	private String vendor_name;
	private String site_name;
	private String item_name;
	private float item_mrp;
	private float item_rate;
	private int total_items;
	private String po_date;
	private int new_qty;
	private String enteredby;
	public int getPo_number() {
		return po_number;
	}
	public void setPo_number(int po_number) {
		this.po_number = po_number;
	}
	public String getBill_number() {
		return bill_number;
	}
	public void setBill_number(String bill_number) {
		this.bill_number = bill_number;
	}
	public String getVendor_name() {
		return vendor_name;
	}
	public void setVendor_name(String vendor_name) {
		this.vendor_name = vendor_name;
	}
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public float getItem_mrp() {
		return item_mrp;
	}
	public void setItem_mrp(float item_mrp) {
		this.item_mrp = item_mrp;
	}
	public float getItem_rate() {
		return item_rate;
	}
	public void setItem_rate(float item_rate) {
		this.item_rate = item_rate;
	}
	public int getTotal_items() {
		return total_items;
	}
	public void setTotal_items(int total_items) {
		this.total_items = total_items;
	}
	public String getPo_date() {
		return po_date;
	}
	public void setPo_date(String po_date) {
		this.po_date = po_date;
	}
	public int getNew_qty() {
		return new_qty;
	}
	public void setNew_qty(int new_qty) {
		this.new_qty = new_qty;
	}
	public String getEnteredby() {
		return enteredby;
	}
	public void setEnteredby(String enteredby) {
		this.enteredby = enteredby;
	}
	
	
	

	
}
