trigger EmployeeEmailAttachTrigger on Employee__c (After Insert) {

  if(Trigger.isAfter && Trigger.isInsert){
  
    //Call Apex class to send Email to employee with attachment and pdf
    
    System.enqueueJob(new EmployeeEmailShare(Trigger.new));
    
  }

}