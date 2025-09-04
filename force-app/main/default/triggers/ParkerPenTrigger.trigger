trigger ParkerPenTrigger on Parker_Pen__c (Before insert) {

  ParkerPenTriggerClass.applyDiscount(Trigger.new);
}