trigger LabourTrigger on LabourExpence__c (After insert, After update) {
   FinalExpence.updateFinalExp(trigger.newMap);

}