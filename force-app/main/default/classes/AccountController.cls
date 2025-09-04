public class AccountController{
    
    public string name{get; set;}
    public string lastName{get; set;}
    
    private ApexPages.StandardController controller;

    public AccountController(ApexPages.StandardController controller) {
        this.controller = controller;
        Integer d;
    }

    
    public void createAccount(){
        system.debug('>>>>>>>>>>>>>>>>>>>>>'+name);
        system.debug('>>>>>>>>>>>>>>>>>>>>>'+lastName);
        
        Employee__c emp= new Employee__c();
        emp.Name = name;
        emp.Last_Name__c=lastName ;
        insert emp;
    }
    public PageReference doFullSave1(){

    SObject so = controller.getRecord();
    upsert so;

    string s = '/' + ('' + so.get('Id')).subString(0, 3) + '/e?';
    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Info, s));
    return new Pagereference(s);

}

}