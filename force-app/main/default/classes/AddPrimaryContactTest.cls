@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void createTestData(){
        List<Account> accounts = new List<Account>();
        for(integer i =1; i<=100;i++){
            if(i<=50){
                accounts.add(new Account(Name = 'Test account :'+i,
                                        BillingState = 'NY'));
            }else{
                accounts.add(new Account(Name = 'Test account :'+i,
                                         BillingState = 'CA'));

            }
        }
        if(!accounts.isEmpty()){
            insert accounts;
        }
    }
    
    @isTest
    static void Method1(){
        Test.startTest();
        Contact contact = new Contact();
        contact.LastName = 'Test Contact';
        insert contact;
        System.enqueueJob(new AddPrimaryContact(contact,'CA'));
        Test.stopTest();
        Integer actualValue = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'].Size();
        System.debug('Actual value :'+actualValue);
        System.assertEquals(actualValue,50,'Not Matched');
    }
}