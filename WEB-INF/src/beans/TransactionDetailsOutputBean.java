package beans;

public class TransactionDetailsOutputBean {

//	select tran_id, tran_type, tran_dt, tran_amt, old_balance_amt, new_balance_amt, new_balance_amt
	private String tran_id;
	private String tran_type;
	private String tran_dt;
	private String tran_amt;
	private String old_balance_amt;
	private String new_balance_amt;
	
	public String getTran_id() {
		return tran_id;
	}
	public void setTran_id(String tran_id) {
		this.tran_id = tran_id;
	}
	public String getTran_type() {
		return tran_type;
	}
	public void setTran_type(String tran_type) {
		this.tran_type = tran_type;
	}
	public String getTran_dt() {
		return tran_dt;
	}
	public void setTran_dt(String tran_dt) {
		this.tran_dt = tran_dt;
	}
	public String getTran_amt() {
		return tran_amt;
	}
	public void setTran_amt(String tran_amt) {
		this.tran_amt = tran_amt;
	}
	public String getOld_balance_amt() {
		return old_balance_amt;
	}
	public void setOld_balance_amt(String old_balance_amt) {
		this.old_balance_amt = old_balance_amt;
	}
	public String getNew_balance_amt() {
		return new_balance_amt;
	}
	public void setNew_balance_amt(String new_balance_amt) {
		this.new_balance_amt = new_balance_amt;
	}
	
	
}
