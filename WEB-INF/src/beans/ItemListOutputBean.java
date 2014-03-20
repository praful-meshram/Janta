package beans;

public class ItemListOutputBean {

	/*select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
	" i.item_weight, ip.item_mrp, ip.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
	" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount,i.comm_amt, i.ticker_flag," +
	"i.barcode,i.box_qty,i.is_bachka,i.mix_item 
*/
	private String itemCode;
	private String itemGroupCode;
	private String itemName;
	private String itemMrp;
	private String itemRate;
	
	private String itemGroupDesc;
	private String itemCode2;
	private String dealActiveFlag;
	private String dealOnQty;
	private String dealAmount;
	
	private String commAmt;
	private String tickerFlag;
	private String barcode;
	private String isBachka;
	private String mixItem;
	
	private String itemWeight;
	private String itemHistory;
	
	
	public String getItemHistory() {
		return itemHistory;
	}
	public void setItemHistory(String itemHistory) {
		this.itemHistory = itemHistory;
	}
	public String getItemWeight() {
		return itemWeight;
	}
	public void setItemWeight(String itemWeight) {
		this.itemWeight = itemWeight;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public String getItemGroupCode() {
		return itemGroupCode;
	}
	public void setItemGroupCode(String itemGroupCode) {
		this.itemGroupCode = itemGroupCode;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemMrp() {
		return itemMrp;
	}
	public void setItemMrp(String itemMrp) {
		this.itemMrp = itemMrp;
	}
	public String getItemRate() {
		return itemRate;
	}
	public void setItemRate(String itemRate) {
		this.itemRate = itemRate;
	}
	public String getItemGroupDesc() {
		return itemGroupDesc;
	}
	public void setItemGroupDesc(String itemGroupDesc) {
		this.itemGroupDesc = itemGroupDesc;
	}
	public String getItemCode2() {
		return itemCode2;
	}
	public void setItemCode2(String itemCode2) {
		this.itemCode2 = itemCode2;
	}
	public String getDealActiveFlag() {
		return dealActiveFlag;
	}
	public void setDealActiveFlag(String dealActiveFlag) {
		this.dealActiveFlag = dealActiveFlag;
	}
	public String getDealOnQty() {
		return dealOnQty;
	}
	public void setDealOnQty(String dealOnQty) {
		this.dealOnQty = dealOnQty;
	}
	public String getDealAmount() {
		return dealAmount;
	}
	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}
	public String getCommAmt() {
		return commAmt;
	}
	public void setCommAmt(String commAmt) {
		this.commAmt = commAmt;
	}
	public String getTickerFlag() {
		return tickerFlag;
	}
	public void setTickerFlag(String tickerFlag) {
		this.tickerFlag = tickerFlag;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public String getIsBachka() {
		return isBachka;
	}
	public void setIsBachka(String isBachka) {
		this.isBachka = isBachka;
	}
	public String getMixItem() {
		return mixItem;
	}
	public void setMixItem(String mixItem) {
		this.mixItem = mixItem;
	}
	
	
	
	
}
