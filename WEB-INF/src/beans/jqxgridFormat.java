package beans;
public class jqxgridFormat {
 	private String text;
	private String datafield;
	private String width;
	//private Aggregates aggregates;
	private String aggregates;
	private String formatString;
	private String columngroup;
	private boolean hidden;
	private boolean sortable=true;
	private boolean filterable=true;
	public jqxgridFormat(String text, String datafield) {
		super();
		this.text = text;
		this.datafield = datafield;
	}
	
	public jqxgridFormat(String text, String datafield, String width) {
		super();
		this.text = text;
		this.datafield = datafield;
		this.width = width;
	}
	
	
	
	public jqxgridFormat(String text, String datafield, String width,String aggregates) {
		super();
		this.text = text;
		this.datafield = datafield;
		this.width = width;
		this.aggregates = aggregates;
	}
	
	
	
	public boolean isFilterable() {
		return filterable;
	}

	public void setFilterable(boolean filterable) {
		this.filterable = filterable;
	}

	public String getAggregates() {
		return aggregates;
	}

	public void setAggregates(String aggregates) {
		this.aggregates = aggregates;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getDatafield() {
		return datafield;
	}
	public void setDatafield(String datafield) {
		this.datafield = datafield;
	}

	public String getFormatString() {
		return formatString;
	}

	public void setFormatString(String formatString) {
		this.formatString = formatString;
	}

	public String getColumngroup() {
		return columngroup;
	}

	public void setColumngroup(String columngroup) {
		this.columngroup = columngroup;
	}

	public boolean isHidden() {
		return hidden;
	}

	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}

	public boolean isSortable() {
		return sortable;
	}

	public void setSortable(boolean sortable) {
		this.sortable = sortable;
	}
	
	
	
	
}
