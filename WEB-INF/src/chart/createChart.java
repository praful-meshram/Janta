package chart;
import java.util.*;
public class createChart {
	
	public String displayChart(String chartName,String caption,String xAxisName,String yAxisName,int height,int width,ArrayList Xvalue,ArrayList Yvalue,String[] Color){
		/*
			type of chart::
			----------------
			1. FCF_Area2D.swf
			2. FCF_Bar2D.swf 
			3. FCF_Candlestick.swf
			4. FCF_Column2D.swf
			5. FCF_Column3D.swf
			6. FCF_Funnel.swf
			7. FCF_Line.swf
			8. FCF_Pie2D.swf
			9. FCF_Pie3D.swf 
			10.FCF_Doughnut2D.swf 
		 */
		String chartSWF="";
		if (chartName.equals("Area2D")){
			chartSWF="FusionCharts/FCF_Area2D.swf";
		}
		else if(chartName.equals("Bar2D")){
			chartSWF="FusionCharts/FCF_Bar2D.swf";
		}
		else if(chartName.equals("Candlestick")){
			chartSWF="FusionCharts/FCF_Candlestick.swf";
		}
		else if(chartName.equals("Column2D")){
			chartSWF="FusionCharts/FCF_Column2D.swf";
		}
		else if(chartName.equals("Column3D")){
			chartSWF="FusionCharts/FCF_Column3D.swf";
		}
		else if(chartName.equals("Funnel")){
			chartSWF="FusionCharts/FCF_Funnel.swf";
		}
		else if(chartName.equals("Line")){
			chartSWF="FusionCharts/FCF_Line.swf";
		}
		else if(chartName.equals("Pie2D")){
			chartSWF="FusionCharts/FCF_Pie2D.swf";
		}
		else if(chartName.equals("Pie3D")){
			chartSWF="FusionCharts/FCF_Pie3D.swf";
		}
		else if(chartName.equals("Doughnut2D")){
			chartSWF="FusionCharts/FCF_Doughnut2D.swf";
		}
		
		String strXML="";
		strXML +="<graph caption='"+caption+"' xAxisName='"+xAxisName+"' yAxisName='"+yAxisName+"' showNames='1' decimalPrecision='0' formatNumberScale='0'>";
		
		for (int i=0;i<Xvalue.size();i++){
			strXML +="<set name='"+Xvalue.get(i)+"' value='"+Yvalue.get(i)+"' color='"+Color[i]+"' />";
		}
		
		strXML +="</graph>";
		
		String chartCode= createChartHTML(chartSWF, "", strXML, "myNext", height, width, false);
		return chartCode;
	}
	
	public String createChartHTML(String chartSWF, String strURL,
		    String strXML, String chartId, int chartWidth, int chartHeight,
		    boolean debugMode) { 
			/*Generate the FlashVars string based on whether dataURL has been provided
		     or dataXML.*/
			String strFlashVars = "";
			Boolean debugModeBool = new Boolean(debugMode);
		
			if (strXML.equals("")) {
			    //DataURL Mode
			    strFlashVars = "chartWidth=" + chartWidth + "&chartHeight="
				    + chartHeight + "&debugMode=" + boolToNum(debugModeBool)
				    + "&dataURL=" + strURL + "";
			} else {
			    //DataXML Mode
			    strFlashVars = "chartWidth=" + chartWidth + "&chartHeight="
				    + chartHeight + "&debugMode=" + boolToNum(debugModeBool)
				    + "&dataXML=" + strXML + "";
			}
			StringBuffer strBuf = new StringBuffer();
		
			// START Code Block for Chart  
			strBuf.append("\t\t<!--START Code Block for Chart-->\n");
			strBuf
				.append("\t\t\t\t<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"
					+ chartWidth
					+ "' height='"
					+ chartHeight
					+ "' id='"
					+ chartId + "'>\n");
			strBuf.append("\t\t\t\t	<param name='allowScriptAccess' value='always' />\n");
			strBuf.append("\t\t\t\t	<param name='movie' value='" + chartSWF + "'/>\n");
			strBuf.append("\t\t\t\t<param name='FlashVars' value=\"" + strFlashVars
				+ "\" />\n");
			strBuf.append("\t\t\t\t	<param name='quality' value='high' />\n");
			strBuf
				.append("\t\t\t\t<embed src='"
					+ chartSWF
					+ "' FlashVars=\""
					+ strFlashVars
					+ "\" quality='high' width='"
					+ chartWidth
					+ "' height='"
					+ chartHeight
					+ "' name='"
					+ chartId
					+ "' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />\n");
			strBuf.append("\t\t</object>\n");
			// END Code Block for Chart
			strBuf.append("\t\t<!--END Code Block for Chart-->\n");
			return strBuf.substring(0);
	    }

	    /**
	     * Converts boolean to corresponding integer
	     * @param bool - The boolean that is to be converted to number
	     * @return int - 0 or 1 representing the given boolean value
	     */
	    public int boolToNum(Boolean bool) {
			int num = 0;
			if (bool.booleanValue()) {
			    num = 1;
			}
			return num;
	    }
}
