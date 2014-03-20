import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 
 */

/**
 * @author Sanketa
 * 
 */
public class GetFileList {
	private Properties props = null;
	Connection con = null;
	PreparedStatement psInsert = null;
	public static void main(String[] args) {		
		GetFileList objGetFileList = new GetFileList();
		objGetFileList.readProperties();
		objGetFileList.initializeConnection();
		objGetFileList.processData();	
		objGetFileList.closeConnection();
	}
	
	public void readProperties() {
		File file;
		file = new File("urlProperties.properties");
		try {
			FileInputStream fis = new FileInputStream(file);
			props = new Properties();
			props.load(fis);
			fis.close();
		} catch (FileNotFoundException e1) {
			System.err.println(e1);
		} catch (IOException e2) {
			System.err.println(e2);
		}
	}
	
	private void initializeConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String dburl = "jdbc:mysql://192.168.1.152:3306/js?autoReconnect=true";
			String dbusername = "root";
			String dbpassword = "@ss123";
			con = DriverManager.getConnection(dburl, dbusername,
					dbpassword);
			psInsert = con.prepareStatement("insert into screen_master(screen_name, module_name, sub_module_name) values(?,'','')");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	private void processData() {
		try {
			String filePath = props.getProperty("projectPath");
			File folder = new File(filePath);
			File[] listOfFiles = folder.listFiles();

			for (int i = 0; i < listOfFiles.length; i++) {
				if (listOfFiles[i].isFile()) {
					int dot = listOfFiles[i].getName().lastIndexOf(".");
					if (listOfFiles[i].getName().substring(dot + 1)
							.equals("jsp")) {
						System.out.println("File " + listOfFiles[i].getName());
						psInsert.setString(1, listOfFiles[i].getName());
						psInsert.executeUpdate();						
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public void closeConnection() {
		try {			
			if (psInsert != null) {
				psInsert.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
