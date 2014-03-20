/**
 * @author: Anup Bansode 
 *  
*/
  
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
import java.util.EventObject;
import java.util.Vector;
import netscape.javascript.JSObject; 
import netscape.javascript.JSException;
import java.text.DecimalFormat;
import java.awt.Font;
 

 
public class EditCustomerOrderApplet extends JApplet implements ActionListener, TableModelListener{
	 
	 TextFieldEditor tf;
	 JSObject win;
	 JTable table;
	 Vector rows;
	 Vector <String> columns;
	 DefaultTableModel tabModel;
	 JScrollPane scrollPane;
	 JButton addButton,deleteButton,saveButton,cancelButton,clearButton,viewButton;
	 JCheckBox checkBox;
	 RemarkColEditor remarkEditor;
	 JComboBox paymentCombo,tempCombo; 
	 JLabel totalPrice,totalField,totalMrp,pickUp,deliver,paymentLbl,savingLbl,
	     totalItemFld,pickUpFld,deliverFld,totalMrpFld,savingFld,emptyFld,emptyFld1,customerName,custPhone,oDate,cstCode,cstName,cstphone,
	     cstdate,orderDetails,custEmpty,totalItemsLbl,customerCode;
	 JPanel tablePanel,innerbuttonPanel,buttonPanel,mainPanel,labelPanel1,labelPanel2,
	     labelPanel3,labelPanel4,emptyPanel,emptyPanel1,wholeLabelPanel,custPanel,
	     custPanel1,custPanel2,custPanel3;
	 JTextComponent editor;
	 Connection con=null;
	 ResultSet rs,rs1,rs2,rs3,rs4,rsFetch,rsForItemName; 
	 Statement getValstmt,getItemstmt,getValstmt1,getValstmt2,stmt,getFetchStmt; 
	 String dburl="", dbusername="", dbpassword="";
	 String productValue,setProdName="", item_code="", pay_type="", p_code="", status="";
	 String user="",disRemark="",quantityValue="",blankString="",weightString="",
	     rateString="",blank=" ",blankValue="  ",blankVar="   ",blankValue3="   ";
	 String[] prodValResult;;
	 long pickup_ind=0;
	 Object objTemp=null;
	 Vector <String> productArray = new Vector<String> (); 
	 Vector <String> item_codeArray = new Vector<String> (); 
	 int itemCount = 0,pickValue=0, deliverCount = 0,setQuantityFlag=0,checkboxFlag,pickUpCnt=0,orderNo=0,i,addedRow=0,checkQuantityVal,columnCount=7;
	 double item_mrp=0.00f;
	 
	 ManageOrderFile mo;
	 
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
	 String phone="";
	 String codeValue="";
	 String categoryCode="";  
	 String p_type="";
	 boolean mousePressed = true;
	 
