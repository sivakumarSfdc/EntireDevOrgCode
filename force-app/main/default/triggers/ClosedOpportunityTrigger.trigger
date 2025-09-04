trigger ClosedOpportunityTrigger on Opportunity (After insert, After update) {

  if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
     
     List<Task> ListOfTasks = new List<Task>();
     
     for(Opportunity varOppRec: Trigger.new){
     
       if(varOppRec.StageName == 'Closed Won'){
         
         Task Task_OBJECT = new Task();
         Task_OBJECT.WhatId = varOppRec.AccountId;
         Task_OBJECT.Subject = 'Follow Up Test Task';
         ListOfTasks.add(Task_OBJECT);
       }
     }
     if(ListOfTasks.size()>0){
      
      insert ListOfTasks;
     }
  }

}