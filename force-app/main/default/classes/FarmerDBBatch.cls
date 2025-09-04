public class FarmerDBBatch implements Database.Batchable<sObject> {

    public final String query;

    public FarmerDBBatch(String query) {
        this.query = query;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Farmer_DB__c> ls2InsertFarmerDB = new List<Farmer_DB__c>();
        List<AgriFarmer__c> ls2DeleteAgriFarmerDB = new List<AgriFarmer__c>();

        for (sObject rec : scope) {
            AgriFarmer__c agri = (AgriFarmer__c) rec;
            System.debug('Year of CreatedDate: ' + agri.CreatedDate.year());
            
            Farmer_DB__c fa = new Farmer_DB__c();
            fa.Name = agri.Name+' '+'('+ String.valueOf(agri.CreatedDate.year()) + '-' + String.valueOf((agri.CreatedDate.year() + 1)) + ') Agri Report';
            fa.CurrencyIsoCode = 'INR';
            fa.Expenidture__c = agri.Final_Expenditure__c;
            fa.Mobile__c = agri.Phone__c;
            fa.Farmer_Name__c = agri.Name;
            fa.Profit__c = agri.Profit__c;
            ls2InsertFarmerDB.add(fa);
            ls2DeleteAgriFarmerDB.add(agri);
        }
        
        if (!ls2InsertFarmerDB.isEmpty()) {
            insert ls2InsertFarmerDB;
        }
        
        if (!ls2DeleteAgriFarmerDB.isEmpty()) {
            delete ls2DeleteAgriFarmerDB;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Implement any final operations here
    }
}