	 public void init(){
		  try{
			  dburl = getParameter("dburl");
			  dbusername = getParameter("dbusername");
			  dbpassword = getParameter("dbpassword");	 
			  orderNo = Integer.parseInt(getParameter("orderNo"));
			  //orderNo = 31;
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
			   Class.forName("com.mysql.jdbc.Driver");
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
		  String[] columnNames = { "Item","Check", "Weight","Price","Quantity","Total Price","MRP","Discount","Remark","ItemCode"};
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
		  itemCodeColumn.setMaxWidth(0); 
		  itemCodeColumn.setMinWidth(0); 
		  table.getTableHeader().getColumnModel().getColumn(9).setMaxWidth(0); 
		  table.getTableHeader().getColumnModel().getColumn(9).setMinWidth(0);
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
		  return t;
	 }
   
	 public void deleteRow(int index){
	    try{
		    int previousRow=-1;  
		    if(index!=-1 ){ 
			     tabModel.removeRow(table.getSelectedRow());			 
			     previousRow=(index-1); 
			     if (previousRow >= 0){
			    	 table.setEditingRow(previousRow);
			    	 table.changeSelection(previousRow, 0, false, false);
			     }
			     table.requestFocusInWindow();
			     if (previousRow >= 0)
			      cme.editor.setText(table.getValueAt(previousRow, 0).toString());
			     table.addNotify();
				 if(itemCount>0 && table.getSelectedRow()!=-1 ){
				       itemCount--;  
				       deliverCount= itemCount-pickValue;
				       totalItemFld.setText(Integer.toString(itemCount));
				       deliverFld.setText(Integer.toString(deliverCount));
				  } 
				 setOverallTotal();
		    }   
	    }catch(ArrayIndexOutOfBoundsException aie){
	    	System.out.println("In DeleteRow "+aie);
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
              if(column ==0 || column ==4 || column ==1 || column ==8)
               return true;
              else
               return false;
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
		  viewButton = new JButton("View Selected Products");
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
		  totalPrice = new JLabel("Total Price :");
		  totalField = new JLabel("0");
		  totalField.setForeground(Color.BLUE);
		  totalMrp = new JLabel("Total MRP  :");
		  totalMrpFld =  new JLabel();    
		  savingLbl =  new JLabel("saving         :");
		  savingFld =  new JLabel();
		  
		  customerCode=new JLabel("Customer Code :");
		  cstCode=new JLabel();
		  customerName=new JLabel("Customer Name :");
		  cstName=new JLabel();
		  custPhone=new JLabel("Phone :");
		  cstphone=new JLabel();
		  oDate=new JLabel("Date :");
		  cstdate=new JLabel();  
		  orderDetails=new JLabel("Order Details");
		  custEmpty=new JLabel("");
		  
		  custPanel1.add(customerCode);
		  custPanel1.add(cstCode);
		  custPanel1.add(customerName);
		  custPanel1.add(cstName);
		  custPanel1.add(custPhone);
		  custPanel1.add(cstphone);
		  custPanel1.add(oDate);
		  custPanel1.add(cstdate); 	  
		  custPanel2.add(orderDetails);//2nd cust Panel	  
		  custPanel.add(custPanel1);	 
		  custPanel.add(custPanel2); 
		  labelPanel1.add(totalItemsLbl);
		  labelPanel1.add(totalItemFld);
	      labelPanel1.add(pickUp);
	      labelPanel1.add(pickUpFld);
	      labelPanel1.add(deliver);
	      labelPanel1.add(deliverFld);     
		  emptyPanel.add(emptyFld); 	     
		  labelPanel2.add(paymentLbl);	  
		  labelPanel3.add(paymentCombo);	  
		  emptyPanel1.add(emptyFld1); 	  
		  labelPanel4.add(totalPrice);
	      labelPanel4.add(totalField);
	      labelPanel4.add(totalMrp);
	      labelPanel4.add(totalMrpFld);
	      labelPanel4.add(savingLbl);
	      labelPanel4.add(savingFld);
		     
	      wholeLabelPanel.add(labelPanel1);
	      wholeLabelPanel.add(emptyPanel);
	      wholeLabelPanel.add(labelPanel2);
	      wholeLabelPanel.add(labelPanel3);
	      wholeLabelPanel.add(emptyPanel1);
	      wholeLabelPanel.add(labelPanel4); 
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
			   String query="SELECT item_name,item_weight, item_rate, item_mrp,item_code from item_master order by item_name";
			   rs = getValstmt.executeQuery(query); 
			   while(rs.next()){ 				   
				     productArray.add(rs.getString(1)+blank+" (  W : "+blank+rs.getString(2)+blank+" , "+" R : "+rs.getString(3)+" , "+" M : "+rs.getString(4)+" ) ");
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
			   String fetcQuery="select DATE_FORMAT(a.order_date,'%d/%m/%y %r'), a.total_items, a.total_value, " +
			        "a.total_value_mrp, a.enterd_by,a.total_value_discount,a.total_taken, " + 
			        "b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark, b.item_taken,e.payment_type_desc, " + 
			        "d.item_code,d.item_name, d.item_weight, " +
			        "c.custcode,c.custname,c.building,c.block,c.wing,c.add1,c.add2,c.phone " +
			        "from orders a, order_detail b, customer_master c, item_master d ,payment_type e " +
			        "where a.order_num = b.order_num " +
			        "and a.custcode = c.custcode " +
			        "and b.item_code = d.item_code " +
			        "and a.payment_type_code = e.payment_type_code "+
			        "and a.order_num = '" + orderNo + "' "+
			        "order by b.entry_no";   
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
				   
				    addRow();
				    table.setValueAt("",table.getSelectedRow(), 4);
				    table.setValueAt(itemName, addedRow, 0);
				    if(item_taken==1){
				    	table.setValueAt(new Boolean(true), addedRow, 1);
				    }
				    else{
				    	table.setValueAt(new Boolean(false), addedRow, 1);
				    }			   
				    table.setValueAt(itemWeight, addedRow, 2);
				    table.setValueAt(Double.toString(itemRate), addedRow, 3);
				    table.setValueAt(Double.toString(itemQty), addedRow, 4);
				    table.setValueAt(Double.toString(itemTotPrice), addedRow, 5);
				    table.setValueAt(Double.toString(itemMRP), addedRow, 6);
				    table.setValueAt(Double.toString(itemTotDis), addedRow, 7);				   
				    table.setValueAt(disRemark, addedRow, 8);
				    table.setValueAt(itemCode, addedRow, 9);
				    paymentCombo.setSelectedItem(p_type);
				    addedRow++;	  
			   }			   
			   setOverallTotal();
			   cstCode.setText(custCode+"  ");
			   cstName.setText(custName+"  ");
			   cstphone.setText(phone+"  ");
			   cstdate.setText(orderDate+"  ");
			   cstCode.setForeground(Color.blue);
			   cstName.setForeground(Color.blue);
			   cstphone.setForeground(Color.blue);
			   cstdate.setForeground(Color.blue);
			   cstCode.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstName.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstphone.setFont(new Font("Arial", Font.PLAIN, 12));
			   cstdate.setFont(new Font("Arial", Font.PLAIN, 12));
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
			   
			   savingFld.setText(Double.toString((totalValueMRP-totalValue)));
			   savingFld.setForeground(Color.blue);
			   DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
			   renderer.setToolTipText("Click the Product to see a list of choices");
			   productColumn.setCellRenderer(renderer);
		}catch(ArrayIndexOutOfBoundsException aie){
			   System.out.println("ArrayIndexOutOfBoundsException in fetchOrderValues"+aie);
		}catch(SQLException se){
	    	System.out.println("SQLException in fetchOrderValues"+se);
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
			 if (source.getSource()==(JButton) addButton){
				  addRow();
				  table.setValueAt("", table.getSelectedRow(), 4);
			 }else if (source.getSource()==(JButton) deleteButton){
				  deleteRow(table.getSelectedRow());
				  				   
			}else if (source.getSource()==(JButton) saveButton){
				 String ans1 = checkPaymentType();
				 if(ans1.equals("1")){
					 String ans = checkDuplicateProduct();
					 if(ans.equals("1")){  
						 checkBlankProduct();
						 saveOrder();
					 }
				 }	
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
	 
	public void saveOrder(){
		status = mo.getStatus("SUBMITTED");			
		saveInOrderTable();			
		clearAll();				
 		 try{  
 		       win = JSObject.getWindow(this);
 		      win.call("showMsgSend",null);
 		            win.eval("document.myform.submit()");
 		 }catch(JSException e){
 		      String error="Not get Win Object";
 		     System.out.println(error);
 		 }		 	
	}
	 
	 public void saveInOrderTable(){
			double itemRate=0.0f,itemQty=0.0f,totItemPrice=0.0f,itemMRP=0.0f, 
			        minDisAmt=0.0f,totOrderValue=0.0f,
			        totDisValue=0.0f,totMRPValue=0.0f;
			String itemqtystr="";
			mo.deleteOrderDetail(orderNo);			    
			for(int i=0; i< table.getRowCount(); i++){				
				try{
					 String query1="SELECT deal_on_qty from item_master where item_code='"+table.getValueAt(i, 9)+"'";
					 item_code = table.getValueAt(i, 9).toString();
					rs2 = getValstmt1.executeQuery(query1);			
					while(rs2.next()){
						 dealQty =	rs2.getInt(1);
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
				minDisAmt= Double.parseDouble((String)table.getValueAt(i, 7));	
				disRemark = (String)table.getValueAt(i, 8);					        			
						
				totItemPrice=(itemQty*itemRate) - minDisAmt;			
				totOrderValue = totOrderValue + totItemPrice;			
				totDisValue = totDisValue + minDisAmt;				
				mo.addOrderDetail(orderNo, item_code, itemRate, itemQty, totItemPrice, minDisAmt, disRemark, itemMRP, i, pickup_ind);	
			}
			int totalItemsCount = table.getRowCount();	
			
			totMRPValue = Double.parseDouble(totalMrpFld.getText());	
			
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
			mo.deleteOrder(orderNo);
			mo.addOrders(orderNo, custCode, totalItemsCount, pickValue, totOrderValue, totMRPValue, totDisValue, user, p_code, status);
	}
		
	public void clearAll(){	
		for(int i=table.getRowCount()-1; i>-1; i--){
			try{					
					rows.removeElementAt(i);
					table.addNotify();
				
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

	public void setCellValues(String item_codeStr){		
		try{	
			
			String insertIntoCellQuery = "SELECT item_name,item_weight,item_rate,item_mrp, deal_active_flag, deal_on_qty, deal_amount FROM item_master where item_code='"+item_codeStr+"'";
			rs1 = getItemstmt.executeQuery(insertIntoCellQuery);
			if(rs1.next()){
				selectCell(table.getSelectedRow(),table.getSelectedColumn());
				table.setValueAt(rs1.getString(1), table.getSelectedRow(), 0);				
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

				String message = "Duplicate entry for:";
				int rowCount = table.getRowCount(),flagCount=0;
				String prodStr1="",prodStr2="",matchString="",weightStr1="",weightStr2="";
				for(int row = 0; row < rowCount; row++){
					prodStr1 = (String)table.getValueAt(row, 0);
					weightStr1=(String)table.getValueAt(row, 2);
					if(flagCount>0){					
						message = message+matchString;
						JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
						table.changeSelection(row-1, 0, false, false);
						return("0"); 						
					}
					for(int j = 0;  j< table.getRowCount(); j++){
						if(row!=j){
							prodStr2 = (String)table.getValueAt(j, 0);
							weightStr2=(String)table.getValueAt(j, 2);
							if(prodStr1.equalsIgnoreCase(prodStr2) && weightStr1.equalsIgnoreCase(weightStr2)){
								flagCount++;
								matchString = prodStr1 + "&" +weightStr1;	
								//message = message+matchString;
								//JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);								
								//return("0");  
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

	 public String checkPaymentType(){
		 String returnVaule="";
		 String message = "Please select payment term";
		 String noItemsMsg = "No items Selected";
		 pay_type = (String)paymentCombo.getSelectedItem();
		 if(paymentCombo.getSelectedItem() == "Select Type" && table.getRowCount()>0){
			 JOptionPane.showMessageDialog(null,message,"RMS",JOptionPane.INFORMATION_MESSAGE);
			 return("0");
		 }
		else if(pay_type.equals("Credit") || pay_type.equals("Cash") || pay_type.equals("Hawala")){
			returnVaule="1";
		}
		 if(table.getRowCount()==0){
			 JOptionPane.showMessageDialog(null,noItemsMsg,"RMS",JOptionPane.INFORMATION_MESSAGE);
			 return("0");
		 }	
		 //return("1");
		 return returnVaule;
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
			   Object productVal,quantityVal,weightVal,priceVal=null;			     
			   String  zeroMessage="Quantity cannot be zero";
			   String  blankMessage="Quantity cannot be blank";			  	 
			   productVal =table.getValueAt(table.getSelectedRow(), 0);
			   quantityVal =table.getValueAt(table.getSelectedRow(), 4);
			   weightVal =table.getValueAt(table.getSelectedRow(), 2);
			   priceVal = table.getValueAt(table.getSelectedRow(), 3);			  
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
										 // ChangeSelection
										 //table.changeSelection(table.getSelectedRow(), 4, false, false);
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
	        		 if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)){
	        			 JOptionPane.showMessageDialog(null,"Numeric digits are not allowed","RMS",JOptionPane.INFORMATION_MESSAGE);
	        			 editor.setText("");
	        		 }	            
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
	            				}
	            				else if(editor.getText().equals("")){
	            					for(int i=0; i<table.getColumnCount(); i++){
	            						if(i==1){
	            							table.setValueAt(new Boolean(false), table.getSelectedRow(), i);
	            						}
	            						else
	            							table.setValueAt("", table.getSelectedRow(), i);
	            					}
	            				}
	            			}
	            			else{
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
	        			}
	        			catch(ArrayIndexOutOfBoundsException aie){
	        				System.out.println("Exception when item entered"+aie);
	        				aie.printStackTrace();
	        			}
	        		}
		            
		            if(!(ke.getKeyCode()==KeyEvent.VK_DOWN) && !(ke.getKeyCode()==KeyEvent.VK_UP)
		            		&& !(ke.getKeyCode()==KeyEvent.VK_LEFT) && !(ke.getKeyCode()==KeyEvent.VK_RIGHT)
		            		&& !(ke.getKeyCode()==KeyEvent.VK_ENTER) && !(ke.getKeyCode()==KeyEvent.VK_TAB)
		            		&& !(ke.getKeyCode()==KeyEvent.VK_SHIFT) && !(ke.getKeyCode()==KeyEvent.VK_HOME)
		            		&& !(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) && !(ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)) {
		            	try{            
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
		            }	  
		            if((ke.getKeyCode()==KeyEvent.VK_DOWN) || (ke.getKeyCode()==KeyEvent.VK_UP)||
		            		(ke.getKeyCode()==KeyEvent.VK_PAGE_UP) || (ke.getKeyCode()==KeyEvent.VK_PAGE_DOWN)){
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
						 }else if(table.getValueAt(i, 4).equals("") || !(Double.parseDouble(table.getValueAt(i, 4).toString())>=1)){
							 JOptionPane.showMessageDialog(null,"Quantity cannot be blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(i, 4, false, false);
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
						 else if(getText().startsWith("0.")){
							 JOptionPane.showMessageDialog(null,"Quantity is less than 1","RMS",JOptionPane.INFORMATION_MESSAGE);
							 setText("");
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !quantity.equals("0")  && checkFirstColFlag==true){
							 JOptionPane.showMessageDialog(null,"Product Name is blank at row "+(productColBlank+1),"RMS",JOptionPane.INFORMATION_MESSAGE);
							 setSelectedCol(3);
						 }else if(!quantity.equals("") && !(Double.parseDouble(quantity)>=1) && checkFirstColFlag==false && checkLastRowFlag==false){
							 JOptionPane.showMessageDialog(null,"Next Row can only be added from last row","RMS",JOptionPane.INFORMATION_MESSAGE);
							 table.changeSelection(rowCount-1, 0, false, false);
						 }else if(!quantity.equals("") && (Double.parseDouble(quantity)>=1) && checkFirstColFlag==false && checkLastRowFlag){               
							 addRow();
							 table.setValueAt("",table.getSelectedRow(), 4);
						 }               
					 } //EOF TAB  
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_N)){
						 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 }
					 if((ke.getKeyCode()==KeyEvent.VK_ALT || ke.getKeyCode()==KeyEvent.VK_D)){
						 table.changeSelection(table.getSelectedRow(), 0, false, false);
					 }       
				 } 
      
				 public void keyReleased(KeyEvent ke){ 
					 if((ke.getKeyCode()>=96) && (ke.getKeyCode()<=105) || (ke.getKeyCode()>=48) && (ke.getKeyCode()<=57)||
							 ke.getKeyCode()==KeyEvent.VK_BACK_SPACE || ke.getKeyCode()==KeyEvent.VK_DELETE ){
						 quantityValue = getText();						 
						 table.setValueAt(getText(), table.getSelectedRow(), 4);        
						 setQuantityTotalPriceMrp();      
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
 				priceValueStr = (String)table.getValueAt(table.getSelectedRow(), 3);
 				if(priceValueStr.equals("")){
 					JOptionPane.showMessageDialog(null,priceMessage,"RMS",JOptionPane.INFORMATION_MESSAGE);
 				}else	priceValue = Double.parseDouble(priceValueStr);
 				if(!getText().equals("")){
 					quantityVal = Double.parseDouble(quantityValue); 								
 					totalRate = (quantityVal * priceValue) - totItemDisAmt1;
 					table.setValueAt(Double.toString(totalRate), table.getSelectedRow(), 5);
 					table.setValueAt(Double.toString(totMRPValue1), table.getSelectedRow(), 6);
 					table.setValueAt(Double.toString(totItemDisAmt1), table.getSelectedRow(), 7);
 					
 				}else if(getText().equals("")){
 					totalRate = 0.0f;
 					table.setValueAt(Double.toString(totalRate), table.getSelectedRow(), 5);
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
					 return flag;
				 }else if(table.getValueAt(r, 4).equals("") || table.getValueAt(r, 4).equals("0") || table.getValueAt(r, 4).toString().startsWith("0.")){ 
					 flag=true;        
					 JOptionPane.showMessageDialog(null,"Quantity is blank or zero","RMS",JOptionPane.INFORMATION_MESSAGE);
					 table.changeSelection(table.getSelectedRow(), 4, false, false);
					 return flag;
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
							 addRow();       
							 table.setValueAt("",table.getSelectedRow(), 4);
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
			double totalCost = 0.0f, totalmrpCost = 0.0f, savCost= 0.0f, totDiscountCost1=0.0f;
			Object str = null, str1=null,sav=null,total,itemMrp,itemDiscountAmt;
			for(int i=0; i<rowCount; i++){
				total =(table.getValueAt(i, 5));
				itemMrp =(table.getValueAt(i, 6));
				itemDiscountAmt =(table.getValueAt(i, 7));
				if(total!=""){
					double totalValue = Double.parseDouble(total.toString());
					totalCost += totalValue;
				} 
				if(itemMrp!=""){
					double totalmrpValue = Double.parseDouble(itemMrp.toString());
					totalmrpCost += totalmrpValue;
				} 
				if(itemDiscountAmt!=""){
					double totalDisValue = Double.parseDouble(itemDiscountAmt.toString());
					totDiscountCost1 += totalDisValue;
				} 
			}			
			savCost = (totalmrpCost - totalCost);			
			str = Double.toString(totalCost);
			totalField.setText(str.toString());
			totalField.setForeground(Color.blue);
			str1 = Double.toString(totalmrpCost);
			totalMrpFld.setText(str1.toString());
			totalMrpFld.setForeground(Color.blue);
			sav = Double.toString(savCost);
			savingFld.setText(sav.toString());
			savingFld.setForeground(Color.blue);			
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
			JPanel winTablePanel,winButtonPanel,winMainPanel;
		  
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
					winMainPanel.setLayout(new BorderLayout());
					winMainPanel.add("Center",winscrollPane);
					winMainPanel.add("South",winButtonPanel);
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
	
}    	

 
 
 
 
 