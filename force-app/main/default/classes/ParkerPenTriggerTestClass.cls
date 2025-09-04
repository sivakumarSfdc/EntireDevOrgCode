@isTest
public class ParkerPenTriggerTestClass {
    @isTest
    public static void insertCollectionOfRecords(){
        
        List<Parker_Pen__c> VarListOfParkerRecs = new List<Parker_Pen__c>();
        for(integer i=0;i<200;i++){
            Parker_Pen__c VarParkerRec = new Parker_Pen__c();
            VarParkerRec.Name = 'TestName'+i;
            VarParkerRec.Price__c = 120;
            VarParkerRec.Oracle_Ext_ID__c = 'O'+i;
            VarListOfParkerRecs.add(VarParkerRec);
        }

        Test.startTest();
        insert VarListOfParkerRecs;
        Test.stopTest();
        integer count = [SELECT count() FROM Parker_Pen__c WHERE Price__c =: 100];
        System.assertEquals(200,count , 'Failed to Insert Records');
        
    }
}