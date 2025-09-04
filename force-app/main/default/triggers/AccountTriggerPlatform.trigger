trigger AccountTriggerPlatform on Account (after update) {
    for (Account acc : Trigger.new) {
        System.debug('Platform Event published');
        RecordUpdateEvent__e event = new RecordUpdateEvent__e();
        event.RecordId__c = acc.Id;
        EventBus.publish(event);
    }
}