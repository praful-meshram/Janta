<%@ page import="java.awt.print.*" %>
<%@ page import="net.sourceforge.barbecue.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%

/**
 * 
 * 
 * @author Sanketa
 *
 */
		try
		{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
		
			String objArray[] = {"IT1127",
								 "IT1308",
								 "IT1312",
								 "IT1526",
								 "IT1677",
								 "IT1891",
								 "IT2268",
								 "IT2317",
								 "IT2391",
								 "IT307",
								 "IT423",
								 "IT471",
								 "IT511",
								 "IT60",
								 "IT711"};

			for(int i=0; i< objArray.length; i++)
			{
				Barcode objBarcode = BarcodeFactory.createCode128A(objArray[i]+"");
				
				String ImagePath = (String) envContext.lookup("imagesfile");
				ImagePath = config.getServletContext().getRealPath(ImagePath)+"\\"+objArray[i]+".PNG";
				File f = new File(ImagePath);            	
	            BarcodeImageHandler.savePNG(objBarcode, f);
	            %>
				<br/><br/>	<img src="images/barcodeImages/<%=objArray[i]%>.PNG"/>
	            <%	            
	    	
			}

		}
		catch (Exception e)
		{
			e.printStackTrace();
		}


%>

<script>
window.onload = funPrint;
function funPrint(){
	self.print();
}
</script>