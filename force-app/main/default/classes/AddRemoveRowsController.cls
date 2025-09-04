public class AddRemoveRowsController{
    
    public integer selIndex{get; set;}
    public class Contacts{
        public integer index{get; set;}
        public Account acc{get; set;}
        public Contact con{get; set;}
    }
    
    public list<Contacts> lstContacts{get; set;}
    
    public AddRemoveRowsController(){
        lstContacts = new list<Contacts>();
        Contacts e = new Contacts();
        e.index = 0;
        e.acc = new Account();
        e.con= new Contact();
        lstContacts.add(e);
    }
    public void addRow(){
        Contacts e = new Contacts();
        e.index = lstContacts.size();
        e.acc = new Account();
        e.con= new Contact();
        lstContacts.add(e);
    }
    
    public void save(){
        Set<String> accNames = new Set<String>();
        
        for(Contacts empRec : lstContacts){
         accNames.add(empRec.acc.Name);
        }
        
        if(!accNames.isEmpty()){
                list<Contact> lstEmp = new list<Contact>();
                map<string, Account> mpAccounts2Insert = new map<string, Account>();
                map<string, list<Contact>> mpContactss2Insert = new map<string, list<Contact>>();
                map<String, Account> mpExistingAccounts = new map<String, Account>();

                for(Account a: [SELECT Id, Name FROM Account WHERE Name IN:accNames]){
                 mpExistingAccounts.put(a.Name,a);
                 System.debug('mpExistingAccounts ='+mpExistingAccounts.values()+'//'+mpExistingAccounts.keyset());

                }
                for(Contacts empRec : lstContacts){
                
                      if(!mpExistingAccounts.containsKey(empRec.acc.Name)){
                           mpAccounts2Insert.put(empRec.acc.Name, empRec.acc);//Broadridge

                        }
            
                      if(mpContactss2Insert.containsKey(empRec.acc.Name)){
                          list<Contact> existing = mpContactss2Insert.get(empRec.acc.Name);
                          existing.add(empRec.con);
                          mpContactss2Insert.put(empRec.acc.Name, existing);
                       }
                      else{
                          mpContactss2Insert.put(empRec.acc.Name, new list<Contact>{empRec.con});

                      }
                }
                if(!mpAccounts2Insert.isEmpty()){
                      System.debug('mpAccounts2Insert='+mpAccounts2Insert.values()+'//'+mpAccounts2Insert.keyset());

                      insert mpAccounts2Insert.values();

                   }
                   
                if(!mpExistingAccounts.isEmpty()){
                    
                    mpAccounts2Insert.putAll(mpExistingAccounts);
                } 

                for(string accountName : mpContactss2Insert.keyset()){
                    Account acc = mpAccounts2Insert.get(accountName);
                    for(Contact emp : mpContactss2Insert.get(accountName)){
                        emp.AccountId = acc.Id;
                        lstEmp.add(emp);
                    }
                }
                insert lstEmp;
        }
         
        
    }
    
    public void removeRow(){
        
        system.debug('>>>>>>>>>>>>'+selIndex);
        lstContacts.remove(selIndex);
        
        list<Contacts> clone = lstContacts.clone();
        lstContacts = new list<Contacts>();
        
        integer i = 0;
        for(Contacts emp : clone){
            emp.index = i;
            i++;
            lstContacts.add(emp);
        }
    }

}