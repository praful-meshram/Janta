package beans;

import java.util.ArrayList;

public class JasonObject {

	ArrayList<Object> jasonData;
	int totalRecords;
	public JasonObject(ArrayList<Object> jasonData, int totalRecords) {
		super();
		this.jasonData = jasonData;
		this.totalRecords = totalRecords;
	}
	public ArrayList<Object> getJasonData() {
		return jasonData;
	}
	public void setJasonData(ArrayList<Object> jasonData) {
		this.jasonData = jasonData;
	}
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	
	
	
		
}
