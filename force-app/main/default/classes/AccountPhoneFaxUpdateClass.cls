public with sharing class AccountPhoneFaxUpdateClass{
  
  public static void updateChildRecords(List<Account> VarListOfAccounts, Map<ID,Account> TriggerOldMap){
  
    Map<ID,Account> MapOfUpdatedAccRecords = new Map<ID,Account>();
    
    for(Account VarAccRec:VarListOfAccounts){
    
      if((VarAccRec.Phone != TriggerOldMap.get(VarAccRec.id).Phone) ||(VarAccRec.Fax != TriggerOldMap.get(VarAccRec.id).Fax)){
      
        MapOfUpdatedAccRecords.put(VarAccRec.id, VarAccRec);
      }
    }
    
    if( MapOfUpdatedAccRecords.size() > 0){
     
      List<Contact> VarListOfContactRecords = [SELECT id,Phone,Fax,AccountId FROM Contact WHERE AccountId IN:MapOfUpdatedAccRecords.keySet()];
      if(VarListOfContactRecords.size() > 0){
       
        List<Contact> ListOfUpdatedContacts = New List<Contact>();
        
        for(Contact VarConRec:VarListOfContactRecords){
        
          VarConRec.Phone = MapOfUpdatedAccRecords.get(VarConRec.AccountId).Phone;
          VarConRec.Fax = MapOfUpdatedAccRecords.get(VarConRec.AccountId).Fax;
          ListOfUpdatedContacts.add(VarConRec);
        }
        update ListOfUpdatedContacts;
      }
      
    }
  
  }
}