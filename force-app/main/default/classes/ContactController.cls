public with sharing class ContactController {


    @AuraEnabled (cacheable=true)
    public static List<Contact> getContacts(){
        throw new AuraHandledException('forced Error');
       // return [SELECT FirstName, LastName, Email FROM Contact WHERE FirstName<>NULL WITH SECURITY_ENFORCED];
    }
}