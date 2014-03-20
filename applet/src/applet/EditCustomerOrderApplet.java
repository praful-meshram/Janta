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
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.event.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.Vector;
import netscape.javascript.JSObject; 
import netscape.javascript.JSException;
import java.text.DecimalFormat;
import java.awt.Font;
import java.util.Stack;

public class EditCustomerOrderApplet extends JApplet implements ActionListener, TableModelListener {//, Runnable{
	 TextFieldEditor tf;
	 Stack lifo = new Stack();
	 //Thread saveThread = new Thread(this);
	 JSObject win;
	 JTable table;
	 Vector rows;
	 Vector <String> columns;
	 DefaultTableModel tabModel;
	 JScrollPane scrollPane;
	 JButton addButton,deleteButton,saveButton,cancelButton,clearButton,viewButton,
	 		 holdButton,paymentButton;
	 JCheckBox checkBox;
	 RemarkColEditor remarkEditor;
	 JComboBox paymentCombo,tempCombo; 
	 JLabel totalPrice,totalField,totalMrp,pickUp,deliver,paymentLbl,savingLbl,
	     totalItemFld,pickUpFld,deliverFld,totalMrpFld,savingFld,emptyFld,emptyFld1,
	     deliverInstruLbl,customerName,custPhone,oDate,cstCode,cstName,cstphone,
	     cstdate,orderDetails,custEmpty,totalItemsLbl,customerCode,orderNumber,ordNumb,
	     advance,otherDiscount,balance,balanceLblVal,blankLbl1,blankLbl2,otherChargesLbl,
	     paidBalanceLbl,paidBalanceLblVal,siteLabel,siteNameLabel;
	 JPanel tablePanel,innerbuttonPanel,buttonPanel,mainPanel,labelPanel1,
	 	labelPanel2,
	     labelPanel3,labelPanel4,labelPanel5,labelPanel6,emptyPanel,emptyPanel1,wholeLabelPanel,custPanel,
	     custPanel1,custPanel2,custPanel3;
	 JTextComponent editor;
	 JTextField deliverInstruText,advanceTxt,otherDiscountTxt,otherChargesTxt;
	 Connection con=null;
	 ResultSet rs,rs1,rs2,rs3,rs4,rsFetch,rsForItemName; 
	 Statement getValstmt,getItemstmt,getValstmt1,getValstmt2,stmt,getFetchStmt; 
	 String dburl="", dbusername="", dbpassword="",statusCode="",copyOrder="",orderType="EDIT",lastOrderdate="";
	 String productValue,setProdName="", item_code="", pay_type="", p_code="", status="",deliveryRemark="";
	 String user="",disRemark="",quantityValue="",blankString="",weightString="",
	     rateString="",blank=" ",blankValue="  ",blankVar="   ",blankValue3="   ";
	 String order_date="",deliveryStaff="",del_ateTime="",send_DateTime,savingType="",paymentMode="";	 
	 String[] prodValResult;
	 long pickup_ind=0,item_returned=0;
	 Object objTemp=null;
	 Vector <String> productArray = new Vector<String> (); 
	 Vector <String> item_codeArray = new Vector<String> (); 
	 Vector <String>priceVersionArray = new Vector<String>();
	 int itemCount = 0,pickValue=0, deliverCount = 0,max=0,transId=0,setQuantityFlag=0,checkboxFlag,pickUpCnt=0,orderNo=0,i,addedRow=0,checkQuantityVal,columnCount=7,siteId;
	 double item_mrp=0.00f,totMRPValue=0.0f,balanceValue=0.0f,advanceValue=0.0f,
	 		otherDiscountValue=0.0f,savingValue=0.0f,totalSaving=0.0f,otherChargesValue=0.0f;
	 double totalFldValue=0.0f,totalMrpLblVal=0.0f;
	 
	 ManageOrderFile mo;
	 int maxrec=0;
	 boolean running = true;
	 ComboBoxEditor cme;
	 TextFieldEditor tfe; 
	 JTextComponent commonJTC;
	 
	 DecimalFormat df = new DecimalFormat("###,###.00");      
	 String orderDate="";    
	 int totalItems=0;
	 long item_taken=0;
	 double totalValue=0.0f;
	 String enteredBy="";
	 int total_taken=0;
	 int delivered=0;
	 int dealQty;
	 int priceVersion;
	 double itemRate=0.0f;
	 double itemQty=0.0f;
	 double itemTotPrice=0.0f;
	 double itemMRP=0.0f;
	 double totalValueMRP=0.0f;
	 double savings=0.0f;
	 double totalValueDis=0.0f;
	 double itemTotDis=0.0f;
	 
	 String itemCode="";
	 String itemName="";
	 String itemWeight="";
	 String custCode="";
	 String custName="";
	 String building="";
	 String block="";
	 String wing="";
	 String add1="";
	 String add2="";
	 String phone="",commAmt="";
	 String codeValue="";
	 String categoryCode="";  
	 String p_type="",startDateTime="",siteName="";
	 boolean mousePressed = true;
	 
	 String msgYesNo="0";
	 
	 Vector <String> itemNames = new Vector <String>();
	 Vector <Integer> quantityArray = new Vector<Integer>();
	 Vector <Integer> previousQuantityArray = new Vector<Integer>();
	 String JItemName =null;
	 
