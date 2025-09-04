public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer n, String Lastname){
                
        List<Contact> ct = new List<Contact>();
        for(Integer i=0; i<n; i++)
        {
           Contact c = new Contact();

           c.FirstName = 'Test '+i;
           c.LastName = Lastname;
           ct.add(c);
        }
        
        return ct;
    }

}