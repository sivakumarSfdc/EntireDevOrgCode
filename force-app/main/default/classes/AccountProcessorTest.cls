@isTest
public class AccountProcessorTest {
    @isTest
    private static void testCountContacts() {
        // Create test data
        Account a = new Account(Name = 'Test Account');
        insert a;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 3; i++) {
            contacts.add(new Contact(AccountId = a.Id, LastName = 'Test Last Name'));
        }
        insert contacts;

        // Call the method under test
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{a.Id});
        Test.stopTest();

        // Verify the results
        Integer actualValue = [SELECT Count() FROM Contact WHERE AccountId = :a.Id];
        System.assertEquals(5, actualValue, 'Number of contacts is incorrect');
    }
}