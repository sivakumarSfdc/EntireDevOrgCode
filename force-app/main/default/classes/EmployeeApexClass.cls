public class EmployeeApexClass {
    
    
    public static String varRecordId = null;
    
    
    public static void CreateRecord(String firstName, String lastName, String email, String mobile){
        
        if(String.isNotBlank(firstName) && String.isNotBlank(lastName) && String.isNotBlank(email) && String.isNotBlank(mobile)){
            
            Employee__c empObj = new Employee__c();
            empObj.Name = firstName;
            empObj.Last_Name__c = lastName;
            empObj.Email__c = email;
            empObj.Mobile__c = mobile;
            insert empObj;
            varRecordId = empObj.Id;
            system.debug('Record Id ='+varRecordId);
        }  
    }
    
    public static void UpdateRecord(String recordId){
        if(recordId != null){
            Employee__c empObj = new Employee__c();
            empObj.Id = recordId;
            empObj.Name = 'Mahesh';
            empObj.Last_Name__c = 'sharma';
            empObj.Email__c = 'Mahesh@gmail.com';
            empObj.Mobile__c = '9440885478';
            update empObj;
            
        }
    }
    public static void DeleteRecord(String recordId){
        if(recordId != null){
            Employee__c empObj = new Employee__c();
            empObj.Id = recordId;
            delete empObj;
            
        }
    }
    
    public static void UnDeleteRecord(String recordId){
        if(recordId != null){
            Employee__c empObj = new Employee__c();
            empObj.Id = recordId;
            undelete empObj;
            
        }
    }
    
    
}