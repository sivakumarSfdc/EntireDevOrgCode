trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> ls2InsertTask = new List<Task>();
    for(Order_Event__e event:Trigger.new){
        if(event.Has_Shipped__c == true){
            Task t = new Task(Priority = 'Medium',
                             Subject = 'Follow up on shipped order 105',
                             OwnerId = event.CreatedById);
            ls2InsertTask.add(t);
        }
    }
    if(!ls2InsertTask.isEmpty()){
        insert ls2InsertTask;
    }
    

}