public Class ContactsClass{

  public static List<Contact> listOfContacts{get; set;}
  
  
  public ContactsClass(){
  
    listOfContacts = new List<Contact>();  
    listOfContacts = [SELECT Id, FirstName, LastName, Email, MobilePhone ,MailingCountry FROM Contact];

  }
  


}