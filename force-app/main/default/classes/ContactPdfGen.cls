public  Class ContactPdfGen{
    
   public  list<Contact> Contacts{get; set;}
    public ContactPdfGen(){
        
        string accountId = ApexPages.CurrentPage().getParameters().get('accountId');
        
        Contacts = new list<Contact>();
        
        if(accountId == null)
            Contacts = [Select Id, FirstName, LastName,Email,MobilePhone ,MailingCountry from Contact];
        else
            Contacts = [Select Id, FirstName, LastName,Email,MobilePhone ,MailingCountry from Contact WHERE AccountId =: accountId];
            
        
    }

}