@isTest
Class PropertyTriggerTestClass{

  @isTest
  static void insertLstOfRecords(){
      
    List<Property__c> VarListOfPropertyRecords = new List<Property__c>();
      for(integer i=10; i<=200 ; i+=10){
          Property__c propertyObject = new Property__c();
          propertyObject.Street_Address__c = 'Test address';
          if(i <=100){
           propertyObject.Price__c =i;
           propertyObject.Type__c = 'Row House';   
          }else if(i>100 && i<=200){
           propertyObject.Price__c =i;
           propertyObject.Type__c = 'Villa';   
          }
        VarListOfPropertyRecords.add(propertyObject);  
      }
      insert VarListOfPropertyRecords;
      update VarListOfPropertyRecords;
      for(Property__c rec:VarListOfPropertyRecords){
          if(rec.Type__c == 'Villa'){
              rec.Price__c =140;
          }
      }
      update VarListOfPropertyRecords;
      delete VarListOfPropertyRecords;
      unDelete VarListOfPropertyRecords;
      
      //get List of records
      List<Property__c> VarAllPropRec = PropertyApexClass.getListOfPropertyRecords();
      System.assertEquals(20, VarAllPropRec.size());
      //apply discount
      PropertyApexClass.applyDiscount(VarAllPropRec);
      List<Property__c> VayRowHouseList =[SELECT id  FROM Property__c WHERE Type__c =: 'Row House' ];
      System.assertEquals(10,VayRowHouseList.size() );
  
  }
    @isTest
    static void insertRecord(){
          Property__c propertyObject = new Property__c();
           propertyObject.Price__c =100;
           propertyObject.Type__c = 'Row House';
        PropertyApexClass.insertPropertyRecord(propertyObject);
        
    }
    
}