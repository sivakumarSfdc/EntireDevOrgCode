public class WrapperController{

    public class Accounts{
        
        public Account acc{get; set;}
        public boolean checked{get; set;}
        
    }
    
    public String selectedAccId {get; set;}

    public list<Account> accounts{get; set;}
    
    public list<Accounts> accData{get; set;}
    
    public string searchText{get; set;}
    
    public WrapperController(){
        prepareData();
        
    }
    
    public void updateRecords(){
    
        list<Account> lstUpdate= new list<Account>();
        for(Accounts a : accData){
            if(a.checked == true){
               a.acc.Type = 'Customer - Direct';
               lstUpdate.add(a.acc);
            }
        }
        update lstUpdate;
        prepareData();
    }
    
    public void prepareData(){
        
        accounts = [Select Id, Name, BillingCity, BillingCountry, Type from Account order by Name asc];
        accData= new list<Accounts>();
        for(Account ac: accounts ){
            Accounts a = new Accounts();
            a.acc = ac;
            a.checked = false;
            accData.add(a);
        }
    }
    
    public void doSearch(){
    
        string searchStr = '%'+searchText+'%';
        accounts = [Select Id, Name, BillingCity, BillingCountry, Type from Account where (Name like: searchStr or BillingCity like: searchStr or BillingCountry like: searchStr) order by Name asc];      
                    
        accData= new list<Accounts>();
        for(Account ac: accounts ){
            Accounts a = new Accounts();
            a.acc = ac;
            a.checked = false;
            accData.add(a);
        }
    }
    
    public void doclear(){
                prepareData();

    }
    
    public pagereference Contacts(){
              System.debug('selectedAccId ='+selectedAccId );

      if(selectedAccId != null){
          Pagereference ref = new Pagereference('/apex/ContactPdfGenVFP?accountId='+selectedAccId);
          ref.setRedirect(true);
          return ref;

      }
      return null;
    }

}