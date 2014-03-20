package applet;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.EventObject;
import java.util.Vector;

import javax.swing.DefaultCellEditor;
import javax.swing.JApplet;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.event.CellEditorListener;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellEditor;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;
import javax.swing.text.JTextComponent;


import netscape.javascript.JSException;
import netscape.javascript.JSObject;

public class OrderCheck extends JApplet implements ActionListener,TableModelListener{
	 TextFieldEditor tf;
	
	 JSObject win;
	 JTable table;
	 Vector rows;
	 Vector <String> columns;
	 DefaultTableModel tabModel;
	 JScrollPane scrollPane;
	 JButton addButton,deleteButton,saveButton,cancelButton,clearButton,viewButton;
	 	
	 JPanel tablePanel,innerbuttonPanel,buttonPanel,mainPanel,labelPanel1,
	 	labelPanel2,
	     labelPanel3,labelPanel4,labelPanel5,labelPanel6,emptyPanel,emptyPanel1,wholeLabelPanel,custPanel,
	     custPanel1,custPanel2,custPanel3;
	 JTextComponent editor;
	 Connection con=null;
	 ResultSet rs,rs1,rs2,rs3,rs4,rsFetch,rsForItemName; 
	 Statement getValstmt,getItemstmt,getValstmt1,getValstmt2,stmt,getFetchStmt; 
	 String dburl="", dbusername="", dbpassword="",statusCode="",copyOrder="",orderType="EDIT",lastOrderdate="";
	 String productValue,setProdName="", item_code="", pay_type="", p_code="", status="",deliveryRemark="";
	 String user="",disRemark="",quantityValue="",blankString="",weightString="",
	     rateString="",blank=" ",blankValue="  ",blankVar="   ",blankValue3="   ";
	 String order_date="",del_ateTime="",send_DateTime,savingType="";	 
	 String[] prodValResult;
	 long pickup_ind=0,item_returned=0;
	 Object objTemp=null;
	 Vector <String> productArray = new Vector<String> (); 
	 Vector <String> item_codeArray = new Vector<String> (); 
	 int itemCount = 0,pickValue=0, deliverCount = 0,max=0,transId=0,setQuantityFlag=0,checkboxFlag,pickUpCnt=0,orderNo=0,i,addedRow=0,checkQuantityVal,columnCount=7;
	
	 
	 ManageOrderFile mo;
	 int maxrec=0;
	 boolean running = true;
	 ComboBoxEditor cme;
	 TextFieldEditor tfe; 
	 JTextComponent commonJTC;
	 
	 DecimalFormat df = new DecimalFormat("###,###.00");      

	 double itemQty=0.0f;
	 double itemPrice=0.0f;
	 String itemCode="";
	 String itemName="";
	 String itemWeight="";
	 String itemBarcode="";
	 
	 boolean mousePressed = true;
	 
	 String msgYesNo="0";
	 
	 public void init(){
		  try{
			  dburl = getParameter("dburl");
			  dbusername = getParameter("dbusername");
			  dbpassword = getParameter("dbpassword");	 
			  orderNo = Integer.parseInt(getParameter("orderNo"));
			  user = getParameter("user");	
			  statusCode="SUBMITTED";
			  copyOrder=getParameter("copyOrder");	
			  initialize(dburl,dbusername,dbpassword);
		      SwingUtilities.invokeAndWait(new Runnable(){     
			      public void run(){      
			    	  makeGUI();
			      }	
		      }
		    );	
		  }catch(Exception e){
			   System.out.println("Exception occured in Init"+e);
		  }
	 }
	 
	 public void initialize(String dburl, String dbusername,String dbpassword){
		  try{
			  	System.out.println("In initialize");		      
			   	Class.forName("com.mysql.jdbc.Driver");
			   	System.out.println("here");			   
			   con = DriverManager.getConnection(dburl, dbusername, dbpassword);
			   mo = new ManageOrderFile(dburl, dbusername, dbpassword); 
			   getFetchStmt = con.createStatement();
			   getValstmt = con.createStatement();
			   getValstmt1 = con.createStatement();
			   getValstmt2 = con.createStatement();
			   getItemstmt = con.createStatement();
			   stmt = con.createStatement();   
		  }catch (Exception e){
			   System.out.println("Error occurred in Database Connection " + e); 
			   e.printStackTrace();
		  }		   
	 }
	 
	 public void closeAll(){
		  try{
			   getValstmt.close();
			   getValstmt1.close();
			   getValstmt2.close();   
			   stmt.close();
			   con.close();
		  }catch(Exception e){
	         e.getMessage();
	         e.printStackTrace();
		  } 
	 }
	 
	 public void makeGUI(){		  
		  rows=new Vector();
		  columns= new Vector <String>();
		  String[] columnNames = { "Item Barcode","Item ","Price","Quantity"};
		  addColumns(columnNames);
		  tabModel = new DefaultTableModel(); 
		  tabModel.setDataVector(rows,columns);
		  setTabFocus();
		  scrollPane = new JScrollPane(table);    
		  table.setRowSelectionAllowed(false);
	  
	      TableColumnModel tcm = table.getColumnModel();
	      TableColumn colwithCombo = tcm.getColumn(1); 
	      TableColumn colwithTextField = tcm.getColumn(3);
	      cme=new ComboBoxEditor();
		  colwithCombo.setCellEditor(cme);  
		  tfe=new TextFieldEditor();
		  colwithTextField.setCellEditor(new DefaultCellEditor(tfe));
		  setUpProductColumn(colwithCombo,colwithTextField);  
		  table.getModel().addTableModelListener(this);  
		  addComponents();
		  colwithCombo.setPreferredWidth(600 );
		  colwithCombo.setMinWidth( 50 );
		  colwithCombo.setMaxWidth(600);
		  
		  table.setRowHeight(20);	    
		  fetchOrderValues(colwithCombo,colwithTextField);
		  table.getModel().addTableModelListener(this);		  	 
	 }  
	 public void addColumns(String[] colName){
		  for(int i=0;i<colName.length;i++)
			  columns.addElement((String) colName[i]);
	 }	  
	 
	 public void addRow(){ 
	   try{
		    Vector r=new Vector();
		    int rowNum=0;
		    r=addBlankElement(); 
		    rows.addElement(r);
		    table.addNotify();   
		    rowNum = (table.getRowCount() - 1);
			table.setValueAt("", rowNum, 0);
		    if(rowNum>=0){
			     table.setEditingRow(rowNum);
			     table.changeSelection(rowNum, 0, false, false);
		    }
		    cme.checkBlankRows();
		    cme.removeAllItems();
		    itemCount++;
			deliverCount= itemCount-pickValue;
			
	   }catch(ArrayIndexOutOfBoundsException aie){
		    System.out.println("Exception in AddRow "+aie);
		    aie.printStackTrace();
	   }
	 }
	   
