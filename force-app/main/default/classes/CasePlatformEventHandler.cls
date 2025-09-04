public class CasePlatformEventHandler {
    public static void invokeMuleFlow(Map<Id, Case> newMap, Map<Id, Case> oldMap){
        set<Id> requiredCaseIds = new set<Id>();
        for(Id i: newMap.keySet()){
            Case newRec = newMap.get(i);
            Case oldRec = oldMap != null? oldMap.get(i) : null;
            if(newRec != null  && newRec.Origin == System.Label.Case_Orgin && newRec.Status != 'Closed' && newRec.Status != 'Working'){
                if(oldRec != null && oldRec.Origin != newRec.Origin){
                    requiredCaseIds.add(i);
                }else{
                    requiredCaseIds.add(i);
                    
                }
                
            }
        }
        if(!requiredCaseIds.isEmpty()){
            List<Case_Notification__e> eventsToPublish = new List<Case_Notification__e>();
            for(Id i: requiredCaseIds){
                eventsToPublish.add(new Case_Notification__e(
                CaseId__c = newMap.get(i).Id,
                Subject__c = newMap.get(i).Subject,
                Origin__c = newMap.get(i).Origin,
                Status__c = newMap.get(i).Status,
                Description__c = newMap.get(i).Description
                ));
            }
            if(!eventsToPublish.isEmpty()){
                EventBus.publish(eventsToPublish);
            }
        }
        
    }

}