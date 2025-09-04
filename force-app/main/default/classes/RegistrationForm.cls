public with sharing Class RegistrationForm{

   //public Registration__c regObj {get;set;}
   
   public String varUserName{get;set;}
   public String varEmail{get;set;}
   public String varPassword{get;set;}
   public String varReEnterPassword{get;set;}

   public void RegistrationForm(){
     
     //regObj = new Registration__c();
   }
   
   public void SignUp(){
   
     if(String.isNotBlank(varUserName)){
     
           if(String.isNotBlank(varPassword)){
                        if(String.isNotBlank(varReEnterPassword)){
                        
                          if(varPassword == varReEnterPassword){
                          
                                List<Registration__c> varRec  = [SELECT Id FROM Registration__c WHERE User_Name__c =: varUserName];
                                if(varRec.isEmpty()){
                                   
                                 Registration__c  regObj = new Registration__c();
                                 regObj.User_Name__c = varUserName;
                                 regObj.Email__c= varEmail;
                                 regObj.Password__c= varPassword;
                                 insert regObj;
                                 ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Confirm,'User Registered Successfully, Click Login To navigate'));
                                 varUserName ='';
                                 varEmail='';
                                 varPassword='';
                                 varReEnterPassword='';
                                 

                                }else{
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'Already User Exits'));

                                }
                          }else{
                                           ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'password not matches to Reeneted password'));

                          }
                        }else{
                              ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'Re Enter password Required'));

                        }

           }else{
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'Password Required'));

           }
     }else{
      ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.fatal,'User Name Required'));

     }

   
   }
   public pagereference Login(){
     pagereference pRef = new pagereference('/apex/RegistartionLoginPage');
     return pRef;
   }

}