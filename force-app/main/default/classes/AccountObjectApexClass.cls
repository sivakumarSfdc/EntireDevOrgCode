public with sharing class AccountObjectApexClass {
    
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountRecords(){
        List<Account> accList= New List<Account>();
        accList= [select id,Name,Type,Phone from Account Limit 10];
        return accList;
    }

}