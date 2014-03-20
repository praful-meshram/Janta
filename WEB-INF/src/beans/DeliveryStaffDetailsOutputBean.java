package beans;
public class DeliveryStaffDetailsOutputBean {

    private String DeliveryPersonName;
	private String totalOrders;	
	private String totalOrders1;
	private String totalEarned;
	private String totalPaid;
	private String balance;
	private String fromDate;
	private String toDate;
	public String getDeliveryPersonName() {
		return DeliveryPersonName;
	}
	public void setDeliveryPersonName(String deliveryPersonName) {
		DeliveryPersonName = deliveryPersonName;
	}
	public String getTotalOrders() {
		return totalOrders;
	}
	public void setTotalOrders(String totalOrders) {
		this.totalOrders = totalOrders;
	}
	
	public String getTotalOrders1() {
		return totalOrders1;
	}
	public void setTotalOrders1(String totalOrders1) {
		this.totalOrders1 = totalOrders1;
	}
	public String getTotalEarned() {
		return totalEarned;
	}
	public void setTotalEarned(String totalEarned) {
		this.totalEarned = totalEarned;
	}
	public String getTotalPaid() {
		return totalPaid;
	}
	public void setTotalPaid(String totalPaid) {
		this.totalPaid = totalPaid;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	
}
