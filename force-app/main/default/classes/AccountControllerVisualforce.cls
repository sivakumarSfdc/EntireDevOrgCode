public with sharing class AccountControllerVisualforce {
    @AuraEnabled(cacheable=true)
    public static List<Account> queryAccountsByRevenue(Decimal annualRevenue) {
        return [
            SELECT id, Name
            FROM Account
            WHERE AnnualRevenue >= : annualRevenue
        ];
    }

}