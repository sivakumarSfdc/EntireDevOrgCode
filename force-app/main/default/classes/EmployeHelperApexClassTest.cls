@isTest
public class EmployeHelperApexClassTest {
    
    @testSetup
    static void insertCompany(){
        Test.startTest();
        Company__c VarCompanyRec = new Company__c();
        VarCompanyRec.Name = 'Hitachi';
        VarCompanyRec.Industry__c = 'Chemical';
        insert VarCompanyRec;
        Test.stopTest();
    }
    
    @isTest
     static void insertBulkChildRecords(){
        Test.startTest(); 
        List<Employee__c> VarListOfEmployees = new List<Employee__c>();
        Company__c CompanyRec = [SELECT id,Name FROM Company__c WHERE Name = 'Hitachi'];
        System.debug('Company Id ='+CompanyRec.id);
         if(CompanyRec.id != Null){
             for(integer i =0; i<10;i++){
                 Employee__c VarEmpObj = new Employee__c();
                 VarEmpObj.Name = 'Emp'+String.valueOf(i);
                 VarEmpObj.Company__c =CompanyRec.id;
                 VarListOfEmployees.add(VarEmpObj);
             }
             Database.insert(VarListOfEmployees,false);
             System.assertEquals(1, [SELECT id,Name,(SELECT id FROM Employees__r) FROM Company__c WHERE id =:CompanyRec.id].Employees__r.size());
             Test.stopTest();
    
         }
    }
 
}