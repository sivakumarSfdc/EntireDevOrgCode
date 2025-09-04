public with sharing class AccountProcessor {
    
    @Future
    public static void countContacts(List<Id> accIds){
        Map<Id,Account> mpOfAccounts = new Map<Id,Account>([SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id IN:accIds]);
        List<Account> lsOfAccounts2Update = new List<Account>();
        for(Id accId:mpOfAccounts.keyset()){
            Account a = new Account(Id =accId,
                                   Number_Of_Contacts__c = mpOfAccounts.get(accId).Contacts.Size());
            lsOfAccounts2Update.add(a);
        }
        if(!lsOfAccounts2Update.isEmpty()){
            update lsOfAccounts2Update;
        }
    }

}