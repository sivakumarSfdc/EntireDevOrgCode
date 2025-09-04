@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';

    @isTest
    static void Method1(){
        Test.startTest();
        List<Lead> lsOfLeads2Insert = new List<Lead>();
        for(integer i = 0 ; i<250; i++){
            lsOfLeads2Insert.add(new Lead(LastName = 'Test Last :'+i,
                                         Company = 'Test Company',
                                         Status = 'Open - Not Contacted'));
        }
        if(!lsOfLeads2Insert.isEmpty()){
            insert lsOfLeads2Insert;
        }
        
        String jobId = System.schedule('ScheduledApexTest',
                                       CRON_EXP,
                                       new DailyLeadProcessor());
        Test.stopTest();
        
        Integer actualValue = [SELECT id FROM Lead WHERE LeadSource ='Dreamforce'].size();
        System.assertEquals(200,actualValue,'Not matched');

    }
}