	 public void init(){
		  try{
			  dburl = getParameter("dburl");
			  dbusername = getParameter("dbusername");
			  dbpassword = getParameter("dbpassword");	 
			  orderNo = Integer.parseInt(getParameter("orderNo"));
			  user = getParameter("user");	
			  statusCode=getParameter("statusCode");
			  copyOrder=getParameter("copyOrder");	
			  //orderNo = 31;
			  initialize(dburl,dbusername,dbpassword);
			  siteId=Integer.parseInt(getParameter("siteID"));
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
	 
	 public void initialize(String dburl, String dbusername,String dbpassword){
		  try{
			  System.out.println("In initialize");		      
			  Class.forName("com.mysql.jdbc.Driver");
			  System.out.println("here1111");			 
			  
				 con = DriverManager.getConnection(dburl, dbusername, dbpassword);
				 System.out.println("connection ");
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
		  String[] columnNames = { "Item","Check", "Weight","Price","Quantity","Total Price","MRP","Discount","Remark","ItemCode","PriceVersion"};
		  addColumns(columnNames);
		  tabModel = new DefaultTableModel(); 
		  tabModel.setDataVector(rows,columns);
		  setTabFocus();
		  scrollPane = new JScrollPane(table);    
		  table.setRowSelectionAllowed(false);
	  
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
		  remarkColwithTextField.setPreferredWidth(100 );
		  remarkColwithTextField.setMinWidth( 135 );
		  remarkColwithTextField.setMaxWidth(250);
		  table.setRowHeight(20);	    
		  fetchOrderValues(colwithCombo,colwithCheck);
//--------
		  //testUpgradedValues();
//--------
		  table.getModel().addTableModelListener(this);		  	 
	 }  

	  public void testUpgradedValues(){
		  String itemcode="",remark="";
		  Float itemRate=0.0f,itemMrp=0.0f,totalPrice=0.0f,dealOnQty=0.0f,
		  		dealOnAmt=0.0f,itemQty=0.0f,qty=0.0f,discount=0.0f;
		  try{
		  String query="select 'NEWNUM',b.item_name,b.item_code,b.item_rate,a.qty,(a.qty*b.item_rate), "+
				"CASE "+
				"            WHEN deal_active_flag = 'Y' and deal_type = 'Money' "+
				"        THEN FLOOR(a.qty/b.deal_on_qty)* b.deal_amount "+
				"        ELSE 0.00 "+
				"END, "+
				"CASE "+
				"            WHEN deal_active_flag = 'Y' and deal_type = 'Money' "+
				"        THEN CONCAT('Rs: ',b.deal_amount,' on ', b.deal_on_qty, ' QTYs') "+
				"        ELSE ' ' "+
				"END, "+
				"b.item_mrp,b.deal_on_qty,b.deal_amount,a.remark "+
				"from order_detail a, item_master b "+
				"where a.order_num = '"+orderNo+"' "+
				"and a.item_code=b.item_code";	  
		  		System.out.println("here query = "+query);		  
		   		rsFetch = getFetchStmt.executeQuery(query); 			  
		   		while(rsFetch.next()){
		   			itemcode=rsFetch.getString(3);		   			
		  		    itemRate=rsFetch.getFloat(4);
		  		    qty=rsFetch.getFloat(5);
		  		    itemMrp=rsFetch.getFloat(9);		  		   
		  		    totalPrice=rsFetch.getFloat(6);
System.out.println("rsFetch.getFloat(7) = "+rsFetch.getFloat(7));		  		    
		  		    discount=rsFetch.getFloat(7);
		  		    dealOnQty=rsFetch.getFloat(10);
		  		  	dealOnAmt=rsFetch.getFloat(11);	  		  	
		   			remark=rsFetch.getString(12);	   			
		  			
		  		  totalPrice=totalPrice-discount;
		   			for(int i=0; i<table.getRowCount(); i++){
		   				if(table.getValueAt(i, 9).toString().equals(itemcode)){
		   					table.setValueAt(itemRate,i,3);
		   					table.setValueAt(totalPrice,i,5);
		   					table.setValueAt(itemMrp,i,6);
		   					table.setValueAt(discount,i,7);
		   					table.setValueAt(remark,i,8);
		   				}
		   			}
		   			
		   		}	
		  }
		  catch(Exception e){
			  System.out.println("Error occured in testUpgradedValues");
			  e.printStackTrace();
		  }
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
			totalItemFld.setText(Integer.toString(itemCount));
			totalItemFld.setForeground(Color.blue);
			deliverFld.setText(Integer.toString(deliverCount));
			deliverFld.setForeground(Color.blue);
			
			setPickupLabel(pickValue);				
			
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
	//							 This code is added on 24/3/08 for editing purpose after deleting a particular rwow.
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
	  }
	public  void populateAfterDelete(String temp){
		 int pos=0;
		 String str="";
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

//if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))        	
        	

             public boolean isCellEditable(int row, int column)
             {    
            	 boolean flag=false;            	 
            	 if(statusCode.equals("SUBMITTED") || statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){	           		 
		             if(column ==0 || column ==4 || column ==1 || column ==8)
		            	 flag= true;
		             else
		            	 flag= false;
	             }
            	 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
            		 flag= false;
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
		  holdButton = new JButton("Hold");
		  cancelButton = new JButton("Cancel");
		  viewButton = new JButton("View");
		  paymentButton= new JButton("Payment");
		  addButton.setMnemonic(KeyEvent.VK_N);
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
		  
		  totalItemsLbl = new JLabel("Total Items :");
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
			   rs4 = stmt.executeQuery("select payment_type_desc from payment_type");
			   while (rs4.next()) {  
				   paymentCombo.addItem(rs4.getString(1));    
			   }
			   rs4.close();
		  }catch(Exception e){
			  System.out.println("Exception in loading payment type"+e);
		  }
		  
		  emptyFld1 = new JLabel("  ");	  
		  totalPrice = new JLabel("Total Price      :");
		  totalField = new JLabel("0");
		  totalField.setForeground(Color.BLUE);
		  totalMrp = new JLabel("Total by MRP  :");
		  totalMrpFld =  new JLabel();    
		  savingLbl =  new JLabel("saving              :");
		  savingFld =  new JLabel();
		  
		  advance =  new JLabel("Advance              :  ");
		  advanceTxt=new JTextField();
		  otherDiscount =  new JLabel("Other Discount  :  ");
		  otherDiscountTxt=new JTextField();	

		  balance =  new JLabel("Balance               : ");		
		  balanceLblVal=new JLabel("0");	
		  balanceLblVal.setForeground(Color.blue);		  
		  blankLbl1=new JLabel("");
		  blankLbl2=new JLabel("");
		  deliverInstruLbl=new JLabel("Delivery Instructions:");
		  deliverInstruText=new JTextField();	
		  otherChargesLbl=new JLabel("Other Charges            : ");
		  otherChargesTxt=new JTextField();
		  paidBalanceLbl=new JLabel("Paid Amount                :   ");
		  paidBalanceLblVal=new JLabel("0");
		  
		  orderNumber=new JLabel("Order Number :");
		  ordNumb=new JLabel();
		  customerCode=new JLabel("Customer Code :");
		  cstCode=new JLabel();
		  customerName=new JLabel("Customer Name :");
		  cstName=new JLabel();
		  custPhone=new JLabel("Phone :");
		  cstphone=new JLabel();
		  oDate=new JLabel("Date :");		 
		  cstdate=new JLabel();  
		  siteLabel=new JLabel("Site Name :");
		  siteNameLabel=new JLabel();
		  orderDetails=new JLabel("Order Details");
		  custEmpty=new JLabel("");
		  
		  custPanel1.add(orderNumber);
		  custPanel1.add(ordNumb);
		  custPanel1.add(customerCode);
		  custPanel1.add(cstCode);
		  custPanel1.add(customerName);
		  custPanel1.add(cstName);
		  custPanel1.add(custPhone);
		  custPanel1.add(cstphone);
		  custPanel1.add(oDate);
		  custPanel1.add(cstdate); 	
		  custPanel1.add(siteLabel);
		  custPanel1.add(siteNameLabel);
		  custPanel2.add(orderDetails);//2nd cust Panel	  
		  custPanel.add(custPanel1);	 
		  custPanel.add(custPanel2); 
		  labelPanel1.add(totalItemsLbl);
		  labelPanel1.add(totalItemFld);
	      labelPanel1.add(pickUp);
	      labelPanel1.add(pickUpFld);
	      labelPanel1.add(deliver);
	      labelPanel1.add(deliverFld);     
		  //emptyPanel.add(emptyFld); 	     
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
		  labelPanel6.add(paidBalanceLbl);  
		  labelPanel6.add(paidBalanceLblVal);	      	      
		  
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
		  saveButton.addActionListener(this);
		  holdButton.addActionListener(this);		  
		  cancelButton.addActionListener(this);
		  viewButton.addActionListener(this);
		  paymentButton.addActionListener(this);
		  //paymentCombo.addActionListener(this);

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
						
					 }
				 }
		  });		  
		  
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
			  	  		  
