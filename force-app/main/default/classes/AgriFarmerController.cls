public without sharing class AgriFarmerController {

    @AuraEnabled(cacheable=true)
    public static List<DataSet> getAgriRec() {
        List<DataSet> lsOfData = new List<DataSet>();
        for (AgriFarmer__c a : [SELECT Id, Name, Final_Expenditure__c, Earned__c, Profit__c FROM AgriFarmer__c]) {
            lsOfData.add(new DataSet(a.Name, a.Final_Expenditure__c, a.Earned__c, a.Profit__c));
        }
        return lsOfData;
    }

    public class DataSet {
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public Decimal finalExp { get; set; }
        @AuraEnabled
        public Decimal earned { get; set; }
        @AuraEnabled
        public Decimal profit { get; set; }

        // Constructor
        public DataSet(String name, Decimal finalExp, Decimal earned, Decimal profit) {
            this.name = name;
            this.finalExp = finalExp;
            this.earned = earned;
            this.profit = profit;
        }
    }
}