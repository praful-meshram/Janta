package beans;

public class CancelOrderOutputBean {
	private String orderNumber;
	private String orderDate;
	private String custName;
	private String payment_type_desc;
	private String enterd_by;
	private String statusCode;
	
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getPayment_type_desc() {
		return payment_type_desc;
	}
	public void setPayment_type_desc(String payment_type_desc) {
		this.payment_type_desc = payment_type_desc;
	}
	public String getEnterd_by() {
		return enterd_by;
	}
	public void setEnterd_by(String enterd_by) {
		this.enterd_by = enterd_by;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	
	
}
