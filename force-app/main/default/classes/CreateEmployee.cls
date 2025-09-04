Global Class CreateEmployee{


  WebService static String CreateEmployee(String firstName, String lastName){
  
  
          if(String.isNotBlank(firstName) && String.isNotBlank(lastName)){
            
            Employee__c empObj = new Employee__c();
            empObj.Name = firstName;
            empObj.Last_Name__c = lastName;
            insert empObj;
            return empObj.Id;
        }  
    return null;
  }

}