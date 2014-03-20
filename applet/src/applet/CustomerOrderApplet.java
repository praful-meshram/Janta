package applet;

import javax.swing.*;
import javax.swing.event.CellEditorListener;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellEditor;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumnModel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.swing.text.JTextComponent; 

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.event.*;
import java.sql.*;
import java.util.*;
import netscape.javascript.JSObject; 
import netscape.javascript.JSException;
import java.lang.Math;
import java.util.Stack;

public class CustomerOrderApplet extends JApplet implements ActionListener, TableModelListener{//, Runnable{
 
	ManageOrderFile mo;
	Stack lifo = new Stack();
	 //Thread saveThread = new Thread(this); 
	 JSObject win;
	 JTable table;
	 DefaultTableModel tabModel;
	 JScrollPane scrollPane;
	 Vector rows = new Vector();
	 Vector <String> columns = new Vector <String>();
	 Vector <String> itemNames = new Vector <String>();
	 Vector <String> productArray = new Vector<String>();
	 Vector <String> item_codeArray = new Vector<String>();
	 Vector <String> priceVersionArray = new Vector<String>();
	 Vector <Integer> reorderArray = new Vector<Integer>();
	 Vector <Integer> quantityArray = new Vector<Integer>();
	 Object objTemp=null;
	 ComboBoxEditor cme; 
	 RemarkColEditor remarkEditor;
	 Connection con=null;
	 ResultSet rs,rs1=null,rs2,rs3,rs4; 
	 Statement getValstmt,getItemstmt,getValstmt1,getValstmt2,stmt; 
	 JButton addButton,deleteButton,saveButton,cancelButton,clearButton,
	 		 holdButton,viewButton,paymentButton;
	 JCheckBox checkBox;
	 JComboBox paymentCombo;
	 JTextComponent commonJTC;
	 TextFieldEditor tfe;
	 JLabel totalPrice,totalField,totalMrp,totalItems,pickUp,deliver,paymentLbl,savingLbl,
	     totalItemFld,pickUpFld,deliverFld,totalMrpFld,savingFld,emptyFld,emptyFld1,
	     deliverInstruLbl,advance,otherDiscount,balance,
	     cstCode,customerName,cstName,custPhone,cstphone,oDate,cstdate,orderDetails,custEmpty,	  
	     balanceLblVal,blankLbl1,blankLbl2,otherChargesLbl,customerCodelbl;
	 JPanel tablePanel,innerbuttonPanel,buttonPanel,mainPanel,labelPanel1,labelPanel2,
	     labelPanel3,labelPanel4,labelPanel5,labelPanel6,emptyPanel,emptyPanel1,
	     wholeLabelPanel,custPanel1,custPanel2;
	 JTextComponent editor;
	 JTextField deliverInstruText,advanceTxt,otherDiscountTxt,otherChargesTxt;

	 double totalFldValue=0.0f,totalMrpLblVal=0.0f;
	 double totMRPValue=0.0f,balanceValue=0.0f,advanceValue=0.0f,
	 		otherDiscountValue=0.0f,totalSaving=0.0f,otherChargesValue=0.0f;
	 long pickup_ind=0,item_returned=0; 
	 int itemCount = 0,pickValue=0, deliverCount = 0, max=0,transId=0,pickUpCnt=0,columnCount=7;
	 String dburl="", dbusername="", dbpassword="",copyOrder="NoCopy",paymentMode="";
	int siteId;
	 String  customerCode="", item_code="", pay_type="", p_code="",orderType="CREATE";
	 String user="", backPage="",disRemark="",status,deliveryRemark;
	 String productValue,setProdName="",quantityValue="",blankString="",weightString="",
	        rateString="",blankValue="  ",blank=" ",blankVar="   ",blankValue3="   ";
	 String[] prodValResult;
	 int dealQty,advanceFocus=0,discountFocus=0,maxrec=0;
	 boolean mousePressed = true;
	 boolean running = true;
	 String msgYesNo="0";
	 
