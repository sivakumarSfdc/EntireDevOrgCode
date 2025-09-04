trigger PesticideTrigger on PesticideExpence__c (After insert, After update) {
    FinalExpence.updateFinalExp(trigger.newMap);

}