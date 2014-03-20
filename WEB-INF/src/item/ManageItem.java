package item;

import java.sql.*;
import java.util.ArrayList;
import java.util.Stack;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import beans.ItemBean;
import beans.ItemStockOutputBean;
import beans.JasonObject;
import beans.JsonOutputBean;

public class ManageItem {
	
	public Connection conn=null;
	public Statement  stat,stmt;
	public ResultSet rs,rss;
	public String query;
	String envLookup;
	public ManageItem(String envLook){
		envLookup = envLook;
		initialize(envLookup);
	}
	public void  initialize(String env){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(env);
			conn = ds.getConnection();
			System.out.println("connected succesfully ........");
			stat=conn.createStatement();
			stmt = conn.createStatement();
		}catch (Exception e){
			System.out.println("Error occurred in Database Connection " + e);			
		}
			
	}
	
	public void closeAll(){
		try{
			stat.close();
	    	conn.close();
	   
		}
		catch(Exception e)
		{
	        e.getMessage();
			e.printStackTrace();
	    }	
	}
	
	public int CheckItem(String ig_code,String i_name,String item_weight){
		try{
			
			//item_weight.rep
			query="select item_group_code,item_name from item_master where item_group_code='"+ig_code+"' and item_name='"+i_name+"' and lower(replace(item_weight,' ','')) =lower(replace('"+item_weight+"',' ',''))";
			
			System.out.println(query);
	    	rs = stat.executeQuery(query);	    	
	    	while(rs.next()) {
	    		System.out.println("record exist ");
	    		return(1);
	    	}
	    	System.out.println("record not exist ");
	    	return(2);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add item entry in Database " + e);
			closeAll();
			return(0);
		}	    		
	}
	
	public int addItem(String ig_code,String i_name,String i_barcode,String i_weight,float i_mrp,String id_type,String id_flag,float id_qty,float id_amt,float i_rate, float i_comm,int siteId,int box_qty,String item_type){
		try{
			String get1="",code="";
			int nextCode=0;
			code.ManageCode c;
			c = new code.ManageCode(envLookup);
			get1 = c.getCodeValue("ItemCodeStart"); 
			System.out.println("Code Value "+get1);
			code = c.getCodeValue("NextItemCode");
			System.out.println("Next Item Code : "+get1+"  "+code);
			nextCode=Integer.parseInt(code);
			get1=get1+nextCode;	
			nextCode= nextCode + 1;
			System.out.println("From db : "+get1+"  "+code);
			if(item_type.equals("mixItem")){
				System.out.println("item type  "+item_type);
				query="insert into item_master (item_code,item_group_code,item_name,item_weight,item_mrp,upd_datetime,deal_type,deal_active_flag,deal_on_qty,deal_amount,item_rate,comm_amt,barcode,box_qty,is_bachka,mix_item)values('"+get1+"','"+ig_code+"','"+i_name+"','"+i_weight+"',"+i_mrp+",sysdate(),'"+id_type+"','"+id_flag+"',"+id_qty+","+id_amt+","+i_rate+","+i_comm+",'"+i_barcode+"',"+box_qty+",'false','true')";
			}
			else
			{	
				System.out.println("item type  "+item_type);
				query="insert into item_master (item_code,item_group_code,item_name,item_weight,item_mrp,upd_datetime,deal_type,deal_active_flag,deal_on_qty,deal_amount,item_rate,comm_amt,barcode,box_qty,is_bachka,mix_item)values('"+get1+"','"+ig_code+"','"+i_name+"','"+i_weight+"',"+i_mrp+",sysdate(),'"+id_type+"','"+id_flag+"',"+id_qty+","+id_amt+","+i_rate+","+i_comm+",'"+i_barcode+"',"+box_qty+",'"+item_type+"','false')";
			} 
			System.out.println(query);
	    	int run_sql= stat.executeUpdate(query);
	    	
	    	
	    	
	    	if(run_sql==1){
	    		 c.editCodeValue(nextCode,"NextItemCode");
	    		 c.closeAll();
	    		 
				 
	    		 String query1 = "insert into item_price(item_code, price_version, item_mrp, item_rate, item_pv_qty)" +
						" values ('"+get1+"',1,'"+i_mrp+"','"+i_rate+"',0)";
				System.out.println("Updating ItemPrice Table : "+query1);
				int ans = stat.executeUpdate(query1);
				 //query1="delete FROM item_price where item_code ='"+get1+"' and item_pv_qty = 1";
				 
				// stat.execute(query1);
				
				
				if(ans == 1){
					query="SELECT distinct site_id FROM site_master";
					rs= stat.executeQuery(query);
					int site_id = 0;
					//query="delete FROM item_site_inventory where item_code = '"+get1+"'";
					//stmt.execute(query);
					while(rs.next()){
						site_id = rs.getInt(1);
						System.out.println("site id : "+site_id);
						
						query=	"insert into item_site_inventory(item_code, price_version, site_id, item_site_qty)" +
								" values ('"+get1+"',1,"+site_id+",0)";
						System.out.println(query);
						stmt.executeUpdate(query);
					}
				}
	    	}		    	
	    	return(run_sql);
		}
		catch(Exception e){
			System.out.println("Error occurred in add item entry in Database " + e);
			closeAll();
			return(0);
		}	    		
	}
	
	public int editItem(ItemBean ib){
		try{
			
			//String update = "update ";
			//System.out.println("before if   :: ib.getItem_type() "+ib.getItem_type());
			if(ib.getItem_type().equals("mixItem")){
			
				System.out.println("call editItem1('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','false','true')");
				//stat.executeQuery("call editItem1('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','"+ ib.getItem_type()+"','true')");
				stat.executeQuery("call editItem1('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','false','true')");
				
			}
			else{
				
				System.out.println("call editItem1('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','"+ ib.getItem_type()+"','false')");
				stat.executeQuery("call editItem1('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','"+ ib.getItem_type()+"','false')");
				//stat.executeQuery("call editItem('"+ib.getI_mrp()+"','"+ib.getI_rate()+"','"+ib.getId_qty()+"','"+ib.getId_amt()+"','"+ib.getI_comm()+"','"+ib.getIg_code()+"','"+ib.getI_name()+"','"+ib.getI_barcode()+"','"+ib.getI_weight()+"','"+ib.getId_flag()+"','"+ib.getId_type()+"','"+ib.getId_chck()+"','"+ib.getBox_qty()+"','"+ib.getI_code()+"','"+ib.getI_tickflag()+"','"+ib.getRemark()+"','"+ ib.getItem_type()+"')");
			}
			
			System.out.println("edited successfully ...");
			
			return 1;
		}
		catch(Exception e){
			System.out.println("Error occurred in add item entry in Database " + e);
			closeAll();
			return 0;
		}	    		
	}	
   
	public void listItem(String i_code,String ig_code,String i_name,String i_mrp,String i_mrp2,String i_rate,String i_rate2, String i_tickflg,String ibarcode, int site_id){

		System.out.println("in list item methhod 1111 ...");
		try{
			
			String query="";
	    	/*query="select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
					" i.item_weight, ip.item_mrp, ip.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
					" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount,i.comm_amt, i.ticker_flag,i.barcode,i.box_qty " +
	    			" from item_group i1, item_site_inventory isi, item_price ip, item_master i" +
	    			" left join item_history i2 on i.item_code = i2.item_code"+
	    	        " where i.item_group_code=i1.item_group_code";
	    	*/
	    	query="select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
					" i.item_weight, ip.item_mrp, ip.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
					" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount,i.comm_amt, i.ticker_flag,i.barcode,i.box_qty,i.is_bachka,i.mix_item " +
	    			" from item_group i1, item_site_inventory isi, item_price ip, item_master i" +
	    			" left join item_history i2 on i.item_code = i2.item_code"+
	    	        " where i.item_group_code=i1.item_group_code ";
	    	
	    	
	    	
	    	if(!i_code.equals("")){
	    	    query = query + " and i.item_code like'" + i_code + "%'";
	    	}
	    	
	    	if(!i_mrp.equals("") && !i_mrp2.equals("")){
	    	    query = query + " and i.item_mrp between '" + i_mrp + "%' and '" + i_mrp2 + "%'";
	    	}
	    	else if(!i_mrp.equals("")){
	    		query = query + " and i.item_mrp like'" + i_mrp + "%'";
	    	} 
	    	   		
	    	if(!i_rate.equals("") && !i_rate2.equals("")){
	    		query = query + " and i.item_rate  between '" + i_rate + "%' and '" + i_rate2 + "%'";
	    	}
	    	else if(!i_rate.equals("")){
	    		query = query + " and i.item_rate like'" + i_rate + "%'";
	    	} 
	    	   	
	    	if(!i_name.equals("")){
	    		query = query + " and i.item_name like'" + i_name + "%'";
	    	}
	    	    	
	    	if(!ig_code.equals("")){
	    		query = query + " and i1.item_group_desc like'" + ig_code + "%'";
	    	} 
	    	if(!i_tickflg.equals("")){
	    		query = query + " and i.ticker_flag ='" + i_tickflg + "'";
	    	} 
	    	
	    	if(!ibarcode.equals("")){
	    		query = query + " and i.barcode like '" + ibarcode + "%'";
	    	} 
	    	if(site_id!=0){
	    		query = query+" and isi.site_id= "+site_id;
	    	}
	    	
	    	/*query =query + "and i.item_code = ip.item_code and ip.item_code = isi.item_code " +
	    			" and isi.site_id = "+site_id+" and ip.current_flag='Y' " +
	    			" order by i.item_name";*/
	    	
	    	query =query + " and i.item_code = ip.item_code and ip.item_code = isi.item_code " +
	    			" and ip.current_flag='Y' " +
	    			" order by i.item_name  ";
	    	System.out.println("itemListQuery  "+query);
	    	rs=stat.executeQuery(query);
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in customer list " + e);
			closeAll();			
		}
	}

	
    public void listItems(){
		try{
			String query="";
	    	query="select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
					" i.item_weight, i.item_mrp, i.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
					" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount,i.comm_amt" +
	    			" from  item_group i1,item_master i" +
	    			" left join item_history i2 on i.item_code = i2.item_code"+
	    	         " where i.item_group_code=i1.item_group_code" +
	    	         " order by i.item_name ";   
	    	System.out.println("list all items all "+query);
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in customer list " + e);
			closeAll();			
		}
	}

	public int addItemGroup(String ig_desc,int fmcg_flag, int ig_number){
		try{
			int ret_val=0;
			query="select item_group_desc from item_group where item_group_desc='"+ig_desc+"'";
			ResultSet rs = stat.executeQuery(query);
	    	if(rs.next()){
				return(ret_val);			
			}
	    	else{
				String get1="",code="";
				int nextCode=0;
				code.ManageCode c;
				c = new code.ManageCode(envLookup);
				get1 = c.getCodeValue("ItemGroupStart"); 
				code = c.getCodeValue("NextItemGroupCode");
				nextCode=Integer.parseInt(code);
				get1=get1+nextCode;	
				nextCode= nextCode + 1;
			
				query="insert into item_group (item_group_code,item_group_desc,fmcg_ind,item_group_number)values('"+get1+"','"+ig_desc+"','"+fmcg_flag+"',"+ig_number+")"; 
				int run_sql= stat.executeUpdate(query);
				if(run_sql==1){
					 c.editCodeValue(nextCode,"NextItemGroupCode");
				}	
				c.closeAll();
				return(run_sql);
	    	}
		}
		catch(Exception e){
			System.out.println("Error occurred in add item group entry in Database " + e);
			closeAll();
			return(0);
		}	    		
	}
	public int addPurchaseItemDetails(String i_code,float i_mrp,float purchase_price,float margin_pct,int scheme_code,int scheme_on_qty,float scheme_value,float purchase_qty,String purchase_datetime,String user_name,int vat_code,float landing_price,float total_price,float cash_discount){
		try{
			String query="";			
			query="insert into item_purchase_details values('"+ 
			i_code+"',"+i_mrp+","+purchase_price+","+margin_pct+","+
			scheme_code+","+scheme_on_qty+","+scheme_value+","+
			purchase_qty +",'"+purchase_datetime+"','"+user_name+"',sysdate(),"+vat_code+","+landing_price+","+total_price+","+cash_discount+")"; 
	    	int run_sql= stat.executeUpdate(query);
	    	if(run_sql==1){
	    		 return 0;
	    	}
	    	else{
	    		return 1;
	    	//closeAll();
	    	}	
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add item entry in Database " + e);
			closeAll();
			return(0);
		}	    		
	}
	
	public void ItemSalesDetail(String action,String fromDate,String toDate,String selMonth,String iGroupCode){
		try{
			System.out.println("TEST===>"+action+","+fromDate+","+toDate+","+selMonth+","+iGroupCode);
			rs = stat.executeQuery("call get_item_sales_detail('"+action+"','"+fromDate+"','"+toDate+"','"+selMonth+"','"+iGroupCode+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	public void ItemSalesGraph(String itemCode,String igCode,String orderDate,String selMonthYear){
		try{
			System.out.println("TEST===>"+itemCode+","+igCode+","+orderDate+","+selMonthYear);
			rs = stat.executeQuery("call get_item_sales_graph('"+itemCode+"','"+igCode+"','"+orderDate+"','"+selMonthYear+"')");
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	public void ItemSalesCustInfo(String orderDate,String itemCode,String itemName){
		try{
			String query="Select a.order_num, a.custcode, d.custname, sum(b.qty)" +
					" from orders a, order_detail b, customer_master d" +
					" where a.order_num = b.order_num" +
					" and b.item_code = '"+itemCode+"'" +
					" and a.custcode = d.custcode" +
					" and trim(date(a.order_date)) = '"+orderDate+"'group by a.order_num, a.custcode order by a.custcode";					
			rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	public void ItemSalesMonthlyCustInfo(String monthyear,String itemCode){
		try{
			String query="select trim(DATE(a.order_date)), c.custcode, c.custname, sum(b.qty)" +
					" from orders a, order_detail b, customer_master c" +
					" where a.order_num = b.order_num" +
					" and b.item_code = '"+itemCode+"'" +
					" and a.custcode = c.custcode" +
					" and CONCAT(MONTHNAME(a.order_date),'-',year(a.order_date)) = '"+monthyear+"'" +
					"  group by trim(Date(a.order_date)),b.item_code, c.custcode order by c.custcode";

			rs = stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in get_cust_stats_detail " + e);
			closeAll();			
		}
	}
	public void ItemList(String itemname){
		try{
			String query="select item_code, item_name, item_weight, item_rate, item_mrp from item_master where item_name like '"+itemname+"%'";
			rs = stat.executeQuery(query);
			System.out.println(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in ItemList " + e);
			closeAll();			
		}
	}
	
	public void listItemBarCode(String ibarcode,String itemName){

		try{ 
			String query="";
	    	query="select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
					" i.item_weight, i.item_mrp, i.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
					" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount,i.comm_amt, i.ticker_flag,i.barcode" +
	    			" from  item_group i1,item_master i" +
	    			" left join item_history i2 on i.item_code = i2.item_code"+
	    	         " where i.item_group_code=i1.item_group_code ";	    	
	    	    	
	    	if(!ibarcode.equals("")){
	    		query = query + " and i.barcode = '" + ibarcode + "'";
	    	} 
	    	if(!itemName.equals("")){
	    		query = query + " and i.item_name like '" + itemName + "%'";
	    	} 
	    	
	    	query =query + "order by i.item_name";	
	    	System.out.println("Select items "+query);
	    	rs=stat.executeQuery(query);
		}
		catch(Exception e){
			System.out.println("Error occurred in customer list " + e);
			closeAll();			
		}
	}
	
	public void getSiteList(){
		try {
			String selSql = "SELECT site_id, site_name FROM site_master";					
			rs = stat.executeQuery(selSql);
			System.out.println(selSql);
		} catch (SQLException e) {
			System.out.println("Error occurred in getSiteList() " + e);
			closeAll();			
			e.printStackTrace();
		}
	}

	public void getListOfItems(String itemCode, Integer siteId){
		try {
			query ="SELECT  i.item_code, i.item_name, s.site_name, ip.price_version, ip.item_mrp," +
					" ip.item_rate, ip.item_pv_qty,s.site_id 	" +
					" FROM item_master i,item_price ip, item_site_inventory isi,site_master s " +
					" where i.item_code= '"+itemCode+"'"+
					" and ip.item_code = i.item_code" +
					" and isi.item_code = ip.item_code ";
			if(siteId != 0){
				query=query+		" and isi.site_id ="+ siteId;
			}
			query=query+		" and s.site_id = isi.site_id" +
					" and ip.price_version = isi.price_version" +
					" order by ip.price_version desc";
			
			rs = stat.executeQuery(query);
			System.out.println(query);
	} catch (SQLException e) {
		System.out.println("Error occurred in getSiteList() " + e);
		closeAll();			
		e.printStackTrace();
	}
	}

	public int changeQuantity(String itemCode,Integer newSiteId,Integer priceVersion,Integer oldQty,Integer newQuantity){
		try {
			Integer siteQty =0;
			Integer value = oldQty + (newQuantity);

			query = "UPDATE item_price set item_pv_qty= " +value+
					" WHERE item_code='"+itemCode+"'" +
					" and price_version ="+priceVersion;
			System.out.println(query);
			stat.executeUpdate(query);
			
			query = "SELECT item_site_qty " +
					" FROM item_site_inventory " +
					" WHERE item_code='"+itemCode+"'" +
					" and price_version ="+priceVersion +
					" and site_id= "+newSiteId;
			System.out.println(query);
			rs = stat.executeQuery(query);
			if(rs.next()){
				siteQty = rs.getInt(1);
				siteQty = siteQty + (newQuantity);
				query = "UPDATE item_site_inventory set item_site_qty= " +siteQty+
						" WHERE item_code='"+itemCode+"'" +
						" and price_version ="+priceVersion +
						" and site_id= "+newSiteId;
				System.out.println(query);
				stat.executeUpdate(query);
			}
			
			System.out.println("siteQty : "+siteQty );
			System.out.println("Value : "+value );
			return 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return 0;
	}
	
	public ResultSet getItemWithPV(String first,String second){
		String query ="";
		if(!first.equals("0-9")){
			query = "select m.item_code, m.item_name, m.item_weight, p.price_version,p.item_mrp,p.item_rate,p.current_flag " +
					" from item_master m, item_price p where m.item_code = p.item_code and active_flag = 'Y' and m.item_name like '"+first+second+"%' order by 1,4 desc";
		} else {
			query = "select m.item_code, m.item_name, m.item_weight, p.price_version,p.item_mrp,p.item_rate,p.current_flag " +
					" from item_master m, item_price p where m.item_code = p.item_code and active_flag = 'Y' and m.item_name regexp '^[0-9]' order by 1,4 desc";
		}
		String query1 ="";
		if(!first.equals("0-9")){
			query1 = "SELECT i.item_code, i.price_version, i.site_id, i.item_site_qty, s.site_name FROM item_site_inventory i, site_master s " +
					"where i.site_id=s.site_id and i.item_code in (select item_code from item_master where item_name like '"+first+second+"%') order by 1,2,3 ";
		} else {
			query1 = "SELECT i.item_code, i.price_version, i.site_id, i.item_site_qty, s.site_name FROM item_site_inventory i, site_master s " +
					"where i.site_id=s.site_id and i.item_code in (select item_code from item_master where item_name like '^[0-9]') order by 1,2,3 ";
		}
		try {
			rs = stat.executeQuery(query);
			Statement s = conn.createStatement();
			ResultSet rs1 = s.executeQuery(query1);
			//System.out.println(query);
			//System.out.println(query1);
			return rs1;
		} catch (SQLException e) {
			System.out.println("Error: getItemWithPV(): ManageItem: 481 line " + e);
			closeAll();			
			e.printStackTrace();
			return null;
		}
				
	}
	public void setCurrentPV(String code, String pv){
		try {
			String query = "update item_price set current_flag = 'N' where item_code = '"+code+"' and price_version != "+pv;
			stat.executeUpdate(query);
			query = "update item_price set current_flag = 'Y' where item_code = '"+code+"' and price_version = "+pv;
			stat.executeUpdate(query);
			//System.out.println(query);
		} catch (SQLException e) {
			System.out.println("Error: setCurrentPV(): ManageItem: 494 line " + e);
		}
	}
	public void discardPV(String code, String pv[]){
		try {
			String query = "update item_price set active_flag = 'N' where item_code = '"+code+"' and price_version in (";
			for(int i=0;i<pv.length;i++){
				query = query + pv[i];
				if(i!=pv.length-1){
					query = query + ",";
				}
			}
			query = query + ")";
			stat.executeUpdate(query);
			//System.out.println(query);
		} catch (SQLException e) {
			System.out.println("Error: setCurrentPV(): ManageItem: 481 line " + e);
		}
	}
	
	public void getItemList(String item_name,String item_code,String item_group,String item_barcode){

		try {
			
			String query = "select item_name, item_weight, item_rate, item_mrp,item_qty,item_code from item_master "+
					"where item_name like '%"+item_name+"%' and item_code like '"+item_code+"%' and barcode like '"+item_barcode+"%'";
			if(!item_group.equals("")){
					query = query + " and item_group_code = '"+item_group+"'";
			}
			System.out.println("selct item query : "+query);
			rs = stat.executeQuery(query);
			
		} catch (SQLException e) {
			System.out.println("Error: getItemList(): ManageItem: 498 line " + e);
		}
	}
	
	// old function for fetching item quantity according to site 
	public ArrayList<ArrayList<Integer>> getStock(String item_code){
		ArrayList<ArrayList<Integer>>  data = new ArrayList<ArrayList<Integer>>();
		try {
			String query = "select max(p.price_version), max(s.site_id) from item_price p, site_master s  where p.item_code = '"+item_code+"'";
			System.out.println(query);
			rs = stmt.executeQuery(query);
			if(rs.next()){
				for(int i = 0;i<rs.getInt(1);i++){
					ArrayList<Integer> list = new ArrayList<Integer>();
					query = "select * from item_site_inventory where item_code = '"+item_code+"' and price_version = "+(i+1);
					rss = stat.executeQuery(query);
					
					for(int j = 0;j<rs.getInt(2);j++){
						list.add(j,0);
					}
					while(rss.next()){
						list.set(rss.getInt(3)-1,rss.getInt(4));
					}
					data.add(i,list);
				}
			}
		} catch (SQLException e) {
			System.out.println("Error: getStock(): ManageItem: 512 line " + e);
		}
		return data;
	}

	// new function for fetching item quantity according to site 
	public ArrayList<ArrayList<Integer>> getStock1(String item_code){
		ArrayList<ArrayList<Integer>>  data = new ArrayList<ArrayList<Integer>>();
		try {
			int totalSite =0;
			String selectSiteQuery = "select count(s.site_id) from  site_master s";
			System.out.println("selectSiteQuery "+selectSiteQuery);
			rs = stmt.executeQuery(selectSiteQuery);
			if(rs.next())
				totalSite = rs.getInt(1); 
			
			String query = "select p.price_version from item_price p where p.item_code = '"+item_code+"' and active_flag='Y'";
			System.out.println("price versio query "+query);
			rs = stmt.executeQuery(query);
			int i=0;
			while(rs.next()){
					ArrayList<Integer> list = new ArrayList<Integer>();
					query = "select * from item_site_inventory isi , item_price ip where isi.item_code = '"+item_code+"'" +
							"and isi.item_code=ip.item_code and isi.price_version=ip.price_version " +
							"and isi.price_version = "+ (i+1) +" and ip.active_flag='Y'";
					System.out.println("site inventory query "+query);
					rss = stat.executeQuery(query);
				
					/*while(rss.next()){
						System.out.println(rss.getInt(3)-1 +"item qty "+rss.getString(4));
						
					}
					rss.beforeFirst();
					*/
					for(int j = 0;j<totalSite;j++)
					{
						list.add(j,0);
					}
					System.out.println("before add j "+list.size());
					while(rss.next() && rss.getInt(3)-1<list.size()){
						System.out.println(rss.getInt(3)-1);
						list.set(rss.getInt(3)-1,rss.getInt(4));
						
					}
					System.out.println("after ");
					data.add(i,list);
					i++;
			}
		} catch (SQLException e) {
			System.out.println("Error: getStock(): ManageItem: 512 line " + e);
		}
		//System.out.println("size of array list "+data.size());
		return data;
	}


	public ArrayList<String> getSiteName(){
		ArrayList<String> siteName = new ArrayList<String>();
		try {
			String selSql = "SELECT site_name FROM site_master order by site_id";					
			rs = stat.executeQuery(selSql);
			while (rs.next()) {
				siteName.add(rs.getString(1));
			}
			System.out.println(selSql);
		} catch (SQLException e) {
			System.out.println("Error occurred in getSiteList() " + e);
			closeAll();			
			e.printStackTrace();
		}
		return siteName;
	}
	
	
	
	public void getReorderList(String site_id){
		try {
			String query = "select i.item_code, i.item_name, i.item_weight, i.reorder_level, sum(s.item_site_qty) "+
							"from item_master i, item_site_inventory s where item_qty <= 20 "+
							"and i.item_code = s.item_code and s.site_id = "+site_id+" group by 1";
			rs=stat.executeQuery(query);
			System.out.println(query);
		} catch (SQLException e) {
			System.out.println("Error: getReorderList(): ManageItem: 538 line " + e);
		}
	}
	
	public ResultSet getMRPRate (String itemCode) {
		ResultSet resultSet = null;
		String priceVersionQyery = "select price_version,item_mrp , item_rate from item_price where item_code = ? and active_flag='Y' order by price_version; ";
		System.out.println("itemCode "+itemCode);
		PreparedStatement preparedStatement;
		try {
			preparedStatement = conn.prepareStatement(priceVersionQyery);
			preparedStatement.setString(1,itemCode);
			System.out.println("priceVersionQyery "+priceVersionQyery);
			resultSet = preparedStatement.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("rsult set "+resultSet);
		return resultSet;
	}
	
	
	public JsonOutputBean getCurrentStock(String itemCode) {
		ArrayList<ItemStockOutputBean> listOutputBean = new ArrayList<ItemStockOutputBean>(); 
		// creating array list of Output Bean
		ItemStockOutputBean outputBean =null;
		int oldPriceVersion =0;
		int newPriceVersion =0;
		int totalQty = 0;
		ResultSet resultSet =null;
		String currentStockQuery =" select s.item_code,s.price_version, p.item_rate, p.item_mrp,s.site_id, s.item_site_qty "+
									"from item_site_inventory s , item_price p "+
									"where s.item_code= ? "+
									"and s.item_code= p.item_code "+
									"and p.price_version= s.price_version "+
									"and p.active_flag='Y' ; ";
		
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(currentStockQuery);
			System.out.println("item code "+itemCode);
			System.out.println("current Stock Query "+currentStockQuery);
			preparedStatement.setString(1, itemCode);
			resultSet = preparedStatement.executeQuery();
			
				while(resultSet.next()){
					
					System.out.println("resultset "+resultSet.getRow());
					
					newPriceVersion = resultSet.getInt("price_version");
					
					if(oldPriceVersion==newPriceVersion){
						System.out.println(resultSet.getRow()+" >> same price vesrion "+outputBean);
						
					}
					else{
						System.out.println(resultSet.getRow() +">>  diff price vesrion ");
						outputBean = new ItemStockOutputBean();
					}
					oldPriceVersion = newPriceVersion;
					
					outputBean.setItemPV(resultSet.getInt("price_version"));
					outputBean.setItemMRP(resultSet.getFloat("item_mrp"));
					outputBean.setItemRate(resultSet.getFloat("item_rate"));
					
					
					int j=resultSet.getInt("site_id") ;
				
					System.out.println("price version  "+newPriceVersion +"\t site iD  "+resultSet.getInt("site_id"));
						
							 switch(resultSet.getInt("site_id")){
						
								case 1 : outputBean.setSite1(resultSet.getInt("item_site_qty"));
											break;
										
								case 2 : outputBean.setSite2(resultSet.getInt("item_site_qty"));
											break;
						
								case 3 : outputBean.setSite3(resultSet.getInt("item_site_qty"));
											break;
						
								case 4 : outputBean.setSite4(resultSet.getInt("item_site_qty"));
											break;
						
								case 5 : outputBean.setSite5(resultSet.getInt("item_site_qty"));
											break;
						
								case 6 : outputBean.setSite6(resultSet.getInt("item_site_qty"));
											break;
						
								case 7 : outputBean.setSite7(resultSet.getInt("item_site_qty"));
											break;
								
								case 8 : outputBean.setSite8(resultSet.getInt("item_site_qty"));
											break;
						
								case 9 : outputBean.setSite9(resultSet.getInt("item_site_qty"));
											break;
						
								case 10 : outputBean.setSite10(resultSet.getInt("item_site_qty"));
											break;
						
								case 11 : outputBean.setSite11(resultSet.getInt("item_site_qty"));
											break;
						
								case 12 : outputBean.setSite12(resultSet.getInt("item_site_qty"));
											break;
						
								case 13 : outputBean.setSite13(resultSet.getInt("item_site_qty"));
											break;
									
								case 14 : outputBean.setSite14(resultSet.getInt("item_site_qty"));
											break;
						
								case 15 : outputBean.setSite15(resultSet.getInt("item_site_qty"));
											break;
								
							 }
							 //System.out.println("listOutputBean.get(listOutputBean.size()-1) "+listOutputBean.get(listOutputBean.size()-1));
						if(listOutputBean.size()>0){
							if(listOutputBean.get(listOutputBean.size()-1)!=outputBean)	 
								listOutputBean.add(outputBean);
						}
						else{
							listOutputBean.add(outputBean);
						}
						
						totalQty+=resultSet.getInt("item_site_qty");
						System.out.println("site 1 :"+resultSet.getInt("site_id")+"\t totl qty "+resultSet.getInt("item_site_qty"));
				} 
				
				
				
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("totalQty "+totalQty);
		JsonOutputBean jsonOutputBean = new  JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBean);
		jsonOutputBean.setGrandTotalValues((totalQty+"").trim());
		return jsonOutputBean;
	}
	
	public ResultSet getSiteNameList(){
		ResultSet resultSet =null;
		try {
			String selSql = "SELECT site_name,site_id FROM site_master order by site_id";		
			System.out.println("site name "+ selSql);
			resultSet = stat.executeQuery(selSql);
			
		} catch (SQLException e) {
			System.out.println("Error occurred in getSiteList() " + e);
			closeAll();			
			e.printStackTrace();
		}
		return resultSet;
	}
	
	public ResultSet getItemNames() {
		ResultSet resultSet =null;
		String itemListQuery = "select item_code, item_name from item_master; ";
		try {
			System.out.println("itemListQuery "+itemListQuery);
			resultSet =stat.executeQuery(itemListQuery);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultSet;
	}
	
}

