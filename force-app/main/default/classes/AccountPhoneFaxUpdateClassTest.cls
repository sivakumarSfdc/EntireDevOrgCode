@isTest
public class AccountPhoneFaxUpdateClassTest{
    
    @testSetup
    private static void CreateAccountRecords(){
        
        Test.startTest();
        
        List<Account> ListOfNewAccounts = new List<Account>();
        
        for(integer i=1 ; i <= 10 ;i++){
            Account VarAccObj = new Account();
            VarAccObj.Name = 'Account '+ String.valueOf(i);
            ListOfNewAccounts.add(VarAccObj);
        }
        insert ListOfNewAccounts;
        
        //fetch account Records
        List<Account> ListOfAccountRecords = [SELECT id, Name FROM Account WHERE id<>Null];
        System.debug('TestClassAccountSize ='+ListOfAccountRecords.size());
        System.assertEquals(10, ListOfAccountRecords.size());
        
        List<Contact> ListOfContactRecords = new List<Contact>();
        for(Account accRec:ListOfAccountRecords){
            
            for(integer j=0; j<3;j++){
                Contact VarConObj = new Contact();
                VarConObj.AccountId = accRec.Id;
                VarConObj.LastName = 'Contact '+ String.valueOf(j);
                ListOfContactRecords.add(VarConObj);
            }
            
        }
        insert ListOfContactRecords;
        Test.stopTest();
        
    }
    
    @isTest
    private static void UpdaeRandomAccountRecords(){
        
        Test.startTest();
        List<Account> UpdateAccountRec =new List<Account>();
        for(Account  acc: [SELECT id, Name,Phone,Fax FROM Account WHERE id<>Null]){
            acc.Phone = '1111';
            acc.Fax ='22222';
            UpdateAccountRec.add(acc);
        }
        update UpdateAccountRec;
        System.assertEquals('22222', [SELECT id,(SELECT id,Phone,Fax FROM Contacts) FROM Account WHERE Name = 'Account 1'].Contacts.get(0).Fax);
        Test.stopTest();
        
    }
}