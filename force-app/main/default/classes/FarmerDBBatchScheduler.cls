public class FarmerDBBatchScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        String query = 'SELECT Id, Name, Earned__c, Phone__c, Profit__c, Final_Expenditure__c, CreatedDate FROM AgriFarmer__c ORDER BY CreatedDate ASC LIMIT 1';
        Database.executeBatch(new FarmerDBBatch(query));
    }

    // Method to schedule the batch job
    public static void scheduleBatch() {
        String cronExp = '0 0 0 25 2 ? *';  // Runs at midnight on February 25th every year
        String jobName = 'Annual FarmerDBBatch Job';
        System.schedule(jobName, cronExp, new FarmerDBBatchScheduler());
    }
}