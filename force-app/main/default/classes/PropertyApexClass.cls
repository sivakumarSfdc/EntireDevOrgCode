public class PropertyApexClass {
    
    @AuraEnabled
    public static void insertPropertyRecord(Property__c propertyObject){
        
        try{
            if(propertyObject != null){
                insert propertyObject;
            }
        }catch(Exception e){
          throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Property__c> getListOfPropertyRecords(){
        try{
            return [SELECT id,Name,Price__c,Type__c,Discount__c ,Final_Price__c  FROM Property__c];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    public static void applyDiscount(List<Property__c> VarPropertyRecords){
      // if(Trigger.isExecuting){
         for(Property__c VarPropertyRecord:VarPropertyRecords){
            if(VarPropertyRecord.Type__c == 'Row House'){
              VarPropertyRecord.Discount__c = 20;
              VarPropertyRecord.Final_Price__c = VarPropertyRecord.Price__c - (VarPropertyRecord.Price__c * VarPropertyRecord.Discount__c/100);
            }else{
              VarPropertyRecord.Discount__c = 0;
              VarPropertyRecord.Final_Price__c = VarPropertyRecord.Price__c;
              
            }
            
         }
      // }
    }
    
    public static void displayLatestVersionOfRecords(List<Property__c> VarListOfRecords, Map<id,Property__c> VarMapOfRecords,String status){
        System.debug('Triggernew ='+status+VarListOfRecords);
        System.debug('Triggernewmap ='+VarMapOfRecords);

    }
    
    public static void displayOldVersionOfRecords(List<Property__c> VarListOfRecords, Map<id,Property__c> VarMapOfRecords,String status){
        System.debug('Triggerold ='+status+VarListOfRecords);
        System.debug('Triggeroldmap ='+VarMapOfRecords);

    }

    

}