	  public Vector addBlankElement(){
		  Vector <String>t = new Vector<String>();
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  return t;
	 }

	  public void deleteRow(int index){
		  String prevQuantity="",nextQuantity="",tempItem="";
		  boolean flag=false;
		  if(index==0){		 
			  if(table.getRowCount()>1)
				  nextQuantity=table.getValueAt(table.getSelectedRow()+1,3).toString();
			  tabModel.removeRow(table.getSelectedRow());
			  if(table.getRowCount()>=1){
				  tfe.setText(nextQuantity);
				  //table.changeSelection(0, 0, false, false);
				  table.changeSelection(0, 3, false, false);
			  }
		  }
		  if(index>=1){
			  try{	
				  prevQuantity=table.getValueAt(table.getSelectedRow()-1,3).toString();
				  if(table.getSelectedRow()==0)
					  tempItem=table.getValueAt(table.getSelectedRow(),0).toString();
				  else if(table.getSelectedRow()>=1)
					  tempItem=table.getValueAt(table.getSelectedRow()-1,0).toString();
				  int previousRow=-1;
				  if(index!=-1 ){			 
					  cme.removeAllItems();	
					  tabModel.removeRow(table.getSelectedRow());				 
					  previousRow=(index-1);				
					  if(previousRow >= 0){
						  table.setEditingRow(previousRow);
						  //cme.editor.setText(tempItem);
					  }			 
					  if(previousRow >= 0 && table.getRowCount()>0){
						  table.requestFocusInWindow();					 
						  String str="",temp=""; 
						  if(table.getRowCount()==1){						 
							  temp=table.getValueAt(0, 0).toString();
						  }						 
						  else{
							  temp=tempItem;
						  }
						  int pos=0;				 
						  if(temp.length()>0){							 
							  for(int i=0; i<productArray.size(); i++){
								  str = productArray.get(i).toString();
								  if(str.toUpperCase().startsWith(temp.toUpperCase())){
									  cme.insertItemAt(str, pos);
									  pos++;
								  }
							  }
						  }					 
						  if(table.getRowCount()==1){					 
							  cme.editor.setText(table.getValueAt(0, 0).toString());					 
							  tfe.setText(prevQuantity);
							  table.setEditingRow(0);
							  //table.changeSelection(0, 0, false, false);
							  table.changeSelection(0, 3, false, false);		 
						  }
						  else if(table.getRowCount()>1){					 
							  //cme.editor.setText(table.getValueAt(previousRow-1, 0).toString());
							  //Below line set current item in editor.
							  cme.editor.setText(tempItem);								 
							  tfe.setText(prevQuantity);
							  table.changeSelection(previousRow, 0, false, false);
							  flag=true;
							  //table.changeSelection(previousRow, 4, false, false);
						  }
					  }	
					  //		 table.addNotify();			 
					  if(itemCount>0){
						  itemCount--;				       
						  deliverCount= itemCount-pickValue;
						 
					  } 					 
					  
					  if(flag==true){
						  table.changeSelection(previousRow, 3, false, false);	
					  }
				  }
				 
			  }
			  catch(Exception e){
				  System.out.println("Exception in Delete row..");
				  e.printStackTrace();
			  }
		  }
	  }
	public  void populateAfterDelete(String temp){
		 int pos=0;
		 String str="";
		 if(temp.length()>0){	
			 for(int i=0; i<productArray.size(); i++){
				 str = productArray.get(i).toString();
				 if(str.toUpperCase().startsWith(temp.toUpperCase())){
					 cme.insertItemAt(str, pos);
					 pos++;
				 }							 
			 }
		 }
	}  
		 
	public void setSelectedRow(int row) {
	     if(row == -1)
	          return;
	     else {
	      table.setRowSelectionInterval(row, row);
	     }
	}
	   
    public void setSelectedCol(int col) {
        if(col == -1)
            return;
       else {
            table.setColumnSelectionInterval(col, col);
       }
    }
	  
	 public void setTabFocus(){
        table = new JTable(tabModel)
         {
             public boolean isCellEditable(int row, int column)
             {    
            	 boolean flag=false;            	 
            	 if(statusCode.equals("SUBMITTED")){	           		 
		              	 flag= true;
            	 }else {
		            	 flag= false;
            	 }
				return flag;
             }
  
             public void changeSelection(final int row, final int column, boolean toggle, boolean extend)
             {
                 super.changeSelection(row, column, toggle, extend);
                 if (editCellAt(row, column))
                     getEditorComponent().requestFocusInWindow();               
             }                                              
         };
	 }
	 
	 public void addComponents(){
		  buttonPanel = new JPanel();
		  innerbuttonPanel = new JPanel();
		  custPanel=new JPanel(new GridLayout(2,1,0,0));	 
		  custPanel1=new JPanel(new FlowLayout(0,0,0));
		  custPanel2=new JPanel(new FlowLayout(1,0,0));	 
		  buttonPanel.setLayout(new GridLayout(2,1,0,0));
		  
		  addButton = new JButton("Add Row");
		  clearButton = new JButton("Clear");
		  deleteButton = new JButton("Delete");
		  saveButton = new JButton("Save&Print");
		  cancelButton = new JButton("Cancel");
		  viewButton = new JButton("View");
		  addButton.setMnemonic(KeyEvent.VK_N);
		  deleteButton.setMnemonic(KeyEvent.VK_D);
		  saveButton.setMnemonic(KeyEvent.VK_S);
		  cancelButton.setMnemonic(KeyEvent.VK_B);
		  viewButton.setMnemonic(KeyEvent.VK_V);
		  wholeLabelPanel = new JPanel(new FlowLayout(0,0,0));
		  labelPanel1 = new JPanel(new GridLayout(3,1,0,0));
		  emptyPanel = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel2 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel3 = new JPanel(new GridLayout(2,1,0,0));
		  emptyPanel1 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel4 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel5 = new JPanel(new GridLayout(3,2,0,0));
		  labelPanel6 = new JPanel(new GridLayout(3,2,0,0));		  
		 
		  custPanel.add(custPanel1);	 
		  custPanel.add(custPanel2); 
		 	  
	      wholeLabelPanel.add(labelPanel1);
	      wholeLabelPanel.add(emptyPanel);
	      wholeLabelPanel.add(labelPanel2);
	      wholeLabelPanel.add(labelPanel3);
	      wholeLabelPanel.add(emptyPanel1);
	      wholeLabelPanel.add(labelPanel4); 
	      wholeLabelPanel.add(labelPanel5); 
	      wholeLabelPanel.add(labelPanel6);
	      
	      innerbuttonPanel.add(addButton);
		  innerbuttonPanel.add(saveButton); 
		  innerbuttonPanel.add(clearButton);
		  innerbuttonPanel.add(deleteButton);  
		  innerbuttonPanel.add(cancelButton);
		  innerbuttonPanel.add(viewButton);
		 
		  buttonPanel.add(wholeLabelPanel);
		  buttonPanel.add(innerbuttonPanel);
		 
		  addButton.addActionListener(this);
		  clearButton.addActionListener(this);
		  deleteButton.addActionListener(this);
		  saveButton.addActionListener(this);
		  cancelButton.addActionListener(this);
		  viewButton.addActionListener(this);
		 
		  mainPanel=new JPanel();
		  tablePanel=new JPanel();
		 
		  mainPanel.setLayout(new BorderLayout());  
		  mainPanel.add("North",custPanel);
		  mainPanel.add("Center",scrollPane);
		  mainPanel.add("South",buttonPanel);
		  tablePanel.setBackground(Color.white);
		  buttonPanel.setBackground(Color.white);
		  table.getParent().setBackground(Color.white);
		  getContentPane().add(mainPanel);
	 }	 
	 
