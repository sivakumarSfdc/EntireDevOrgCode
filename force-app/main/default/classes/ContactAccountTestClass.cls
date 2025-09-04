@isTest
public class ContactAccountTestClass {
   @testSetup
    public static void createAccountRecords(){
        Test.startTest();
        List<Account> ListOfAccounts = new List<Account>();
        for(Integer i = 0 ; i<10; i++){
            
            Account varAccRec = new Account();
            varAccRec.Name = 'ABC'+ i;
            ListOfAccounts.add(varAccRec);
            
        }
        insert ListOfAccounts;   
        Test.stopTest(); 
    }
    
    @isTest
    public static void insertContact(){
        Test.startTest();
        List<Contact> ListOfContacts = new List<Contact>();
        Account accountRec = [SELECT id, Name FROM Account WHERE Name = 'ABC1'];
        Contact varc = new Contact();
            varc.AccountId =accountRec.Id;
            varc.LastName = 'Vinaya';
            varc.Primary__c = True;
        insert varc;
        for(Integer i =0 ; i< 10;i++){
            Contact varContactRec = new Contact();
            varContactRec.AccountId =accountRec.Id;
            varContactRec.LastName = 'Vinaya'+ i;
            varContactRec.Primary__c = True;
            ListOfContacts.add(varContactRec);
        }
        insert ListOfContacts;
        Account rec = [SELECT id, (SELECT id,Primary__c FROM Contacts WHERE Primary__c = True) FROM Account WHERE id =: accountRec.Id];
        System.debug('Size ='+rec.Contacts.size());
        System.assertEquals(1,rec.Contacts.size() , 'Failed to Insert Records');
        Test.stopTest();

    }
}