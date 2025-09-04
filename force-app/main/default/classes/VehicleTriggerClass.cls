Public Class VehicleTriggerClass{


  public static void checkAccountStatus(List<Vehicle__c > VarListOfVehicleRecords){
  
         for(Vehicle__c VarVehicleRecord:VarListOfVehicleRecords){
           
           if(VarVehicleRecord.IsOpen__c == 'True'){
              
               VarVehicleRecord.addError('Vehicle in Active You Can\'t delete this record.');
           }
         }
  }
}