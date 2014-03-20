package beans;

import java.util.ArrayList;

public class JsonOutputBean {
	private Object OutputData;
	private  ArrayList <jqxgridFormat> format = new ArrayList<jqxgridFormat>();
	private String grandTotalOrders;
	private String grandTotalValues;
	
	public String getGrandTotalOrders() {
		return grandTotalOrders;
	}
	public void setGrandTotalOrders(String grandTotalOrders) {
		this.grandTotalOrders = grandTotalOrders;
	}
	public String getGrandTotalValues() {
		return grandTotalValues;
	}
	public void setGrandTotalValues(String grandTotalValues) {
		this.grandTotalValues = grandTotalValues;
	}
	public Object getOutputData() {
		return OutputData;
	}
	public void setOutputData(Object outputData) {
		OutputData = outputData;
	}
	public ArrayList<jqxgridFormat> getFormat() {
		return format;
	}
	public void setFormat(ArrayList<jqxgridFormat> format) {
		this.format = format;
	}
	
	
	

}
