public with sharing class DisplayAccounts {
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts(String searchTerm) {
        try {
            String query = 'SELECT Id, Name, Industry, Active__c FROM Account';
            if (String.isNotBlank(searchTerm)) {
                searchTerm = '%' + searchTerm + '%';
                query += ' WHERE Name LIKE :searchTerm';
            }
            return Database.query(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAccount(String recordId) {
        if (!String.isEmpty(recordId)) {
            List<Account> accountsToDelete = new List<Account>{ new Account(Id = recordId) };
            delete accountsToDelete;
        }
    }
}