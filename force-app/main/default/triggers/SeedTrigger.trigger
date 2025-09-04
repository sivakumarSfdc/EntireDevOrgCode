trigger SeedTrigger on SeedsExpence__c (After insert, After update) {

  FinalExpence.updateFinalExp(trigger.newMap);

}