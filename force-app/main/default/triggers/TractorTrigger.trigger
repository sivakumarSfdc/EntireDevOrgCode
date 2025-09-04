trigger TractorTrigger on TractorExpence__c (After insert, After update) {
  FinalExpence.updateFinalExp(trigger.newMap);
}