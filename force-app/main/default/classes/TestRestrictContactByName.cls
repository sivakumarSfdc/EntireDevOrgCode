@isTest
public with sharing Class TestRestrictContactByName{

  @isTest
  public static void TestMethod1(){
  
    Test.startTest();
    List<Contact> ListOfContact = new List<Contact>();
    for(integer i=0; i<10;i++){
      
      Contact objContact = new Contact();
      objContact.LastName ='INVALIDNAME';
      ListOfContact.add(objContact);
    }
    
    insert ListOfContact;
    Test.stopTest();
  }
}