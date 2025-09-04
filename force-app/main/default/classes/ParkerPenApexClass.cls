public class ParkerPenApexClass {
    
    
    @AuraEnabled
    public static void CreateRecord(Parker_Pen__c parkerPenObj){
        try{
            if(parkerPenObj != null){
                insert parkerPenObj;
            } 
        }catch(Exception e){
          throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void UpdateRecord(Parker_Pen__c parkerPenObj){
        try{
            if(parkerPenObj != null){
                Parker_Pen__c Record = [select id from Parker_Pen__c where UID__c =: parkerPenObj.UID__c];
                if(parkerPenObj.Name != null){
                    record.Name =parkerPenObj.Name;
                }
                if(parkerPenObj.Oracle_Ext_ID__c != null){
                    record.Oracle_Ext_ID__c =parkerPenObj.Oracle_Ext_ID__c;
                }
                if(parkerPenObj.Price__c != null){
                    record.Price__c =parkerPenObj.Price__c;
                }
                 if(parkerPenObj.UID__c!= null){
                    record.UID__c =parkerPenObj.UID__c;
                }
                update Record;
            }
        }catch(Exception e){
          throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void DeleteRecord(Parker_Pen__c parkerPenObj){
        try{
            if(parkerPenObj != null){
                Parker_Pen__c Record =[Select id From Parker_Pen__c Where UID__c =:parkerPenObj.UID__c];
                delete Record;
            } 
        }catch(Exception e){
          throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Parker_Pen__c > getParkerRecords(){
       try{
          return [SELECT id,Name,Price__c FROM Parker_Pen__c LIMIT 5];
       }catch(Exception e){
          throw new AuraHandledException(e.getMessage());
       }
    
    }



}