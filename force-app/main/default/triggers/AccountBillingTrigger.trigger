trigger AccountBillingTrigger on Account (Before insert, Before update) {

   if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
   if(System.label.Deactivate_Trigger == 'true'){
return;
}

   
        for(Account rec: Trigger.new){
        
          if(rec.BillingCountry == 'India'){
            
            rec.BillingCity = 'Hyderabad';
            
          }else if(rec.BillingCountry == 'UAE'){
            
            rec.BillingCity = 'Dubai';
            
          }else{
          
            rec.BillingCity = '';

          }

        }
          

   }

}