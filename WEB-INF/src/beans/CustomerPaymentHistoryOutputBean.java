package beans;

public class CustomerPaymentHistoryOutputBean {

	private String OrderNumber;
	private String OrderDate;
	private String DelDateTime;
	private String ClosedDateTime;
	private String CloseStatus;
	private String BalanceAmount;
	private String ChangeAmount;
	private String PaidAmount;
	private String Remark;
	private String absValue;
	
	public String getAbsValue() {
		return absValue;
	}
	public void setAbsValue(String absValue) {
		this.absValue = absValue;
	}
	public String getOrderNumber() {
		return OrderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		OrderNumber = orderNumber;
	}
	public String getOrderDate() {
		return OrderDate;
	}
	public void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}
	public String getDelDateTime() {
		return DelDateTime;
	}
	public void setDelDateTime(String delDateTime) {
		DelDateTime = delDateTime;
	}
	public String getClosedDateTime() {
		return ClosedDateTime;
	}
	public void setClosedDateTime(String closedDateTime) {
		ClosedDateTime = closedDateTime;
	}
	public String getCloseStatus() {
		return CloseStatus;
	}
	public void setCloseStatus(String closeStatus) {
		CloseStatus = closeStatus;
	}
	public String getBalanceAmount() {
		return BalanceAmount;
	}
	public void setBalanceAmount(String balanceAmount) {
		BalanceAmount = balanceAmount;
	}
	public String getChangeAmount() {
		return ChangeAmount;
	}
	public void setChangeAmount(String changeAmount) {
		ChangeAmount = changeAmount;
	}
	public String getPaidAmount() {
		return PaidAmount;
	}
	public void setPaidAmount(String paidAmount) {
		PaidAmount = paidAmount;
	}
	public String getRemark() {
		return Remark;
	}
	public void setRemark(String remark) {
		Remark = remark;
	}
	
	
	
}
