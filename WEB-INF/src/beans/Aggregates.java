package beans;

public class Aggregates {
	private String name;
	private String function;
	
	public Aggregates(String name, String function) {
		super();
		this.name = name;
		this.function = function;
	}
	
	public Aggregates( String function) {
		super();
		//this.name = name;
		this.function = function;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	
	
}
