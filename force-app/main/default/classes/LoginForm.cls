public with sharing Class LoginForm{

   //public Registration__c regObj {get;set;}
   
   public String varUserName{get;set;}
   public String varPassword{get;set;}

   public void RegistrationForm(){
     
     //regObj = new Registration__c();
   }//(User_Name__c =: varUserName && Password__c =: varPassword)
   
   public pagereference Login(){
   
     if(String.isNotBlank(varUserName)){
     
           if(String.isNotBlank(varPassword)){
           
                  List<Registration__c> varRegistred = [SELECT Id FROM Registration__c WHERE User_Name__c =: varUserName AND Password__c =: varPassword ];
                  if(!varRegistred.isEmpty()){
                    varUserName='';
                    varPassword='';
                    pagereference pRef = new pagereference('/a0g/o');
                    return pRef;
                   
                  }else{
                    varUserName='';
                    varPassword='';

                  ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'Please sign up'));
                  return null;

                  }
           
           
           }else{
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'Password Required'));
                 return null;

           }
     }else{
      ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'User Name Required'));
      return null;

     }

   
   }
   public pagereference SignUp(){
   
    pagereference pRef = new pagereference('/apex/RegistrationForm');
    return pRef;
   }

}