	 public void init(){
		System.out.println("\n\n  init =========\n\n");
		 try{ 
			 dburl = getParameter("dburl");
			 dbusername = getParameter("dbusername");
			 dbpassword = getParameter("dbpassword");	 
			 siteId = Integer.parseInt(getParameter("siteId"));
			 customerCode = getParameter("customerCode");
			 user = getParameter("user");
			  backPage = getParameter("backPage");
			 
			 /*dburl = "jdbc:mysql://localhost:3306/js_data?autoReconnect=true";
			 dbusername="root";
			 dbpassword="@ss123";
			 user="admin";
			 siteId=1;*/
			
			 System.out.println(dburl+"\n"+dbusername+"\n"+dbpassword);
			 initialize(dburl,dbusername,dbpassword);
			//addMouseListener(this);
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
	 
	 public void assignVar(String custCode, String user1, String backPage1){
		 customerCode = custCode;  
		 user = user1; 
		 backPage = backPage1;  
	 }
	 
	public void start(){
		
	}
	 
	 public void  initialize(String dburl, String dbusername,String dbpassword){
		 try{				 
			 Class.forName("com.mysql.jdbc.Driver");			
			 System.out.println("values = ["+dburl+"] ["+dbusername+"] ["+dbpassword+"]");
			 con = DriverManager.getConnection(dburl, dbusername, dbpassword);
			 System.out.println("After getConnection");
			 mo = new ManageOrderFile(dburl, dbusername, dbpassword); 
			 getValstmt = con.createStatement();
			 getValstmt1 = con.createStatement();
			 getValstmt2 = con.createStatement(); 
			 getItemstmt = con.createStatement();
			 stmt = con.createStatement();    
		 }catch (Exception e){
			 System.out.println("Error occurred in Database Connection " + e);   
		 }   
	 }
	 
	 public void closeAll(){
		 try{
			 getValstmt.close();
			 getValstmt1.close();
			 getValstmt2.close();
			 getItemstmt.close();
			 stmt.close();
			 con.close();
		 }catch(Exception e){
	         e.getMessage();
	         e.printStackTrace();
		 } 
	 } 
	 
	 public void makeGUI(){  
		 String[] columnNames = { "Item","Check", "Weight","Price","Quantity","Total Price","MRP","Discount","Remark","ItemCode","PriceVersion"};
		 addColumns(columnNames);  
		 tabModel = new DefaultTableModel();  
		 tabModel.setDataVector(rows,columns); 
		 setTabFocus();
		 table.setCellSelectionEnabled(true);   
		 scrollPane = new JScrollPane(table); 
	     TableColumnModel tcm = table.getColumnModel();
	     TableColumn colwithCombo = tcm.getColumn(0);  
	     TableColumn colwithCheck = tcm.getColumn(1);
	     TableColumn colwithTextField = tcm.getColumn(4); 
	     TableColumn remarkColwithTextField = tcm.getColumn(8);
	     TableColumn itemCodeColumn = tcm.getColumn(9);
	     TableColumn priceVersionColumn = tcm.getColumn(10);
	     
	     itemCodeColumn.setMaxWidth(0); 
	     itemCodeColumn.setMinWidth(0);
	     priceVersionColumn.setMaxWidth(0);
	     priceVersionColumn.setMinWidth(0);
	     table.getTableHeader().getColumnModel().getColumn(9).setMaxWidth(0); 
	     table.getTableHeader().getColumnModel().getColumn(9).setMinWidth(0);
	     table.getTableHeader().getColumnModel().getColumn(10).setMaxWidth(0); 
	     table.getTableHeader().getColumnModel().getColumn(10).setMinWidth(0);
	     cme=new ComboBoxEditor();
	     colwithCombo.setCellEditor(cme);  
	     colwithCheck.setCellEditor(new DefaultCellEditor(new CheckBoxEditor()));  
	     CheckBoxCellRendrer chkRenderer = new CheckBoxCellRendrer();
	     colwithCheck.setCellRenderer(chkRenderer);
	     tfe=new TextFieldEditor();
	     colwithTextField.setCellEditor(new DefaultCellEditor(tfe));
	     remarkEditor= new RemarkColEditor();
	     remarkColwithTextField.setCellEditor(new DefaultCellEditor(remarkEditor));
		  
	     setUpProductColumn(colwithCombo,colwithCheck);  
	     table.getModel().addTableModelListener(this);  
	     addComponents();
	     colwithCombo.setPreferredWidth(600 );
	     colwithCombo.setMinWidth( 250 );
	     colwithCombo.setMaxWidth(600); 
	     remarkColwithTextField.setPreferredWidth(250 );
	     remarkColwithTextField.setMinWidth( 250 );
	     remarkColwithTextField.setMaxWidth(250); 
	     table.setRowHeight(20);	
	     
	     // add balank rows on load of applet 
	     
	     addRowFirst();
	 }
	 
	 public void selectDefault(){
		 addRowFirst();
	     table.changeSelection(0, 0, false, false);
		 //return "selectDefault called";
	 }
	 public void addColumns(String[] colName){
		 for(int i=0;i<colName.length;i++)
			 columns.addElement((String) colName[i]);
	 }  
	 
	 public void addRow(){ 
		 //System.out.println("Adding row : "+table.getRowCount());
		 Vector r=new Vector();
		 String showMsgStatus="";
		 r=addBlankElement();	
		 rows.addElement(r);
		 table.addNotify();	
		 
		 if(customerCode.equals("CC")){
			 try{
				 win = JSObject.getWindow(this);
				 win.call("showMsg",null);
					 
			 }catch(JSException e){
				 String error="Not get Win Object";
				 System.out.println(error);
			 }
			 catch(Exception e){
				 System.out.println("error "+e);
				 e.printStackTrace();
			 }
		 }
		 else{
			 int row = table.getRowCount() - 1;
			 table.setValueAt("", row, 0);
			 if(row>=0){
				 /*Commented to solve problem when tab pressed on remark col*/
				 //table.setEditingRow(row);  
				 table.changeSelection(row, 0, false, false);
			 }
			 cme.checkBlankRows();
			 cme.removeAllItems();
			 itemCount++;
			 totalItemFld.setText(Integer.toString(itemCount));
			 totalItemFld.setForeground(Color.blue);
			 deliverFld.setText(Integer.toString(itemCount));
			 deliverFld.setForeground(Color.blue);
			 table.changeSelection(table.getSelectedRow(), 0, false, false);			 
			
		 }
		 
	 } 
	 
	 public void addRowFirst(){ 
		System.out.println("Adding first row : "+table.getRowCount());
		 if(table.getRowCount()<1){
			 Vector r=new Vector();
			 r=addBlankElement();	
			 rows.addElement(r);
			 table.addNotify();		
			
			 int row = table.getRowCount() - 1;
			 table.setValueAt("", row, 0);
			 if(row>=0){
				 table.setEditingRow(row);
				 table.changeSelection(row, 0, false, false);
			 }
			 cme.checkBlankRows();
			 cme.removeAllItems();
			 itemCount++;
			 totalItemFld.setText(Integer.toString(itemCount));
			 totalItemFld.setForeground(Color.blue);
			 deliverFld.setText(Integer.toString(itemCount));
			 deliverFld.setForeground(Color.blue);
			 table.changeSelection(table.getSelectedRow(), 0, false, false);
		 }
		 saveButton.setEnabled(true);
	 } 
	   
	 public Vector addBlankElement(){
		  Vector <String>t = new Vector<String>();
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
		  t.addElement("");
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
				 nextQuantity=table.getValueAt(table.getSelectedRow()+1,4).toString();
			 tabModel.removeRow(table.getSelectedRow());
			 if(table.getRowCount()>=1){
				 tfe.setText(nextQuantity);
				 //table.changeSelection(0, 0, false, false);
				 table.changeSelection(0, 4, false, false);
			 }
		 }
		 if(index>=1){
		 try{	
			 prevQuantity=table.getValueAt(table.getSelectedRow()-1,4).toString();
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
//					 This code is added on 24/3/08 for editing purpose after deleting a particular row.
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
								 //cme.addItem(str); //This Statement not working. Gives ArrayOutOfBounds Excp -1.
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
						 table.changeSelection(0, 4, false, false);		 
					 }
					 else if(table.getRowCount()>1){					 
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
				       totalItemFld.setText(Integer.toString(itemCount));
				       deliverFld.setText(Integer.toString(deliverCount));
				  } 					 
				
				 if(flag==true){
					 table.changeSelection(previousRow, 4, false, false);	
				 }
		 }	
			 
		 }
		 catch(Exception e){
			 System.out.println("Exception in Delete row..");
			 e.printStackTrace();
		 }
		}
		 setOverallTotal();	
	}//Delete Row
	 
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
		 table = new JTable(tabModel){
			 public boolean isCellEditable(int row, int column){              
				 if(column ==0 || column ==4 || column ==1 || column ==8)
					 return true;
				 else
					 return false;
			 } 
			 public void changeSelection(final int row, final int column, boolean toggle, boolean extend){
	     	      	super.changeSelection(row, column, toggle, extend);
	     	      	if (editCellAt(row, column))
	     	      		getEditorComponent().requestFocusInWindow();               
			 }           
		 };
	 }
	 
	 public void addComponents(){
		  buttonPanel = new JPanel();
		  innerbuttonPanel = new JPanel();
		  buttonPanel.setLayout(new GridLayout(2,1,0,0));
		  
		  addButton = new JButton("Add New Row");
		  clearButton = new JButton("Clear");
		  deleteButton = new JButton("Delete");
		  saveButton = new JButton("Save & Print");
		  holdButton = new JButton("Hold");
		  cancelButton = new JButton("Cancel");
		  viewButton = new JButton("View");
		  paymentButton= new JButton("Payment");
		  addButton.setMnemonic(KeyEvent.VK_N);
		  clearButton.setMnemonic(KeyEvent.VK_C);
		  deleteButton.setMnemonic(KeyEvent.VK_D);
		  saveButton.setMnemonic(KeyEvent.VK_S);  
		  holdButton.setMnemonic(KeyEvent.VK_H);  
		  cancelButton.setMnemonic(KeyEvent.VK_B);
		  viewButton.setMnemonic(KeyEvent.VK_V);
		  paymentButton.setMnemonic(KeyEvent.VK_P);
		  
		  wholeLabelPanel = new JPanel(new FlowLayout(0,0,0));
		  labelPanel1 = new JPanel(new GridLayout(3,1,0,0));
		  emptyPanel = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel2 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel3 = new JPanel(new GridLayout(2,1,0,0));
		  emptyPanel1 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel4 = new JPanel(new GridLayout(3,1,0,0));
		  labelPanel5 = new JPanel(new GridLayout(3,2,0,0));
		  labelPanel6 = new JPanel(new GridLayout(3,2,0,0));
		  totalItems = new JLabel("Total Items :");
		  totalItemFld =  new JLabel();
		  pickUp = new JLabel("PickUp         :");
		  pickUpFld =  new JLabel();
		  deliver = new JLabel("Deliver         :");
		  deliverFld =  new JLabel();  
		  emptyFld = new JLabel("                                  ");  
		  paymentLbl = new JLabel("Payment :");		 
		  paymentCombo = new JComboBox(); 
		  paymentCombo.addItem("Select Type");

		  try{
			  stmt = con.createStatement();
			  rs4 = stmt.executeQuery("select payment_type_desc from payment_type");
			  while (rs4.next()) {
				  paymentCombo.addItem(rs4.getString(1));
			  }
			  rs4.close();			 
		  }catch(Exception e){
			  System.out.println("Exception in loading payment type"+e);
		  }
		  emptyFld1 = new JLabel("  ");  
		  totalPrice = new JLabel("Total Price     :");
		  totalField = new JLabel();
		  totalMrp = new JLabel("Total by MRP :");
		  totalMrpFld =  new JLabel();    
		  savingLbl =  new JLabel("saving             :  ");
		  savingFld =  new JLabel();

		  advance =  new JLabel("Advance              :  ");
		  advanceTxt=new JTextField(8);
		  otherDiscount =  new JLabel("Other Discount  :  ");
		  otherDiscountTxt=new JTextField(8);		  
		  balance =  new JLabel("Balance               : ");		
		  balanceLblVal=new JLabel("0");	
		  balanceLblVal.setForeground(Color.blue);
		  blankLbl1=new JLabel("");
		  blankLbl2=new JLabel("");
		  deliverInstruLbl=new JLabel("Delivery Instructions : ");
		  deliverInstruText=new JTextField();	
		  otherChargesLbl=new JLabel("Other Charges            : ");
		  otherChargesTxt=new JTextField(8);
		  otherChargesTxt.setText("5");
		  otherChargesTxt.setColumns(8);
		  
		  labelPanel1.add(totalItems);
		  labelPanel1.add(totalItemFld);
		  labelPanel1.add(pickUp);
		  labelPanel1.add(pickUpFld);
		  labelPanel1.add(deliver);
		  labelPanel1.add(deliverFld);
		  
		  labelPanel2.add(paymentLbl);  
		  
		  labelPanel3.add(paymentCombo);  
		  
		  paymentCombo.addActionListener(this);

		  emptyPanel1.add(emptyFld1);   
		  
		  labelPanel4.add(totalPrice);
		  labelPanel4.add(totalField);
		  labelPanel4.add(totalMrp);
		  labelPanel4.add(totalMrpFld);
		  labelPanel4.add(savingLbl);
		  labelPanel4.add(savingFld);
		  
		  labelPanel5.add(advance);
		  labelPanel5.add(advanceTxt);
		  labelPanel5.add(otherDiscount);
		  labelPanel5.add(otherDiscountTxt);
		  labelPanel5.add(balance);
		  labelPanel5.add(balanceLblVal);
		    
		  labelPanel6.add(deliverInstruLbl);
		  labelPanel6.add(deliverInstruText);
		  labelPanel6.add(otherChargesLbl);
		  labelPanel6.add(otherChargesTxt);
		  labelPanel6.add(blankLbl1);  
		  labelPanel6.add(blankLbl2);	  
		  
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
		  innerbuttonPanel.add(holdButton); 
		  innerbuttonPanel.add(clearButton);
		  innerbuttonPanel.add(deleteButton);  
		  innerbuttonPanel.add(cancelButton);
		  innerbuttonPanel.add(viewButton);
		  innerbuttonPanel.add(paymentButton);
		 
		  buttonPanel.add(wholeLabelPanel);
		  buttonPanel.add(innerbuttonPanel);
		 
		  addButton.addActionListener(this);
		  clearButton.addActionListener(this);
		  deleteButton.addActionListener(this);
		  //deleteButton.addMouseListener(this);		  
		  saveButton.addActionListener(this);
		  holdButton.addActionListener(this);
		  cancelButton.addActionListener(this);
		  viewButton.addActionListener(this);
		  paymentButton.addActionListener(this);
		  
		  advanceTxt.addActionListener(this);
		  otherDiscountTxt.addActionListener(this);		  	  
		  
		  advanceTxt.addKeyListener(new KeyAdapter(){
			  public void keyReleased(KeyEvent ke){	
					 if((ke.getKeyCode()==KeyEvent.VK_TAB )){							 
						 setFocusOnTextField();
					 } //EOF TAB
					 else if(advanceTxt.getText().length()>8){
						 JOptionPane.showMessageDialog(null,"You can enter maximum 8 digits","RMS",JOptionPane.INFORMATION_MESSAGE);
						 trimTextField(advanceTxt);
						 advanceTxt.requestFocus();
					 }
					 else if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
							 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 setBalance();						
					 }		
					 
					 else if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
						 JOptionPane.showMessageDialog(null,"Negative value is not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
						 advanceTxt.setText("");
						 setBalance();
						 advanceTxt.requestFocus();
					 }
					 else if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
						 JOptionPane.showMessageDialog(null,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
						 advanceTxt.setText(advanceTxt.getText().trim());
					 }	
					 else if((ke.getKeyCode()==KeyEvent.VK_ALT)){
						 advanceTxt.requestFocus();
					 }
					 else if(!(ke.getKeyCode()==KeyEvent.VK_DOWN) && !(ke.getKeyCode()==KeyEvent.VK_UP)
							 && !(ke.getKeyCode()==KeyEvent.VK_LEFT) && !(ke.getKeyCode()==KeyEvent.VK_RIGHT)
							 && !(ke.getKeyCode()==KeyEvent.VK_ENTER) && !(ke.getKeyCode()==KeyEvent.VK_TAB)
							 && !(ke.getKeyCode()==KeyEvent.VK_SHIFT) && !(ke.getKeyCode()==KeyEvent.VK_HOME)
							 && !(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) && !(ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)
							 && !(ke.getKeyCode()==KeyEvent.VK_INSERT) && !(ke.getKeyCode()==KeyEvent.VK_END)
							 && !(ke.getKeyCode()==KeyEvent.VK_ESCAPE) && !(ke.getKeyCode()==KeyEvent.VK_CONTROL)
							 && !(ke.getKeyCode()==524) && !(ke.getKeyCode()==525) && !(ke.getKeyCode()==20) 
							 && !(ke.getKeyCode()>=112 && (ke.getKeyCode()<=123))){
						 //int len=0;					 
						

					 }
				 }
		  });
		  
		  otherDiscountTxt.addKeyListener(new KeyAdapter(){			  
			  public void keyReleased(KeyEvent ke){         
				 if((ke.getKeyCode()==KeyEvent.VK_TAB)){					 
					 setFocusOnTextField();
				 } //EOF TAB
				 else if(otherDiscountTxt.getText().length()>8){
					 JOptionPane.showMessageDialog(null,"You can enter maximum 8 digits","RMS",JOptionPane.INFORMATION_MESSAGE);
					 trimTextField(otherDiscountTxt);
					 otherDiscountTxt.requestFocus();
				 }
				 else if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
						 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){	
					 setBalance();						
				 }				
				 else if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
					 JOptionPane.showMessageDialog(null,"Negative value in not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
					 otherDiscountTxt.setText("");
					 setBalance();
					 otherDiscountTxt.requestFocus();
				 }
			
				 else if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
					 JOptionPane.showMessageDialog(null,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
					 otherDiscountTxt.setText(otherDiscountTxt.getText().trim());
				 }
				 else if((ke.getKeyCode()==KeyEvent.VK_ALT)){
					 otherDiscountTxt.requestFocus();
				 }
				 else if(!(ke.getKeyCode()==KeyEvent.VK_DOWN) && !(ke.getKeyCode()==KeyEvent.VK_UP)
						 && !(ke.getKeyCode()==KeyEvent.VK_LEFT) && !(ke.getKeyCode()==KeyEvent.VK_RIGHT)
						 && !(ke.getKeyCode()==KeyEvent.VK_ENTER) && !(ke.getKeyCode()==KeyEvent.VK_TAB)
						 && !(ke.getKeyCode()==KeyEvent.VK_SHIFT) && !(ke.getKeyCode()==KeyEvent.VK_HOME)
						 && !(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) && !(ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)
						 && !(ke.getKeyCode()==KeyEvent.VK_INSERT) && !(ke.getKeyCode()==KeyEvent.VK_END)
						 && !(ke.getKeyCode()==KeyEvent.VK_ESCAPE) && !(ke.getKeyCode()==KeyEvent.VK_CONTROL)
						 && !(ke.getKeyCode()==524) && !(ke.getKeyCode()==525) && !(ke.getKeyCode()==20) 
						 && !(ke.getKeyCode()>=112 && (ke.getKeyCode()<=123))){
					 //int len=0;
					
				 }
			 }
		  });
		  
		  
		  otherChargesTxt.addKeyListener(new KeyAdapter(){
			  public void keyReleased(KeyEvent ke){	
					 if((ke.getKeyCode()==KeyEvent.VK_TAB )){
						 //TAB does not work in JTable/ Applet  here.Its a bug from Sun Java.
					 } //EOF TAB
					 else if(otherChargesTxt.getText().length()>8){
						 JOptionPane.showMessageDialog(null,"You can enter maximum 8 digits","RMS",JOptionPane.INFORMATION_MESSAGE);
						 trimTextField(otherChargesTxt);
						 otherChargesTxt.requestFocus();
					 }
					 else if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
							 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 setBalance();					
					 }				
					 
					 else if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
						 JOptionPane.showMessageDialog(null,"Negative value in not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
						 otherChargesTxt.setText("");
						 setBalance();	
						 otherChargesTxt.requestFocus();
					 }
					 else if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
						 JOptionPane.showMessageDialog(null,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
						 otherChargesTxt.setText(otherChargesTxt.getText().trim());
					 }	
					 else if((ke.getKeyCode()==KeyEvent.VK_ALT)){
						 otherChargesTxt.requestFocus();
					 }
					 else if(!(ke.getKeyCode()==KeyEvent.VK_DOWN) && !(ke.getKeyCode()==KeyEvent.VK_UP)
							 && !(ke.getKeyCode()==KeyEvent.VK_LEFT) && !(ke.getKeyCode()==KeyEvent.VK_RIGHT)
							 && !(ke.getKeyCode()==KeyEvent.VK_ENTER) && !(ke.getKeyCode()==KeyEvent.VK_TAB)
							 && !(ke.getKeyCode()==KeyEvent.VK_SHIFT) && !(ke.getKeyCode()==KeyEvent.VK_HOME)
							 && !(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) && !(ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)
							 && !(ke.getKeyCode()==KeyEvent.VK_INSERT) && !(ke.getKeyCode()==KeyEvent.VK_END)
							 && !(ke.getKeyCode()==KeyEvent.VK_ESCAPE) && !(ke.getKeyCode()==KeyEvent.VK_CONTROL)
							 && !(ke.getKeyCode()==524) && !(ke.getKeyCode()==525) && !(ke.getKeyCode()==20) 
							 && !(ke.getKeyCode()>=112 && (ke.getKeyCode()<=123))){
						 //int len=0;					 
						 
					 }
				 }
		  });		  
		  
		  mainPanel=new JPanel();
		  tablePanel=new JPanel();
		 
		  mainPanel.setLayout(new BorderLayout());
		  mainPanel.add("Center",scrollPane);
		  mainPanel.add("South",buttonPanel);
		  tablePanel.setBackground(Color.white);
		  buttonPanel.setBackground(Color.white);
		  table.getParent().setBackground(Color.white);
		  getContentPane().add(mainPanel);
	 }
	 
	 // show only available item 
	 public void setUpProductColumn(TableColumn productColumn , TableColumn checkColumn){
	  	  try{  
		
	  		  String query = "SELECT distinct m.item_name, m.item_weight,p.item_rate,p.item_mrp, m.item_code, p.price_version," +
	  		  		//"m.reorder_level,sum(s.item_site_qty) sumQty  " +
	  		  		"m.reorder_level,s.item_site_qty sumQty  " +
	  		  		"FROM item_master m,item_price p,item_site_inventory s  " +
	  		  		"WHERE  p.item_code = m.item_code and s.site_id = " + siteId +" and p.item_code = s.item_code  " +
	  		  		"and p.current_flag = 'Y' " +
	  		  		//"and p.current_flag = 'Y' and s.item_site_qty > 0 " +
	  		  		"group by m.item_code order by m.item_name, p.price_version desc";
			   System.out.println("create order query "+query);
			   rs = getValstmt.executeQuery(query); 
			   while(rs.next()){ 				   
				     //productArray.add(rs.getString(1).concat(blankString)+rs.getString(2).concat(weightString)+rs.getString(3).concat(rateString)+rs.getString(4));
				   	 productArray.add(rs.getString(1)+blank+"( W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+", AvailQty : "+rs.getString("sumQty")+")");
				     item_codeArray.add(rs.getString(5));
				     priceVersionArray.add(rs.getString(6));
				     reorderArray.add(rs.getInt(7));
				     quantityArray.add(rs.getInt(8));
				     //itemNames.add(rs.getString(1)+"(AvailQty : "+rs.getString("sumQty")+")");
				     itemNames.add(rs.getString(1).trim());			     
				     //System.out.println(" item name "+rs.getString("item_name")+" item weight "+rs.getString("item_weight")+" sumQty  "+rs.getString("sumQty"));

			   }   
			   DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
			   renderer.setToolTipText("Click the Product to see a list of choices");
			   productColumn.setCellRenderer(renderer);
		  }catch(Exception e){	 
			   System.out.println("Could not connect to database"+e);	 
		  } 
	 }	 
	  
	 public void tableChanged(javax.swing.event.TableModelEvent source){
		 if(source.getColumn()==1){
			 pickValue = 0;
			 int rowCount= table.getRowCount();      
			 if(rowCount>0){
				 for(int pickYes=0; pickYes<rowCount; pickYes++ ){
					 Object obj=table.getValueAt(pickYes, 1);
					 if(obj.toString()=="true"){
						 pickValue++;
					 }
				 }
			 }
			 setPickupLabel(pickValue);
		 }
	 }
	 
	 public void actionPerformed(ActionEvent source){
		 try{
			 if (source.getSource()==(JComboBox) paymentCombo){
			    JComboBox cb = (JComboBox)source.getSource();
			    paymentMode = (String)cb.getSelectedItem();			    
			    processCashPayment(paymentMode);
			 }
			 else if (source.getSource()==(JButton) addButton){
				 boolean flagResutlt;
				 flagResutlt=checkRowBeforeAdding();   
				 if(flagResutlt==false){
					 if(customerCode.equals("CC")){
						 try{
							win = JSObject.getWindow(this);				 
							win.call("dialogBox", null);
								 
						 }catch(JSException e){
							 String error="Not get Win Object";
							 System.out.println(error);
						 }
						 
					 }
					 else{
						 	addRow(); 
					 }  
					 table.setValueAt("", table.getSelectedRow(), 4);
				 }
			 }else if (source.getSource()==(JButton) deleteButton){	
				 if(table.getRowCount()!=0 && table.getRowCount()>0 ){ 
					 deleteRow(table.getSelectedRow());
					 setBalance();
				 }
				 else if(table.getRowCount()==0)	
					 JOptionPane.showMessageDialog(scrollPane,"There are no rows anymore to delete","RMS",JOptionPane.INFORMATION_MESSAGE);
					 
			 }else if (source.getSource()==(JButton) saveButton){	
				 String saveType = "SAVE";
				 int emptyFlag=0;
				 if(table.getValueAt(0, 0).equals("") && table.getValueAt(0, 2).equals("")
					&& table.getValueAt(0, 3).equals("") && table.getValueAt(0, 4).equals("") ){
				 	emptyFlag=1;
				 }
				 if(table.getRowCount()!=0 && table.getRowCount()>0)					 
				 {					
					if(emptyFlag!=1){
						 String ans1 = checkPaymentType(saveType);
						 if(ans1.equals("1")){	
							 String ans = checkDuplicateProduct();
							 if(ans.equals("1")){  
								 checkBlankProduct();
								 int result=setFocusOnTextField();								 
								 if(result==0){	
									 String ansadvbal = checkadv();
									 if(ansadvbal.equals("1")){  
										 String ansdisbal = checkdis();
										 if(ansdisbal.equals("1")){  
											 String anstotalval = "1";//checktotalval();
											 if(anstotalval.equals("1")){  
												 balanceValue=Double.parseDouble(balanceLblVal.getText());
												 if(balanceValue>=0 || paymentMode.equals("Cash")){
													 saveOrder("SAVE");
													 System.out.println(" after order saved ");
													 
												 }
												 else if(balanceValue<=0)
													 JOptionPane.showMessageDialog(scrollPane,"Balance amount is less than zero","RMS",JOptionPane.INFORMATION_MESSAGE);
											 }
										 }
									 }
								 }
							 }
						 }					 
					}
					else if(emptyFlag==1){
						JOptionPane.showMessageDialog(scrollPane,"Please Select Item Details","RMS",JOptionPane.INFORMATION_MESSAGE);
					}
				}
				else if(table.getRowCount()==0)	
					JOptionPane.showMessageDialog(scrollPane,"Please add a row","RMS",JOptionPane.INFORMATION_MESSAGE);				 
			 }else if (source.getSource()==(JButton) holdButton){
				 // Code for Holding orders
				 String saveType = "HOLD";	
				 int emptyFlag=0;
				 if(table.getValueAt(0, 0).equals("") && table.getValueAt(0, 2).equals("")
					&& table.getValueAt(0, 3).equals("") && table.getValueAt(0, 4).equals("") ){
				 	emptyFlag=1;
				 }				 
				 if(table.getRowCount()!=0 && table.getRowCount()>0)					 
				 {		
					 if(emptyFlag!=1){					 
						 saveOrder("SAVE");
						
					 }
					else if(emptyFlag==1){
						JOptionPane.showMessageDialog(scrollPane,"Please Select Item Details","RMS",JOptionPane.INFORMATION_MESSAGE);
					}					 
				 }
				else if(table.getRowCount()==0)	
					JOptionPane.showMessageDialog(scrollPane,"Please add a row","RMS",JOptionPane.INFORMATION_MESSAGE);				 
				 
			 }else if (source.getSource()==(JButton) cancelButton){
				 try{
					 clearAll();
					
					 win = JSObject.getWindow(this);
					 win.eval("window.close()");
					 win.eval("document.myform.submit()");	        
				 }catch(JSException e){
					 String error="Not get Win Object";
					 System.out.println(error);
				 }   
			 }else if (source.getSource()==(JButton) clearButton){
				 try{
					 for(int i=table.getRowCount()-1; i>=0; i--){
						 try{   
							 
							 rows.removeElementAt(i);
							 table.addNotify();	       
						 }catch(Exception e){
							 System.out.println("Exception in DeleteRow "+e);
						 }
					 }	     
					 columnCount=7;
					 itemCount = 0;
					 pickValue=0;
					 deliverCount = 0;  
					 pickUpCnt=0; 
	     
				     totalItemFld.setText("");
				     deliverFld.setText("");
				     pickUpFld.setText("");
				     totalField.setText("");
				     totalMrpFld.setText("");
				     savingFld.setText(""); 
				     paymentCombo.setSelectedItem("Select Type");	
				    
				 }catch(JSException e){
					 String error="Not get Win Object";
					 System.out.println(error);
				 }    
			 }
			 else if (source.getSource()==(JButton) viewButton){
					 new DialogFrame("View Slected Product Information Details");
			 }
			 else if (source.getSource()==(JButton) paymentButton){
				 boolean flag=false;
				 for(int i=0; i<table.getRowCount(); i++){
					 if(!table.getValueAt(i, 0).equals("") && !table.getValueAt(i, 4).equals(""))
						 	flag=true;
					 else 
						 	flag=false;
				 }
				 if(flag){
					 paymentCombo.requestFocus(true);
					 paymentCombo.setPopupVisible(true);
				 }
				 else if(table.getValueAt(table.getRowCount()-1,0).equals(""))
					 	table.changeSelection(table.getRowCount()-1, 0, false, false);
				 else if(table.getValueAt(table.getRowCount()-1,0).equals(""))
					 	table.changeSelection(table.getRowCount()-1, 4, false, false);
			 }
			 
		 }catch(ArrayIndexOutOfBoundsException aie){
			 System.out.println("Error occured in actionPerformed "+ aie);
		 }
	 }
	 
	 public void saveOrder(String saveType){	
		 saveButton.setEnabled(false);
		 max=mo.getOrderNum();  
		 transId=mo.getTransactionId();
		 
		 if(saveType.equals("SAVE"))
			 status = mo.getStatus("SUBMITTED");
		 else 
			 status = saveType;	
		 msgYesNo="0";
		 //setBalance();
		 saveInOrderTable();
		 saveButton.setEnabled(true);
		 if(!msgYesNo.equals("1")){
			 clearAll();		
			 try{  		
				 System.out.println("before window object "+win);
				 win = JSObject.getWindow(this); 
				 System.out.println("after window object "+win);
				 if(!backPage.equals("create_newCustomer.jsp")) 
					 backPage="cust_orederBill.jsp";
				 win.eval("opener.parent.document.getElementById('txtHint').innerHTML=''");
				 win.eval("opener.parent.document.myform.appletMax.value=" + max);
				 if(saveType.equals("HOLD"))
					 win.eval("opener.parent.document.myform.printed.value=0");
				 else if(saveType.equals("SAVE")){
					 win.eval("opener.parent.document.myform.printed.value=1");
				 }
				
				 win.eval("opener.parent.document.myform.custCode.focus();");
				 win.eval("window.close()");
				 
				 //client side error action not assigned
				 //win.eval("document.myform.submit()");
		     }catch(JSException e){
		    	 String error="Not get Win Object";
		    	 win.eval("alert('JSException"+e.getMessage()+"')");
		    	 e.printStackTrace();
		    	 System.out.println("\n error "+e.getMessage());
		     }catch (Exception e) {
				 //TODO: handle exception
		    	 System.out.println(e.getMessage());
		    	 win.eval("alert('Exception:"+e.getMessage()+"')");
		    	 e.printStackTrace();
			}
		 }
		 System.out.println("\n\n ordered saved ..... ");
	 } 
	 
	 public void saveInOrderTable(){
		 try{
			 mo.conn.setAutoCommit(false);
			 double itemRate=0.0f,itemQty=0.0f,totItemPrice=0.0f,itemMRP=0.0f, 
			 	totItemDisAmt=0.0f,minDisAmt=0.0f,totOrderValue=0.0f,
			 	totDisValue=0.0f,totMRPValue=0.0f;
			 int totDisTimes=0,priceVersion=0;
			 String date="";
			 String itemqtystr="",orderDate="";
			 
			
			 /* To assign values in case below input not filled or used. */	
			 if(!advanceTxt.getText().equals(""))
				 advanceValue=Double.parseDouble(advanceTxt.getText());
			 else
				 advanceValue=0.0f;
			 if(!otherDiscountTxt.getText().equals(""))			 
				 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
			 else
				 otherDiscountValue=0.0f;	
			 if(!otherChargesTxt.getText().equals(""))
				otherChargesValue=Double.parseDouble(otherChargesTxt.getText());
			 else
				otherChargesValue=0.0f;
			    balanceValue=Double.parseDouble(balanceLblVal.getText());
			 
			 System.out.println("total rows "+table.getRowCount());
			 for(int i=0; i< table.getRowCount(); i++){ 	
				 try{
					 String query1="SELECT deal_on_qty,deal_amount from item_master where item_code='"+table.getValueAt(i, 9)+"'";
					 item_code = table.getValueAt(i, 9).toString();
					 System.out.println(" item master "+query1);
					 rs2 = getValstmt1.executeQuery(query1);   
					 while(rs2.next()){
						 dealQty = rs2.getInt(1);
						 minDisAmt = rs2.getFloat(2);
					 }
					 rs2.close();    
				 }catch(Exception e){
					 System.out.println("Error in item_code "+e);
				 }    
				 if(table.getValueAt(i, 1).toString()== "true")  pickup_ind = 1; 
				 else pickup_ind = 0; 			
				 itemRate= Double.parseDouble((String)table.getValueAt(i, 3));   
				 itemqtystr = table.getValueAt(i, 4).toString();
				 itemQty = Double.parseDouble(itemqtystr);   
				 totItemPrice= Double.parseDouble((String)table.getValueAt(i, 5)); 
				 itemMRP= Double.parseDouble((String)table.getValueAt(i, 6)); 
				 totItemDisAmt= Double.parseDouble((String)table.getValueAt(i, 7)); 
				 priceVersion=Integer.parseInt((String)table.getValueAt(i, 10));
				 disRemark = table.getValueAt(i, 8).toString();
				
				
				 //	This Line was uncommented because total item price was coming as zero
					
				 totItemPrice=(itemQty*itemRate) - totItemDisAmt;
				 totOrderValue = totOrderValue + totItemPrice;   
				 totDisValue = totDisValue + totItemDisAmt; 
				 
				mo.addOrderDetail(max, item_code, itemRate, itemQty, totItemPrice, totItemDisAmt, disRemark, 
						itemMRP, i, pickup_ind, item_returned,priceVersion,siteId);
			 }// EOF For
			 int totalItemsCount = table.getRowCount(); 
			 totMRPValue = Double.parseDouble(totalMrpFld.getText()); 
			 deliveryRemark=deliverInstruText.getText(); 
			 
			  try{
				 String query2="SELECT payment_type_code from payment_type where payment_type_desc='"+pay_type+"'";
				 System.out.println(" payment tpe "+query2);
				 rs3 = getValstmt2.executeQuery(query2);   
				 while(rs3.next()){
					 p_code = rs3.getString(1);
				 } 
				 rs3.close();      
			 }catch(Exception e){
				 System.out.println("Error in Payment_code "+e);
			 } 
			   
			if(balanceValue<0){
				JOptionPane.showMessageDialog(scrollPane,"Balance amount is less than zero","RMS",JOptionPane.INFORMATION_MESSAGE);
			}
			else if(balanceValue>=0){	
				
				 double checktotalval = 0.0f;
				 checktotalval =  balanceValue + advanceValue + otherDiscountValue - otherChargesValue;
				 
				 if(Math.abs(totOrderValue - checktotalval)>1){
					 String wMessage="Please check the Amounts. There is a difference of:"+(checktotalval-totOrderValue)+".";
					 JOptionPane.showMessageDialog(scrollPane,wMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
					msgYesNo="1";
				 }
				 
			if(msgYesNo.equals("0")){
				System.out.println("\norder type "+orderType);
				 mo.addOrders(max, customerCode, totalItemsCount, pickValue, totOrderValue, totMRPValue, totDisValue, user, p_code, status,deliveryRemark,orderType,date,copyOrder,orderDate,balanceValue,advanceValue,otherDiscountValue,otherChargesValue,siteId);
				System.out.println("\n before transction ");
				 mo.addTransactionDetails(transId,advanceValue,totOrderValue,balanceValue,max);
				 
				 
			}
			}
			 mo.conn.commit();
		 }
		 catch (Exception e) {
			// TODO: handle exception
			 try {
				mo.conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			 e.printStackTrace();
		}
		
	 }
	 
	 public void clearAll(){ 
		 for(int i=table.getRowCount()-1; i>-1; i--){
			 try{     
				 rows.removeElementAt(i);
				 table.addNotify();	
				 advanceTxt.setText("");
				 otherDiscountTxt.setText("");
				 otherChargesTxt.setText("5");
				 balanceLblVal.setText("0");
				 cme.editor.setText("");
				 deliverInstruText.setText("");
			 }catch(Exception e){
				 System.out.println("In DeleteRow "+e);
			 }
		 }	  
		 columnCount=7;
		 itemCount = 0;
		 pickValue=0;
		 deliverCount = 0;  
		 pickUpCnt=0;  	  
		 totalItemFld.setText("");
		 deliverFld.setText("");
		 pickUpFld.setText("");
		 totalField.setText("");
		 totalMrpFld.setText("");
		 savingFld.setText(""); 
		 paymentCombo.setSelectedItem("Select Type");
		 try{
			 customerCode = "CC";
			 win = JSObject.getWindow(this);
			 win.eval("document.myform.hcuscode.value = '"+customerCode+"'");
			 //change functin name
			 //win.call("_showHint",null);        
			 System.out.println("after window clear all ");
		 }catch(JSException e){
			 String error="Not get Win Object111";
			 System.out.println(error);
		 }   
	 }
	 
	 public void setCellValues(String item_codeStr,String priceVersionStr){  
		 try{ 	   
			 String insertIntoCellQuery = " SELECT i.item_name,i.item_weight," +
			 		" ip.item_rate,ip.item_mrp, " +
			 		" i.deal_active_flag, i.deal_on_qty, i.deal_amount,isi.item_site_qty " +
			 		" FROM item_master i,item_price ip, item_site_inventory isi " +
			 		" where i.item_code='"+item_codeStr+"'"+
					" and ip.item_code = i.item_code " +
					" and ip.price_version = '"+priceVersionStr+"'"+
					" and isi.site_id = "+siteId+
					" and isi.item_code  = i.item_code" +
					" and isi.price_version = ip.price_version ";
			 System.out.println("insertIntoCellQuery:"+insertIntoCellQuery);
			 rs1 = getItemstmt.executeQuery(insertIntoCellQuery);
			 
			 if(rs1.next()){
				 selectCell(table.getSelectedRow(),table.getSelectedColumn());
				 //table.setValueAt(rs1.getString(1)+"(AvailQty : "+rs1.getString("item_site_qty")+")", table.getSelectedRow(), 0);    
				 table.setValueAt(rs1.getString(1).trim(),table.getSelectedRow(), 0);    
				 table.setValueAt(rs1.getString(2), table.getSelectedRow(), 2);
				 table.setValueAt(rs1.getString(3), table.getSelectedRow(), 3);	    
				 table.setValueAt("", table.getSelectedRow(), 4);
				 tfe.setText("");
				 table.setValueAt("0", table.getSelectedRow(), 5);
				 table.setValueAt(rs1.getString(4), table.getSelectedRow(), 6);
				 String rem ="";			 
				 if(rs1.getString(5).equals("Y")){
					 rem = "Rs: " + rs1.getString(7) + " on " + rs1.getString(6) + " QTYs ";
				 }
				 table.setValueAt(rs1.getString(7), table.getSelectedRow(), 7);
				 table.setValueAt(rem, table.getSelectedRow(), 8);	
				 table.setValueAt(item_codeStr, table.getSelectedRow(), 9);	
				 table.setValueAt(priceVersionStr, table.getSelectedRow(), 10);	
				 //table.setValueAt(rs1.getString("item_site_qty"), table.getSelectedRow(), 11);  // available qty set
				
			 }   
		 }catch(Exception se){
			 System.out.println("Exception Occured while inserting data in table cells"+se);
		 }
	 }    
	 //double totItemDisAmt1=0.0f;
	  public void setTotalPrice(String quantityValue){
		  try{
			  double totItemPrice1=0.0f,itemMRP1=0.0f, 
			  totItemDisAmt1=0.0f,minDisAmt1=0.0f,totOrderValue1=0.0f,
			  totDisValue1=0.0f,totMRPValue1=0.0f;
			  int totDisTimes1=0;
			  
			  try{  
				  String query1="SELECT item_mrp, deal_amount, deal_on_qty from item_master where item_code='"+(String)table.getValueAt(table.getSelectedRow(), 9)+"'";
				  rs2 = getValstmt1.executeQuery(query1);   
				  while(rs2.next()){
					  itemMRP1 = rs2.getFloat(1);
					  minDisAmt1 = rs2.getInt(2);
					  dealQty = rs2.getInt(3);
				  }
				  rs2.close();    
			  }catch(Exception e){
				  System.out.println("Error in item_code "+e);
			  }			 
			  if (dealQty ==0) totDisTimes1=0;
			  else totDisTimes1 = (int)(Double.parseDouble(quantityValue) / dealQty);			 
			  if(totDisTimes1 >= 1) totItemDisAmt1 = minDisAmt1 * totDisTimes1;
			  else totItemDisAmt1=0;                 
			  if(totItemDisAmt1>0){
				  disRemark=totItemDisAmt1+ "(@Rs " +  minDisAmt1 + " per " + dealQty + " QTYs)";
			  }   
			  totOrderValue1 = totOrderValue1 + totItemPrice1;	    
			  totDisValue1 = totDisValue1 + totItemDisAmt1;
			  totMRPValue1 = (Double.parseDouble(quantityValue)*itemMRP1);	 

			  String priceValueStr="",priceMessage="Price is Blank";
			  double quantityVal=0.0f;
			  double priceValue=0.0f, totalRate=0.0f;
			  priceValueStr = (String)table.getValueAt(table.getSelectedRow(), 3);
			 if(priceValueStr.equals("")){
				  JOptionPane.showMessageDialog(scrollPane,priceMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
			  }else priceValue = Double.parseDouble(priceValueStr);
			  if(!tfe.getText().equals("")){
				  quantityVal = Double.parseDouble(quantityValue);         
				  totalRate = (quantityVal * priceValue) - totItemDisAmt1;
				  table.setValueAt(Double.toString(totalRate), table.getSelectedRow(), 5);
				  
				  //Set only MRP Price in MRP column	//			  
				  table.setValueAt(table.getValueAt(table.getSelectedRow(), 6), table.getSelectedRow(), 6);
				  table.setValueAt(Double.toString(totItemDisAmt1), table.getSelectedRow(), 7);	     
			  }else if(tfe.getText().equals("")){
				  totalRate = 0.0f;
				  table.setValueAt(Double.toString(totalRate), table.getSelectedRow(), 5);
				
				  //Set only MRP Price in MRP column	
				  table.setValueAt(table.getValueAt(table.getSelectedRow(), 6), table.getSelectedRow(), 6);
				  table.setValueAt(Double.toString(totItemDisAmt1), table.getSelectedRow(), 7);
			  }
		  }catch(NumberFormatException nfe){
			  nfe.printStackTrace();
			  System.out.println("Exception Occured in setTotalPrice"+nfe);
		  }catch(StackOverflowError soe){
			  System.out.println("Error Occured in setTotalPrice"+soe);
		  }
	  }
	  
	  public void setOverallTotal(){
		  try{
			  int rowCount = table.getRowCount();
			  double totalCost = 0.0f, totalmrpCost = 0.0f, savCost= 0.0f, totDiscountCost=0.0f,totMRPValue=0.0f,mrpVal=0.0f;
			  Object str = null, str1=null,sav=null,total,itemMrp,itemDiscountAmt;
			  int qty=0;
			  for(int i=0; i<rowCount; i++){
				  total =(table.getValueAt(i, 5));
				  itemMrp =(table.getValueAt(i, 6));

				  if(table.getValueAt(i, 6).equals("") || Double.parseDouble(table.getValueAt(i, 6).toString())<=0)
					  mrpVal=Double.parseDouble(table.getValueAt(i, 3).toString());
				  else if(!table.getValueAt(i, 6).toString().equals("") || Double.parseDouble(table.getValueAt(i, 6).toString())>0)
					  mrpVal=Double.parseDouble(table.getValueAt(i, 6).toString());
				  if(!table.getValueAt(i, 4).equals(""))
					  	totMRPValue=totMRPValue+Double.parseDouble((table.getValueAt(i, 4).toString()))*mrpVal;
				  else if(table.getValueAt(i, 4).equals(""))					  	
					  	totMRPValue=totMRPValue+qty*mrpVal;			  

				  itemDiscountAmt =(table.getValueAt(i, 7));
				  if(!total.equals("")){
					  double totalValue = Double.parseDouble(total.toString());
					  totalCost += totalValue;
				  } 
				  if(!itemMrp.equals("")){
					  double totalmrpValue = Double.parseDouble(itemMrp.toString());
					  totalmrpCost += totalmrpValue;
				  } 
				  if(!itemDiscountAmt.equals("")){
					  double totalDisValue = Double.parseDouble(itemDiscountAmt.toString());
					  totDiscountCost += totalDisValue;
				  } 
					 
			  }
			  savCost = (totMRPValue - totalCost); 

			  str = Double.toString(totalCost);
			  totalField.setText(str.toString());
			  totalField.setForeground(Color.blue);
			
			  // This is to display totalMrp in totalMrp label and set mrp/item in mrp column
			  str1 = Double.toString(totMRPValue);			  
			  totalMrpFld.setText(str1.toString());
			  totalMrpFld.setForeground(Color.blue);
			  sav = Double.toString(savCost);
			  savingFld.setText(sav.toString());
			  savingFld.setForeground(Color.blue); 
			  totMRPValue=0.0f;
		  }catch(NumberFormatException nfe){
			  System.out.println("Error Occured in setOverallTotal "+nfe);
		  }
	  	}
	 
	 public void checkBlankProduct(){  
		 for(int i=0; i< table.getRowCount(); i++){
			 if(table.getValueAt(i, 0).toString().equals("")){      
				 deleteRow(i);
				 if(table.getRowCount()>0){
					 table.changeSelection((table.getRowCount()-1), 0, false, false);
				 }
				 //return("0");
			 }   
		 }
		 //return("1");
	 }
	 public String checkDuplicateProduct(){
		 try{
			String message =""; 
			int rowCount = table.getRowCount();
			String matchString="";
			ArrayList prodArr=new ArrayList();
			ArrayList weightArr=new ArrayList();
			for(int row = 0; row < rowCount; row++){
				prodArr.add((String)table.getValueAt(row, 0));
				weightArr.add((String)table.getValueAt(row, 2));
			}	
			for(int row = 0; row < prodArr.size(); row++){
				for(int j = 0;  j< prodArr.size(); j++){
					if(row!=j){
						matchString="";
						if(prodArr.get(row).toString().equalsIgnoreCase(prodArr.get(j).toString()) && weightArr.get(row).toString().equalsIgnoreCase(weightArr.get(j).toString())){
							message="Duplicate entry for: ";
							matchString = prodArr.get(row) + "&" +weightArr.get(row);
							message = message+matchString+".\n	Do you want to allow duplicate items";
							int n=JOptionPane.showConfirmDialog(this, message,"RMS",0,1);
							
							if(n==1){			//no
								for(int row1 = 0; row1 < table.getRowCount(); row1++){
									if(table.getValueAt(row1, 0).equals(prodArr.get(row))){
										table.changeSelection(row1, 0, false, false);
										String duplicateItem=table.getValueAt(row1, 0).toString();
										cme.editor.setText(duplicateItem);
									}
								}
								prodArr.remove(row);
								weightArr.remove(row);
								return("0");
							}
							else if(n==0){		//yes
								prodArr.remove(row);
								weightArr.remove(row);
								matchString="";
								message="";
							}
						}
					}				
				}
			}
			return("1"); 
				
			}
			catch(ArrayIndexOutOfBoundsException aie){
				System.out.println("Exception in checkDuplicateProduct" +aie);
				 return("0"); 
			}
	 }
	 
	 public int checkQuantity(){
		 try{
			 String quantityVal =(String)(table.getValueAt(table.getSelectedRow(), 4));
			 if(quantityVal.equals("")){   
				 String  message="Quantity cannot be blank";
				 JOptionPane.showMessageDialog(scrollPane,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return 1;
			 }
		 }catch(NumberFormatException nfe){
			 System.out.println("Error while editing cell"+nfe);
		 }
		 return 0;
	 }
	 
	 public String checkPaymentType(String saveType){
		 String returnVaule="";
		 String message = "Please select payment term";
		 String noItemsMsg = "No items Selected";
		 String msgconfirm = "You have selected CASH as payment type. Are you sure?" ;
		 pay_type = (String)paymentCombo.getSelectedItem();
		 
		 if(table.getRowCount()==0){
			 JOptionPane.showMessageDialog(scrollPane,noItemsMsg,"RMS",JOptionPane.INFORMATION_MESSAGE);
			 return("0");
		 }
	 
		 if(saveType.equals("SAVE")){			 
			
			 if(pay_type.equals("Select Type") || pay_type.equals("") && table.getRowCount()>0){
				 JOptionPane.showMessageDialog(scrollPane,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return("0");
			 }	

			else if(pay_type.equals("Credit") || pay_type.equals("Cash") || pay_type.equals("Hawala")  || pay_type.equals("Cheque")){
				if(advanceTxt.getText().equals(""))					 
					 advanceTxt.setText("0.0");
				 if(otherDiscountTxt.getText().equals(""))			 
					  otherDiscountTxt.setText("0.0");
				 if(otherChargesTxt.getText().equals(""))				
					 otherChargesTxt.setText("0.0");
				if(pay_type.equals("Cash")){					
					int n=JOptionPane.showConfirmDialog(this, msgconfirm,"RMS", 0,1);
					if(n==1){						
						return("0");
					}
					else if(n==0)
						return("1");	
					
				}else{
					returnVaule="1";
				}
			
			}			 
		}
		else if(saveType.equals("HOLD")){
			returnVaule="HOLD";			
		}
		 
		 return returnVaule;
	 }
	 
	 public String checkadv(){
			try{
				if(!advanceTxt.getText().equals("") || !advanceTxt.getText().equals("0.0"))
					 advanceValue=Double.parseDouble(advanceTxt.getText());
				else advanceValue=0.0f;
				if(advanceValue == 0.0){		
					return("1");
				}else{
					String message = " You have put an advance amount of "+advanceValue+" . Are you sure?";
					
					int n=JOptionPane.showConfirmDialog(this, message,"RMS", 0,1);
					if(n==1){					
						return("0");
					}
					else if(n==0){				
						return("1");
					}
				}
				return("1");
			}
			catch(ArrayIndexOutOfBoundsException aie){
				System.out.println("Exception in checkAdvance" +aie);
				 return("0"); 
			}
		}
	 public String checkdis(){
			try{
				 if(!otherDiscountTxt.getText().equals("") )			 
					 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
				 else otherDiscountValue=0.0f;
				 if(otherDiscountValue == 0.0){
					 return("1");
				 }else{
				
					String message = " You have put an discount amount of "+otherDiscountValue+" . Are you sure?";
										
					int n=JOptionPane.showConfirmDialog(this, message,"RMS", 0,1);
					if(n==1){					
						return("0");
					}
					else if(n==0){				
						return("1");
					}
				 }
				return("1");
			}
			catch(ArrayIndexOutOfBoundsException aie){
				System.out.println("Exception in checkDiscount" +aie);
				 return("0"); 
			}
		}
	 
	 
	 public String checktotalval(){
			try{
				 if(!advanceTxt.getText().equals(""))
					 advanceValue=Double.parseDouble(advanceTxt.getText());
				 else
					 advanceValue=0.0f;
				 if(!otherDiscountTxt.getText().equals(""))			 
					 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
				 else
					 otherDiscountValue=0.0f;	
				 if(!otherChargesTxt.getText().equals(""))
					otherChargesValue=Double.parseDouble(otherChargesTxt.getText());
				 else
					otherChargesValue=0.0f;
				 balanceValue=Double.parseDouble(balanceLblVal.getText());
				 
				 double caltotalval = Double.parseDouble(totalField.getText()); 
				 double checktotalval = 0.0f;
				 checktotalval =  balanceValue + advanceValue + otherDiscountValue - otherChargesValue;
				 
				 if(caltotalval != checktotalval){
					 String wMessage="Please check the Amounts. There is a difference of:"+(checktotalval-caltotalval)+".";
					 JOptionPane.showMessageDialog(scrollPane,wMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
					 advanceTxt.setText("");
					 advanceTxt.requestFocus();
					 return ("0");
				 }
				 
				return("1");
			}
			catch(ArrayIndexOutOfBoundsException aie){
				System.out.println("Exception in checktotalval " +aie);
				 return("0"); 
			}
		}
	 public void setPickupLabel(int pickValue){  
		 objTemp=Integer.toString(pickValue);
		 pickUpFld.setText(objTemp.toString());
		 pickUpFld.setForeground(Color.BLUE);
		 deliverCount= itemCount-pickValue;  
	 	 deliverFld.setText(Integer.toString(deliverCount));
	 	 deliverFld.setForeground(Color.blue);
	 }
	 
	 public int checkBlankValue(){
		 try{
			 Object productVal,quantityVal,weightVal,priceVal=null,totalprice;			
			 String blankMessage="Quantity cannot be blank";
			 productVal =table.getValueAt(table.getSelectedRow(), 0);
			 quantityVal =table.getValueAt(table.getSelectedRow(), 4);
			 weightVal =table.getValueAt(table.getSelectedRow(), 2);
			 priceVal = table.getValueAt(table.getSelectedRow(), 3);	
			 totalprice = table.getValueAt(table.getSelectedRow(), 5);
			 if(productVal.equals("")){
				 table.changeSelection(table.getSelectedRow(), 0, false, false);
				 return 1;
			 }else if(quantityVal.equals("")){
				 JOptionPane.showMessageDialog(scrollPane,blankMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 table.changeSelection(table.getSelectedRow(), 4, false, false);
				 return 1;
			 }else if(!quantityVal.equals("") && (quantityVal.equals("0"))){  
				 table.changeSelection(table.getSelectedRow(), 4, false, false);
				 return 1;
			 }else if(weightVal.equals("") && priceVal.equals("")){
				 String wpMessage="Weight and Price cannot be blank";
				 JOptionPane.showMessageDialog(scrollPane,wpMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return 1;
			 }else if( weightVal.equals("")){
				 String wMessage="Weight cannot be blank";
				 JOptionPane.showMessageDialog(scrollPane,wMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return 1;
			 }else if(priceVal.equals("")){
				 String pMessage="Price cannot be blank";
				 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return 1;
			 }else if((totalprice.equals("0.0")) || (totalprice.equals("0"))){  
				 String pMessage="Total Price cannot be Zero";
				 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 table.changeSelection(table.getSelectedRow(), 4, false, false);
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
		 String item_codeStr="";
		 String priceVersionStr="";
		 
		 String[] splitResult=null,splitStr;
		 String s;
		 String JItemName = null; 
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
						 System.out.println(" selected  index "+getSelectedIndex());;
						 if(!s.equals("")){
							 //String avaiQty = s.substring(s.indexOf("AvailQty"));	
							 //System.out.println("avaiQty "+avaiQty);
							 splitStr=s.split("\\( W :");
							 if(getSelectedIndex()!=-1){
								 JItemName = s;
							 }
												 
							 if (!mousePressed){
								 
								 System.out.println(JItemName + " if mouse pressed "+s+"\t"+splitStr[0]);
								 editor.setText(splitStr[0].trim()); 
								 System.out.println(" end of mouse pressed if ");
								 }
							 else if(mousePressed)
							 {  
								 System.out.println(" else mouse pressed ");
								 editor.setText(splitStr[0]);
								 if(!tempStr.equals(s) && s.contains("( " )){
									 tempStr=s;
									 if(productArray.indexOf(tempStr)!=-1){
										 item_codeStr=item_codeArray.get(productArray.indexOf(tempStr)).toString();
										 priceVersionStr=priceVersionArray.get(productArray.indexOf(tempStr)).toString();
									 }
									 if(table.getRowCount()>0){
										 setCellValues(item_codeStr,priceVersionStr);
										 table.changeSelection(table.getSelectedRow(), 4, false, false);
									 }
									 item_codeStr="";
									 priceVersionStr ="";
							 
								 }
								 System.out.println("before set values ");
								 //setSelectedItem(splitStr[0]+" ("+avaiQty);
								 setSelectedItem(splitStr[0]);
								 
								 System.out.println(" end of mouse pressed else ");
								 mousePressed = true;
								
							 }
							 
						 }
						 else
							 editor.setText("");
					 }
				 } 
			 }); 

			
			 
			 editor.addMouseListener(new MouseAdapter(){   
				
				 public void mouseReleased(MouseEvent me) {      
					 System.out.println(" mouse relesed ");
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
					 System.out.println(" mouse pressed event ");
					 try{
						 for(int i=0; i<table.getRowCount(); i++){
							 if(!table.getValueAt(i, 0).equals("") && table.getValueAt(i, 4).equals("")){
								 JOptionPane.showMessageDialog(scrollPane,"Quantiy cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
								 table.changeSelection(i, 4, false, false);
							 }
						 }
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
						 priceVersionStr="";
						 mousePressed=true;
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
				 String priceVersionStr="";
				 
				 public void keyPressed(KeyEvent ke){  
					 try{  
						 mousePressed = false;
						  if(ke.getKeyCode() == KeyEvent.VK_TAB){
							 int r = table.getSelectedRow();
							 int c = table.getSelectedColumn();                
							 if(table.getValueAt(table.getSelectedRow(), 0).equals("") && editor.getText().equals("")){
								 JOptionPane.showMessageDialog(scrollPane,"Product Name is blank","RMS",JOptionPane.INFORMATION_MESSAGE);
								 table.changeSelection(r, 2, false, false);	                    	                    	                    	
							 }else if(!editor.getText().equals("") && table.getValueAt(table.getSelectedRow(), 3).equals("") && table.getValueAt(table.getSelectedRow(), 5).equals("")){
								 JOptionPane.showMessageDialog(scrollPane,"Press enter to select product name","RMS",JOptionPane.INFORMATION_MESSAGE);
								 table.changeSelection(r, 2, false, false);	                    	                    	                    	
							 }else if(c ==0 ) {                       
								 table.changeSelection(table.getSelectedRow(), 3, false, false);
							 } 
						 }
					 
					 }catch(NumberFormatException nfe){
						 System.out.println("Exception occured in ComboBoxEdidor keyPressed");
						 nfe.printStackTrace();
					 }
				 }// EOF KeyPressed()           
				 public void keyReleased(KeyEvent ke){                     
					        
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
						 System.out.println("enter key released  ");
						 try{  
							 System.out.println(getSelectedIndex()+" JItemName "+JItemName);
							 //if(editor.getText().length()<3){
							 if(editor.getText().length()>1 && !editor.getText().equals("") ){	 
								 String selectedTextVal="";
								 String splitVal[]=null;
								 if(!editor.getText().equals("") && getItemCount()>=0){
									// selectedTextVal=(String)getItemAt(getSelectedIndex());
									 
									 selectedTextVal = JItemName;
									 System.out.println("selectedTextVal "+selectedTextVal);
									 splitVal = selectedTextVal.split("\\( W :");
									 System.out.println("selectedTextVal "+selectedTextVal);
									 
									 //String avaiQty = selectedTextVal.substring(selectedTextVal.indexOf("AvailQty")).trim();	
									 //System.out.println("avaiQty #"+avaiQty+"#");
									//System.out.println("editor text "+splitVal[0].trim()+"("+avaiQty);
									 
									 //editor.setText(splitVal[0].trim()+"("+avaiQty.trim());
									 //editor.setText(splitVal[0].trim());
									
									 if(productArray.indexOf(selectedTextVal)!=-1){	 
										 item_codeStr=item_codeArray.get(productArray.indexOf(selectedTextVal)).toString();
										 priceVersionStr = priceVersionArray.get(productArray.indexOf(selectedTextVal)).toString();
										
									 }
									 if(table.getRowCount()>0){
										 setCellValues(item_codeStr,priceVersionStr);
										 // ChangeSelection
										 table.changeSelection(table.getSelectedRow(), 4, false, false);
									 }
									 item_codeStr="";
									 priceVersionStr ="";
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
								 prodValResult = setProdName.split("\\( W :");
								 if(editor.getText().equals(prodValResult[0])){
									 item_codeStr=item_codeArray.get(productArray.indexOf(setProdName)).toString();
									 priceVersionStr = priceVersionArray.get(productArray.indexOf(setProdName)).toString();
									 if(table.getRowCount()>0)
										 setCellValues(item_codeStr,priceVersionStr);
									 	 // ChangeSelection
									 	 table.changeSelection(table.getSelectedRow(), 4, false, false);

								 }
								 item_codeStr="";
								 priceVersionStr ="";
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
						 
						// System.out.println("selectedItem : ["+selectedItem+"]");
						 if(!selectedItem.equals("")){
							 splitStrVal = selectedItem.split("\\( W :");
							 String avaiQty = selectedItem.substring(selectedItem.indexOf("AvailQty")).trim();	
							 editor.setText(splitStrVal[0].trim());
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
		 
		 public void addCellEditorListener(CellEditorListener listener) {  }
 
		 public void removeCellEditorListener(CellEditorListener listener) {}
 
		 public void fireEditingStopped() {  }
 
		 public void fireEditingCanceled() {}
 
		 public void cancelCellEditing() {
			 fireEditingCanceled();
		 }
 
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
    
	 public class CheckBoxEditor extends JCheckBox { 
		 Object objTemp=null; 
		 int spaceCount=0,pickValue=0; 
		 public CheckBoxEditor(){ 
			 super(); 
			 setEnabled(true); 
			 requestFocus(); 
			 setHorizontalAlignment(JLabel.CENTER); 
			 setBackground(Color.LIGHT_GRAY); 
			 addItemListener(new ItemListener() { 
				 public void itemStateChanged(ItemEvent event) {  
					 if(event.getStateChange()==ItemEvent.SELECTED){ 
						 pickUpCnt++; 
						 int checkFlag=0;  
						 checkFlag = checkBlankValue(); 
						 if(checkFlag == 1){  
							 table.setValueAt(new Boolean(false), table.getSelectedRow(), 1);  
						 }  
					 }
					 if(event.getStateChange()==ItemEvent.DESELECTED){ 
						 pickUpCnt--;  
					 }  
				 } 
			 });  
		 }  
	 }//EOF CheckBox Class 
 
	 public class CheckBoxCellRendrer implements TableCellRenderer {
		 public boolean cellEnabled = true;
		 int spaceCount =0,pickValue=0;
		 Object objTemp=null;
		 JCheckBox jcb = new JCheckBox();
	 	 public CheckBoxCellRendrer(){
	 		 jcb.setEnabled(true);   
	 		 jcb.setHorizontalAlignment(JLabel.CENTER);
	 	 }
	  
	 	 public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, 
	 			 boolean hasFocus, int row, int column) {   
	 		 if (value != null && value.equals(new Boolean(true))) {
	 			 jcb.setSelected(true);
	 		 }else {
	 			 jcb.setSelected(false);
	 		 }
	 		 return jcb;
	 	 }
	 }// EOF CheckBoxCellRendrer 
	 
	 public class TextFieldEditor extends JTextField{
		 int productColBlank=0;
		 public TextFieldEditor(){
			 super();
			 table.addMouseListener(new MouseAdapter(){
				 public void mouseReleased(MouseEvent me) {	        
					 int rowCount=table.getRowCount();        
					 for(int i=0; i<rowCount; i++){
						 if(table.getValueAt(i, 0).equals("")){
							 cme.editor.setText("");
							 JOptionPane.showMessageDialog(scrollPane,"Product cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 0, false, false);
						 }
						 else if(table.getValueAt(i, 4).equals("") || table.getValueAt(i, 4).equals("0") ||table.getValueAt(i, 4).toString().startsWith("0.") || table.getValueAt(i, 0).equals("")){
							 JOptionPane.showMessageDialog(scrollPane,"Quantity cannot be blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 4, false, false);
						 }
					
						 else if((table.getValueAt(i, 5).equals("0.0")) || (table.getValueAt(i, 5).equals("0"))){  
							 String pMessage="Total Price cannot be Zero";
							 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
							 //return 1;
						 }
					 }//EOF For 	        
					 if(table.getSelectedColumn()==0){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("0")){
							 table.changeSelection(table.getSelectedRow(), 0, false, false);
						 }
					 }else if(table.getSelectedColumn()==4){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("0")){
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
						 }
					 }else if(table.getSelectedColumn()==2 || table.getSelectedColumn()==3 || table.getSelectedColumn()==5 || table.getSelectedColumn()==6){
						 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 }
				 }
				 public void mousePressed(MouseEvent me) {					 
				 }
			 });	 
			 table.addKeyListener(new KeyAdapter(){    
				 public void keyReleased(KeyEvent ke){
					 for(int i=0; i<table.getRowCount(); i++){
						 if(table.getValueAt(i, 0).equals("")){
							 JOptionPane.showMessageDialog(scrollPane,"Product cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 0, false, false);
						 }else if(!table.getValueAt(i, 4).equals("") && !table.getValueAt(i, 4).equals("0")){
							 table.changeSelection(i, 4, false, false);
						 }else if(!table.getValueAt(i, 0).equals("")){
							 table.changeSelection(i, 4, false, false);
						 }	         
					 }
					 if(table.getSelectedColumn()==0){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("0")){
							 table.changeSelection(table.getSelectedRow(), 0, false, false);
						 }
					 }else if(table.getSelectedColumn()==4){
						 if(!table.getValueAt(table.getSelectedRow(), 0).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("") && !table.getValueAt(table.getSelectedRow(), 4).equals("0")){
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
						 }
					 }
				 }
			 });	   
			 addKeyListener(new KeyAdapter(){				
				 public void keyPressed(KeyEvent ke){		

					// System.out.println(" available qty  "+ table.getValueAt(table.getSelectedRow(), 11).toString());
					 
					 boolean checkFirstColFlag=false,checkLastRowFlag=false;
					 int rowCount=table.getRowCount();	
					 
					 if((ke.getKeyCode()==KeyEvent.VK_TAB && table.getSelectedColumn()==4)){
						 System.out.println("tab pressed  ");
						 
						 System.out.println("tab "+ table.getValueAt(table.getSelectedRow(), 0).toString());
						 
						 String quantity=getText();
						 checkFirstColFlag=isFirstColumnBlank();
						 System.out.println(" after first col blank #"+(table.getRowCount()-1)+"#");
						 /*System.out.println(" qty  #"+quantity+"# "+(!quantity.equals("") && (Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false && checkLastRowFlag));
						 System.out.println(" (!quantity.equals('') )"+(!quantity.equals("")));
						 System.out.println("(Double.parseDouble(quantity)>=0.0) "+(Double.parseDouble(quantity)>=0.0)); 
						 System.out.println("checkFirstColFlag "+(checkFirstColFlag==false));
						 System.out.println("checkLastRowFlag "+checkLastRowFlag);*/
						
						 if(table.getSelectedRow()==rowCount-1 && table.getSelectedColumn()==4){
							 checkLastRowFlag=true;
		        	     }
						 
						 if(quantity.equals("") || quantity.equals("0")){
							 System.out.println("iffffffffffff 1");
							 JOptionPane.showMessageDialog(tfe,"Quantity cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							setSelectedCol(3);//setSelected only works here
						 }else if(getText().startsWith("0.0")){ 
							 System.out.println("iffffffffffff 2");
							 JOptionPane.showMessageDialog(tfe,"Quantity is less than 0","RMS",JOptionPane.INFORMATION_MESSAGE);
							 setText("");
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !quantity.equals("0")  && checkFirstColFlag==true){
							 System.out.println("iffffffffffff 3");
							 JOptionPane.showMessageDialog(tfe,"Product Name is blank at row "+(productColBlank+1),"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !(Double.parseDouble(quantity)>=0.0) && checkLastRowFlag==false && checkFirstColFlag==false){
							 System.out.println(" ifffffffff 4");
							 JOptionPane.showMessageDialog(cme,"Next Row can only be added from last row","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(rowCount-1, 0, false, false);
						 } else if((table.getValueAt(table.getSelectedRow(), 5).equals("0.0")) || (table.getValueAt(table.getSelectedRow(), 5).equals("0"))){  
							 System.out.println("iffffffffffff 5");
							 String pMessage="Total Price cannot be Zero";
							 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);
							 
						 } // condition added to check availability 
						 /*else if(quantityArray.get(itemNames.indexOf(table.getValueAt(table.getSelectedRow(), 0).toString())) < Integer.parseInt(quantity)){
							 String msg = "Quantity cannnot be greater than available quantity ";
							 JOptionPane.showMessageDialog(scrollPane,msg,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setText("");
							 setSelectedCol(3);
						 }*/
						 //else if((!quantity.equals("")) && (Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false && checkLastRowFlag){
						 else if((!quantity.equals("")) && (Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false){
							 System.out.println("iffffffffffff 6 "+table.getValueAt(table.getSelectedRow(), 0).toString().split("\\(")[0]);
							 String itemName = table.getValueAt(table.getSelectedRow(), 0).toString();
							 int remQty = quantityArray.get(itemNames.indexOf(itemName))-Integer.parseInt(quantity);
							 int reorderQty = reorderArray.get(itemNames.indexOf(itemName));
							 System.out.println("rem qty "+remQty +"\t reorder qty "+reorderQty);
							 if(remQty<=reorderQty){
								 JOptionPane.showMessageDialog(scrollPane,"It's time to order the stock for \n"+table.getValueAt(table.getSelectedRow(), 0).toString().split("\\(")[0]+"( Remaining quantity : "+remQty+ ")","RMS",JOptionPane.INFORMATION_MESSAGE);
							 }
							 System.out.println("before add Row ");
							 addRow();
							 table.setValueAt("",table.getSelectedRow(), 4);
							 						
						 }		
						 System.out.println("end of tab  ");
					 } //EOF TAB		
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_N)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_D) || ke.getKeyCode()==KeyEvent.VK_P){
						 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 }
				 } //EOF Pressed			
				 public void keyReleased(KeyEvent ke){	
					 System.out.println("key released  ... ");
					 
					 if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
							 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 quantityValue = getText();	
						 table.setValueAt(getText(), table.getSelectedRow(), 4);
						 setQuantityTotalPriceMrp();
						 setBalance();
					 }				
					
					 if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
						 JOptionPane.showMessageDialog(scrollPane,"Negative value in not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText("");
					 }
				
					 if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
						 JOptionPane.showMessageDialog(scrollPane,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText(getText().trim());
					 }
				
					 if((ke.getKeyCode()==KeyEvent.VK_ENTER)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_SHIFT)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
				 }// EOF keyReleased()  	
			 }); //EOF KeyListener Adapter inner Class	
		 } // EOF TextFieldEditor constructor..
	  
		 public boolean isFirstCell() {
			 int rows = table.getRowCount();
			 int selectedRow = table.getSelectedRow();
			 if(rows == (selectedRow+1) && table.getSelectedColumn()==4){
				 return true;
			 }else{
				 return false;
			 }
		 }
		 public boolean isFirstColumnBlank(){
			 int rows = table.getRowCount();
			 boolean flag=false;
			 for(int i=0; i<rows; i++){
				 //if(cme.editor.getText().equals("")){
				 if(table.getValueAt(i, 0).equals("")){
					 flag=true;
					 productColBlank=i;
					 break;
				 }else{
					 flag=false;
				 }
			 }
			 return flag;
		 }// EOF isFirstColumnBlank() 
	 
	  public void setQuantityTotalPriceMrp(){
		  int tempquantity=0;
		  setText(quantityValue);
		  if(quantityValue.equals("")){
			  tempquantity=0;
			  setTotalPrice(Integer.toString(tempquantity));
		  }
		  
		  if(!quantityValue.equals("")){
			  setTotalPrice(quantityValue);
		  }
		  setOverallTotal();
	  }
	        

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
					 JOptionPane.showMessageDialog(scrollPane,"Product Name is blank","RMS",JOptionPane.INFORMATION_MESSAGE);
					 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 return flag;
				 }else if(table.getValueAt(r, 4).equals("") || table.getValueAt(r, 4).equals("0")|| table.getValueAt(r, 4).toString().startsWith("0.")){ 
					 flag=true;    
					 JOptionPane.showMessageDialog(scrollPane,"Quantity is blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
					 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 return flag;
				 }	    
			 }// EOF For loop
		 } catch(NumberFormatException nfe){
			 System.out.println("Exception in checkRowBeforeAdding"+nfe);
		 }
		 return flag;
	 }   
	
	 public class RemarkColEditor extends JTextField{
		 int productColBlank=0,qtyColBlank=0;
		 public RemarkColEditor(){
			 super(); 
			 
			 addKeyListener(new KeyAdapter(){    
				 public void keyPressed(KeyEvent ke){	      
					 boolean checkFirstColFlag=false,checkLastRowFlag=false,checkBlankQtyFlag;
					 int rowCount=table.getRowCount();   				 
					 if((ke.getKeyCode()==KeyEvent.VK_TAB && table.getSelectedColumn()==8)){       
						 checkFirstColFlag=isFirstColumnBlank();
						 checkBlankQtyFlag=isQuantityBlank();
						 if(table.getSelectedRow()==rowCount-1 && table.getSelectedColumn()==8){
							 checkLastRowFlag=true;
						 } 						 
						 if(!checkFirstColFlag && !checkBlankQtyFlag && checkLastRowFlag){
							 addRow();
													 
						 }	       
					 } //EOF TAB  
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_N)){
						 table.changeSelection(table.getSelectedRow(), 8, false, false);
					 }	      
				 } //EOF Pressed	     
				 public void keyReleased(KeyEvent ke){
					 /*Below line sets the value typed in remark column. which earlier 
					  *used to be get replaced by space*/
					 table.setValueAt(getText(), table.getSelectedRow(), 8);
				 }// EOF keyReleased()
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
				 }else{
					 flag=false;
				 }
			 }
			 return flag;
		 }// EOF isFirstColumnBlank()
		 public boolean isQuantityBlank(){
			 int rows = table.getRowCount();
			 boolean flag=false;
			 for(int i=0; i<rows; i++){
				 if(table.getValueAt(i, 4).equals("")){
					 flag=true;
					 qtyColBlank=i;
					 break;
				 }else{
					 flag=false;
				 }
			 }
			 return flag;
		 }// EOF isFirstColumnBlank()
	 } //EOF RemarkColEditor Class
	 
// Class for adding a window popup for displaying slected products description
	 
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
		    		  winTable.setValueAt(table.getValueAt(i, 4), i, 3);
		    		  winTable.setValueAt(table.getValueAt(i, 5), i, 4);
		    	  }
		      }
		    } //EOF Constructor

//-----------------------------------------------------------------------------------		  
			public void makeDialogGUI(){
				//setSize(1000,350);
				rows1=new Vector();
				columns1= new Vector();
				String[] columnName = { "Product", "Weight","Price","Quantity","Total Price"};
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
				System.out.println("addrowintable");
			}
			
			 public Vector addBlankElements() {
					Vector <String> t1  = new Vector<String>();
					t1.addElement(" ");
					t1.addElement(" ");
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
					
					tcmWinPopup.getColumn(3).setPreferredWidth(75 );
					tcmWinPopup.getColumn(3).setMinWidth( 75 );
					tcmWinPopup.getColumn(3).setMaxWidth(100);
					
					tcmWinPopup.getColumn(4).setPreferredWidth(75 );
					tcmWinPopup.getColumn(4).setMinWidth( 100 );
					tcmWinPopup.getColumn(4).setMaxWidth(100);

				}			
//-----------------------------------------------------------------------------------		  
		}//EOF DialougeFrame class
		
	 class MyWindowAdapter extends WindowAdapter{
		 DialogFrame dialogFrame;
		 public MyWindowAdapter(DialogFrame dialogFrame){
			 this.dialogFrame = dialogFrame;
		 }
		 public void windowClosing(WindowEvent we){
			 //dialogFrame.setVisible(false);
			 dialogFrame.dispose();
		 }
	 } // EOF MyWindowAdapter class

	public void mouseClicked(MouseEvent arg0) {
		// TODO Auto-generated method stub
	}

	 public void setBalance(){	
		 try{
	 		if(!paymentMode.equals("Cash")){
				double savingFldValue=0.0f;
/*--------------------------------------------------------------------------------------------*/			
					getValues();
/*--------------------------------------------------------------------------------------------*/
				//totalFldValue=Double.parseDouble(totalField.getText());	
				savingFldValue=(totalFldValue-totalMrpLblVal);				
				balanceValue=(totalFldValue-advanceValue)-otherDiscountValue+otherChargesValue;
				balanceLblVal.setText(Double.toString(balanceValue));				
				int result = setFocusOnTextField();					
				if(balanceValue<0){
					if(result==0)
						JOptionPane.showMessageDialog(scrollPane,"Balance amount cannot be less than zero","RMS",JOptionPane.INFORMATION_MESSAGE);
					if(advanceValue<=totalFldValue){
						otherDiscountTxt.setText("");
						savingFld.setText(Double.toString(Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText())));
						balanceLblVal.setText(Double.toString((totalFldValue-advanceValue)+otherChargesValue));
						balanceLblVal.setForeground(Color.blue);
					    savingFld.setForeground(Color.blue);
					}
				}
				else if(balanceValue>=0){				
					balanceLblVal.setText(Double.toString(balanceValue));
				    //savingFld.setText(Double.toString(savingFldValue));
					 if(!otherDiscountTxt.getText().equals(""))
						 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
					 else
						 otherDiscountValue=0.0f;	
					savingFld.setText(Double.toString(Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText())+otherDiscountValue));					
					balanceLblVal.setForeground(Color.blue);
				    savingFld.setForeground(Color.blue);
				}			
	 		}
	 		else if(paymentMode.equals("Cash")){
				 cashProcess();				 
	 		}
		 }
		 catch(Exception e){
				System.out.println("Exception occured in setBalance");
				e.printStackTrace();
		 }
		}//EOF setBalance()
	 
	 public  int setFocusOnTextField(){
		 boolean flag=false;
		 try{
			 double discount=0.0f,advance=0.0f;		 
			 if(advanceValue>totalFldValue){
				JOptionPane.showMessageDialog(null,"Advance amount cannot be greater than total price.","RMS",JOptionPane.INFORMATION_MESSAGE);			
				advanceTxt.setText("");	
				advanceTxt.requestFocus();	
				if(!otherDiscountTxt.getText().equals(""))
					discount=Double.parseDouble(otherDiscountTxt.getText());
				else
					discount=0.0f;						
				balanceLblVal.setText(Double.toString(Double.parseDouble(totalField.getText())-discount));
				balanceLblVal.setForeground(Color.blue);				
				//savingFld.setText(Double.toString((Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText())))+discount);
				//savingFld.setForeground(Color.blue);
				
				flag=true;
			}
			else if(otherDiscountValue>totalFldValue){		
				JOptionPane.showMessageDialog(null,"Discount amount cannot be greater than total price.","RMS",JOptionPane.INFORMATION_MESSAGE);				
				otherDiscountTxt.setText("");
				otherDiscountTxt.requestFocus();			
				if(!advanceTxt.getText().equals(""))
					advance=Double.parseDouble(advanceTxt.getText());
				else
					advance=0.0f;		
				balanceLblVal.setText(Double.toString(Double.parseDouble(totalField.getText())-advance));
				balanceLblVal.setForeground(Color.blue);				
				//savingFld.setText(Double.toString((Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText()))));
				//savingFld.setForeground(Color.blue);
				flag=true;			
			}
		 }
		 catch(Exception e){
			System.out.println("Exception occured in setFocusOnTextField");
			e.printStackTrace();
		 } 
		 
		if(flag==true)
			return 1;
		else
			return 0;
	 }//EOF setFocusOnTextField() 
	 	
	 public void processCashPayment(String item){
		 try{			 
			 if(item.equals("Cash")){
				 advanceTxt.setText(totalField.getText());
				 advanceTxt.setBackground(Color.white);
				 advanceTxt.setForeground(Color.blue);
				 advanceTxt.setEditable(false);				 

				 //advanceTxt.setBackground(Color.yellow);
				 balanceLblVal.setText("0");
				 balanceLblVal.setForeground(Color.blue);				 
				 //cashProcess();				 
				 setBalance();
			 }
			 else if(!item.equals("Cash")){	
				 
				 advanceTxt.setEditable(true);
				 advanceTxt.setForeground(Color.black);
				 advanceTxt.setText("");
				 otherDiscountTxt.setText("");
				 otherChargesTxt.setText("5");
/*------------------------------------------------------------------------------------------*/				 
				 getValues();
/*------------------------------------------------------------------------------------------*/				 
				 double balanceval=(totalFldValue-advanceValue)-otherDiscountValue+otherChargesValue;				 
				 balanceLblVal.setText(Double.toString(balanceval));
				 balanceLblVal.setForeground(Color.blue);		
				 savingFld.setText(Double.toString(totalMrpLblVal-totalFldValue));
				 savingFld.setForeground(Color.blue);
			 }
		 }
		catch(Exception e){
			System.out.println("Exception occured in processCashPayment");
			e.printStackTrace();
		}			 
	 }
	 
	 
	 public void cashProcess(){
		 try{		 
			 double savingFldValue=0.0f;
			 totalFldValue=Double.parseDouble(totalField.getText());
			 //otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
/*------------------------------------------------------------------------------------------*/			 
			 getValues();
/*------------------------------------------------------------------------------------------*/		 
			 if(otherDiscountValue>totalFldValue){
				JOptionPane.showMessageDialog(scrollPane,"Discount amount cannot be greater than total price.","RMS",JOptionPane.INFORMATION_MESSAGE);				
				otherDiscountTxt.setText("");
				//advanceTxt.setText(Double.toString(totalPriceVal + otherChargesValue));
				otherDiscountTxt.requestFocus();	
				calculateValues(savingFldValue);
			 }
			 else if(otherDiscountValue<=totalFldValue){			 
				 //totalFldValue=Double.parseDouble(totalField.getText());						 
				 advanceTxt.setForeground(Color.blue);
				 advanceTxt.setBackground(Color.white);
				 advanceTxt.setText(Double.toString(totalFldValue - otherDiscountValue));		

				 savingFldValue=totalMrpLblVal-totalFldValue;
				 //savingFldValue=Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText());
				 savingFldValue=savingFldValue+otherDiscountValue;	
				 savingFld.setText(Double.toString(savingFldValue));
				 savingFld.setForeground(Color.blue);
				 if(!advanceTxt.getText().equals(""))
					 advanceValue=Double.parseDouble(advanceTxt.getText());
				 else
					 advanceValue=0.0f;				 
				 double balanceval=(totalFldValue-advanceValue)-otherDiscountValue;				 
				 if(balanceval<0)
					 JOptionPane.showMessageDialog(scrollPane,"Balance cannot be zero. Please enter correct Discount amount.","RMS",JOptionPane.INFORMATION_MESSAGE);
				 else if(balanceval>=0){
					 balanceLblVal.setText(Double.toString(balanceval));
					 balanceLblVal.setForeground(Color.blue);
				 }
				 
				 advanceTxt.setText(Double.toString(advanceValue + otherChargesValue));
			 }
		 }
		catch(Exception e){
			System.out.println("Exception occured in cashProcess");
			e.printStackTrace();
		}
	}		
	 
	public void calculateValues(double savingFldValue){
		try{
			 if(!otherDiscountTxt.getText().equals(""))
				 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
			 else
				 otherDiscountValue=0.0f;
			 advanceTxt.setForeground(Color.blue);
			 advanceTxt.setBackground(Color.white);
			 //advanceTxt.setBackground(new Color(0xFF, 0xCC, 0xFF));
			 advanceTxt.setText(Double.toString((totalFldValue - otherDiscountValue)+otherChargesValue));

			 savingFldValue=Double.parseDouble(totalMrpFld.getText())-Double.parseDouble(totalField.getText());
			 savingFldValue=savingFldValue+otherDiscountValue;	
			 savingFld.setText(Double.toString(savingFldValue));
			 savingFld.setForeground(Color.blue);
			 
		}
		catch(Exception e){
			System.out.println("Exception occured in calculateValues");
			e.printStackTrace();
		}
	}
	
	public void getValues(){
		try{
		 if(!advanceTxt.getText().equals(""))
			 advanceValue=Double.parseDouble(advanceTxt.getText());
		 else
			advanceValue=0.0f;
		 if(!otherDiscountTxt.getText().equals(""))
			 otherDiscountValue=Double.parseDouble(otherDiscountTxt.getText());
		 else
			 otherDiscountValue=0.0f;		 
		 if(!otherChargesTxt.getText().equals(""))
			otherChargesValue=Double.parseDouble(otherChargesTxt.getText());
		 else				 
			 otherChargesValue=0.0f;			 
		 if(!totalMrpFld.getText().toString().equals("")){
			 totalMrpLblVal=Double.parseDouble(totalMrpFld.getText().toString());
		 }
		 else
			 totalMrpLblVal=0.0f;
		 if(!totalField.getText().toString().equals(""))
			 totalFldValue=Double.parseDouble(totalField.getText().toString());
		 else
			 totalFldValue=0.0f;
		}
		catch(Exception e){
			System.out.println("Exception occured in getValues....");
			e.printStackTrace();
		}
	}
	 public void trimTextField(JTextField jtf){	 
		 int len=0;
		 len=jtf.getText().length();
		 String temp = jtf.getText().substring(0, len-1);
		 jtf.setText(temp);	 
		 jtf.requestFocus();
	 }
 
	 
	 
}// EOF Class