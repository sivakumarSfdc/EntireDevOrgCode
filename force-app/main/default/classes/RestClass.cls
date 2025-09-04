@RestResource(urlmapping='/RESTDATA')
Global Class RestClass{


   @HTTPPOST
   Global static Responce CreateAccount(Accounts ac){
   
     Account a = new Account();
     a.Name = ac.AccountName;
     insert a;
     
     Contact c = new Contact();
     c.LastName = ac.LastName;
     c.AccountId =a.Id;
     insert c;
     
     Responce res = new Responce();
     res.success = true;
     res.AccountId = a.Id;
     res.accounts =[SELECT Id, Name, (SELECT id, LastName FROM Contacts) FROM Account WHERE Name = :ac.AccountName];
     return res;
   
   
   }
   
   global class  Accounts{
     
     public String AccountName;
     public String LastName;
   
   }
   
  global class  Responce{
 
       global Boolean success;
       global String AccountId;
       global list<Account> accounts;
     }


}