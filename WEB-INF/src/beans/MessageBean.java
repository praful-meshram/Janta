package beans;



public class MessageBean {
  
   
   private String cust_code;
   private String mobile_no;
   private String message;
   private String sent_by;
   private String init_date;
   private String sent_date;
   private String status;
   private String message_type;
   
public String getMessage_type() {
	return message_type;
}

public void setMessage_type(String message_type) {
	this.message_type = message_type;
}

public String getCust_code() {
		return cust_code;
	}

public void setCust_code(String cust_code) {
		this.cust_code = cust_code;
	}
	
public String getMobile_no() {
			return mobile_no;
		}
	  

public void setMobile_no(String mobile_no) {
			this.mobile_no = mobile_no;
		}

public String getMessage() {
	return message;
}

public void setMessage(String message) {
	this.message = message;
}

public String getSent_by() {
	return sent_by;
}

public void setSent_by(String sent_by) {
	this.sent_by = sent_by;
}

public String getInit_date() {
	return init_date;
}

public void setInit_date(String init_date) {
	this.init_date = init_date;
}

public String getSent_date() {
	return sent_date;
}

public void setSent_date(String sent_date) {
	this.sent_date = sent_date;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}
   
}
