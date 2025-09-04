trigger CasePlatformEventTrigger on Case (After Insert, After Update) {

  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate) && Utility.alreadyFired == false){
    Utility.alreadyFired = true;
    CasePlatformEventHandler.invokeMuleFlow(trigger.newMap, trigger.oldMap);
  }

}