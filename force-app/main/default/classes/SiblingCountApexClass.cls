public class SiblingCountApexClass{

  public static void getSiblingCount(List<Contact> triggerNew){
  
  
     Set<id> SetofContactAccountIds = new Set<id>();
     for(Contact c:triggerNew){
        SetofContactAccountIds.add(c.AccountId);
        
     }
     
     List<Account> ListOfAccountsRecords = [SELECT id,Name,(SELECT id FROM Contacts) FROM Account WHERE id IN:SetofContactAccountIds];
     Map<id,integer> MapofAccountWithContacts = new Map<id,integer>();
     for(Account a:ListOfAccountsRecords){
     
       integer count;
       if(a.Contacts.size() >0){
         count = a.Contacts.size() -1;
       }else{
         count =0;
       }
       MapofAccountWithContacts.put(a.id,count);
       
     }
     
     List<Contact> ListOfContacts = [SELECT id,Name,Siblings_Count__c,AccountId FROM Contact WHERE AccountId IN:MapofAccountWithContacts.keySet()];
     List<Contact> ListOfContactsUpdate = new List<Contact>();
     for(Contact co:ListOfContacts){
      co.Siblings_Count__c = MapofAccountWithContacts.get(co.AccountId);
      ListOfContactsUpdate.add(co);
       
     }
     update ListOfContactsUpdate;
  }

}