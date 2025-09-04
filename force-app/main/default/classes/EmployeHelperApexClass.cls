public with sharing class EmployeHelperApexClass{

  public static void checkEmployeeSize(List<Employee__c> VarListOfEmpRec){
      
      Set<ID> SetOfCompanyIds = new Set<ID>();
      for(Employee__c VarEmpRec:VarListOfEmpRec){
          SetOfCompanyIds.add(VarEmpRec.Company__c);
      }
      for(Company__c VarCompanyRec :[SELECT id, Name,(SELECT id FROM Employees__r) FROM Company__c WHERE id IN:SetOfCompanyIds]){
          
          if(VarCompanyRec.id != null){
              if(VarCompanyRec.Employees__r.size()>=1){
                  VarCompanyRec.addError('Only One Record Permitted');
              }else if(VarListOfEmpRec.size() > 1){
                  for(integer i=1;i<VarListOfEmpRec.size();i++){
                      VarListOfEmpRec.get(i).addError('Only One Record Permitted');
                  }
              }
          }
          
      }
      
  }
}