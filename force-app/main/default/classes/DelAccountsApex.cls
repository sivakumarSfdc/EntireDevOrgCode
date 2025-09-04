/*
Class Name: DelAccountsApex
Created Date: 03/03/2025
Description: Perform mass action on Account records using List button 
*/

public with sharing Class DelAccountsApex{
   
   @AuraEnabled
   public static void delAccounts(List<Id> listOfAccIds){ 
   List<Account> acc2Delete = [SELECT Id FROM Account WHERE Id IN: listOfAccIds];
   try{
       if(!acc2Delete.isEmpty()){
         delete acc2Delete;
       }
   }catch(Exception e){
       throw new AuraHandledException('Something wrong');
   }  
   }
}