	 public void setUpProductColumn(TableColumn productColumn , TableColumn checkColumn){
	  	  try{  
			   String query="SELECT item_name,barcode,deal_on_qty,item_rate,item_code from item_master order by item_name";
			   rs = getValstmt.executeQuery(query); 
			   while(rs.next()){ 				   
				     productArray.add(rs.getString(1)+blank+" ( W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+" ) ");
				     item_codeArray.add(rs.getString(5));
			   }   
			   DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
			   renderer.setToolTipText("Click the Product to see a list of choices");
			   productColumn.setCellRenderer(renderer);
		  }catch(Exception e){	 
			   System.out.println("Could not connect to database"+e);	 
		  } 
	 }	 
	 
	 public void fetchOrderValues(TableColumn productColumn , TableColumn checkColumn){
		 try{     
			   String fetcQuery=" SELECT b.barcode,b.item_name,a.qty,a.price,a.item_code "+
				   				" from order_detail a,item_master b "+
				   				" where a.item_code=b.item_code and a.order_num="+orderNo; 	
			  
			   rsFetch = getFetchStmt.executeQuery(fetcQuery); 			  
			   while(rsFetch.next()){
				    i=1;

				    itemBarcode=rsFetch.getString(i++);
				    itemName=rsFetch.getString(i++);
				    itemPrice=rsFetch.getDouble(i++);
				    itemQty=rsFetch.getDouble(i++);
				    addRow();
				    
				    table.setValueAt(itemBarcode, addedRow, 0);
				    table.setValueAt(itemName, addedRow, 1);
				    table.setValueAt(itemQty, addedRow, 2);
				    table.setValueAt(itemPrice, addedRow, 3);

				    addedRow++;					   
			   }// EOF While			   
			  		   
			   DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
			   renderer.setToolTipText("Click the Product to see a list of choices");
			   productColumn.setCellRenderer(renderer);
		}catch(ArrayIndexOutOfBoundsException aie){
			   System.out.println("ArrayIndexOutOfBoundsException in fetchOrderValues"+aie);
		}catch(SQLException se){
	    	System.out.println("SQLException in fetchOrderValues"+se);
	    	se.printStackTrace();
	    }catch(Exception e){
	    	System.out.println("Could not connect to database in fetchOrderValues"+e);
	    }
	 } //EOF fetchOrderValues
	  
	// This method is to implement the change in table cells
	 public void tableChanged(javax.swing.event.TableModelEvent source){	  
		  if(source.getColumn()==1){
			  pickValue=0;
			  int rowCount= table.getRowCount();
			  if(rowCount>0){
		    	   for(int pickYes=0; pickYes<rowCount; pickYes++ ){
		    		   Object obj=table.getValueAt(pickYes, 1);
		    		   if(obj.toString()=="true"){
		    			   pickValue++;
		    		   }
		    	   }
		       }
		  }	  
	 }//Table Changed Method   
	 
	 public void actionPerformed(ActionEvent source){
		 
		 try{
			 if (source.getSource()==(JButton) addButton){
				 boolean flagResutlt;
				 flagResutlt=checkRowBeforeAdding();
				 if(flagResutlt==false){ 
					 if(statusCode.equals("SUBMITTED") ){
						addRow();
					  	table.setValueAt("", table.getSelectedRow(), 3);
					 }
					 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
						 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);
				 }

			 }else if (source.getSource()==(JButton) deleteButton){
				 if(table.getRowCount()!=0 && table.getRowCount()>0 && statusCode.equals("SUBMITTED")){					 
					 deleteRow(table.getSelectedRow());
				 }
				 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
					 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);				 
				 else if(table.getRowCount()==0)	
					 JOptionPane.showMessageDialog(null,"There are no rows anymore to delete","RMS",JOptionPane.INFORMATION_MESSAGE);
				  				   
			 }else if (source.getSource()==(JButton) saveButton){
				 String saveType = "SAVE";
				 int emptyFlag=0;					 
				 if(table.getValueAt(0, 0).equals("") && table.getValueAt(0, 2).equals("")
					&& table.getValueAt(0, 3).equals("") && table.getValueAt(0, 3).equals("") ){
				 	emptyFlag=1;
				 }	
								
				
				else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
					JOptionPane.showMessageDialog(null,"Delivered order cannot be saved","RMS",JOptionPane.INFORMATION_MESSAGE);					 				 
				
			  }else if (source.getSource()==(JButton) cancelButton){
				   try{
					    win = JSObject.getWindow(this);
					    win.call("showMsg",null);
				        win.eval("document.myform.submit()");
				   }catch(JSException e){
					   String error="Not get Win Object";
					   System.out.println(error);
				   } 
			}else if (source.getSource()==(JButton) clearButton){
				   try{
					   win = JSObject.getWindow(this);
					   win.eval("window.location.reload(false)");
					   win.eval("document.myform.submit()");
				   }catch(JSException e){
					   String error="Not get Win Object";
					   System.out.println(error);
				   } 
			}
			 else if (source.getSource()==(JButton) viewButton){
				 new DialogFrame("View Slected Product Information Details");
			 }
		}catch(ArrayIndexOutOfBoundsException aie){
			System.out.println("Error occured in actionPerformed "+ aie);
		}	 
	}// EOF ActionList
	 
	 public void saveOrder(String saveType){	
/* Logic here is copyOrder=="copyOrder" then new orderNo is 
 * created both for save or hold. Else if copyOrder="" then 
 * existing orderNo ie the order which is being edited is 
 * inserted into DataBase*/		 
		 if(copyOrder.equals("CopyOrder"))
			 max=mo.getOrderNum(); 	
		 if(saveType.equals("SAVE")){
			 savingType="SAVE";
			 if(copyOrder.equals("CopyOrder")){
				 orderNo=max;
				 status = mo.getStatus("SUBMITTED");			 
			}
			 else if(copyOrder.equals("") || copyOrder==null){
				 status = mo.getStatus("SUBMITTED");
				}
		 }
		 else if(saveType.equals("HOLD")){
			 savingType="HOLD";
			 if(copyOrder.equals("CopyOrder")){
				 orderNo=max;
				 status="HOLD" 	;
			 }
			else if(copyOrder.equals(""))			 
			 status = saveType;	
		 }
		 if(copyOrder.equals("") )
			 lastOrderdate = mo.getLastOrderDate(orderNo);	
		 transId=mo.getTransactionId();
		 msgYesNo="0";
		 //setBalance();
		// saveInOrderTable();
		 if(!msgYesNo.equals("1")){
			 clearAll();				
	 		 try{  
	 		       win = JSObject.getWindow(this);
	 				 if(saveType.equals("HOLD"))
	 					 win.eval("document.myform.printed.value=0");
	 				 else if(saveType.equals("SAVE"))
	 					 win.eval("document.myform.printed.value=1");	 
	 				win.eval("document.myform.orderNo.value="+orderNo);
	 		       win.call("showMsgSend",null);
	 		            win.eval("document.myform.submit()");
	 		 }catch(JSException e){
	 		      String error="Not get Win Object";
	 		     System.out.println(error);
	 		 }
		 }
	}
	 
