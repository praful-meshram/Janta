package beans;

public class SalesReportOutputBean {

	private String orderNumber;
	private String customerCode;
	private String orderDate;
	private String totalItems;
	private String totalValue;
	private String totalMrpValue;
	private String totalDiscountValue;
	private String paymentTypeDesc;
	private String lastModifiedDate;
	private String statusCode;
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getCustomerCode() {
		return customerCode;
	}
	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getTotalItems() {
		return totalItems;
	}
	public void setTotalItems(String totalItems) {
		this.totalItems = totalItems;
	}
	public String getTotalValue() {
		return totalValue;
	}
	public void setTotalValue(String totalValue) {
		this.totalValue = totalValue;
	}
	public String getTotalMrpValue() {
		return totalMrpValue;
	}
	public void setTotalMrpValue(String totalMrpValue) {
		this.totalMrpValue = totalMrpValue;
	}
	public String getTotalDiscountValue() {
		return totalDiscountValue;
	}
	public void setTotalDiscountValue(String totalDiscountValue) {
		this.totalDiscountValue = totalDiscountValue;
	}
	public String getPaymentTypeDesc() {
		return paymentTypeDesc;
	}
	public void setPaymentTypeDesc(String paymentTypeDesc) {
		this.paymentTypeDesc = paymentTypeDesc;
	}
	public String getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	
	
}
