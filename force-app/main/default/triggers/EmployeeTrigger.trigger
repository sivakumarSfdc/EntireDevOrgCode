trigger EmployeeTrigger on Employee__c (before insert, before update, after insert, after update, after delete, after undelete) {
    //trigger.oldmap - Key = RecordId , value - old version of employee records
   // if(system.label.StopEmployeeTrigger != 'true'){
        list<Employee__c> employees = new list<Employee__c>();
        list<Employee__c> empSalUpdateRec= new list<Employee__c>();

        if(trigger.isDelete)
            employees = trigger.old;
        else
            employees = trigger.new;   

        set<Id> accountIds = new set<Id>();
        for(Employee__c emp : employees){
            if(trigger.isAfter){
               if(!EmployeeUtilityClass.SetofUpdatedEmpId.contains(emp.Id)){
                    EmployeeUtilityClass.SetofUpdatedEmpId.add(emp.Id);
                    // if(DeepcloudUtility.stopRecursion == false){
                   // DeepcloudUtility.stopRecursion = true;
                    Employee__c newEmp = new Employee__c(Id = emp.Id);
                    newEmp.Tax_Amount__c = 0.1*emp.Salary__c;
                    empSalUpdateRec.add(newEmp);
                    //update newEmp;
               // }

               }
            }
            if(trigger.isAfter){
                if(emp.Account__c != null){
                    accountIds.add(emp.Account__c);
                }
                if(trigger.isUpdate){
                    Employee__c oldEmp =  trigger.oldmap.get(emp.Id);
                    accountIds.add(oldEmp.Account__c);
                }
            }
        }
        if(!empSalUpdateRec.isEmpty()){
         update empSalUpdateRec;
        }
                

        if(!accountIds.isEmpty()){            
            list<Account> accounts = [Select id, (Select id, Name from Employees__r) from Account where id in: accountIds];
            for(Account acc : accounts){
                acc.NumberOfEmployees = acc.Employees__r.size();
            }
            update accounts;

        }
   // }

}