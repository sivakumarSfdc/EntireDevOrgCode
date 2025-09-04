trigger oppurtunityTriger on Opportunity (After update) {


 if(trigger.isUpdate && trigger.isAfter){
 
     for(Student__c st: [SELECT Id FROM Student__c WHERE Opportunity__c IN: trigger.newmap.keySet()]){
     
       System.debug('Student Record ='+st);
     
     }
 
 }

}