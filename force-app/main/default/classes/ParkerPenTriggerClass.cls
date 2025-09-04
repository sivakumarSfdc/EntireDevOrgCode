public Class ParkerPenTriggerClass{
   
   public static void applyDiscount(List<Parker_Pen__c > VarListOfParkerRecords){
      
      for(Parker_Pen__c VarParkerRecord:VarListOfParkerRecords){
         
         if(VarParkerRecord.Price__c >= 100){
            
            VarParkerRecord.Price__c = VarParkerRecord.Price__c - 20;
         }
      }
   }
}