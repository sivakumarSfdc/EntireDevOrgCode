public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact inputcontact, String inputstate){
        this.contact = inputcontact;
        this.state = inputstate;
    }
    
    public void execute(QueueableContext context){
        
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState =: state LIMIT 200];
        List<Contact> lsOfContact2Insert = new List<Contact>();
        for(Account acc :accounts){
            Contact contactClone = contact.clone();
            contactClone.AccountId = acc.Id;
            lsOfContact2Insert.add(contactClone);
        }
        if(!lsOfContact2Insert.isEmpty()){
            insert lsOfContact2Insert;
        }
        
    }

}