public class ContactAndLeadSearch{
    
    public static  void SampleMethod(){
        
        
        Map<Integer,String> MapofMonths = new Map<Integer,String>{1=>'January',2=>'Feb',3=>'Mar',4=>'April',5=>'May',6 =>'Jun',7=>'Jul',8=>'Aug',9=>'Sep',10=>'oct',11=>'Nov',12=>'Dec'};
        
            for(Integer varMonth : MapofMonths.keyset())  {
                
                if(MapofMonths.keyset().contains(varMonth)){
                    Integer varDaysInMonth = Date.daysInmonth(System.today().year()-1,varMonth);
                    for(integer i=1; i<= varDaysInMonth; i++){
                        
                        system.debug('formatted date ='+ i+'rd, '+MapofMonths.get(varMonth)+' '+(System.today().year()-1));
                        
                        /* Datetime customDate = Datetime.newInstanceGMT(System.today().year(),varMonth,i);
                             String formatedDate = customDate.format('dd \'of\' MMMM yyyy');
                             system.debug('formatted date ='+formatedDate);*/
                        
                        
                    }
                    
                }
                
                
                
            } 
            
   
    }   
}