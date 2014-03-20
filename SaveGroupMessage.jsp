<%@ page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="beans.MessageBean"%>
<%@ page import="sms.ManageMessage"%>

<jsp:include page="MessagePopUp.jsp"></jsp:include>


<%  
          
              String callfor=request.getParameter("callfor");
              //System.out.println("   callfor"+callfor);
              
              if(callfor!=null){
            	 
               if(callfor.equals("sendmessage")){
           	   String message=request.getParameter("message");
           	   String custcode=request.getParameter("custcode");
           	   String custphone=request.getParameter("custphone");
           	   String messageType=request.getParameter("messageType");
           	   //System.out.print("gggggggg"+custphone);
           	   //System.out.print("ppppppp"+messageType);
           	   String user=session.getAttribute("UserName").toString();
           	   ManageMessage MsgObj = new ManageMessage("jdbc/js");
           	   MessageBean msg = new MessageBean();
           	   msg.setMessage(message);
           	   msg.setCust_code(custcode);
           	   msg.setMobile_no(custphone);
           	   msg.setMessage_type(messageType);
           	   msg.setSent_by(user);
           	   MsgObj.insertMsgData(msg);
           	   MsgObj.closeAll();
           	   }

             }
               
           else{
            
        	
            String message=request.getParameter("message");
            String cust_code [] =request.getParameterValues("custcode");
            String cust_phone [] =request.getParameterValues("custphone");
            String user = session.getAttribute("UserName").toString();
            String message_type=request.getParameter("message_type");
            
            ManageMessage MsgObj = new ManageMessage("jdbc/js");
            
                    for(int i=0;i<cust_code.length;i++){
            	         out.println(cust_code[i] + "    " +cust_phone[i]);
            	        MessageBean msg = new MessageBean();
            	        msg.setMessage(message);
            	        msg.setCust_code(cust_code[i]);
            	        msg.setMobile_no(cust_phone[i]);
            	        msg.setSent_by(user);
            	        msg.setMessage_type(message_type);
            	        MsgObj.insertMsgData(msg);
                               }
                          MsgObj.closeAll();
            
         
           



            response.sendRedirect("SendGroupMessage.jsp");
           }
%>


