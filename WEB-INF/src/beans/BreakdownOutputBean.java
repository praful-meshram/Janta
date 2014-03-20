package beans;

public class BreakdownOutputBean {

	private int breakdownNumber;
	private String bachkaName;
	private float loss;
	private float gain;
	private String siteName;
	private String breakdownDate;
	private String enteredBy;
	
	// breakdown details
	private float itemMRP;
	private float itemRate;
	private String itemWeight;
	private int qty;
	
	
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
	public String getItemWeight() {
		return itemWeight;
	}
	public void setItemWeight(String itemWeight) {
		this.itemWeight = itemWeight;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getBreakdownNumber() {
		return breakdownNumber;
	}
	public void setBreakdownNumber(int breakdownNumber) {
		this.breakdownNumber = breakdownNumber;
	}
	
	public String getBachkaName() {
		return bachkaName;
	}
	public void setBachkaName(String bachkaName) {
		this.bachkaName = bachkaName;
	}
	public float getLoss() {
		return loss;
	}
	public void setLoss(float loss) {
		this.loss = loss;
	}
	public float getGain() {
		return gain;
	}
	public void setGain(float gain) {
		this.gain = gain;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getBreakdownDate() {
		return breakdownDate;
	}
	public void setBreakdownDate(String breakdownDate) {
		this.breakdownDate = breakdownDate;
	}
	public String getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(String enteredBy) {
		this.enteredBy = enteredBy;
	}
	
	
	
	
	
	
	
}
