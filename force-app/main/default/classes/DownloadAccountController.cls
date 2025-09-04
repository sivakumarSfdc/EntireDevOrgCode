public  Class DownloadAccountController{
    
    public string csvString{get; set;}
    
    public DownloadAccountController(){
        
        string accountId = ApexPages.CurrentPage().getParameters().get('accountId');
        
        list<Contact> Contacts = new list<Contact>();
        
        if(accountId == null)
            Contacts = [Select Id, FirstName, LastName from Contact];
        else
            Contacts = [Select Id, FirstName, LastName from Contact WHERE AccountId =: accountId];
            
        csvString = '';
            
        csvString += 'ContactId,FirstName,LastName'+'\n';
        
        for(Contact co: Contacts){
            csvString += co.Id+','+co.FirstName+','+co.LastName+'\n';
        }
        
    }

}