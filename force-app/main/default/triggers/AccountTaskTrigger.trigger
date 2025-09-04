trigger AccountTaskTrigger on Account (After Insert) {
  
  if(Trigger.isAfter && Trigger.isInsert && !AccountUtility.isAlreadyExecuted){
      AccountTaskCreationHandler.createTask(trigger.new);
      AccountUtility.isAlreadyExecuted = true;
  }

}