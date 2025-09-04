public with sharing class DiceJobForumApexClass {
    @AuraEnabled
    public static void createRecord(Dice_Job_Form__c diceObj){
        try{
            System.debug('DiceJobFormObj::DiceJobRec:'+diceObj);
            if(diceObj != null){
                insert diceObj;
            }
        }catch(Exception ex){
            
        }
    }
}