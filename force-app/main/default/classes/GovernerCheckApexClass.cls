//This apex class is writeen for testing apex class governer limits
public class GovernerCheckApexClass {
    
    public static void HitGovernerLimits(){
        
       /* for(integer i=0;i<150;i++){
            Test_Obj__c VarTestObject = new Test_Obj__c();
            VarTestObject.Email__c = String.valueOf('siva'+i+'@gmail.com');
            database.insert (VarTestObject,false);
        }*/
        List<Test_Obj__c> VarListRecords = new List<Test_Obj__c>();
        VarListRecords = [SELECT id From Test_Obj__c WHERE id<>Null];
        delete VarListRecords;
    }

}