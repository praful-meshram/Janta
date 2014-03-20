package item;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ManageItemHistory {
	
	public Connection conn=null;
	public Statement  stat,stat1,stat2;
	public ResultSet rs,rs1,rs2;
	public String query,query1,query2,query3;
	public ManageItemHistory(String envLookup){
		initialize(envLookup);
	}
	public void  initialize(String envLookup){
		try{
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup(envLookup);
			conn = ds.getConnection();
			stat=conn.createStatement();
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
	public void addItemHistory(String i_code,String Remark){
		try{
			query="select i.item_code,i.item_group_code,i.item_name,i.item_weight,i.item_mrp,i.upd_datetime,i.deal_type,i.deal_active_flag, " +
					"i.deal_on_qty,i.deal_amount,i.item_rate,max(i1.version_no),i.comm_amt,i.box_qty from item_master i, item_history " +
					"i1 where i.item_code=i1.item_code and i.item_code='"+i_code+"' group by i.item_code";
	    	System.out.println("History : "+query);
			rs= stat.executeQuery(query);
	    	if(rs.next()){
	    	     int nextver = rs.getInt(12);
	    	     nextver = nextver+1;
	    	     query3="insert into item_history (item_code,version_no,item_group_code,item_name,item_weight,item_mrp, " +
	    	     		"upd_datetime,deal_type,deal_active_flag,deal_on_qty,deal_amount,item_rate,comm_amt,upd_datetime_new,remark,box_qty) " +
	    	     		"values('"+rs.getString(1)+"','"+nextver+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"',' " +
	    	     				""+rs.getString(5)+"','"+rs.getString(6)+"','"+rs.getString(7)+"','"+rs.getString(8)+"','"+rs.getString(9)+" " +
	    	     						"','"+rs.getString(10)+"','"+rs.getString(11)+"','"+rs.getString(13)+"',now(),'"+Remark+"', " +
	    	     								""+rs.getInt(14)+")";
		    	 stat.executeUpdate(query3);
		    	 System.out.println("History : "+query3);
		    }
	    	else{    
		    	 query2="select item_code,item_group_code,item_name,item_weight,item_mrp,upd_datetime,deal_type,deal_active_flag, " +
		    	 		"deal_on_qty,deal_amount,item_rate,comm_amt,box_qty from item_master where item_code= '"+i_code+"'";
		    	 rs2= stat.executeQuery(query2);
		    	 System.out.println("History new : "+query2);
		    	 while (rs2.next()){    	   
			    	   query3="insert into item_history (item_code,version_no,item_group_code,item_name,item_weight,item_mrp, " +
			    	   		"upd_datetime,deal_type,deal_active_flag,deal_on_qty,deal_amount,item_rate,comm_amt,upd_datetime_new, " +
			    	   		"remark,box_qty) values('"+rs2.getString(1)+"',1,'"+rs2.getString(2)+"','"+rs2.getString(3)+"',' " +
			    	   				""+rs2.getString(4)+"','"+rs2.getString(5)+"','"+rs2.getString(6)+"','"+rs2.getString(7)+"',' " +
			    	   						""+rs2.getString(8)+"','"+rs2.getString(9)+"','"+rs2.getString(10)+"','"+rs2.getString(11)+" " +
			    	   								"','"+rs2.getString(12)+"',now(),'"+Remark+"',"+rs2.getInt(13)+")";
			    	   stat1=conn.createStatement();
				    stat1.executeUpdate(query3);
			    	   System.out.println("History : "+query3);
		    	 }    	   
	    	}   	
	    	
		}
		catch(Exception e){
			System.out.println("Error occurred in add item history entry in Database " + e);
			closeAll();		
		}	    		
	}
	
	public void listItemHistory(String i_code){

		try{
			
	    	query="select i1.item_code, i1.version_no,i2.item_group_desc, i1.item_name, "+
	    		  "i1.item_weight, i1.item_mrp, i1.item_rate, i1.deal_type, i1.deal_on_qty, "+
	    		  "i1.deal_amount, date(i1.upd_datetime),i1.comm_amt "+
	    		  "from item_history i1,item_group i2 "+
	    		  "where i1.item_group_code=i2.item_group_code "+
	    		  "and i1.item_code='"+i_code+"'";
	    	System.out.println(query);
	    	rs=stat.executeQuery(query);			
	      	
		}
		catch(Exception e){
			System.out.println("Error occurred in Item History list " + e);
			closeAll();			
		}
	}
}
	