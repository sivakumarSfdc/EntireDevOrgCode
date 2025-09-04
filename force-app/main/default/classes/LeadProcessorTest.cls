@isTest
public class LeadProcessorTest {
    @testSetup
    static void createTestData(){
        List<Lead> lsOfLead2Insert = new List<Lead>();
        for(integer i =0 ; i<200; i++){
            lsOfLead2Insert.add(new Lead(LastName ='Test :'+i,
                                        Company = 'Test Company',
                                        Status = 'Working - Contacted',
                                        LeadSource = 'Test Source'));
        }
        if(!lsOfLead2Insert.isEmpty()){
            insert lsOfLead2Insert;
        }
    }
    @isTest
    private static void Method1(){
        Test.startTest();
        LeadProcessor lBatch = new LeadProcessor();
        Database.executeBatch(lBatch);
        Test.stopTest();
        Integer actualValue = [Select Count() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200,actualValue,'Issue with record processing');
    }
}