//	 public void saveInOrderTable(){
//			double itemRate=0.0f,itemQty=0.0f,totItemPrice=0.0f,itemMRP=0.0f, 
//			        minDisAmt=0.0f,totOrderValue=0.0f,
//			        totDisValue=0.0f;
//			int currentQuantity=0;
//			
//			
//			 try{
//			if(copyOrder.equals("")){
//				mo.deleteOrderDetail(orderNo);
//				orderType="EDIT";
//			}		
//			else if(copyOrder.equals("CopyOrder")){
//				orderType="CREATE";
//			}
//			for(int i=0; i< table.getRowCount(); i++){		
//				try{
//					 String query1="SELECT deal_on_qty,deal_amount from item_master where item_code='"+table.getValueAt(i, 3)+"'";
//					 item_code = table.getValueAt(i, 3).toString();
//					rs2 = getValstmt1.executeQuery(query1);			
//					while(rs2.next()){
//						 minDisAmt = rs2.getFloat(2);
//					}
//					rs2.close();				
//				}catch(Exception e){
//					System.out.println("Error in item_code "+e);
//				}				
//				if(table.getValueAt(i, 1).toString()== "true")  pickup_ind = 1;	
//				else pickup_ind = 0;	
//				itemRate= Double.parseDouble(table.getValueAt(i, 3).toString());	
//				//itemqtystr = table.getValueAt(i, 4).toString();
//				itemQty = Double.parseDouble(table.getValueAt(i, 4).toString());
//				totItemPrice= Double.parseDouble(table.getValueAt(i, 5).toString());
//				itemMRP= Double.parseDouble(table.getValueAt(i, 6).toString());
//				minDisAmt= Double.parseDouble(table.getValueAt(i, 7).toString());
//				disRemark = table.getValueAt(i, 8).toString();
////				This Line was uncommented because total item price was coming as zerototItemPrice=(itemQty*itemRate) - minDisAmt;			
//				totOrderValue = totOrderValue + totItemPrice;			
//				totDisValue = totDisValue + minDisAmt;									
//				mo.addOrderDetail(orderNo, item_code, itemRate, itemQty, totItemPrice, minDisAmt, disRemark, itemMRP, i, pickup_ind,item_returned);
//				currentQuantity=currentQuantity+(int)itemQty;
//			}
//			int totalItemsCount = table.getRowCount();	
//			
//			 }
//			 catch(Exception e){
//				 System.out.println("Exception occured in SaveInOrderTable "+e);
//				 e.printStackTrace();
//			 }
//	}
		
	public void clearAll(){	
		for(int i=table.getRowCount()-1; i>-1; i--){
			try{					
					rows.removeElementAt(i);
					table.addNotify();
					
					cme.editor.setText("");
					
					}catch(Exception e){
					System.out.println("In DeleteRow "+e);
			}
		}			
		columnCount=7;
		itemCount = 0;
		pickValue=0;
		deliverCount = 0;		
		pickUpCnt=0;			
		
	}

	public void setCellValues(String item_codeStr){		
		try{	
			System.out.println("Item String : "+item_codeStr);
			String insertIntoCellQuery = "SELECT item_code,item_name,item_rate,deal_on_qty "+
				" FROM item_master where item_code='"+item_codeStr+"'";
			rs1 = getItemstmt.executeQuery(insertIntoCellQuery);
			if(rs1.next()){
				selectCell(table.getSelectedRow(),table.getSelectedColumn());
				table.setValueAt(rs1.getString(1), table.getSelectedRow(), 0);				
				table.setValueAt(rs1.getString(2), table.getSelectedRow(), 2);
				table.setValueAt(rs1.getString(3), table.getSelectedRow(), 3);
				tfe.setText("");
			}	
		}catch(Exception se){
			System.out.println("Exception Occured while inserting data in table cells"+se);
			se.printStackTrace();
		}
    }    
	  
