global class EmployeeBirtWishBatchable implements Database.Batchable<SObject>,Database.Stateful {

        EmailTemplate temp {get; set;}
        Contact con {get; set;}

        global EmployeeBirtWishBatchable (){
        
            this.temp = [Select id from EmaiLtemplate where developerName = 'Employee_Email_Template'];
            this.con = [SELECT Id FROM Contact WHERE LastName = 'test contact' Limit 1];

        }

        global Database.QueryLocator Start(Database.BatchableContext Bc){
        
        
          return Database.getQueryLocator('select id, Name,Email__c FROM Employee__c WHERE This_Year_DOB__c = TODAY');
        }
        
        global void execute(Database.BatchableContext Bc, List<Employee__c> scope){
        
            for(Employee__c emp:scope){
        
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                list<string> toAddress = new list<string>();

                if(emp.Email__c != null){
                  toAddress.add(emp.Email__c);

                }
                System.debug('Email Address ='+toAddress );
                mail.setToaddresses(toAddress);
                mail.setTemplateId(temp.Id);
                mail.setWhatId(emp.Id); 
                mail.settargetObjectId(con.Id); 
                mail.setsaveAsActivity(false);
               Messaging.Sendemail(new list<Messaging.SingleEmailMessage>{mail});

        
        }
        }

            
            
        global void finish(Database.BatchableContext Bc){

        }

}