public with sharing class LeadContactSelectorController {

    @AuraEnabled
    public static List<Contact> getContacts(Id leadId) {
        System.debug('Lead Id :' + leadId);

        Lead ld = [
            SELECT Id, Possible_Matching_Account__c
            FROM Lead
            WHERE Id = :leadId
            LIMIT 1
        ];

        if (ld.Possible_Matching_Account__c == null) {
            return new List<Contact>();
        }

        return [
            SELECT Id, Name
            FROM Contact
            WHERE AccountId = :ld.Possible_Matching_Account__c
            ORDER BY Name
        ];
    }

    @AuraEnabled
    public static void updateLead(Id leadId, Id contactId) {
        try{
        Lead ld = [SELECT Id FROM Lead WHERE Id = :leadId LIMIT 1];
        ld.Status = 'Pl';
        ld.Primary_Contact__c = contactId;
        update ld;

        }catch(Exception e){
         System.debug('TestMessage :'+e.getMessage());
        }
    }

    @AuraEnabled
    public static Id createContactForLead(Id leadId) {
        Lead ld = [
            SELECT Id, FirstName, LastName, Email, Possible_Matching_Account__c
            FROM Lead
            WHERE Id = :leadId
            LIMIT 1
        ];

        if (ld.Possible_Matching_Account__c == null) {
            throw new AuraHandledException('Lead does not have a Possible Matching Account.');
        }

        Contact con = new Contact(
            FirstName = ld.FirstName,
            LastName = (ld.LastName != null ? ld.LastName : 'New Contact'),
            Email = ld.Email,
            AccountId = ld.Possible_Matching_Account__c
        );
        insert con;
        return con.Id;
    }
}