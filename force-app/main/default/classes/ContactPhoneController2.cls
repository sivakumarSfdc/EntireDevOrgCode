public with sharing Class ContactPhoneController2{


   public static void contactUpdate( List<Contact> newMap){
   
   
       Set<Id> setOfAccs = new Set<Id>();
       for(Contact con: newMap){
       
          setOfAccs.add(con.AccountId);
       }
       
       //List<Account> lsOfAccounts = [SELECT Id, Phone FROM Account WHERE Id IN: setOfAccs];
       Map<Id, Account> mpOfAccounts = new Map<Id, Account>([SELECT Id, Phone FROM Account WHERE Id IN: setOfAccs]);
       if(!mpOfAccounts.isEmpty()){
       
          for(Id i: mpOfAccounts.keySet()){
          
               for(Contact cont: newMap){
               
               
                   if(cont.AccountId == i){
                   
                      cont.Phone = mpOfAccounts.get(i).Phone;
                   }
               }
          }
       }
       
       
   
   
   }

}