//	 public void checkBlankProduct(){	
//		for(int i=0; i< table.getRowCount(); i++){
//			if(table.getValueAt(i, 0).toString().equals("")){	
//				deleteRow(i);
//				if(table.getRowCount()>0){
//					table.changeSelection((table.getRowCount()-1), 0, false, false);
//					
//				}
//				//return("0");
//			}			
//		}
//		//return("1");
//	 }
//	 public String checkDuplicateProduct(){
//		 try{
//			String message =""; 
//			int rowCount = table.getRowCount();
//			String matchString="";
//			ArrayList prodArr=new ArrayList();
//			ArrayList weightArr=new ArrayList();
//			for(int row = 0; row < rowCount; row++){
//				prodArr.add((String)table.getValueAt(row, 0));
//				weightArr.add((String)table.getValueAt(row, 2));
//			}	
//			for(int row = 0; row < prodArr.size(); row++){
//				for(int j = 0;  j< prodArr.size(); j++){
//					if(row!=j){
//						matchString="";
//						if(prodArr.get(row).toString().equalsIgnoreCase(prodArr.get(j).toString()) && weightArr.get(row).toString().equalsIgnoreCase(weightArr.get(j).toString())){
//							message="Duplicate entry for: ";
//							matchString = prodArr.get(row) + "&" +weightArr.get(row);
//							message = message+matchString+".\n	Do you want to allow duplicate items";
//							int n=JOptionPane.showConfirmDialog(this, message,"RMS",0,1);
//							
//							if(n==1){			//no
//								for(int row1 = 0; row1 < table.getRowCount(); row1++){
//									if(table.getValueAt(row1, 0).equals(prodArr.get(row))){
//										table.changeSelection(row1, 0, false, false);
//										String duplicateItem=table.getValueAt(row1, 0).toString();
//										cme.editor.setText(duplicateItem);
//									}
//								}
//								prodArr.remove(row);
//								weightArr.remove(row);
//								return("0");
//							}
//							else if(n==0){		//yes
//								prodArr.remove(row);
//								weightArr.remove(row);
//								matchString="";
//								message="";
//							}
//						}
//					}				
//				}
//			}
//			return("1"); 
//				
//			}
//			catch(ArrayIndexOutOfBoundsException aie){
//				System.out.println("Exception in checkDuplicateProduct" +aie);
//				 return("0"); 
//			}
//	 }
	 	 
	 public int checkQuantity(){
		 try{
			  String quantityVal =(String)(table.getValueAt(table.getSelectedRow(), 3));
			  if(quantityVal.equals("")){
				  String  message="Quantity cannot be blank";
				  JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
				  return 1;
			  }
		 }catch(NumberFormatException nfe){
			 System.out.println("Error while editing cell"+nfe);
		 }		 
		 return 0;
	 }

	 
	 public int checkBlankValue(){
		  try{
			   Object barcodeVal,quantityVal,priceVal=null;			     
			   String  zeroMessage="Quantity cannot be zero";
			   String  blankMessage="Quantity cannot be blank";			  	 
			   barcodeVal =table.getValueAt(table.getSelectedRow(), 0);
			   quantityVal =table.getValueAt(table.getSelectedRow(), 2);
			   priceVal = table.getValueAt(table.getSelectedRow(), 3);	
			   if(barcodeVal.equals("")){
				   table.changeSelection(table.getSelectedRow(), 0, false, false);
				   return 1;
			   }else if(quantityVal.equals("")){
			       JOptionPane.showMessageDialog(null,blankMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
			       table.changeSelection(table.getSelectedRow(), 3, false, false);
			       return 1;
			   }else if(!quantityVal.equals("") && (quantityVal.equals("0"))){
				   JOptionPane.showMessageDialog(null,zeroMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				   table.changeSelection(table.getSelectedRow(), 3, false, false);
				   return 1;
			  }else if(priceVal.equals("")){
			       String  pMessage="Price cannot be blank";
			       JOptionPane.showMessageDialog(null,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
			       return 1;
			   }
		  }catch(NumberFormatException nfe){
			  System.out.println("Exception occured in checkBlankValue"+nfe);
			  nfe.printStackTrace();
		  } 
		  return 0;
	 }	 
	 
	 public void selectCell(int row,int col){
		  if(row!=-1 && col !=-1){
			  table.setRowSelectionInterval(row,row);
			  table.setColumnSelectionInterval(col,col);
		  }
	 }
	 
	 public class ComboBoxEditor extends JComboBox implements TableCellEditor{
		 JTextComponent editor;
	     String item_codeStr="",s;
	     String[] splitResult=null,splitStr;
	     int iCount=0;   
	     public ComboBoxEditor() {
	    	 super();
	    	 setEditable(true);
	    	 setEnabled(true);
	    	 setMaximumRowCount(5); 
	    	 editor = (JTextComponent) getEditor().getEditorComponent();
	    	 
	    	 addItemListener(new ItemListener(){ 
	    		 public void itemStateChanged(ItemEvent ie) {
	    			 String tempStr="";
	    			 s = (String)ie.getItem();
	    			 if(ie.getStateChange()== ItemEvent.SELECTED ){
	    				 if(!s.equals("")){
	    					 splitStr=s.split(" \\(  W : ");
	    					 if (!mousePressed)
	    						 editor.setText(splitStr[0]);
	    					 else{
	    						 if(s.contains("( ")){
	    							 tempStr=s;
	    							 if(productArray.indexOf(tempStr)!=-1){
	    								 item_codeStr=item_codeArray.get(productArray.indexOf(tempStr)).toString();
	    							 }
	    							 if(table.getRowCount()>0){
	    								 setCellValues(item_codeStr);
	    							 }
	    							 item_codeStr="";
	    						 }    	
	    						 setSelectedItem(splitStr[0]);
	    					 }
	    					 mousePressed = true;
	    				 }
	    				 else
	    					 editor.setText("");
	    			 }
	    		 } 
	    	 }); 
	         editor.addMouseListener(new MouseAdapter(){
	        	
	        	 public void mouseReleased(MouseEvent me) {
	        		
	        		 int rowCount=table.getRowCount();
	        		 if(table.getSelectedColumn()==0 ){	        
	        			 editor.setText(table.getValueAt(table.getSelectedRow(), table.getSelectedColumn()).toString());
	                 }else if(table.getSelectedColumn()==4){
			             if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("0")){
			              table.changeSelection(table.getSelectedRow(), 4, false, false);
			             }
			         }	         
			         for(int i=0; i<rowCount; i++){
				          if(table.getValueAt(i, 0).equals("")){				           
				           table.changeSelection(i, 0, false, false);
				          }
			         }	  
	        	 } 
	        	 
	        	 public void mousePressed(MouseEvent me) {
		          	try{
		          		checkBlankRows();
		                cme.editor.addKeyListener(new KeyAdapter(){
		                	public void keyReleased(KeyEvent ke){         
		                		if(ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
		                			if(cme.editor.getText().equals("")){
		                				table.setValueAt("", table.getSelectedRow(), table.getSelectedColumn());
		                			}
		                		}
		                	}
				        });  
			    		item_codeStr="";
		          	}catch(ArrayIndexOutOfBoundsException aio){
		          		System.out.println("Exception in mousePressed"+aio);
		          		aio.printStackTrace();
		          	}catch(NullPointerException npe){
		          		System.out.println("Exception in mousePressed"+npe);
		          		npe.printStackTrace();
		          	}
	        	 }
	         });	  
	         editor.addKeyListener(new KeyAdapter(){
	        	 String temp="",selectedItem="";      
	        	 String[] splitStrVal=null;
	        	 String item_codeStr="";	  
	        	 public void keyPressed(KeyEvent ke){  
	        		 try{      
	        			 mousePressed=false;
	 	               	if(ke.getKeyCode() == KeyEvent.VK_TAB){
		                    int r = table.getSelectedRow();
		                    int c = table.getSelectedColumn();		                   
		                    if(table.getValueAt(table.getSelectedRow(), 0).equals("") && editor.getText().equals("")){
		                    	JOptionPane.showMessageDialog(null,"Product Name is blank","RMS",JOptionPane.INFORMATION_MESSAGE);
		                    	table.changeSelection(r, 2, false, false);	                    	                    	                    	
		                    }
		                    else if(!editor.getText().equals("") && table.getValueAt(table.getSelectedRow(), 3).equals("") && table.getValueAt(table.getSelectedRow(), 5).equals("")){
		                    	JOptionPane.showMessageDialog(null,"Press enter to select product name","RMS",JOptionPane.INFORMATION_MESSAGE);
		                    	table.changeSelection(r, 2, false, false);	                    	                    	                    	
		                    }
		                    else if(c ==0 ) {
		                        table.changeSelection(table.getSelectedRow(), 3, false, false);
		                    } 
		                } 
	 	               if(ke.getKeyCode() == KeyEvent.VK_ENTER){
	 	            	   //ChangeSelection to be done here
	 	               }
	        		 }catch(NumberFormatException nfe){
	        			 System.out.println("Exception occured in ComboBoxEdidor keyPressed");
	        			 nfe.printStackTrace();
	        		 }
	        	 }// EOF KeyPressed()  
	        	 public void keyReleased(KeyEvent ke){                     
					 //if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)){
					//	 JOptionPane.showMessageDialog(scrollPane,"Numeric digits are not allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
					//	 editor.setText("");
					// }           
					 if ((ke.getKeyCode() == KeyEvent.VK_ESCAPE)){
						 if(isPopupVisible())
							 hidePopup(); 
					 }           
					 if ((ke.getKeyCode() == KeyEvent.VK_SHIFT) && ke.getKeyCode() == KeyEvent.VK_TAB){
						 checkBlankRows();
						 if(table.getSelectedColumn()==0 && table.getValueAt(table.getSelectedRow(), 1)!=""){
							 editor.setText(table.getValueAt(table.getSelectedRow(), table.getSelectedColumn()).toString());
						 }
					 }
					 if (ke.getKeyCode() == KeyEvent.VK_ENTER){
						 try{    
							 if(editor.getText().length()<3){
								 String selectedTextVal="";
								 String splitVal[]=null;
								 if(!editor.getText().equals("") && getItemCount()>=0){
									 selectedTextVal=(String)getItemAt(0);
									 splitVal = selectedTextVal.split(" \\(  W : ");
									 editor.setText(splitVal[0]);
									 if(productArray.indexOf(selectedTextVal)!=-1){
										 item_codeStr=item_codeArray.get(productArray.indexOf(selectedTextVal)).toString();
									 }
									 if(table.getRowCount()>0){
										 setCellValues(item_codeStr);
										 // ChangeSelection
										 table.changeSelection(table.getSelectedRow(), 4, false, false);
									 }
									 item_codeStr="";
								 }else if(editor.getText().equals("")){
									 for(int i=0; i<table.getColumnCount(); i++){
										 if(i==1){
											 table.setValueAt(new Boolean(false), table.getSelectedRow(), i);
										 }
										 else
											 table.setValueAt("", table.getSelectedRow(), i);
									 }
								 }
							 }else{								 
								 setProdName=selectedItem;
								 prodValResult = setProdName.split(" \\(  W : ");
								 if(editor.getText().equals(prodValResult[0])){
									 item_codeStr=item_codeArray.get(productArray.indexOf(setProdName)).toString();
									 if(table.getRowCount()>0)
										 setCellValues(item_codeStr);
									 	 // ChangeSelection
									 	 table.changeSelection(table.getSelectedRow(), 4, false, false);

								 }
								 item_codeStr="";
							 }
						 }catch(ArrayIndexOutOfBoundsException aie){
							 System.out.println("Exception when item entered"+aie);
							 aie.printStackTrace();
						 }
					 }           
					 if(!(ke.getKeyCode()==KeyEvent.VK_DOWN) && !(ke.getKeyCode()==KeyEvent.VK_UP)
							 && !(ke.getKeyCode()==KeyEvent.VK_LEFT) && !(ke.getKeyCode()==KeyEvent.VK_RIGHT)
							 && !(ke.getKeyCode()==KeyEvent.VK_ENTER) && !(ke.getKeyCode()==KeyEvent.VK_TAB)
							 && !(ke.getKeyCode()==KeyEvent.VK_SHIFT) && !(ke.getKeyCode()==KeyEvent.VK_HOME)
							 && !(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) && !(ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)
							 && !(ke.getKeyCode()==KeyEvent.VK_ESCAPE)) {
						 try{   							 
							 String temp="";
							 temp = editor.getText();
							 while(getItemCount()!=0)
								 removeItemAt(0);             
							 String str="";   
							 if (temp.trim().length()>0){								 
								 for(int i=0; i<productArray.size(); i++){
									 str = productArray.get(i).toString();
									 if(str.toUpperCase().startsWith(temp.toUpperCase())){
										 addItem(str);    
									 }
								 }
							 }
							 setProdName = temp;               
							 if(setProdName == ""){
								 hidePopup();
							 }else
								 showPopup();
							 editor.setText(temp); 

						 }catch(Exception e){
							 System.out.println("Error occured in KeyReleased"+e);
						 }
					 } // EOF Various Conditions 
					 
					 if((ke.getKeyCode()==KeyEvent.VK_DOWN) || (ke.getKeyCode()==KeyEvent.VK_UP)||
							 (ke.getKeyCode()==KeyEvent.VK_PAGE_UP) || (ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)){						 						 
						 
						 selectedItem="";	
						 setPopupVisible(true);
						 if(getSelectedIndex()!=-1){
							 setPopupVisible(true);
							 selectedItem=(String)getItemAt(getSelectedIndex());							 
						 }        			
						 if(!selectedItem.equals("")){
							 splitStrVal = selectedItem.split(" \\(  W : ");
							 editor.setText(splitStrVal[0]);
						 }						 
					 }//EOF Condition for up,down,pageUp, pageDown keys respectively for setting the editor.
					 
					 if(ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 if(editor.getText().equals("")){
							 for(int i=0; i<table.getColumnCount(); i++){
								 if(i==1){
									 table.setValueAt(new Boolean(false), table.getSelectedRow(), i);
								 }
								 else
									 table.setValueAt("", table.getSelectedRow(), i);
							 }
						 }
					 } 
				 }  
				 
			 });     
		 } // EOF Combo Constructor 
	     
	     public void addCellEditorListener(CellEditorListener listener) {}
	  
	     public void removeCellEditorListener(CellEditorListener listener) {}
	     
	     public void cancelCellEditing() {}
	     
	     public boolean stopCellEditing() {
	    	 return true;
	     }
	  
	     public boolean isCellEditable(EventObject event) {
	         return true;
	     }
	  
	     public boolean shouldSelectCell(EventObject event) {
	    	 return true;
	     }
	  
	     public Object getCellEditorValue() {
	    	 return this;
	     }
	  
	     public Component getTableCellEditorComponent(JTable table, Object value, boolean isSelected,
	         int row, int column) {
	    	 return this;
	     }
	     
	     public void checkBlankRows(){
	    	 int rowCount=0;
		     rowCount=table.getRowCount();
		     for(int row=0; row<rowCount; row++){
		    	 if(table.getValueAt(row, 0).equals("") || table.getValueAt(row, 2).equals("false") &&
		    			 table.getValueAt(row, 3).equals("") && table.getValueAt(row, 4).equals("")&&
		    			 table.getValueAt(row, 5).equals("") && table.getValueAt(row, 6).equals("") ){
		    		 for(int itemCount=0; itemCount<getItemCount(); itemCount++){
		    			 removeItemAt(0);
		    		 }
		    	 }
		     }            
		     for(int row=0; row<rowCount; row++){
		    	 if(!(table.getValueAt(row, 0).equals("") || table.getValueAt(row, 2).equals("false") &&
		    			 table.getValueAt(row, 3).equals("") && table.getValueAt(row, 4).equals("")&&
		    			 table.getValueAt(row, 5).equals("") && table.getValueAt(row, 6).equals(""))){
		    		 if(getItemCount()!=0){
		    			 for(int itemCount=0; itemCount<getItemCount(); itemCount++){
		    				 removeItemAt(0);
		    			 }
		    		 }
		    	 }
		     }
	     } // EOF checkBlankRows     
	 }// EOF ComboBoxEditor
  
	public class TextFieldEditor extends JTextField{
		 int productColBlank=0;
		 public TextFieldEditor(){
			 super();
			 table.addMouseListener(new MouseAdapter(){
				 public void mouseReleased(MouseEvent me) {          
					 int rowCount=table.getRowCount();        
					 for(int i=0; i<rowCount; i++){
						 if(table.getValueAt(i, 1).equals("")){
							 cme.editor.setText("");
							 JOptionPane.showMessageDialog(null,"Product cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 1, false, false);
							 break;
						 }else if(table.getValueAt(i, 3).equals("") || !(Double.parseDouble(table.getValueAt(i, 4).toString())>=0.0)){
							 JOptionPane.showMessageDialog(null,"Quantity cannot be blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 3, false, false);
							 break;
						 } 
						 
					 }          
					 if(table.getSelectedColumn()==0){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !(Double.parseDouble(table.getValueAt(table.getSelectedRow(), 4).toString())>=1) ){
							 table.changeSelection(table.getSelectedRow(), 0, false, false);
						 }
					 }else if(table.getSelectedColumn()==4){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !(Double.parseDouble(table.getValueAt(table.getSelectedRow(), 4).toString())>=1)){
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
						 }
					 }else if(table.getSelectedColumn()==2 || table.getSelectedColumn()==3 || table.getSelectedColumn()==5 || table.getSelectedColumn()==6){
						 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 }
				 }
				 public void mousePressed(MouseEvent me) {}
			 }); 
			 
			 table.addKeyListener(new KeyAdapter(){    
				 public void keyReleased(KeyEvent ke){
					 for(int i=0; i<table.getRowCount(); i++){
						 if(table.getValueAt(i, 0).equals("")){
							 JOptionPane.showMessageDialog(null,"Product cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 0, false, false);
						 }            
						 else if(!table.getValueAt(i, 4).equals("") && !(Double.parseDouble(table.getValueAt(i, 4).toString())>=1)){
							 	table.changeSelection(i, 4, false, false);
						 }else if(!table.getValueAt(i, 0).equals("")){
							 table.changeSelection(i, 4, false, false);
						 }
					 }//EOF For
					 if(table.getSelectedColumn()==0){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !(Double.parseDouble(table.getValueAt(table.getSelectedRow(), 4).toString())>=1)){
							 table.changeSelection(table.getSelectedRow(), 0, false, false);
						 }
					 }else if(table.getSelectedColumn()==4){           
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !(Double.parseDouble(table.getValueAt(table.getSelectedRow(), 4).toString())>=1)){
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
						 }
					 } 
				 } // EOF KeyRealeased      
			 });     
			 addKeyListener(new KeyAdapter(){    
				 public void keyPressed(KeyEvent ke){   
					
					 boolean checkFirstColFlag=false,checkLastRowFlag=false;
					 int rowCount=table.getRowCount();   
					
					 if((ke.getKeyCode()==KeyEvent.VK_TAB && table.getSelectedColumn()==4)){
						 String quantity=getText();
						 checkFirstColFlag=isFirstColumnBlank();
						 if(table.getSelectedRow()==rowCount-1 && table.getSelectedColumn()==4){
							 checkLastRowFlag=true;
						 }
						 if(quantity.equals("") || quantity.equals("0")){
							 JOptionPane.showMessageDialog(null,"Quantity cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);//setSelected only works here
						 }        
						 else if(getText().startsWith("0.0")){
							 JOptionPane.showMessageDialog(null,"Quantity is less than 1","RMS",JOptionPane.INFORMATION_MESSAGE);
							 setText("");
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !quantity.equals("0")  && checkFirstColFlag==true){
							 JOptionPane.showMessageDialog(null,"Product Name is blank at row "+(productColBlank+1),"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !(Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false && checkLastRowFlag==false){
							 JOptionPane.showMessageDialog(null,"Next Row can only be added from last row","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(rowCount-1, 0, false, false);
						 }else if((table.getValueAt(table.getSelectedRow(), 5).equals("0.0")) || (table.getValueAt(table.getSelectedRow(), 5).equals("0"))){  
							 String pMessage="Total Price cannot be Zero";
							 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);
							 
						 }else if(!quantity.equals("") && (Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false && checkLastRowFlag){
							 if(statusCode.equals("SUBMITTED") || statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){							
								 addRow();
								 table.setValueAt("",table.getSelectedRow(), 4);
							 }
							 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
								 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);							 
						 }               
					 } //EOF TAB  
					
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_N) || ke.getKeyCode()==KeyEvent.VK_P){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_D)){
						 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 }       
				 } 
      
				 public void keyReleased(KeyEvent ke){ 
					
					 if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
						 JOptionPane.showMessageDialog(null,"Negative value in not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText("");
					 }       
					 if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
						 JOptionPane.showMessageDialog(null,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText(getText().trim());
					 }       
					 if((ke.getKeyCode()==KeyEvent.VK_ENTER)){
						 table.changeSelection(table.getSelectedRow(), 3, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_SHIFT)){
						 table.changeSelection(table.getSelectedRow(), 3, false, false);
					 }
				 }  
			 }); //EOF KeyListener Adapter inner Class     
		 } // EOF TextFieldEditor constructor..
         public boolean isFirstColumnBlank(){
              int rows = table.getRowCount();
              boolean flag=false;
              for(int i=0; i<rows; i++){
            	  if(table.getValueAt(i, 0).equals("")){
            		  flag=true;
            		  productColBlank=i;
            		  break;
            	  }
            	  else{
            		  flag=false;
            	  }
              }
              return flag;
          }// EOF isFirstColumnBlank()       
         

 	} //EOF TextFieldEditor Class      
   
	 public boolean checkRowBeforeAdding(){
		 boolean flag=false;
		 String productStrValue="";
		 try{			
			 int rowCount = table.getRowCount();
			 for(int r=0; r<rowCount; r++){ 				
				 productStrValue="";				
				 productStrValue=table.getValueAt(r, 0).toString();				    
				 if( productStrValue.equals("")){
					 flag=true;
					 JOptionPane.showMessageDialog(null,"Product Name is blank","RMS",JOptionPane.INFORMATION_MESSAGE);
					 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 break;//return flag;
				 }else if(table.getValueAt(r, 4).equals("") || table.getValueAt(r, 4).equals("0") || table.getValueAt(r, 4).toString().startsWith("0.0")){ 
					 flag=true;        
					 JOptionPane.showMessageDialog(null,"Quantity is blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
					 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 break;//return flag;
				 }      
			 }// EOF For loop
		 }catch(NumberFormatException nfe){
			 System.out.println("Exception in checkRowBeforeAdding"+nfe);
		 }
		 return flag;
	 }
	
//	 Class for adding a window popup for displaying slected products description
	 
	  public class DialogFrame extends Frame implements ActionListener {
		  
		    JFrame jframe;
			JTable winTable;
			Vector rows1 ;
			Vector <String> columns1;
			DefaultTableModel winTabModel;
			JScrollPane winscrollPane;
			JButton cmdClose,cmdDelete;
			JPanel winTablePanel,winButtonPanel,winMainPanel,displayPanel;
			JLabel dispLabel;
		  
		    DialogFrame(String title) {
		      super(title);
		      jframe=new JFrame();
		      jframe.setSize(580,650);
		      jframe.setVisible(true);
		      makeDialogGUI();
		      MyWindowAdapter adapter = new MyWindowAdapter(this);
		      addWindowListener(adapter);
		      if(table.getRowCount()>0){
		    	  for(int i=0; i<table.getRowCount(); i++){
		    		  addRowInTable();
		    		  winTable.setValueAt(table.getValueAt(i, 0), i, 0);
		    		  winTable.setValueAt(table.getValueAt(i, 2), i, 1);
		    		  winTable.setValueAt(table.getValueAt(i, 3), i, 2);
		    	  }
		      }
		    } //EOF Constructor

//-----------This Code Is for the View button Window -----------------------------------------------------------		  
			public void makeDialogGUI(){
				//setSize(1000,350);
				rows1=new Vector();
				columns1= new Vector();
				String[] columnName = { "Product", "Price","Quantity"};
				addColumnsInTable(columnName);
				winTabModel=new DefaultTableModel();
				winTabModel.setDataVector(rows1,columns1);
				winTable = new JTable(winTabModel);
				winscrollPane= new JScrollPane(winTable);//ScrollPane	
				add(winscrollPane);
				winButtonPanel=new JPanel();
				cmdClose=new JButton("Close Window");
				cmdClose.setMnemonic(KeyEvent.VK_B);
				
				winButtonPanel.add(cmdClose);							    
				cmdClose.addActionListener(this);
				
				addWindowPopupComponents();
				setTableCellSize();	
				winTable.setEnabled(false);
				
			}//EOF makeDialogGUI()
	
			public void addColumnsInTable(String[] colName){
				for(int i=0;i<colName.length;i++){
					columns1.addElement((String) colName[i]);
				}
			}
				
			public void addRowInTable(){ 
				Vector r1=new Vector();
				r1=addBlankElements();
				rows1.addElement(r1);
				winTable.addNotify();	    
			}
			
			 public Vector addBlankElements() {
					Vector <String> t1  = new Vector<String>();
					t1.addElement(" ");
					t1.addElement(" ");
					t1.addElement(" ");
						
					return t1;
				}
			 
				public void actionPerformed(ActionEvent source)
				{
					if (source.getSource()==(JButton) cmdClose)
					{
						jframe.dispose();
					}	
				}// EOF ActionList
			 
				public void addWindowPopupComponents(){
					winMainPanel=new JPanel();
					winTablePanel=new JPanel();
					displayPanel=new JPanel(new FlowLayout());
					dispLabel=new JLabel("Following are the selected products");
					dispLabel.setForeground(Color.BLUE);
					dispLabel.setFont(new Font("Arial", Font.BOLD, 15));
					winMainPanel.setLayout(new BorderLayout());
					winMainPanel.add("North",displayPanel);
					winMainPanel.add("Center",winscrollPane);
					winMainPanel.add("South",winButtonPanel);
					displayPanel.add(dispLabel);
					winTablePanel.setBackground(Color.white);
					winButtonPanel.setBackground(Color.white);
					winTable.getParent().setBackground(Color.BLACK);
					jframe.getContentPane().add(winMainPanel);
					jframe.setVisible(true);
					winTable.setVisible(true);
				}
				
				public void setTableCellSize(){
					TableColumnModel tcmWinPopup = winTable.getColumnModel();
					//tcmWinPopup.getColumn(0);
					tcmWinPopup.getColumn(0).setPreferredWidth(100 );
					tcmWinPopup.getColumn(0).setMinWidth( 225 );
					tcmWinPopup.getColumn(0).setMaxWidth(350);
					
					tcmWinPopup.getColumn(1).setPreferredWidth(75 );
					tcmWinPopup.getColumn(1).setMinWidth( 75 );
					tcmWinPopup.getColumn(1).setMaxWidth(100);
					
					tcmWinPopup.getColumn(2).setPreferredWidth(75 );
					tcmWinPopup.getColumn(2).setMinWidth( 75 );
					tcmWinPopup.getColumn(2).setMaxWidth(100);
					
				}			
//-----------------------------------------------------------------------------------		  
		}//EOF DialougeFrame class
		
	 class MyWindowAdapter extends WindowAdapter{
		 DialogFrame dialogFrame;
		 public MyWindowAdapter(DialogFrame dialogFrame){
			 this.dialogFrame = dialogFrame;
		 }
		 public void windowClosing(WindowEvent we){
			 dialogFrame.dispose();
		 }
	 } // EOF MyWindowAdapter class
	
	
	 public void trimTextField(JTextField jtf){	 
		 int len=0;
		 len=jtf.getText().length();
		 String temp = jtf.getText().substring(0, len-1);
		 jtf.setText(temp);	 
		 jtf.requestFocus();
	 }


}
