public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{
    public Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, LeadSource FROM Lead';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> lsOfLeads2Update = new List<Lead>();
        for(Lead l: scope){
            l.LeadSource = 'Dreamforce';
            lsOfLeads2Update.add(l);
            recordsProcessed =recordsProcessed+1;
        }
        if(!lsOfLeads2Update.isEmpty()){
            update lsOfLeads2Update;
        }
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total List of records processed : '+recordsProcessed);
    }

}