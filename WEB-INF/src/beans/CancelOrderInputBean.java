package beans;

import java.sql.Date;

public class CancelOrderInputBean {
	private String orderNumber;
	private String phoneNumber;
	private String customerCode;
	private String custName;
	private String enterBy;
	private String createFromDate;
	private String createToDate;
	private String updateFromDate;
	private String updateToDate;
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getCustomerCode() {
		return customerCode;
	}
	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getEnterBy() {
		return enterBy;
	}
	public void setEnterBy(String enterBy) {
		this.enterBy = enterBy;
	}
	public String getCreateFromDate() {
		return createFromDate;
	}
	public void setCreateFromDate(String createFromDate) {
		this.createFromDate = createFromDate;
	}
	public String getCreateToDate() {
		return createToDate;
	}
	public void setCreateToDate(String createToDate) {
		this.createToDate = createToDate;
	}
	public String getUpdateFromDate() {
		return updateFromDate;
	}
	public void setUpdateFromDate(String updateFromDate) {
		this.updateFromDate = updateFromDate;
	}
	public String getUpdateToDate() {
		return updateToDate;
	}
	public void setUpdateToDate(String updateToDate) {
		this.updateToDate = updateToDate;
	}
	
 
	
}
