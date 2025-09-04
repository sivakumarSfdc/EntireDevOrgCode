trigger VehicleTrigger on Vehicle__c (Before delete) {

  if(Trigger.isDelete && Trigger.isBefore){
    
    VehicleTriggerClass.checkAccountStatus(Trigger.old);
    
  }


}