trigger ContactAccTrigger on Contact(After insert, After update, After delete, After undelete) {

      
      List<Contact> ListOfContacts = new List<Contact>();
      List<Account> ListOfUpdatedAcc = new List<Account>();
      Set<Id> SetOfAccountIds = new Set<Id>();
      if(Trigger.isDelete){
         ListOfContacts = Trigger.old;
      }else {
         ListOfContacts = Trigger.new;
  
      }
      
      for(Contact con : ListOfContacts){
        
        if(con.AccountId != null){
           SetOfAccountIds.add(con.AccountId);
        }
        
        if(Trigger.isUpdate){
          SetOfAccountIds.add(Trigger.oldmap.get(con.id).AccountId);
        }
      }
      
      if(!SetOfAccountIds.isEmpty()){
        for(Account ac: [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id IN:SetOfAccountIds]){
        
          Account accRec = new Account();
          accRec.Id = ac.Id;
          accRec.Number_of_Contacts__c = ac.Contacts.size();
          ListOfUpdatedAcc.add(accRec);
        }
      }
      
      if(!ListOfUpdatedAcc.isEmpty()){
        update ListOfUpdatedAcc;
      }
 

}