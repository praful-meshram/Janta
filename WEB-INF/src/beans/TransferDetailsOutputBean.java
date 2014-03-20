package beans;

public class TransferDetailsOutputBean {

	private int transfer_id;
	private float item_mrp;
	private float item_rate;
	private int transfer_qty;
	private String item_trans_status;
	private String remark;
	private String source;
	private String dest;
	public int getTransfer_id() {
		return transfer_id;
	}
	public void setTransfer_id(int transfer_id) {
		this.transfer_id = transfer_id;
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
	public int getTransfer_qty() {
		return transfer_qty;
	}
	public void setTransfer_qty(int transfer_qty) {
		this.transfer_qty = transfer_qty;
	}
	public String getItem_trans_status() {
		return item_trans_status;
	}
	public void setItem_trans_status(String item_trans_status) {
		this.item_trans_status = item_trans_status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	
	
	
	
	
}