	  		  String query= "SELECT distinct m.item_name, m.item_weight,p.item_rate,p.item_mrp, m.item_code, p.price_version, "+
							//"m.reorder_level,sum(s.item_site_qty) sumQty "+  
							" m.reorder_level,s.item_site_qty sumQty "+  
							" FROM item_master m,item_price p,item_site_inventory s "+  
							" WHERE  p.item_code = m.item_code and s.site_id =  "+siteId+  
							" and p.item_code = s.item_code "+  
							" and p.current_flag = 'Y' "+ 
							//"and p.current_flag = 'Y' and s.item_site_qty > 0 " +
							" and p.current_flag = 'Y' group by m.item_code "+ 
							" order by m.item_name, p.price_version desc ";
	  		  
					   
			   System.out.println("edit order query "+query);
			   rs = getValstmt.executeQuery(query); 
			   while(rs.next()){ 				   
				     //productArray.add(rs.getString(1)+" ( W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+" ) ");
				     productArray.add(rs.getString(1)+" ( W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+", AvailQty : "+rs.getString("sumQty")+")");
				     item_codeArray.add(rs.getString(5));
				     priceVersionArray.add(rs.getString(6));
				     quantityArray.add(rs.getInt(8));
				     //itemNames.add(rs.getString(1)+"(AvailQty : "+rs.getString("sumQty")+")");
				     itemNames.add(rs.getString(1).trim());
				     //System.out.println("product array "+rs.getString(1)+" ( W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+", AvailQty : "+rs.getString("sumQty")+")");
				     
			   }   
			   DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
			   renderer.setToolTipText("Click the Product to see a list of choices");
			   productColumn.setCellRenderer(renderer);
		  }catch(Exception e){	 
			   System.out.println("Could not connect to database"+e);	 
		  } 
	 }	 
	 
	 public void fetchOrderValues(TableColumn productColumn , TableColumn checkColumn){
		 String advanceStr="",otherDiscountStr="",balanceStr="",otherChargesStr="",paidBalanceStr="";
		 try{     
			   String fetcQuery="select DATE_FORMAT(a.order_date,'%d-%m-%y %r'), a.total_items, a.total_value, " +
			        "a.total_value_mrp, a.enterd_by,a.total_value_discount,a.total_taken, " + 
			        "b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark, b.item_taken,ifnull(e.payment_type_desc,''),b.price_version, " + 
			        "d.item_code,d.item_name, d.item_weight, c.custcode,c.custname, "+
			        "c.building,c.block,c.wing,c.add1,c.add2,c.phone,a.remark, "+
			        "a.order_date,a.dstaff_code,a.comm_amt ,a.advance_amt,a.discount_amt,a.balance_amt,a.other_charges,a.paid_amt, " +
			        "sm.site_name,sm.site_id " +
			        "from orders a left outer join payment_type e on a.payment_type_code = e.payment_type_code, " +
			        "order_detail b, customer_master c, item_master d,site_master sm " +
			        "where a.order_num = b.order_num " +
			        "and a.custcode = c.custcode " +
			        "and b.item_code = d.item_code " +
			        "and a.order_num = '" + orderNo + "' " +
			        "and sm.site_id = a.site_id "+
			        "order by b.entry_no"; 	
			  System.out.println("fetcQuery:"+fetcQuery);
			  
			   rsFetch = getFetchStmt.executeQuery(fetcQuery); 			  
			   while(rsFetch.next()){
				    i=1;
					orderDate=rsFetch.getString(i++);
				    totalItems=rsFetch.getInt(i++);
				    totalValue=rsFetch.getDouble(i++);
				    totalValueMRP=rsFetch.getDouble(i++);
				    enteredBy=rsFetch.getString(i++);
				    totalValueDis=rsFetch.getDouble(i++);
				    total_taken=rsFetch.getInt(i++);
				    
				    itemRate=rsFetch.getDouble(i++);
				    itemQty=rsFetch.getDouble(i++);
				    itemTotPrice=rsFetch.getDouble(i++);
				    itemMRP=rsFetch.getDouble(i++);
				    itemTotDis=rsFetch.getDouble(i++);
				    disRemark=rsFetch.getString(i++);
				    item_taken=rsFetch.getLong(i++);
				    p_type=rsFetch.getString(i++);
				    priceVersion=rsFetch.getInt(i++);
				    itemCode=rsFetch.getString(i++);
				    itemName=rsFetch.getString(i++);
				    itemWeight=rsFetch.getString(i++);
				    custCode=rsFetch.getString(i++);
				    custName=rsFetch.getString(i++);
				    building=rsFetch.getString(i++);
				    block=rsFetch.getString(i++);
				    wing=rsFetch.getString(i++);
				    add1=rsFetch.getString(i++);
				    add2=rsFetch.getString(i++);
				    phone=rsFetch.getString(i++);		    
				    deliveryRemark=rsFetch.getString(i++);
					//java.sql.Timestamp stamp = (java.sql.Timestamp)rsFetch.getObject(i++);
					//order_date = stamp.toString();	
				    order_date=rsFetch.getString(i++);
				    deliveryStaff=rsFetch.getString(i++);
				    commAmt=rsFetch.getString(i++);				    
				    advanceStr=rsFetch.getString(i++);
				    otherDiscountStr=rsFetch.getString(i++);
				    balanceStr=rsFetch.getString(i++);
				    otherChargesStr=rsFetch.getString(i++);	
				    paidBalanceStr=rsFetch.getString(i++);
				    siteName = rsFetch.getString(i++);
				    siteId = rsFetch.getInt(i++);
				    addRow();
				    table.setValueAt("",table.getSelectedRow(), 4);
				    //table.setValueAt(itemName+"(AvailQty : "+rsFetch.getString("item_site_qty")+")", addedRow, 0);
				    table.setValueAt(itemName.trim(), addedRow, 0);
				    if(item_taken==1){
				    	table.setValueAt(new Boolean(true), addedRow, 1);
				    }
				    else{
				    	table.setValueAt(new Boolean(false), addedRow, 1);
				    }	
				    
				    
				    
				    table.setValueAt(itemWeight, addedRow, 2);
				    table.setValueAt(Double.toString(itemRate), addedRow, 3);
				    table.setValueAt((int)itemQty, addedRow, 4);
				    // stored previos qty values 
				    previousQuantityArray.add((int)itemQty);
				    table.setValueAt(Double.toString(itemTotPrice), addedRow, 5);
				    table.setValueAt(Double.toString(itemMRP), addedRow, 6);
//-----------------				    
				    table.setValueAt(Double.toString(itemTotDis), addedRow, 7);
//-----------------				    
				    table.setValueAt(disRemark, addedRow, 8);
				    table.setValueAt(itemCode, addedRow, 9);	
				    table.setValueAt(priceVersion, addedRow, 10);
				    paymentCombo.setSelectedItem(p_type);
				    deliverInstruText.setText(deliveryRemark);
				    addedRow++;					   
			   }// EOF While			   
			   setOverallTotal();
			   ordNumb.setText(orderNo+"  ");
			   cstCode.setText(custCode+"  ");
			   cstName.setText(custName+"  ");
			   cstphone.setText(phone+"  ");
			   cstdate.setText(orderDate+"  ");
			   siteNameLabel.setText(siteName+"  ");
			   ordNumb.setForeground(Color.blue);
			   cstCode.setForeground(Color.blue);
			   cstName.setForeground(Color.blue);
			   cstphone.setForeground(Color.blue);
			   cstdate.setForeground(Color.blue);
			   siteNameLabel.setForeground(Color.blue);
			   ordNumb.setFont(new Font("Arial", Font.PLAIN, 12));
			   
			   cstCode.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstName.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstphone.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstdate.setFont(new Font("Arial", Font.PLAIN, 12));
			   siteNameLabel.setFont(new Font("Arial", Font.PLAIN, 12));
			   delivered=totalItems-total_taken;
			   totalItemFld.setText(Integer.toString(totalItems));
			   totalItemFld.setForeground(Color.blue);			   
			   pickUpFld.setText(Long.toString(total_taken));
			   pickUpFld.setForeground(Color.blue);
			   deliverFld.setText(Long.toString(delivered));
			   deliverFld.setForeground(Color.blue);
			   totalField.setText(Double.toString(totalValue));
			   totalField.setForeground(Color.blue);
			   totalMrpFld.setText(Double.toString(totalValueMRP));
			   totalMrpFld.setForeground(Color.blue);			   
			   totalSaving=totalSaving+(totalValueMRP-totalValue);
			   if(advanceStr.equals(""))
				   advanceStr="0";
			   if(otherDiscountStr.equals(""))
				   otherDiscountStr="0";	
			   if(otherChargesTxt.equals(""))
				   otherChargesStr="0";
			   savingFld.setText(Double.toString((totalValueMRP-totalValue)+Double.parseDouble(otherDiscountStr)));		   
			   savingFld.setForeground(Color.blue);			   
			   advanceTxt.setText(advanceStr);
			   otherDiscountTxt.setText(otherDiscountStr);
			   otherChargesTxt.setText(otherChargesStr);		   
			   balanceLblVal.setText(balanceStr);
			   balanceLblVal.setForeground(Color.blue);
			   paidBalanceLblVal.setText(paidBalanceStr);
			   paidBalanceLblVal.setForeground(Color.blue);
			   
			  
			  
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
		       setPickupLabel(pickValue);
		  }	  
	 }//Table Changed Method   
	 
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
					 if(statusCode.equals("SUBMITTED") || statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){
						addRow();
					  	table.setValueAt("", table.getSelectedRow(), 4);
					 }
					 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
						 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);
				 }

			 }else if (source.getSource()==(JButton) deleteButton){
				 if(table.getRowCount()!=0 && table.getRowCount()>0 && statusCode.equals("SUBMITTED") ||statusCode.equals("HOLD") || copyOrder.equals("CopyOrder") ){					 
					 deleteRow(table.getSelectedRow());
					 setBalance();
				 }
				 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
					 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);				 
				 else if(table.getRowCount()==0)	
					 JOptionPane.showMessageDialog(null,"There are no rows anymore to delete","RMS",JOptionPane.INFORMATION_MESSAGE);
				  				   
			 }else if (source.getSource()==(JButton) saveButton){
				 String saveType = "SAVE";
				 int emptyFlag=0;					 
				 if(table.getValueAt(0, 0).equals("") && table.getValueAt(0, 2).equals("")
					&& table.getValueAt(0, 3).equals("") && table.getValueAt(0, 4).equals("") ){
				 	emptyFlag=1;
				 }	
				 if(statusCode.equals("SUBMITTED") ||statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){
					 if(table.getRowCount()!=0 && table.getRowCount()>0)					 
					 {
						 if(emptyFlag!=1){				 
							 String ans1 = checkPaymentType(saveType);
							 if(ans1.equals("1")){
								 String ans = checkDuplicateProduct();
								 if(ans.equals("1")){  
									 checkBlankProduct();
									 //saveOrder("SAVE");
									 int result=setFocusOnTextField();
									 if(result==0){
										 String ansadvbal = checkadv();
										 if(ansadvbal.equals("1")){  
											 String ansdisbal = checkdis();
											 if(ansdisbal.equals("1")){
												 String anstotalval ="1"; //checktotalval();
												 if(anstotalval.equals("1")){  
													 balanceValue=Double.parseDouble(balanceLblVal.getText());
													 if(balanceValue>=0 || paymentMode.equals("Cash"))
													    	 saveOrder("SAVE");
													 else if(balanceValue<=0)
														 JOptionPane.showMessageDialog(null,"Balance amount is less than zero","RMS",JOptionPane.INFORMATION_MESSAGE);
												 }
											 }
										 }
									 }
								 }
							 }	
						 }
						else if(emptyFlag==1){
							JOptionPane.showMessageDialog(null,"Please Select Item Details","RMS",JOptionPane.INFORMATION_MESSAGE);
						}	
					}
					else if(table.getRowCount()==0)	
						JOptionPane.showMessageDialog(null,"Please add a row","RMS",JOptionPane.INFORMATION_MESSAGE);					
				}
				else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
					JOptionPane.showMessageDialog(null,"Delivered order cannot be saved","RMS",JOptionPane.INFORMATION_MESSAGE);					 				 
				
			 }else if (source.getSource()==(JButton) holdButton){
				 // Code for Holding orders
				 String saveType = "HOLD";	
				 int emptyFlag=0;	
				 if(table.getValueAt(0, 0).equals("") && table.getValueAt(0, 2).equals("")
					&& table.getValueAt(0, 3).equals("") && table.getValueAt(0, 4).equals("") ){
				 	emptyFlag=1;
				 }
				 if(statusCode.equals("SUBMITTED") ||statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){
					 if(table.getRowCount()!=0 && table.getRowCount()>0)					 
					 {		
						 if(emptyFlag!=1){	
							 String ans1 = checkPaymentType(saveType);
							 if(ans1.equals("HOLD")){
									 saveOrder("HOLD");
							 }
						 }
						 else if(emptyFlag==1){
							JOptionPane.showMessageDialog(null,"Please Select Item Details","RMS",JOptionPane.INFORMATION_MESSAGE);
						 }
					 }
					else if(table.getRowCount()==0)	
						JOptionPane.showMessageDialog(null,"Please add a row","RMS",JOptionPane.INFORMATION_MESSAGE);					 
				 }
				 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
					 JOptionPane.showMessageDialog(null,"Delivered order cannot be kept on hold","RMS",JOptionPane.INFORMATION_MESSAGE);				 
				 
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
			 else if (source.getSource()==(JButton) paymentButton){
				 boolean flag=false;
				 for(int i=0; i<table.getRowCount(); i++){
					 if(!table.getValueAt(i, 0).equals("") && table.getValueAt(i, 4).equals(""))
						 	flag=true;
					 else 
						 	flag=false;
				 }
				 //if(flag){
					 paymentCombo.requestFocus(true);
					 paymentCombo.setPopupVisible(true);
				 //}
				//else
				//	 	table.changeSelection(table.getRowCount()-1, 0, false, false);
			 
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
		 saveInOrderTable();
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
	 
	 public void saveInOrderTable(){
		 System.out.println("save in order table ");
			double itemRate=0.0f,itemQty=0.0f,totItemPrice=0.0f,itemMRP=0.0f, 
			        minDisAmt=0.0f,totOrderValue=0.0f,
			        totDisValue=0.0f,totMRPValue=0.0f;
			int currentQuantity=0,priceVersion=0;
			
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
			
			 //System.out.println("dic"+otherDiscountValue);
			 //System.out.println("charges"+otherChargesValue);
			 
			 try{
			if(copyOrder.equals("")){
				mo.deleteOrderDetail(orderNo);
				orderType="EDIT";
			}		
			else if(copyOrder.equals("CopyOrder")){
				orderType="CREATE";
			}
			for(int i=0; i< table.getRowCount(); i++){		
				try{
					 String query1="SELECT deal_on_qty,deal_amount from item_master where item_code='"+table.getValueAt(i, 9)+"'";
					 item_code = table.getValueAt(i, 9).toString();
					rs2 = getValstmt1.executeQuery(query1);			
					while(rs2.next()){
						 dealQty =	rs2.getInt(1);
						 minDisAmt = rs2.getFloat(2);
					}
					rs2.close();				
				}catch(Exception e){
					System.out.println("Error in item_code "+e);
				}				
				if(table.getValueAt(i, 1).toString()== "true")  pickup_ind = 1;	
				else pickup_ind = 0;	
				itemRate= Double.parseDouble(table.getValueAt(i, 3).toString());	
				//itemqtystr = table.getValueAt(i, 4).toString();
				itemQty = Double.parseDouble(table.getValueAt(i, 4).toString());
				totItemPrice= Double.parseDouble(table.getValueAt(i, 5).toString());
				itemMRP= Double.parseDouble(table.getValueAt(i, 6).toString());
				minDisAmt= Double.parseDouble(table.getValueAt(i, 7).toString());				
				disRemark = table.getValueAt(i, 8).toString();
				priceVersion = Integer.parseInt(table.getValueAt(i, 10).toString());
//				This Line was uncommented because total item price was coming as zerototItemPrice=(itemQty*itemRate) - minDisAmt;			
				totOrderValue = totOrderValue + totItemPrice;			
				totDisValue = totDisValue + minDisAmt;		
				System.out.println("priceVersion:"+priceVersion);
				if(i>=previousQuantityArray.size())
					mo.addOrderDetail(orderNo, item_code, itemRate, itemQty, totItemPrice, minDisAmt, disRemark, itemMRP, i, pickup_ind,item_returned,priceVersion,siteId);
				else
					mo.updateOrderDetail(orderNo, item_code, itemRate, itemQty, totItemPrice, minDisAmt, disRemark, itemMRP, i, pickup_ind,item_returned,priceVersion,siteId,previousQuantityArray.get(i));
				
				currentQuantity=currentQuantity+(int)itemQty;
			}
			int totalItemsCount = table.getRowCount();	
			
			totMRPValue = Double.parseDouble(totalMrpFld.getText());	
			deliveryRemark=deliverInstruText.getText(); 
			try{
				String query2="SELECT payment_type_code from payment_type where payment_type_desc='"+pay_type+"'";
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
				
				//double caltotalval = Double.parseDouble(totalField.getText()); 
				 double checktotalval = 0.0f;
				 checktotalval =  balanceValue + advanceValue + otherDiscountValue - otherChargesValue;
				 //System.out.println("totOrderValue= "+totOrderValue);
				 //System.out.println("checktotalval= "+checktotalval);
				 //System.out.println("Math.abs(totOrderValue - checktotalval)= "+Math.abs(totOrderValue - checktotalval));
				 
				 if(Math.abs(totOrderValue - checktotalval)>1){
					 String wMessage="Please check the Amounts. There is a difference of:"+(checktotalval-totOrderValue)+".";
					 JOptionPane.showMessageDialog(scrollPane,wMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
					 msgYesNo="1";
					 //System.out.println("in side please check= ");
				 }
				if(msgYesNo.equals("0")){
					if(copyOrder.equals("")){
						mo.updateOrderHistory(orderNo,savingType,currentQuantity);
						mo.deleteOrder(orderNo);
					}
					System.out.println("siteId :"+siteId);
					 mo.addOrders(orderNo, custCode, totalItemsCount, pickValue, totOrderValue, totMRPValue, totDisValue, user, p_code, status,deliveryRemark,orderType,lastOrderdate,copyOrder,order_date,balanceValue,advanceValue,otherDiscountValue,otherChargesValue,siteId);
					 mo.addTransactionDetails(transId,advanceValue,totOrderValue,balanceValue,orderNo);
					 //running = false;
					// saveThread = null;
					// mo.deleteorderec(maxrec);
				}
			}
			 
			 }
			 catch(Exception e){
				 System.out.println("Exception occured in SaveInOrderTable "+e);
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
				table.setValueAt(rs1.getString(1).trim(), table.getSelectedRow(), 0);
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
			}	
		}catch(Exception se){
			System.out.println("Exception Occured while inserting data in table cells"+se);
			se.printStackTrace();
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
				  JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
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
			 JOptionPane.showMessageDialog(null,noItemsMsg,"RMS",JOptionPane.INFORMATION_MESSAGE);
			 return("0");
		 }
	 
		 if(saveType.equals("SAVE")){			 
			 /*				 
			 if(paymentCombo.getSelectedItem().equals("Select Type") || paymentCombo.getSelectedItem().equals("") && table.getRowCount()>0){
				 JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
				 return("0");
			 }	
			 */
			 if(pay_type.equals("Select Type") || pay_type.equals("") && table.getRowCount()>0){
				 JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
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
		 
		 //return("1");
		 return returnVaule;
	 }
	 
	 public String checkadv(){
			try{
				if(!advanceTxt.getText().equals("") )
					 advanceValue=Double.parseDouble(advanceTxt.getText());
				else advanceValue=0.0f;
					 
				if( advanceValue == 0.0){
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
				System.out.println("Exception in checktotalval" +aie);
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
			   String  zeroMessage="Quantity cannot be zero";
			   String  blankMessage="Quantity cannot be blank";			  	 
			   productVal =table.getValueAt(table.getSelectedRow(), 0);
			   quantityVal =table.getValueAt(table.getSelectedRow(), 4);
			   weightVal =table.getValueAt(table.getSelectedRow(), 2);
			   priceVal = table.getValueAt(table.getSelectedRow(), 3);	
			   totalprice = table.getValueAt(table.getSelectedRow(), 5);
			   if(productVal.equals("")){
				   table.changeSelection(table.getSelectedRow(), 0, false, false);
				   return 1;
			   }else if(quantityVal.equals("")){
			       JOptionPane.showMessageDialog(null,blankMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
			       table.changeSelection(table.getSelectedRow(), 4, false, false);
			       return 1;
			   }else if(!quantityVal.equals("") && (quantityVal.equals("0"))){
				   JOptionPane.showMessageDialog(null,zeroMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				   table.changeSelection(table.getSelectedRow(), 4, false, false);
				   return 1;
			   }else if(weightVal.equals("") && priceVal.equals("")){
			       String  wpMessage="Weight and Price cannot be blank";
			       JOptionPane.showMessageDialog(null,wpMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
			       return 1;
			   }else if( weightVal.equals("")){			    
				   String  wMessage="Weight cannot be blank";
				   JOptionPane.showMessageDialog(null,wMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
				   return 1;
			   }else if(priceVal.equals("")){
			       String  pMessage="Price cannot be blank";
			       JOptionPane.showMessageDialog(null,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
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
	     String item_codeStr="",s;
	     String priceVersionStr ="";
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
	    					 splitStr=s.split("\\( W :");
	    					 if(getSelectedIndex()!=-1){
								 JItemName = s;
							 }
	    					 if (!mousePressed)
	    						 editor.setText(splitStr[0].trim());
	    					 else{
	    						 if(s.contains("( ")){
	    							 tempStr=s;
	    							 if(productArray.indexOf(tempStr)!=-1){
	    								 item_codeStr=item_codeArray.get(productArray.indexOf(tempStr)).toString();
	    								 priceVersionStr=priceVersionArray.get(productArray.indexOf(tempStr)).toString();
	    							 }
	    							 if(table.getRowCount()>0){
	    								 setCellValues(item_codeStr,priceVersionStr);
										 // ChangeSelection
										 //table.changeSelection(table.getSelectedRow(), 4, false, false);
	    							 }
	    							 item_codeStr="";
	    							 priceVersionStr ="";
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
							 //if(editor.getText().length()<3){
							 if(editor.getText().length()>1 && !editor.getText().equals("")){	 
								 String selectedTextVal="";
								 String splitVal[]=null;
								 if(!editor.getText().equals("") && getItemCount()>=0){
									 //selectedTextVal=(String)getItemAt(0);
									 selectedTextVal = JItemName;
									 splitVal = selectedTextVal.split("\\( W :");
									 String avaiQty = selectedTextVal.substring(selectedTextVal.indexOf("AvailQty")).trim();	
									 //editor.setText(splitVal[0].trim()+"("+avaiQty.trim());
									 editor.setText(splitVal[0].trim());
									 if(productArray.indexOf(selectedTextVal)!=-1){
										 item_codeStr=item_codeArray.get(productArray.indexOf(selectedTextVal)).toString();
										 priceVersionStr = priceVersionArray.get(productArray.indexOf(selectedTextVal)).toString();
									 }
									 if(table.getRowCount()>0){
										 System.out.println("row count "+table.getRowCount());
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
						 if(!selectedItem.equals("")){
							 splitStrVal = selectedItem.split("\\( W :");
							 String avaiQty = selectedItem.substring(selectedItem.indexOf("AvailQty")).trim();	
							// editor.setText(splitStrVal[0].trim()+"("+avaiQty.trim());
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
	 						setSelected(false);           
	 					}
		 			}         
		 			if(event.getStateChange()==ItemEvent.DESELECTED){
		 				pickUpCnt--;
		 			} 
		 		}
		 	});  
		 }//Consturtor 
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
							 JOptionPane.showMessageDialog(null,"Product cannot be blank","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 0, false, false);
							 break;
						 }else if(table.getValueAt(i, 4).equals("") || !(Double.parseDouble(table.getValueAt(i, 4).toString())>=0.0)){
							 JOptionPane.showMessageDialog(null,"Quantity cannot be blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 4, false, false);
							 break;
						 } 
						 else if((table.getValueAt(i, 5).equals("0.0")) || (table.getValueAt(i, 5).equals("0"))){  
							 String pMessage="Total Price cannot be Zero";
							 JOptionPane.showMessageDialog(scrollPane,pMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(table.getSelectedRow(), 4, false, false);
							 //return 1;
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
						 System.out.println("tab  "+table.getValueAt(table.getSelectedRow(),0));
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
							 
						 }
						 // condition added to check availability 
						 /*
						  *  else if(quantityArray.get(itemNames.indexOf(table.getValueAt(table.getSelectedRow(), 0).toString())) < Integer.parseInt(quantity)){
							 String msg = "Quantity cannnot be greater than available quantity ";
							 JOptionPane.showMessageDialog(scrollPane,msg,"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setText("");
							 setSelectedCol(3);
						 }*/
						 else if(!quantity.equals("") && (Double.parseDouble(quantity)>=0.0) && checkFirstColFlag==false && checkLastRowFlag){
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
					 //System.out.println("In method keyReleased...");
					 if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
							 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 quantityValue = getText();		
						 table.setValueAt(getText(), table.getSelectedRow(), 4);
						 setQuantityTotalPriceMrp(); 
						 setBalance();
					 }        
					 
					 if((ke.getKeyCode()==45) || (ke.getKeyCode()==109)){
						 JOptionPane.showMessageDialog(null,"Negative value in not permitted","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText("");
					 }       
					 if((ke.getKeyCode()==KeyEvent.VK_SPACE)){
						 JOptionPane.showMessageDialog(null,"No blank value allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
						 setText(getText().trim());
					 }       
					 if((ke.getKeyCode()==KeyEvent.VK_ENTER)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_SHIFT)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
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
         public void setQuantityTotalPriceMrp(){
        	 double tempquantity=0.0f;
        	 if(quantityValue.equals("")){
        		 tempquantity=0.0f;
        		 setTotalPrice(Double.toString(tempquantity));
        	 }
        	 setText(quantityValue);
        	 if(!quantityValue.equals("")){
        		 setTotalPrice(quantityValue);
        	 }
        	 setOverallTotal();
         }   
         public void setTotalPrice(String quantityValue){
 			try{
 				double totItemPrice1=0.0f,itemMRP1=0.0f, 
 			        totItemDisAmt1=0.0f,minDisAmt1=0.0f,totOrderValue1=0.0f,
 			        totDisValue1=0.0f,totMRPValue1=0.0f;
 				double tempquantityValue=Double.parseDouble(quantityValue);
 				int totDisTimes1=0;
 				try{
 					  String query1="SELECT item_mrp, deal_amount, deal_on_qty from item_master where item_code='"+(String)table.getValueAt(table.getSelectedRow(), 9)+"'";			
 					  rs2 = getValstmt1.executeQuery(query1);			
 					while(rs2.next()){
 						itemMRP1 = rs2.getFloat(1);
 						minDisAmt1 = rs2.getInt(2);
 						 dealQty =	rs2.getInt(3);
 					}
 					rs2.close();				
 				}catch(Exception e){
 					System.out.println("Error in item_code "+e);
 				} 				
 				if (dealQty >0){
 					totDisTimes1 = (int)(Integer.parseInt(quantityValue) / dealQty);
 				}
 				if(totDisTimes1 >= 1) totItemDisAmt1 = minDisAmt1 * totDisTimes1;
 				else totItemDisAmt1=0;	
 				if(totItemDisAmt1>0)
 				{
 					disRemark=totItemDisAmt1+ "(@Rs " +  minDisAmt1 +	" per " + dealQty + " QTYs)";
 				}
 				totOrderValue1 = totOrderValue1 + totItemPrice1;
 				
 				totDisValue1 = totDisValue1 + totItemDisAmt1;
 				
 				totMRPValue1 = (Double.parseDouble(quantityValue)*itemMRP1);
 				String priceValueStr="",priceMessage="Price is Blank";;
 				double quantityVal=0.0f;
 				double priceValue=0.0f, totalRate=0.0f;
 				priceValueStr = table.getValueAt(table.getSelectedRow(), 3).toString();
 				if(priceValueStr.equals("")){
 					JOptionPane.showMessageDialog(null,priceMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
 				}else	priceValue = Double.parseDouble(priceValueStr);
 				if(!getText().equals("")){
 					quantityVal = Double.parseDouble(quantityValue); 								
 					totalRate = (quantityVal * priceValue) - totItemDisAmt1;
 					table.setValueAt(Double.toString(totalRate), table.getSelectedRow(), 5);
// 					Set only MRP Price in MRP column	//			  //table.setValueAt(Double.toString(totMRPValue1), table.getSelectedRow(), 6);
					table.setValueAt(table.getValueAt(table.getSelectedRow(), 6), table.getSelectedRow(), 6);
 					table.setValueAt(Double.toString(totItemDisAmt1), table.getSelectedRow(), 7);
 					
 				}else if(getText().equals("")){
 					totalRate = 0.0f;
 					table.setValueAt(totalRate, table.getSelectedRow(), 5);
 				}
 			}catch(NumberFormatException nfe){
 				nfe.printStackTrace();
 				System.out.println("Exception Occured in setTotalPrice"+nfe);
 			}	
 			catch(StackOverflowError soe){
 				System.out.println("Error Occured in setTotalPrice"+soe);
 			}
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
							 if(statusCode.equals("SUBMITTED") || statusCode.equals("HOLD") || copyOrder.equals("CopyOrder")){							
								 addRow();
								 table.setValueAt("",table.getSelectedRow(), 4);
							 }
							 else if(statusCode.equals("DELIVERED") || statusCode.equals("TRANSIT") || statusCode.equals("CHECKED") || statusCode.equals("CLOSED"))
								 JOptionPane.showMessageDialog(null,"Delivered order cannot be edited","RMS",JOptionPane.INFORMATION_MESSAGE);							 
						 }       
					 } //EOF TAB  
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_N)){
						 table.changeSelection(table.getSelectedRow(), 8, false, false);
					 }      
				 } //EOF Pressed
     
				 public void keyReleased(KeyEvent ke){ }// EOF keyReleased()  
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
				  else if(!table.getValueAt(i, 6).equals("") || Double.parseDouble(table.getValueAt(i, 6).toString())>0)
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
			//  savCost = (totalmrpCost - totalCost);
			  savCost = (totMRPValue - totalCost); 

			  str = Double.toString(totalCost);
			  totalField.setText(str.toString());
			  totalField.setForeground(Color.blue);
			  //str1 = Double.toString(totalmrpCost);
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

} // EOF Class    	

 
 
 
 
 