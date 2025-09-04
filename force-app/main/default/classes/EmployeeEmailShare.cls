public  Class EmployeeEmailShare implements Queueable, Database.AllowsCallouts{

    private List<Employee__c> listOfEmployees;

    public EmployeeEmailShare (List<Employee__c> lstEmp){
    
      this.listOfEmployees = lstEmp;
    }
    
    public void execute(QueueableContext context){
    
             EmailTemplate temp = [Select id from EmaiLtemplate where developerName = 'Employee_Email_Template'];
            Contact con = [SELECT Id FROM Contact WHERE LastName = 'test contact' Limit 1];
            for(Employee__c emp:listOfEmployees){
        
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                list<string> toAddress = new list<string>{emp.Email__c};
                mail.setToaddresses(toAddress);
                mail.setTemplateId(temp.Id);
                mail.setWhatId(emp.Id); 
                mail.settargetObjectId(con.Id); 
                mail.setsaveAsActivity(false);
                
                PageReference pdf = Page.EmployeeRenderasPdf;
                pdf.getParameters().put('id',(String)emp.id);
                pdf.setRedirect(true);

                // Take the PDF content
                Blob b = pdf.getContentAsPDF();

               // Create the email attachment
               Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
               efa.setFileName('EmployeeRenderasPdf.pdf');
               efa.setBody(b);
               mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

               Messaging.Sendemail(new list<Messaging.SingleEmailMessage>{mail});
        }

    }
}