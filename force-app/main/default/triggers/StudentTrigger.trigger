trigger StudentTrigger on Student__c (Before insert, Before update,After update) {
 
   if(Trigger.isAfter && Trigger.isUpdate){
     sendEmail(trigger.new);
   }
   public static void sendEmail(List<Student__c> inquirys){
    

        EmailTemplate temp = [Select id from EmaiLtemplate where developerName ='Test_Email' LIMIT 1];
        
        if (temp.Id != null) {
        
            List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'sivakumarthota13@gmail.com'];

            for (Student__c inq :inquirys) {
            
                   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                   List<String> toAddresses = new List<String>{inq.Email__c,'sivasfdc23@gmail.com'};
                   mail.setToAddresses(toAddresses);
                   mail.setTemplateId(temp.Id);
                  // mail.setWhatId(inq.Id);
                  // mail.setReplyTo('DAMAC<no-replysf@damacgroup.com>  ');
                   mail.setOrgWideEmailAddressId(owea.get(0).Id);
                   mail.setTargetObjectId(inq.ownerId);
                   mail.setSaveAsActivity(false);
                   emailMessages.add(mail);
            }
            
            if(!emailMessages.isEmpty()){
                  Messaging.SendEmailResult[] results = Messaging.sendEmail(emailMessages);
            }
            
        }
        
    }   

}