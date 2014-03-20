package beans;

import java.awt.Image;
import java.awt.image.BufferedImage;

public class PrintOrderDetailsBean {
	private int totalItems;
	private int totalItemsTaken;
	private int totalItemsRemain;
	private String orderDate;
	private String custCode;
	private String custName;
	private String deliveryRemark="";
	private String other_charges_amt="";
	private String buildingNo;
	private String wing;
	private String block;
	private String building;
	private String area;
	private String phone;
	private String add1;
	private String add2;
	private String station;
	private String orderNo;
	private String savings;
	private String itemWeight;
	private int itemQty;
	private String itemName;
	private String disRemark;
	private String taken_ind;
	private float itemTotPriceToJsPrice;
	private float itemMRP;
	//private String pageItemCount;
	//private String itemsPerPage;
	private String itemCount;
	//private String emptyLines;
	private float bal_amt;
	private float totalValue;
	private String p_type; 
	private float adv_amt;
	private float dis_amt;
	private String addressLine1; // buildingNo,wing,block,buliding,area
	private String addressLine2; // Add1,Add2,Station
 	private String userName;
 	private Image image;
 	BufferedImage bufferedImage;
 	
 	
	public BufferedImage getBufferedImage() {
		return bufferedImage;
	}
	public void setBufferedImage(BufferedImage bufferedImage) {
		this.bufferedImage = bufferedImage;
	}
	public Image getImage() {
		return image;
	}
	public void setImage(Image image) {
		this.image = image;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	public int getTotalItemsRemain() {
		return totalItemsRemain;
	}
	public void setTotalItemsRemain(int totalItemsRemain) {
		this.totalItemsRemain = totalItemsRemain;
	}
	public int getTotalItems() {
		return totalItems;
	}
	public void setTotalItems(int totalItems) {
		this.totalItems = totalItems;
	}
	public int getTotalItemsTaken() {
		return totalItemsTaken;
	}
	public void setTotalItemsTaken(int totalItemsTaken) {
		this.totalItemsTaken = totalItemsTaken;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getCustCode() {
		return custCode;
	}
	public void setCustCode(String custCode) {
		this.custCode = custCode;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getDeliveryRemark() {
		return deliveryRemark;
	}
	public void setDeliveryRemark(String deliveryRemark) {
		this.deliveryRemark = deliveryRemark;
	}
	public String getOther_charges_amt() {
		return other_charges_amt;
	}
	public void setOther_charges_amt(String other_charges_amt) {
		this.other_charges_amt = other_charges_amt;
	}
	public String getBuildingNo() {
		return buildingNo;
	}
	public void setBuildingNo(String buildingNo) {
		this.buildingNo = buildingNo;
	}
	public String getWing() {
		return wing;
	}
	public void setWing(String wing) {
		this.wing = wing;
	}
	public String getBlock() {
		return block;
	}
	public void setBlock(String block) {
		this.block = block;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAdd1() {
		return add1;
	}
	public void setAdd1(String add1) {
		this.add1 = add1;
	}
	public String getAdd2() {
		return add2;
	}
	public void setAdd2(String add2) {
		this.add2 = add2;
	}
	public String getStation() {
		return station;
	}
	public void setStation(String station) {
		this.station = station;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getSavings() {
		return savings;
	}
	public void setSavings(String savings) {
		this.savings = savings;
	}
	public String getItemWeight() {
		return itemWeight;
	}
	public void setItemWeight(String itemWeight) {
		this.itemWeight = itemWeight;
	}
	public int getItemQty() {
		return itemQty;
	}
	public void setItemQty(int itemQty) {
		this.itemQty = itemQty;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getDisRemark() {
		return disRemark;
	}
	public void setDisRemark(String disRemark) {
		this.disRemark = disRemark;
	}
	public String getTaken_ind() {
		return taken_ind;
	}
	public void setTaken_ind(String taken_ind) {
		this.taken_ind = taken_ind;
	}
	public float getItemTotPriceToJsPrice() {
		return itemTotPriceToJsPrice;
	}
	public void setItemTotPriceToJsPrice(float itemTotPriceToJsPrice) {
		this.itemTotPriceToJsPrice = itemTotPriceToJsPrice;
	}
	public float getItemMRP() {
		return itemMRP;
	}
	public void setItemMRP(float itemMRP) {
		this.itemMRP = itemMRP;
	}
	public String getItemCount() {
		return itemCount;
	}
	public void setItemCount(String itemCount) {
		this.itemCount = itemCount;
	}
	public float getBal_amt() {
		return bal_amt;
	}
	public void setBal_amt(float bal_amt) {
		this.bal_amt = bal_amt;
	}
	public float getTotalValue() {
		return totalValue;
	}
	public void setTotalValue(float totalValue) {
		this.totalValue = totalValue;
	}
	public String getP_type() {
		return p_type;
	}
	public void setP_type(String p_type) {
		this.p_type = p_type;
	}
	public float getAdv_amt() {
		return adv_amt;
	}
	public void setAdv_amt(float adv_amt) {
		this.adv_amt = adv_amt;
	}
	public float getDis_amt() {
		return dis_amt;
	}
	public void setDis_amt(float dis_amt) {
		this.dis_amt = dis_amt;
	}
	
	
	
}
