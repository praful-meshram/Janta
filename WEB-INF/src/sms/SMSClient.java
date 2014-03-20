package sms;
public class SMSClient implements Runnable{

  public final static int SYNCHRONOUS=0;
  public final static int ASYNCHRONOUS=1;
  private Thread myThread=null;

  private int mode=-1;
  private String recipient=null;
  private String message=null;

  public int status=-1;
  public int statuschange;
  public long messageNo=-1;


  public SMSClient(int mode) {
      this.mode=mode;
    }

  public int sendMessage (String recipient, String message){
    this.recipient=recipient;
    this.message=message;
    System.out.println("recipient: " + recipient + " message: " + message);
    myThread = new Thread(this);
    myThread.start();
    run();
    
    
    return SYNCHRONOUS;
    }
    public void run(){
        System.out.println("sending1 ... ");

    sms.Sender aSender = new sms.Sender(recipient,message);

    try{
      //send message
          aSender.send ();

         System.out.println("sending ... ");

      //in SYNCHRONOUS mode wait for return : 0 for OK,
      //-2 for timeout, -1 for other errors
      if (mode==SYNCHRONOUS) {
          while (aSender.status == -1){
            myThread.sleep (1000);
          }
      }
      if (aSender.status == 0) messageNo=aSender.messageNo ;

    }catch (Exception e){

        e.printStackTrace();

    }

    this.status=aSender.status ;

    aSender=null;
    statuschange =  this.status;

  }
}
  