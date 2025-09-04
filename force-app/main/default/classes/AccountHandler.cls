public with sharing class AccountHandler {

    @AuraEnabled
    public static List<Account> getAllAccounts(Boolean varStatus) {
        try {
            List<Account> lsOfAccounts = [
                SELECT Id, Name, Industry, Active__c,
                       (SELECT Id, Name FROM Contacts)
                FROM Account
                WHERE Id IN (SELECT AccountId FROM Contact WHERE AccountId != null) AND Active__c =: varStatus
            ];
            return lsOfAccounts;
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching accounts: ' + e.getMessage());
        }
    }
@AuraEnabled
public static void updateAccountStatus(List<Id> accountIds, Boolean newStatus) {
    List<Account> accountsToUpdate = [
        SELECT Id, Active__c FROM Account WHERE Id IN :accountIds
    ];
    for (Account acc : accountsToUpdate) {
        acc.Active__c = newStatus;
    }
    update accountsToUpdate;
}

}