public with sharing class bankAccountsManager {
    @AuraEnabled(cacheable=true)
    public static List<Bank__c> GetCustomerInformation(String recId){
        try {
            return [SELECT Id, Name, (SELECT Id, Name, Account_Number__c, Mobile__c, RecordType.Name FROM Bank_Accounts__r) FROM Bank__c WHERE Id =: recId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}